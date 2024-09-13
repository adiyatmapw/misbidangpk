import os
from flask import Flask, render_template, redirect, url_for, request, flash, jsonify
from flask_login import LoginManager, login_user, login_required, logout_user, current_user
from flask_paginate import Pagination, get_page_args
from functools import wraps
from werkzeug.utils import secure_filename
from flask import abort
from models import db, User, DataPegawai, BiayaTransportasi, BobotKriteria, LogPerhitungan, SkalaBiayaBahanBakar, HasilPerhitungan, DataPelakuUsaha, PelanggaranPengawasan, PelaporanPelanggaran, HasilPerencanaan, BarangPengawasan
import config
import json
import logging
import random
from sqlalchemy import func
from reportlab.lib.pagesizes import A4
from reportlab.lib import colors
from reportlab.lib.styles import getSampleStyleSheet
from reportlab.lib.units import inch
from reportlab.platypus import SimpleDocTemplate, Paragraph, Spacer, Table, TableStyle, Image
from flask import send_file
from io import BytesIO
import matplotlib.pyplot as plt
import matplotlib.ticker as ticker


# Konfigurasi folder upload
UPLOAD_FOLDER = 'C:/xampp/htdocs/spkbidangpk/static/uploads'
ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg', 'pdf'}

app = Flask(__name__)
app.config.from_object(config.Config)
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER


db.init_app(app)
login_manager = LoginManager()
login_manager.init_app(app)
login_manager.login_view = 'login'

# Fungsi untuk memeriksa ekstensi file
def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

def format_jenis_pelanggaran(jenis_pelanggaran):
    items = jenis_pelanggaran.split(', ')
    if len(items) > 1:
        return ', '.join(items[:-1]) + ' dan ' + items[-1] + ' tidak sesuai.'
    else:
        return items[0] + ' tidak sesuai.'

# Menentukan batas maksimal 3 angka di belakang koma
def format_thousands_decimal(value):
    try:
        formatted_value = "{:,.3f}".format(value)
        # Remove trailing zeros and the dot if not necessary
        formatted_value = formatted_value.rstrip('0').rstrip('.') if '.' in formatted_value else formatted_value
        return formatted_value
    except (ValueError, TypeError):
        return value

def role_required(*roles):
    def decorator(f):
        @wraps(f)
        def decorated_function(*args, **kwargs):
            if current_user.roles not in roles:
                abort(403)
            return f(*args, **kwargs)
        return decorated_function
    return decorator

app.jinja_env.filters['format_thousands_decimal'] = format_thousands_decimal

@login_manager.user_loader
def load_user(user_id):
    return User.query.get(int(user_id))

@app.context_processor
def inject_user():
    return dict(current_user=current_user)

def format_number(value):
    try:
        return "{:,.2f}".format(value)
    except (ValueError, TypeError):
        return value

app.jinja_env.filters['format_number'] = format_number

@app.route('/')
def index():
    return redirect(url_for('login'))

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        user = User.query.filter_by(username=username).first()
        if user and user.password == password:
            login_user(user)
            return redirect(url_for('home'))
        else:
            flash('Invalid username or password')
    return render_template('login.html')

@app.route('/home')
@login_required
def home():
        # Query untuk mendapatkan data pengawasan yang sedang berlangsung
        pengawasan_berlangsung = db.session.query(HasilPerhitungan).join(LogPerhitungan).filter(LogPerhitungan.status == 'Sedang Berlangsung').all()

        # Query untuk mendapatkan data daerah yang gagal diawasi pada periode sebelumnya
        gagal_periode_sebelumnya = db.session.query(HasilPerhitungan).join(LogPerhitungan).filter(HasilPerhitungan.gagal == True, LogPerhitungan.status != 'Sedang Berlangsung').all()

        # Query untuk mendapatkan data daerah yang terdapat pelanggaran pada periode yang sedang berlangsung
        pelanggaran_periode_sekarang = db.session.query(HasilPerhitungan).join(LogPerhitungan).filter(HasilPerhitungan.terdapat_pelanggaran == True, LogPerhitungan.status == 'Sedang Berlangsung').all()

        # Mengolah data untuk grafik
        daerah_gagal_box = [d.nama_daerah for d in pengawasan_berlangsung if d.gagal == 1]
        gagal = [d.gagal for d in pengawasan_berlangsung if d.gagal == 1]
        daerah_pelanggaran_box = [d.nama_daerah for d in pengawasan_berlangsung if d.terdapat_pelanggaran == 1]
        pelanggaran = [d.terdapat_pelanggaran for d in pengawasan_berlangsung if d.terdapat_pelanggaran == 1]
        total_anggaran = sum(d.anggaran_biaya for d in pengawasan_berlangsung)
        anggaran_daerah = [d.anggaran_biaya for d in pengawasan_berlangsung]
        periode = [d.log_id for d in pengawasan_berlangsung]

        # Info box data
        daerah_selanjutnya = [d.nama_daerah for d in pengawasan_berlangsung]
        daerah_gagal_sekarang = [d.nama_daerah for d in gagal_periode_sebelumnya]
        daerah_pelanggaran_sekarang = [d.nama_daerah for d in pelanggaran_periode_sekarang]

        return render_template('home.html', username=current_user.username, 
                               gagal=gagal, periode=periode, 
                               pelanggaran=pelanggaran, 
                               total_anggaran=total_anggaran, anggaran_daerah=anggaran_daerah,
                               daerah_selanjutnya=daerah_selanjutnya, daerah_gagal_sekarang=daerah_gagal_sekarang, pelanggaran_periode_sekarang=pelanggaran_periode_sekarang,
                               daerah_pelanggaran_sekarang=daerah_pelanggaran_sekarang, daerah_gagal_box=daerah_gagal_box, daerah_pelanggaran_box=daerah_pelanggaran_box)


@app.route('/dashboard-data')
@login_required
def dashboard_data():
    data = db.session.query(HasilPerhitungan).all()

    # Data Dummy
    daerah_dummy = ['Kota Bandung', 'Kabupaten Bekasi', 'Kota Bogor', 'Kota Depok']
    parameter_dummy = ['SNI', 'MKG', 'Label', 'K3L']
    barang_dummy = ['Helm Motor', 'Ban Mobil', 'Sepatu', 'Mainan Anak']
    merk_dummy = ['Merk A', 'Merk B', 'Merk C', 'Merk D']
    tahun_dummy = ['2021', '2022', '2023', '2024']

    # Data Pelanggaran per Daerah
    pelanggaran_per_daerah = [12, 15, 8, 10]  # Misal: Kota Bandung 12, Kabupaten Bekasi 15, dll.
    
    # Data Pelanggaran per Parameter (SNI, MKG, Label, K3L)
    pelanggaran_per_parameter = [30, 20, 15, 35]  # Misal: SNI 30, MKG 20, dll.
    
    # Data Barang Tidak Sesuai Ketentuan
    barang_tidak_sesuai = [5, 8, 2, 10]  # Misal: Helm Motor 5, Ban Mobil 8, dll.
    
    # Data Merk Tidak Sesuai Ketentuan
    merk_tidak_sesuai = [7, 12, 6, 9]  # Misal: Merk A 7, Merk B 12, dll.
    
    # Data Pelanggaran per Tahun
    pelanggaran_per_tahun = [25, 30, 20, 35]  # Misal: 2021 ada 25 pelanggaran, 2022 ada 30 pelanggaran, dll.

    # Response Data untuk Frontend
    response_data = {
        # Data Dummy Pelanggaran
        'pelanggaran_per_daerah': pelanggaran_per_daerah,
        'pelanggaran_per_parameter': pelanggaran_per_parameter,
        'barang_tidak_sesuai': barang_tidak_sesuai,
        'merk_tidak_sesuai': merk_tidak_sesuai,
        'pelanggaran_per_tahun': pelanggaran_per_tahun,
        
        # Labels
        'daerah_labels': daerah_dummy,
        'parameter_labels': parameter_dummy,
        'barang_labels': barang_dummy,
        'merk_labels': merk_dummy,
        'tahun_labels': tahun_dummy,
        'daerah_gagal': ['Kota Bandung', 'Kabupaten Bekasi', 'Kota Depok'],
        'gagal': [5, 8, 12],
        'daerah_pelanggaran': ['Kota Bandung', 'Kabupaten Bogor', 'Kota Tangerang'],
        'pelanggaran': [7, 9, 10],
        'log_ids': [1, 2, 3],
        'tanggal_per_log': ['2023-01', '2023-02', '2023-03'],
        'total_gagal': 25,
        'total_pelanggaran': 26,
        'total_anggaran': 120000000,
        'anggaran_per_log': [40000000, 35000000, 45000000],
        'anggaran_per_daerah': {
            1: {'Kota Bandung': 20000000, 'Kabupaten Bekasi': 20000000},
            2: {'Kabupaten Bogor': 35000000},
            3: {'Kota Tangerang': 45000000}
    }
    }
    
    return jsonify(response_data)


@app.route('/logout')
@login_required
def logout():
    logout_user()
    return redirect(url_for('login'))

def get_data_pegawai(offset=0, per_page=10):
    return DataPegawai.query.offset(offset).limit(per_page).all()

@app.route('/data_pegawai')
@login_required
def data_pegawai():
    search = request.args.get('search')
    page = request.args.get('page', 1, type=int)
    per_page = 15  # Menampilkan 15 data per halaman
    query = DataPegawai.query

    if search:
        search = f"%{search}%"
        query = query.filter(
            (DataPegawai.nama_pegawai.ilike(search)) |
            (DataPegawai.nip.ilike(search))
        )
    
    total = query.count()
    data_pegawai = query.paginate(page=page, per_page=per_page, error_out=False)
    
    return render_template('data_pegawai.html', data_pegawai=data_pegawai.items, page=page, per_page=per_page, total=total, pagination=data_pegawai)

@app.route('/tambah_data_pegawai', methods=['GET', 'POST'])
@login_required
@role_required('Admin')  # Hanya admin yang bisa menambah data pegawai
def tambah_data_pegawai():
    if request.method == 'POST':
        nama_pegawai = request.form['nama_pegawai']
        nip = request.form['nip']
        jabatan = request.form['jabatan']
        
        # Menambahkan data pegawai baru ke database
        pegawai_baru = DataPegawai(nama_pegawai=nama_pegawai, nip=nip, jabatan=jabatan)
        db.session.add(pegawai_baru)
        db.session.commit()
        
        flash('Data pegawai berhasil ditambahkan.', 'success')
        return redirect(url_for('data_pegawai'))
    
    return render_template('tambah_data_pegawai.html')

@app.route('/ubah_data_pegawai/<int:id>', methods=['GET', 'POST'])
@login_required
@role_required('Admin')
def ubah_data_pegawai(id):
    pegawai = DataPegawai.query.get_or_404(id)
    
    if request.method == 'POST':
        pegawai.nama_pegawai = request.form['nama_pegawai']
        pegawai.nip = request.form['nip']
        pegawai.jabatan = request.form['jabatan']
        
        db.session.commit()
        flash('Data pegawai berhasil diubah.', 'success')
        return redirect(url_for('data_pegawai'))

    return render_template('ubah_data_pegawai.html', pegawai=pegawai)

@app.route('/hapus_data_pegawai/<int:id>', methods=['POST'])
@login_required
def hapus_data_pegawai(id):
    pegawai = DataPegawai.query.get_or_404(id)
    db.session.delete(pegawai)
    db.session.commit()
    flash('Data pegawai berhasil dihapus.', 'success')
    return redirect(url_for('data_pegawai'))

@app.route('/data_transportasi')
@login_required
def data_transportasi():
    page = request.args.get('page', 1, type=int)
    per_page = 15
    offset = (page - 1) * per_page

    # Query skala biaya bahan bakar
    skala_biaya_bahan_bakar = SkalaBiayaBahanBakar.query.all()

    # Query biaya transportasi dengan join ke skala biaya bahan bakar untuk mendapatkan total biaya bahan bakar yang diperbarui
    biaya_transportasi_query = BiayaTransportasi.query
    total = biaya_transportasi_query.count()
    biaya_transportasi = biaya_transportasi_query.offset(offset).limit(per_page).all()

    # Update total biaya bahan bakar berdasarkan jarak daerah dan skala biaya bahan bakar
    for biaya in biaya_transportasi:
        for skala in skala_biaya_bahan_bakar:
            if skala.rentang_jarak_minimal <= biaya.jarak_daerah <= skala.rentang_jarak_maksimal:
                biaya.total_biaya_bahan_bakar = skala.biaya_bensin
                break
        db.session.commit()

    # Query total biaya transportasi dengan biaya bahan bakar yang diperbarui
    total_biaya_transportasi_query = BiayaTransportasi.query.with_entities(
        BiayaTransportasi.nama_daerah,
        (BiayaTransportasi.harga_tol + BiayaTransportasi.total_biaya_bahan_bakar).label('total_biaya_transportasi')
    )
    total_biaya_transportasi = total_biaya_transportasi_query.offset(offset).limit(per_page).all()

    # Query estimasi perjalanan
    estimasi_perjalanan_query = BiayaTransportasi.query.with_entities(
        BiayaTransportasi.nama_daerah, BiayaTransportasi.estimasi_perjalanan, BiayaTransportasi.jarak_daerah
    )
    estimasi_perjalanan = estimasi_perjalanan_query.offset(offset).limit(per_page).all()

    # Query biaya jalan tol
    biaya_jalan_tol_query = BiayaTransportasi.query.with_entities(
        BiayaTransportasi.nama_daerah, BiayaTransportasi.harga_tol
    )
    biaya_jalan_tol = biaya_jalan_tol_query.offset(offset).limit(per_page).all()

    total_pages = (total + per_page - 1) // per_page  # Calculate total pages

    return render_template('data_transportasi.html', 
                           total_biaya_transportasi=total_biaya_transportasi,
                           estimasi_perjalanan=estimasi_perjalanan,
                           biaya_jalan_tol=biaya_jalan_tol,
                           skala_biaya_bahan_bakar=skala_biaya_bahan_bakar,
                           biaya_bahan_bakar=biaya_transportasi,
                           page=page, per_page=per_page, total=total, total_pages=total_pages)



def update_total_biaya_transportasi():
    biaya_transportasi_records = BiayaTransportasi.query.all()
    for record in biaya_transportasi_records:
        record.total_biaya_transportasi = record.harga_tol + record.total_biaya_bahan_bakar
    db.session.commit()


@app.route('/edit_estimasi_perjalanan', methods=['GET', 'POST'])
@login_required
@role_required('Admin', 'Pengawas')
def edit_estimasi_perjalanan():
    if request.method == 'POST':
        data_estimasi_perjalanan = BiayaTransportasi.query.all()
        for row in data_estimasi_perjalanan:
            id = row.id
            row.estimasi_perjalanan = request.form[f'estimasi_perjalanan_{id}']
            row.jarak_daerah = request.form[f'jarak_daerah_{id}']
        db.session.commit()
        flash('Data estimasi perjalanan berhasil diupdate.', 'success')
        return redirect(url_for('data_transportasi'))

    data_estimasi_perjalanan = BiayaTransportasi.query.all()
    return render_template('edit_estimasi_perjalanan.html', data_estimasi_perjalanan=data_estimasi_perjalanan)

@app.route('/edit_skala_biaya_bahan_bakar', methods=['GET', 'POST'])
@login_required
@role_required('Admin')
def edit_skala_biaya_bahan_bakar():
    if request.method == 'POST':
        skala_biaya_bahan_bakar = SkalaBiayaBahanBakar.query.all()
        for row in skala_biaya_bahan_bakar:
            id = row.id
            row.rentang_jarak_minimal = request.form[f'rentang_jarak_minimal_{id}']
            row.rentang_jarak_maksimal = request.form[f'rentang_jarak_maksimal_{id}']
            row.biaya_bensin = request.form[f'biaya_bensin_{id}']
        db.session.commit()
        flash('Data skala biaya bahan bakar berhasil diupdate.', 'success')
        return redirect(url_for('data_transportasi'))

    skala_biaya_bahan_bakar = SkalaBiayaBahanBakar.query.all()
    return render_template('edit_skala_biaya_bahan_bakar.html', skala_biaya_bahan_bakar=skala_biaya_bahan_bakar)


@app.route('/data')
@login_required
def data():
    data_pegawai = DataPegawai.query.all()
    data_biaya_transportasi = BiayaTransportasi.query.all()
    data_harga_bensin = HargaBensin.query.first().harga

    for biaya in data_biaya_transportasi:
        daerah = DataPegawai.query.filter_by(nama_daerah=biaya.nama_daerah).first()
        if daerah:
            total_biaya = ((daerah.jarak_daerah / 14) * data_harga_bensin) + biaya.harga_tol
            if biaya.total_biaya_transportasi != total_biaya:
                biaya.total_biaya_transportasi = total_biaya
            
    db.session.commit()
    data_biaya_transportasi = BiayaTransportasi.query.all()  # Refresh data after update

    return render_template('data.html', data_pegawai=data_pegawai, data_biaya_transportasi=data_biaya_transportasi, data_harga_bensin=data_harga_bensin)

@app.route('/edit_data_pegawai', methods=['GET', 'POST'])
@login_required
def edit_data_pegawai():
    if request.method == 'POST':
        data_pegawai = DataPegawai.query.all()
        for row in data_pegawai:
            id = row.id
            row.nama_pegawai = request.form[f'nama_pegawai_{id}']
            row.nip = request.form[f'nip_{id}']
            row.jabatan = request.form[f'jabatan_{id}']
        db.session.commit()
        flash('Data pegawai berhasil diupdate.', 'success')
        return redirect(url_for('data_pegawai'))

    data_pegawai = DataPegawai.query.all()
    return render_template('edit_data_pegawai.html', data_pegawai=data_pegawai)

@app.route('/bobotkriteria')
@login_required
def bobotkriteria():
    data_bobot_kriteria = BobotKriteria.query.all()
    return render_template('bobotkriteria.html', data_bobot_kriteria=data_bobot_kriteria)


@app.route('/edit_biaya_tol', methods=['GET', 'POST'])
@login_required
def edit_biaya_tol():
    if current_user.roles not in ['Admin', 'Pengawas']:
        flash('Anda tidak memiliki akses untuk halaman ini.', 'danger')
        return redirect(url_for('data_transportasi'))

    if request.method == 'POST':
        try:
            data = request.form.getlist('harga_tol')
            ids = request.form.getlist('id')
            for i in range(len(ids)):
                biaya = BiayaTransportasi.query.get(ids[i])
                biaya.harga_tol = float(data[i].replace(',', ''))
                db.session.commit()
            flash('Data Biaya Jalan Tol berhasil diperbarui.', 'success')
        except Exception as e:
            flash(f'Gagal memperbarui data: {str(e)}', 'danger')

        return redirect(url_for('data_transportasi'))

    biaya_jalan_tol = BiayaTransportasi.query.with_entities(
        BiayaTransportasi.id, BiayaTransportasi.nama_daerah, BiayaTransportasi.harga_tol).all()

    return render_template('edit_biaya_tol.html', biaya_jalan_tol=biaya_jalan_tol)

@app.route('/edit_data_bobot', methods=['GET', 'POST'])
@login_required
def edit_data_bobot():
    if request.method == 'POST':
        data_bobot_kriteria = BobotKriteria.query.all()
        for row in data_bobot_kriteria:
            id = row.id
            row.nilai_kriteria = float(request.form[f'nilai_kriteria_{id}'])
        db.session.commit()
        flash('Data bobot kriteria berhasil diupdate.', 'success')
        return redirect(url_for('bobotkriteria'))

    data_bobot_kriteria = BobotKriteria.query.all()
    return render_template('edit_data_bobot.html', data_bobot_kriteria=data_bobot_kriteria)

@app.route('/logperhitungan')
@login_required
def logperhitungan():
    log_perhitungan = LogPerhitungan.query.all()
    return render_template('logperhitungan.html', log_perhitungan=log_perhitungan)

# @app.route('/perhitungan', methods=['GET', 'POST'])
# @login_required
# def perhitungan():
    if request.method == 'POST':
        data_pegawai = DataPegawai.query.all()
        data_biaya_transportasi = BiayaTransportasi.query.all()
        data_harga_bensin = HargaBensin.query.first().harga

        # Perhitungan Total Biaya Transportasi
        for biaya in data_biaya_transportasi:
            daerah = DataPegawai.query.filter_by(nama_daerah=biaya.nama_daerah).first()
            if daerah:
                total_biaya = ((daerah.jarak_daerah / 10) * data_harga_bensin) + biaya.harga_tol
                biaya.total_biaya_transportasi = total_biaya

        db.session.commit()
        data_biaya_transportasi = BiayaTransportasi.query.all()  # Refresh data after update

        # Sorting Min-Max
        sorted_biaya = sorted(data_biaya_transportasi, key=lambda x: x.total_biaya_transportasi)
        sorted_jarak = sorted(data_pegawai, key=lambda x: x.jarak_daerah)
        sorted_estimasi = sorted(data_pegawai, key=lambda x: x.estimasi_perjalanan)

        # Normalisasi
        normalisasi = []
        for i in range(len(data_pegawai)):
            row = {
                'nama_daerah': data_pegawai[i].nama_daerah,
                'biaya': sorted_biaya[0].total_biaya_transportasi / data_biaya_transportasi[i].total_biaya_transportasi,
                'jarak': sorted_jarak[0].jarak_daerah / data_pegawai[i].jarak_daerah,
                'estimasi': sorted_estimasi[0].estimasi_perjalanan / data_pegawai[i].estimasi_perjalanan
            }
            normalisasi.append(row)

        # Perhitungan Weighted Sum
        data_bobot_kriteria = BobotKriteria.query.all()
        weighted_sum = []
        for row in normalisasi:
            weighted_score = (
                data_bobot_kriteria[0].nilai_kriteria * row['biaya'] +
                data_bobot_kriteria[1].nilai_kriteria * row['jarak'] +
                data_bobot_kriteria[2].nilai_kriteria * row['estimasi']
            )
            weighted_sum.append({
                'nama_daerah': row['nama_daerah'],
                'weighted_sum': weighted_score
            })

        # Sorting dan Peringkat
        weighted_sum = sorted(weighted_sum, key=lambda x: x['weighted_sum'], reverse=True)
        for idx, row in enumerate(weighted_sum):
            row['peringkat'] = idx + 1

        # Kesimpulan
        kesimpulan = []
        for row in weighted_sum:
            if row['peringkat'] <= 6:
                jumlah_lokasi = 4
            elif row['peringkat'] <= 13:
                jumlah_lokasi = 3
            elif row['peringkat'] <= 19:
                jumlah_lokasi = 2
            else:
                jumlah_lokasi = 1
            kesimpulan.append({
                'nama_daerah': row['nama_daerah'],
                'peringkat': row['peringkat'],
                'jumlah_lokasi': jumlah_lokasi
            })
        
        # Save to log
        log_entry = LogPerhitungan(
            username=current_user.username
        )
        db.session.add(log_entry)
        db.session.commit()

        return {
            'normalisasi': render_template('partials/normalisasi_table.html', normalisasi=normalisasi),
            'weighted_sum': render_template('partials/weighted_sum_table.html', weighted_sum=weighted_sum),
            'kesimpulan': render_template('partials/kesimpulan_table.html', kesimpulan=kesimpulan)
        }

    data_pegawai = DataPegawai.query.all()
    data_biaya_transportasi = BiayaTransportasi.query.all()
    return render_template('perhitungan.html', 
                           data_pegawai=data_pegawai, 
                           data_biaya_transportasi=data_biaya_transportasi)

@app.route('/perencanaan', methods=['GET'])
@login_required
def perencanaan():
    # Query untuk mendapatkan data biaya transportasi dan estimasi perjalanan
    biaya_transportasi = BiayaTransportasi.query.all()
    biaya_tertinggi = max(b.total_biaya_transportasi for b in biaya_transportasi)
    biaya_terendah = min(b.total_biaya_transportasi for b in biaya_transportasi)
    estimasi_tertinggi = max(b.estimasi_perjalanan for b in biaya_transportasi)
    estimasi_terendah = min(b.estimasi_perjalanan for b in biaya_transportasi)
    tol_tertinggi = max(b.harga_tol for b in biaya_transportasi)
    tol_terendah = min(b.harga_tol for b in biaya_transportasi)

    return render_template('perencanaan.html', 
                           biaya_tertinggi=biaya_tertinggi,
                           biaya_terendah=biaya_terendah,
                           estimasi_tertinggi=estimasi_tertinggi,
                           estimasi_terendah=estimasi_terendah,
                           tol_tertinggi=tol_tertinggi,
                           tol_terendah=tol_terendah)


@app.route('/generate_perencanaan', methods=['POST'])
@login_required
def generate_perencanaan():
    # Mendapatkan 27 kota dari database atau daftar tetap
    daftar_daerah = [
        'Kota Bandung', 'Kabupaten Bandung', 'Kota Bekasi', 'Kabupaten Bekasi', 
        'Kota Bogor', 'Kabupaten Bogor', 'Kota Cimahi', 'Kabupaten Cirebon',
        'Kota Cirebon', 'Kota Depok', 'Kota Sukabumi', 'Kabupaten Sukabumi',
        'Kota Tasikmalaya', 'Kabupaten Tasikmalaya', 'Kabupaten Bandung Barat',
        'Kabupaten Ciamis', 'Kabupaten Cianjur', 'Kabupaten Garut', 
        'Kabupaten Indramayu', 'Kabupaten Karawang', 'Kabupaten Kuningan', 
        'Kabupaten Majalengka', 'Kabupaten Pangandaran', 'Kabupaten Purwakarta', 
        'Kabupaten Subang', 'Kabupaten Sumedang', 'Kabupaten Indramayu'
    ]

    # Dapatkan data dari tabel BiayaTransportasi
    biaya_transportasi = BiayaTransportasi.query.all()
    biaya_tertinggi = max(b.total_biaya_transportasi for b in biaya_transportasi)
    biaya_terendah = min(b.total_biaya_transportasi for b in biaya_transportasi)

    # Persiapkan data untuk tabel
    table_rows = ""
    for i, daerah in enumerate(daftar_daerah):
        biaya_daerah = next((b.total_biaya_transportasi for b in biaya_transportasi if b.nama_daerah == daerah), 0)
        table_rows += f"""
        <tr>
            <td>{i + 1}</td>
            <td class="nama-daerah">{daerah}</td>
            <td>
                <input type="text" class="nama-pelaku-usaha" name="pelaku_usaha_{i}_1">
                <input type="text" class="nama-pelaku-usaha" name="pelaku_usaha_{i}_2">
            </td>
            <td class="status-lokasi">Belum Terawasi</td>
            <td>
                <input type="text" class="pengawas" name="pengawas_{i}_1">
                <input type="text" class="pengawas" name="pengawas_{i}_2">
                <input type="text" class="pengawas" name="pengawas_{i}_3">
                <input type="text" class="pengawas" name="pengawas_{i}_4">
            </td>

            <td class="status-pengawasan">Belum Terawasi</td>
            <td class="indikasi-pelanggaran">Tidak</td>
            <td class="status-tindak-lanjut-pelanggaran">Tidak Ada</td>
            <td><textarea class="catatan" name="catatan_{i}"></textarea></td>
            <td class="anggaran-biaya">Rp {biaya_daerah}</td>
        </tr>
        """

    return jsonify({"table_rows": table_rows})


@app.route('/simpan_perencanaan', methods=['POST'])
@login_required
def simpan_perencanaan():
    planning_data = request.json.get('planningData')

    # Mulai blok pertama untuk LogPerhitungan
    try:
        log_entry = LogPerhitungan(username=current_user.nama_pengguna)
        db.session.add(log_entry)
        db.session.commit()
    except Exception as e:
        db.session.rollback()
        logging.error("Gagal menyimpan LogPerhitungan: %s", str(e))
        flash('Gagal menyimpan log perhitungan.', 'error')
        return jsonify({'status': 'error', 'message': 'Gagal menyimpan log perhitungan: ' + str(e)})

    # Blok kedua untuk HasilPerencanaan
    try:
        for data in planning_data:
            pelaku_usaha_1 = DataPelakuUsaha.query.filter_by(nama_pelaku_usaha=data.get('nama_pelaku_usaha_1', '')).first()
            pelaku_usaha_2 = DataPelakuUsaha.query.filter_by(nama_pelaku_usaha=data.get('nama_pelaku_usaha_2', '')).first()
            
            hasil_entry = HasilPerencanaan(
                log_id=log_entry.id,
                nama_daerah=data['nama_daerah'],
                pelaku_usaha_id_1=pelaku_usaha_1.id if pelaku_usaha_1 else None,
                pelaku_usaha_id_2=pelaku_usaha_2.id if pelaku_usaha_2 else None,
                pengawas_1=data.get('pengawas_1', ''),
                pengawas_2=data.get('pengawas_2', ''),
                pengawas_3=data.get('pengawas_3', ''),
                pengawas_4=data.get('pengawas_4', ''),
                status_pengawasan=data['status_pengawasan'],
                indikasi_pelanggaran=data['indikasi_pelanggaran'] == 'Ya',
                status_pelanggaran=data['status_tindak_lanjut_pelanggaran'],
                catatan=data['catatan'],
                anggaran_biaya=float(data['anggaran_biaya'].replace('Rp ', '').replace(',', '')) if data.get('anggaran_biaya') else 0.0
            )
            db.session.add(hasil_entry)
        db.session.commit()
    except Exception as e:
        db.session.rollback()
        logging.error("Gagal menyimpan hasil perencanaan: %s", str(e))
        flash('Gagal menyimpan hasil perencanaan.', 'error')
        return jsonify({'status': 'error', 'message': 'Gagal menyimpan hasil perencanaan: ' + str(e)})

    # Jika semua langkah berhasil, berikan respons sukses
    flash('Perencanaan berhasil disimpan!', 'success')
    return jsonify({'status': 'success'})





@app.route('/riwayat_perhitungan')
@login_required
def riwayat_perhitungan():
    search_tanggal = request.args.get('search_tanggal')
    user_role = current_user.roles
    user_nama = current_user.nama_pengguna    
    log_lengkapi_data = LogPerhitungan.query.filter_by(status='Lengkapi Data')
    log_sedang_berlangsung = LogPerhitungan.query.filter_by(status='Sedang Berlangsung')
    query_selesai = LogPerhitungan.query.filter_by(status='Selesai')    

    # Filter berdasarkan role dan nama pengguna jika role-nya adalah Pengawas
    if user_role == 'Pengawas':
        log_lengkapi_data = log_lengkapi_data.join(HasilPerencanaan).filter(
            db.or_(
                HasilPerencanaan.pengawas_1 == user_nama,
                HasilPerencanaan.pengawas_2 == user_nama,
                HasilPerencanaan.pengawas_3 == user_nama,
                HasilPerencanaan.pengawas_4 == user_nama
            )
        )
        
        log_sedang_berlangsung = log_sedang_berlangsung.join(HasilPerencanaan).filter(
            db.or_(
                HasilPerencanaan.pengawas_1 == user_nama,
                HasilPerencanaan.pengawas_2 == user_nama,
                HasilPerencanaan.pengawas_3 == user_nama,
                HasilPerencanaan.pengawas_4 == user_nama
            )
        )
        
        query_selesai = query_selesai.join(HasilPerencanaan).filter(
            db.or_(
                HasilPerencanaan.pengawas_1 == user_nama,
                HasilPerencanaan.pengawas_2 == user_nama,
                HasilPerencanaan.pengawas_3 == user_nama,
                HasilPerencanaan.pengawas_4 == user_nama
            )
        )

    if search_tanggal:
        log_lengkapi_data = log_lengkapi_data.filter(func.date(LogPerhitungan.tanggal) == search_tanggal)
        log_sedang_berlangsung = log_sedang_berlangsung.filter(func.date(LogPerhitungan.tanggal) == search_tanggal)
        query_selesai = query_selesai.filter(func.date(LogPerhitungan.tanggal) == search_tanggal)

    log_lengkapi_data = log_lengkapi_data.all()
    log_sedang_berlangsung = log_sedang_berlangsung.all()
    log_selesai = query_selesai.all()

    return render_template('riwayat_perhitungan.html', 
                           log_lengkapi_data=log_lengkapi_data, 
                           log_sedang_berlangsung=log_sedang_berlangsung, 
                           log_selesai=log_selesai)

@app.route('/download_hasil_pengawasan/<int:log_id>')
@login_required
def download_hasil_pengawasan(log_id):
    log_entry = LogPerhitungan.query.get_or_404(log_id)
    hasil_perencanaan = HasilPerencanaan.query.filter_by(log_id=log_id).all()
    barang_pengawasan = BarangPengawasan.query.filter_by(log_id=log_id).all()

    buffer = BytesIO()
    doc = SimpleDocTemplate(buffer, pagesize=A4)
    elements = []
    styles = getSampleStyleSheet()

    # Title
    elements.append(Paragraph("Laporan Hasil Pengawasan", styles['Title']))
    elements.append(Paragraph(f"Tanggal: {log_entry.tanggal}", styles['Normal']))
    elements.append(Spacer(1, 12))

    # Detail Perencanaan
    elements.append(Paragraph("Detail Perencanaan", styles['Heading2']))
    table_data = [
        ['Nama Daerah', 'Pelaku Usaha 1', 'Pelaku Usaha 2', 'Status Pengawasan', 'Indikasi Pelanggaran']
    ]
    for hasil in hasil_perencanaan:
        table_data.append([
            hasil.nama_daerah,
            hasil.pelaku_usaha_1.nama_pelaku_usaha if hasil.pelaku_usaha_1 else 'Tidak Ada',
            hasil.pelaku_usaha_2.nama_pelaku_usaha if hasil.pelaku_usaha_2 else 'Tidak Ada',
            hasil.status_pengawasan,
            hasil.indikasi_pelanggaran
        ])
    table = Table(table_data)
    table.setStyle(TableStyle([
        ('BACKGROUND', (0, 0), (-1, 0), colors.grey),
        ('TEXTCOLOR', (0, 0), (-1, 0), colors.whitesmoke),
        ('ALIGN', (0, 0), (-1, -1), 'CENTER'),
        ('FONTNAME', (0, 0), (-1, 0), 'Helvetica-Bold'),
        ('BOTTOMPADDING', (0, 0), (-1, 0), 12),
        ('BACKGROUND', (0, 1), (-1, -1), colors.beige),
        ('GRID', (0, 0), (-1, -1), 1, colors.black),
    ]))
    elements.append(table)
    elements.append(Spacer(1, 12))

    # Detail Barang Pengawasan
    elements.append(Paragraph("Detail Barang Pengawasan", styles['Heading2']))
    for barang in barang_pengawasan:
        elements.append(Paragraph(f"Nama Barang: {barang.nama_barang}", styles['Normal']))
        elements.append(Paragraph(f"Merk: {barang.merk_barang}", styles['Normal']))
        elements.append(Paragraph(f"Jenis Pelanggaran: {barang.jenis_pelanggaran or 'Tidak Ada'}", styles['Normal']))
        elements.append(Spacer(1, 12))

    # Grafik Pelanggaran per Daerah
    elements.append(Paragraph("Grafik Pelanggaran per Daerah", styles['Heading2']))

    daerah_names = [hasil.nama_daerah for hasil in hasil_perencanaan]
    pelanggaran_counts = [len([b for b in barang_pengawasan if b.jenis_pelanggaran and b.pelaku_usaha_id == hasil.id]) for hasil in hasil_perencanaan]

    fig, ax = plt.subplots(figsize=(8, 4))
    ax.bar(daerah_names, pelanggaran_counts, color='skyblue')
    ax.set_xlabel('Nama Daerah')
    ax.set_ylabel('Jumlah Pelanggaran')
    ax.set_title('Jumlah Pelanggaran per Daerah')
    ax.xaxis.set_major_locator(ticker.MaxNLocator(nbins=6))
    ax.tick_params(axis='x', rotation=45)

    # Simpan grafik ke dalam buffer
    img_buffer = BytesIO()
    plt.savefig(img_buffer, format='png')
    img_buffer.seek(0)
    plt.close()

    # Tambahkan grafik ke dalam PDF
    image = Image(img_buffer)
    image.drawHeight = 2*inch
    image.drawWidth = 6*inch
    elements.append(image)

    # Build PDF
    doc.build(elements)

    buffer.seek(0)
    return send_file(buffer, as_attachment=True, download_name=f'Hasil_Pengawasan_{log_entry.tanggal}.pdf')


@app.route('/butuh_penanganan/<int:log_id>', methods=['GET', 'POST'])
@login_required
def butuh_penanganan(log_id):
    log_entry = LogPerhitungan.query.get_or_404(log_id)

    hasil_perencanaan_entries = HasilPerencanaan.query.filter_by(log_id=log_id).all()
    
    for entry in hasil_perencanaan_entries:
        if entry.status_lokasi_1 == 'Sudah Terawasi' and entry.status_lokasi_2 == 'Sudah Terawasi':
            entry.status_pengawasan = 'Selesai Terawasi'
        elif entry.status_lokasi_1 == 'Sudah Terawasi' or entry.status_lokasi_2 == 'Sudah Terawasi':
            entry.status_pengawasan = 'Terawasi Sebagian'
        else:
            entry.status_pengawasan = 'Belum Terawasi'
    
    db.session.commit()

    pelanggaran_pelaku_usaha_1 = False
    pelanggaran_pelaku_usaha_2 = False
    
    if request.method == 'POST':
        hasil_perencanaan_data = request.get_json()
        print(hasil_perencanaan_data)  # Debugging line to print received data
        
        for entry_id, data in hasil_perencanaan_data.items():
            entry = HasilPerencanaan.query.get(entry_id)
            
            if entry:
                print(f"Updating HasilPerencanaan for entry_id: {entry_id}, pelaku_usaha_id_1: {data.get('pelaku_usaha_1')}, pelaku_usaha_id_2: {data.get('pelaku_usaha_2')}")
                entry.pelaku_usaha_id_1 = data.get('pelaku_usaha_1', None)
                entry.pelaku_usaha_id_2 = data.get('pelaku_usaha_2', None)
                entry.status_lokasi_1 = data.get('status_lokasi_1', 'Belum Terawasi')
                entry.status_lokasi_2 = data.get('status_lokasi_2', 'Belum Terawasi')
                entry.pengawas_1 = data.get('pengawas_1', '')
                entry.pengawas_2 = data.get('pengawas_2', '')
                entry.pengawas_3 = data.get('pengawas_3', '')
                entry.pengawas_4 = data.get('pengawas_4', '')
                entry.status_pengawasan = data.get('status_pengawasan', 'Belum Terawasi')
                entry.catatan = data.get('catatan', '') or ''
                entry.anggaran_biaya = data.get('anggaran_biaya', '') or ''
                entry.status_pelanggaran = data.get('status_pelanggaran', 'Tidak Ada')
                entry.status_tindak_lanjut_pelanggaran = data.get('status_tindak_lanjut_pelanggaran', 'Tidak Ada')

        db.session.commit()
        return jsonify({'status': 'success'})
    
    # Start of the GET request handling
    for entry in hasil_perencanaan_entries:
        # Check if pelaku usaha 1 has any violations
        pelanggaran_pelaku_usaha_1 = BarangPengawasan.query.filter(
            BarangPengawasan.log_id == log_id,
            BarangPengawasan.pelaku_usaha_id == entry.pelaku_usaha_id_1,
            db.or_(
                BarangPengawasan.sni == 'Tidak Sesuai',
                BarangPengawasan.mkg == 'Tidak Sesuai',
                BarangPengawasan.label == 'Tidak Sesuai',
                BarangPengawasan.k3l == 'Tidak Sesuai'
            )
        ).first() is not None

        # Check if pelaku usaha 2 has any violations
        pelanggaran_pelaku_usaha_2 = BarangPengawasan.query.filter(
            BarangPengawasan.log_id == log_id,
            BarangPengawasan.pelaku_usaha_id == entry.pelaku_usaha_id_2,
            db.or_(
                BarangPengawasan.sni == 'Tidak Sesuai',
                BarangPengawasan.mkg == 'Tidak Sesuai',
                BarangPengawasan.label == 'Tidak Sesuai',
                BarangPengawasan.k3l == 'Tidak Sesuai'
            )
        ).first() is not None

        # Save the status back to entry
        entry.status_pelanggaran_pelaku_usaha_1 = pelanggaran_pelaku_usaha_1
        entry.status_pelanggaran_pelaku_usaha_2 = pelanggaran_pelaku_usaha_2

    # Mengelompokkan pelaku usaha berdasarkan nama daerah
    pelaku_usaha_dict = {}
    for daerah in set(entry.nama_daerah for entry in hasil_perencanaan_entries):
        pelaku_usaha_dict[daerah] = DataPelakuUsaha.query.filter_by(nama_daerah=daerah).all()
    
    data_pegawai = DataPegawai.query.all()  # Mendapatkan semua pengawas

    return render_template('butuh_penanganan.html', log_entry=log_entry, 
                           hasil_perencanaan_entries=hasil_perencanaan_entries, 
                           pelaku_usaha_dict=pelaku_usaha_dict, 
                           data_pegawai=data_pegawai)


@app.route('/tambah_data_pengawasan/<int:log_id>', methods=['GET', 'POST'])
@login_required
def tambah_data_pengawasan(log_id):
    if request.method == 'GET':
        # Ambil daftar semua daerah unik dari tabel DataPelakuUsaha
        daftar_daerah = db.session.query(DataPelakuUsaha.nama_daerah).distinct().all()
        daftar_daerah = [daerah[0] for daerah in daftar_daerah]  # Ubah dari list of tuples ke list of strings

        # Ambil daftar semua pegawai
        data_pegawai = DataPegawai.query.all()

        return render_template('tambah_data_pengawasan.html', daftar_daerah=daftar_daerah, data_pegawai=data_pegawai, log_id=log_id)
    
    elif request.method == 'POST':
        data = request.form
        nama_daerah = data.get('nama_daerah')
        nama_pelaku_usaha_1 = data.get('nama_pelaku_usaha_1')
        nama_pelaku_usaha_2 = data.get('nama_pelaku_usaha_2')
        pelaku_usaha_1 = DataPelakuUsaha.query.filter_by(nama_pelaku_usaha=nama_pelaku_usaha_1, nama_daerah=nama_daerah).first()
        pelaku_usaha_2 = DataPelakuUsaha.query.filter_by(nama_pelaku_usaha=nama_pelaku_usaha_2, nama_daerah=nama_daerah).first()
        pengawas_1 = data.get('pengawas_1')
        pengawas_2 = data.get('pengawas_2')
        pengawas_3 = data.get('pengawas_3')
        pengawas_4 = data.get('pengawas_4')

        # Cek apakah sudah ada entri untuk nama_daerah dalam log_id yang sama
        hasil_perencanaan_entry = HasilPerencanaan.query.filter_by(log_id=log_id, nama_daerah=nama_daerah).first()

        if hasil_perencanaan_entry:
            # Jika entri sudah ada, update data yang ada
            hasil_perencanaan_entry.pelaku_usaha_id_1 = pelaku_usaha_1.id if pelaku_usaha_1 else None
            hasil_perencanaan_entry.pelaku_usaha_id_2 = pelaku_usaha_2.id if pelaku_usaha_2 else None
            hasil_perencanaan_entry.pengawas_1 = pengawas_1
            hasil_perencanaan_entry.pengawas_2 = pengawas_2
            hasil_perencanaan_entry.pengawas_3 = pengawas_3
            hasil_perencanaan_entry.pengawas_4 = pengawas_4
        else:
            # Jika entri tidak ada, buat entri baru
            hasil_perencanaan_entry = HasilPerencanaan(
                log_id=log_id,
                nama_daerah=nama_daerah,
                pelaku_usaha_id_1=pelaku_usaha_1.id if pelaku_usaha_1 else None,
                pelaku_usaha_id_2=pelaku_usaha_2.id if pelaku_usaha_2 else None,
                pengawas_1=pengawas_1,
                pengawas_2=pengawas_2,
                pengawas_3=pengawas_3,
                pengawas_4=pengawas_4,
                status_lokasi='Belum Terawasi',
                status_pengawasan='Belum Terawasi',
                indikasi_pelanggaran='Tidak',
                status_pelanggaran='Tidak Ada',
                status_tindak_lanjut_pelanggaran='Tidak Ada',
                anggaran_biaya=0  # Atur sesuai kebutuhan
            )

        db.session.add(hasil_perencanaan_entry)
        db.session.commit()

        flash('Data pengawasan berhasil ditambahkan.', 'success')
        return redirect(url_for('butuh_penanganan', log_id=log_id))


@app.route('/get_pelaku_usaha', methods=['GET'])
@login_required
def get_pelaku_usaha():
    daerah = request.args.get('daerah')
    pelaku_usaha = DataPelakuUsaha.query.filter_by(nama_daerah=daerah).all()
    return jsonify({'pelaku_usaha': [{'nama_pelaku_usaha': p.nama_pelaku_usaha} for p in pelaku_usaha]})

@app.route('/detail_pengawasan/<int:log_id>/<int:pelaku_usaha_id>', methods=['GET', 'POST'])
@login_required
def detail_pengawasan(log_id, pelaku_usaha_id):
    log_entry = LogPerhitungan.query.get_or_404(log_id)
    
    # Ambil entri perencanaan berdasarkan pelaku usaha ID
    entry = HasilPerencanaan.query.filter(
        HasilPerencanaan.log_id == log_id,
        (HasilPerencanaan.pelaku_usaha_id_1 == pelaku_usaha_id) | 
        (HasilPerencanaan.pelaku_usaha_id_2 == pelaku_usaha_id)
    ).first_or_404()

    indikasi_pelanggaran = 'Tidak'

    if request.method == 'POST':
                print("Data yang diterima dari form:")
                print(request.form)
                # Lakukan iterasi melalui setiap barang pengawasan
                for barang in BarangPengawasan.query.filter_by(log_id=log_id, pelaku_usaha_id=pelaku_usaha_id).all():
                    barang.sni = request.form.get(f'sni_{barang.id}', 'Tidak Dicek')
                    barang.mkg = request.form.get(f'mkg_{barang.id}', 'Tidak Dicek')
                    barang.label = request.form.get(f'label_{barang.id}', 'Tidak Dicek')
                    barang.k3l = request.form.get(f'k3l_{barang.id}', 'Tidak Dicek')
                    barang.keterangan = request.form.get(f'keterangan_{barang.id}', '')

                    # Cek apakah ada yang tidak sesuai
                    if barang.sni == 'Tidak Sesuai' or barang.mkg == 'Tidak Sesuai' or barang.label == 'Tidak Sesuai' or barang.k3l == 'Tidak Sesuai':
                        indikasi_pelanggaran = 'Ya'
                
                # Update status lokasi di HasilPerencanaan
                if entry.pelaku_usaha_id_1 == pelaku_usaha_id:
                    print(f"Updating status_lokasi_1 for pelaku_usaha_id_1: {entry.pelaku_usaha_id_1}")
                    entry.status_lokasi_1 = request.form.get(f'status_lokasi_{barang.id}', entry.status_lokasi_1)
                elif entry.pelaku_usaha_id_2 == pelaku_usaha_id:
                    print(f"Updating status_lokasi_2 for pelaku_usaha_id_2: {entry.pelaku_usaha_id_2}")
                    entry.status_lokasi_2 = request.form.get(f'status_lokasi_{barang.id}', entry.status_lokasi_2)
                else:
                    print("pelaku_usaha_id does not match either pelaku_usaha_id_1 or pelaku_usaha_id_2")
                    
                    # Simpan berkas hasil pengawasan jika ada
                    berkas = request.files.get(f'berkas_{barang.id}')
                    if berkas and allowed_file(berkas.filename):
                        filename = secure_filename(berkas.filename)
                        berkas.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
                        barang.berkas_hasil_pengawasan = filename

                entry.indikasi_pelanggaran = indikasi_pelanggaran

                db.session.commit()
                print("Data after commit:")
                print(f"Status Lokasi 1: {entry.status_lokasi_1}")
                print(f"Status Lokasi 2: {entry.status_lokasi_2}")

                flash('Perubahan berhasil disimpan.', 'success')
                return redirect(url_for('detail_pengawasan', log_id=log_id, pelaku_usaha_id=pelaku_usaha_id))
    
    barang_pengawasan = BarangPengawasan.query.filter_by(log_id=log_id, pelaku_usaha_id=pelaku_usaha_id).all()
    
    return render_template('detail_pengawasan.html', log_entry=log_entry, entry=entry, barang_pengawasan=barang_pengawasan, pelaku_usaha_id=pelaku_usaha_id)

@app.route('/tambah_barang_pengawasan/<int:log_id>/<int:pelaku_usaha_id>', methods=['GET', 'POST'])
@login_required
def tambah_barang_pengawasan(log_id, pelaku_usaha_id):
    if request.method == 'POST':
        # Ambil data dari form
        penanggung_jawab = request.form['penanggung_jawab']
        nama_barang = request.form['nama_barang']
        merk_barang = request.form['merk_barang']

        # Debugging to check pelaku_usaha_id
        print(f"Received pelaku_usaha_id: {pelaku_usaha_id}")
        print(f"Form data - Penanggung Jawab: {penanggung_jawab}, Nama Barang: {nama_barang}, Merk Barang: {merk_barang}")
        print(f"Form initiated for pelaku_usaha_id: {pelaku_usaha_id}")


        # Tambahkan entri baru ke HasilPerencanaan
        barang = BarangPengawasan(
            log_id=log_id,
            pelaku_usaha_id=pelaku_usaha_id,  # atau pelaku_usaha_id_2 tergantung konteks
            penanggung_jawab=penanggung_jawab,
            nama_barang=nama_barang,
            merk_barang=merk_barang
        )

        db.session.add(barang)
        db.session.commit()

        print(f"Barang added to pelaku_usaha_id: {pelaku_usaha_id}")
        flash('Barang pengawasan berhasil ditambahkan.', 'success')
        return redirect(url_for('detail_pengawasan', log_id=log_id, pelaku_usaha_id=pelaku_usaha_id))
    # Ambil data pengawas dari HasilPerencanaan yang sesuai
    entry = HasilPerencanaan.query.filter_by(log_id=log_id, pelaku_usaha_id_1=pelaku_usaha_id).first()
    if not entry:
        entry = HasilPerencanaan.query.filter_by(log_id=log_id, pelaku_usaha_id_2=pelaku_usaha_id).first_or_404()

    print(f"Entry found for pelaku_usaha_id: {pelaku_usaha_id}, Pengawas: {entry.pengawas_1}")
    print(f"Using pelaku_usaha_id_1: {entry.pelaku_usaha_id_1}, pelaku_usaha_id_2: {entry.pelaku_usaha_id_2}")
    # Jika GET, ambil data pengawas sesuai daerah
    pengawas_daerah = [entry.pengawas_1, entry.pengawas_2, entry.pengawas_3, entry.pengawas_4]
    return render_template('tambah_barang_pengawasan.html', pengawas_daerah=pengawas_daerah, log_id=log_id, pelaku_usaha_id=pelaku_usaha_id)


@app.route('/add_barang_pengawasan', methods=['POST'])
@login_required
def add_barang_pengawasan():
    # Ambil data dari form
    penanggung_jawab = request.form.get('penanggung_jawab')
    nama_barang = request.form.get('nama_barang')
    merk_barang = request.form.get('merk_barang')
    log_id = request.form.get('log_id')
    pelaku_usaha_id = request.form.get('pelaku_usaha_id')

    # Debugging input data
    print(f"Received form data: penanggung_jawab={penanggung_jawab}, nama_barang={nama_barang}, merk_barang={merk_barang}, log_id={log_id}, pelaku_usaha_id={pelaku_usaha_id}")

    # Validasi data
    if not penanggung_jawab or not nama_barang or not merk_barang:
        flash('Semua field harus diisi!', 'danger')
        return redirect(url_for('tambah_barang_pengawasan', log_id=log_id, pelaku_usaha_id=pelaku_usaha_id))
    

    # Ambil entry dari HasilPerencanaan berdasarkan log_id dan pelaku_usaha_id
    entry = HasilPerencanaan.query.filter_by(log_id=log_id, pelaku_usaha_id_1=pelaku_usaha_id).first()
    
    if entry:
        print(f"Entry found for pelaku_usaha_id_1: {pelaku_usaha_id}")
    else:
        entry = HasilPerencanaan.query.filter_by(log_id=log_id, pelaku_usaha_id_2=pelaku_usaha_id).first_or_404()
        print(f"Entry found for pelaku_usaha_id_2: {pelaku_usaha_id}")
    # Buat entri baru di tabel HasilPerencanaan dengan barang baru
    barang = BarangPengawasan(
        log_id=log_id,
        pelaku_usaha_id=pelaku_usaha_id,
        penanggung_jawab=penanggung_jawab,
        nama_barang=nama_barang,
        merk_barang=merk_barang,
        sni='Tidak Dicek',
        mkg='Tidak Dicek',
        label='Tidak Dicek',
        k3l='Tidak Dicek',
    )

    print(f"Saving BarangPengawasan for pelaku_usaha_id: {pelaku_usaha_id}")

    db.session.add(barang)
    db.session.commit()

    print(f"BarangPengawasan saved successfully for pelaku_usaha_id: {pelaku_usaha_id}")
    flash('Barang pengawasan berhasil ditambahkan.', 'success')
    return redirect(url_for('detail_pengawasan', log_id=log_id, pelaku_usaha_id=pelaku_usaha_id))


@app.route('/edit_barang_pengawasan/<int:id>', methods=['GET'])
@login_required
def edit_barang_pengawasan(id):
    barang = BarangPengawasan.query.get_or_404(id)
    
    # Ambil data pengawas dari HasilPerencanaan yang sesuai
    entry = HasilPerencanaan.query.filter_by(log_id=barang.log_id, pelaku_usaha_id_1=barang.pelaku_usaha_id).first()
    if not entry:
        entry = HasilPerencanaan.query.filter_by(log_id=barang.log_id, pelaku_usaha_id_2=barang.pelaku_usaha_id).first_or_404()

    pengawas_daerah = [entry.pengawas_1, entry.pengawas_2, entry.pengawas_3, entry.pengawas_4]
    
    return render_template('edit_barang_pengawasan.html', barang=barang, pengawas_daerah=pengawas_daerah)

@app.route('/update_barang_pengawasan/<int:id>', methods=['POST'])
@login_required
def update_barang_pengawasan(id):
    barang = BarangPengawasan.query.get_or_404(id)

    # Update data barang berdasarkan input dari form
    barang.penanggung_jawab = request.form['penanggung_jawab']
    barang.nama_barang = request.form['nama_barang']
    barang.merk_barang = request.form['merk_barang']

    db.session.commit()

    flash('Barang pengawasan berhasil diperbarui.', 'success')
    return redirect(url_for('detail_pengawasan', log_id=barang.log_id, pelaku_usaha_id=barang.pelaku_usaha_id))


@app.route('/hapus_barang_pengawasan/<int:barang_id>', methods=['POST'])
@login_required
def hapus_barang_pengawasan(barang_id):
    barang = BarangPengawasan.query.get_or_404(barang_id)

    db.session.delete(barang)
    db.session.commit()

    return jsonify({'message': 'Data berhasil dihapus'})



@app.route('/tindak_lanjut_pelanggaran/<int:log_id>/<int:pelaku_usaha_id>')
@login_required
def tindak_lanjut_pelanggaran(log_id, pelaku_usaha_id):
    log_entry = LogPerhitungan.query.get_or_404(log_id)

    # Ambil entry dari HasilPerencanaan terkait log_id
    entry = HasilPerencanaan.query.filter(
        HasilPerencanaan.log_id == log_id,
        (HasilPerencanaan.pelaku_usaha_id_1 == pelaku_usaha_id) | 
        (HasilPerencanaan.pelaku_usaha_id_2 == pelaku_usaha_id)
    ).first_or_404()

    # Debugging pelaku usaha ID
    print(f"Accessing tindak lanjut for Log ID: {log_id}, Pelaku Usaha ID: {pelaku_usaha_id}")
    print(f"Pelaku Usaha 1: {entry.pelaku_usaha_id_1}, Pelaku Usaha 2: {entry.pelaku_usaha_id_2}")

    # Ambil semua barang pengawasan dari kedua pelaku usaha yang memiliki parameter "Tidak Sesuai"
    barang_tidak_sesuai = BarangPengawasan.query.filter(
        BarangPengawasan.log_id == log_id,
        BarangPengawasan.pelaku_usaha_id == pelaku_usaha_id,  # Menggunakan pelaku_usaha_id yang diteruskan dari URL
        db.or_(
            BarangPengawasan.sni == 'Tidak Sesuai',
            BarangPengawasan.mkg == 'Tidak Sesuai',
            BarangPengawasan.label == 'Tidak Sesuai',
            BarangPengawasan.k3l == 'Tidak Sesuai'
        )
    ).all()

    # Menyiapkan data untuk dikirim ke template
    pelanggaran_data = []
    for barang in barang_tidak_sesuai:
        jenis_pelanggaran_list = []
        
        if barang.sni == 'Tidak Sesuai':
            jenis_pelanggaran_list.append("SNI")
        if barang.mkg == 'Tidak Sesuai':
            jenis_pelanggaran_list.append("MKG")
        if barang.label == 'Tidak Sesuai':
            jenis_pelanggaran_list.append("Label")
        if barang.k3l == 'Tidak Sesuai':
            jenis_pelanggaran_list.append("K3L")

        # Tentukan jenis pelanggaran berdasarkan jumlah item di jenis_pelanggaran_list
        if len(jenis_pelanggaran_list) > 2:
            jenis_pelanggaran = ", ".join(jenis_pelanggaran_list) + " Tidak Sesuai"
        elif len(jenis_pelanggaran_list) == 2:
            jenis_pelanggaran = " & ".join(jenis_pelanggaran_list) + " Tidak Sesuai"
        elif len(jenis_pelanggaran_list) == 1:
            jenis_pelanggaran = jenis_pelanggaran_list[0] + " Tidak Sesuai"
        else:
            jenis_pelanggaran = "Tidak Sesuai"

        print(f"Jenis Pelanggaran untuk {barang.nama_barang}: {jenis_pelanggaran}")
        
        pelanggaran_data.append({
            "id": barang.id, 
            "jenis_pelanggaran": jenis_pelanggaran,
            "nama_barang": barang.nama_barang,
            "merk_barang": barang.merk_barang,
            "nama_distributor": barang.nama_distributor or "",  # Tempat untuk menambahkan nama distributor
            "keterangan": barang.keterangan or "",  # Tempat untuk menambahkan keterangan tambahan
            "bukti_pengembalian": barang.bukti_pengembalian_barang,  # Berkas hasil pengawasan
            "tindak_lanjut": "",  # Tempat untuk menambahkan tindak lanjut
        })

    # Render template dan kirimkan entry ke template
    return render_template('tindak_lanjut_pelanggaran.html', log_entry=log_entry, pelanggaran_data=pelanggaran_data, pelaku_usaha_id=pelaku_usaha_id, entry=entry)


@app.route('/simpan_tindak_lanjut_pelanggaran', methods=['POST'])
@login_required
def simpan_tindak_lanjut_pelanggaran():
    print("==== Start simpan_tindak_lanjut_pelanggaran ====")
    log_id = request.form.get('log_id')
    pelaku_usaha_id = request.form.get('pelaku_usaha_id')

    print(f"log_id: {log_id}, pelaku_usaha_id: {pelaku_usaha_id}")
    if not log_id or not pelaku_usaha_id:
        flash('Terjadi kesalahan: log_id atau pelaku_usaha_id tidak valid.', 'error')
        return redirect(request.referrer)

    entry = HasilPerencanaan.query.filter(
        HasilPerencanaan.log_id == log_id,
        (HasilPerencanaan.pelaku_usaha_id_1 == pelaku_usaha_id) | 
        (HasilPerencanaan.pelaku_usaha_id_2 == pelaku_usaha_id)
    ).first_or_404()

    print("Form data received:")
    print(request.form)

    # Ambil status tindak lanjut dari form dan simpan ke HasilPerencanaan
    status_tindak_lanjut = request.form.get('status_tindak_lanjut_pelanggaran')
    print(f"Updating status_tindak_lanjut_pelanggaran to: {status_tindak_lanjut}")

    entry.status_tindak_lanjut_pelanggaran = status_tindak_lanjut

    for key in request.form.keys():
        if key.startswith('barang_id_'):
            barang_id = key.split('_')[1]
            print(f"Processing barang_id: {barang_id}")
            barang = BarangPengawasan.query.get(barang_id)

            if barang:
                print(f"Found Barang: {barang.nama_barang}")

                # Update nama distributor
                nama_distributor = request.form.get(f'nama_distributor_{barang_id}')
                print(f"Updating distributor to: {nama_distributor}")
                barang.nama_distributor = nama_distributor

                # Update keterangan
                keterangan = request.form.get(f'keterangan_{barang_id}')
                print(f"Updating keterangan to: {keterangan}")
                barang.keterangan = keterangan

                # Update tindak lanjut pelanggaran
                tindak_lanjut = request.form.get(f'tindak_lanjut_{barang_id}')
                print(f"Updating tindak lanjut to: {tindak_lanjut}")
                barang.tindak_lanjut_pelanggaran = tindak_lanjut

                try:
                    db.session.commit()
                    print(f"Barang {barang_id} saved successfully.")
                except Exception as e:
                    db.session.rollback()
                    print(f"Error during commit for barang_id {barang_id}: {e}")

                    db.session.commit()
                    print(f"Barang {barang_id} saved successfully.")

    db.session.commit()
    print("Form data received:")
    print(request.form)    
    flash('Data tindak lanjut pelanggaran berhasil disimpan.', 'success')
    print("==== End simpan_tindak_lanjut_pelanggaran ====")
    return redirect(url_for('tindak_lanjut_pelanggaran', log_id=log_id, pelaku_usaha_id=pelaku_usaha_id))





@app.route('/detail_anggaran/<int:log_id>', methods=['GET'])
@login_required
def detail_anggaran(log_id):
    log_entry = LogPerhitungan.query.get_or_404(log_id)
    
    # Data dummy untuk anggaran, nanti bisa diganti dengan data dari database
    anggaran_data = {
        'bahan_bakar': 300000,
        'jalan_tol': 0,
        'akomodasi': 200000,
        'tambahan': 0,
        'lainnya': 19500000,
        'catatan_lainnya': 'Catatan Biaya Lainnya'
    }

    return render_template('detail_anggaran.html', log_entry=log_entry, entry=log_entry, anggaran_data=anggaran_data)


@app.route('/lihat_pengawasan/<int:log_id>', methods=['GET'])
@login_required
def lihat_pengawasan(log_id):
    log_entry = LogPerhitungan.query.get_or_404(log_id)
    hasil_perencanaan_entries = HasilPerencanaan.query.filter_by(log_id=log_id).all()
    
    return render_template('lihat_pengawasan.html', log_entry=log_entry, hasil_perencanaan_entries=hasil_perencanaan_entries, log_id=log_id)
# @app.route('/lihat_pengawasan/<int:log_id>')
# @login_required
# def lihat_pengawasan(log_id):
#     log_entry = LogPerhitungan.query.get_or_404(log_id)
#     hasil_perhitungan_entries = HasilPerhitungan.query.filter_by(log_id=log_id).all()
#     return render_template('lihat_pengawasan.html', log_entry=log_entry, hasil_perhitungan_entries=hasil_perhitungan_entries, log_id=log_id)

@app.route('/hapus_log/<int:log_id>', methods=['POST'])
@login_required
def hapus_log(log_id):
    HasilPerhitungan.query.filter_by(log_id=log_id).delete()
    log_entry = LogPerhitungan.query.get_or_404(log_id)
    db.session.delete(log_entry)
    db.session.commit()
    flash('Log perhitungan berhasil dihapus!', 'success')
    return redirect(url_for('riwayat_perhitungan'))

@app.route('/update_status', methods=['POST'])
@login_required
@role_required('Admin')
def update_status():
    data = request.get_json()
    log_id = data.get('log_id')
    status = data.get('status')

    log_entry = LogPerhitungan.query.get(log_id)
    if log_entry:
        log_entry.status = status
        db.session.commit()
        flash('Status berhasil diubah!', 'success')
        return jsonify({'status': 'success'})
    flash('Terjadi kesalahan: Log entry tidak ditemukan', 'danger')
    return jsonify({'status': 'error', 'message': 'Log entry not found'}), 404

@app.route('/biaya-anggaran')
@login_required
def biaya_anggaran():
    if current_user.roles == 'Struktural Inti':
        # Query untuk mendapatkan data log perhitungan beserta total anggaran
        logs = db.session.query(LogPerhitungan).all()
        log_data = []

        for log in logs:
            total_anggaran = db.session.query(db.func.sum(HasilPerhitungan.anggaran_biaya)).filter(HasilPerhitungan.log_id == log.id).scalar()
            log_data.append({
                'id': log.id,
                'periode': log.tanggal.strftime("%b - %Y"),  # Mengubah format tanggal ke bulan dan tahun
                'total_anggaran': total_anggaran
            })

        return render_template('biaya_anggaran.html', log_data=log_data)
    else:
        return redirect(url_for('home'))

@app.route('/data_pelaku_usaha')
@login_required
def data_pelaku_usaha():
    search_query = request.args.get('search', '')
    nama_daerah_filter = request.args.get('nama_daerah', '')
    kategori_usaha_filter = request.args.get('kategori_usaha', '')

    # Daftar nama daerah (27 kota/kabupaten di Jawa Barat)
    nama_daerah_list = [
        'Kota Bandung', 'Kabupaten Bandung', 'Kota Bekasi', 'Kabupaten Bekasi', 
        'Kota Bogor', 'Kabupaten Bogor', 'Kota Cimahi', 'Kabupaten Cirebon', 
        'Kota Cirebon', 'Kota Depok', 'Kota Sukabumi', 'Kabupaten Sukabumi', 
        'Kota Tasikmalaya', 'Kabupaten Tasikmalaya', 'Kabupaten Bandung Barat', 
        'Kabupaten Ciamis', 'Kabupaten Cianjur', 'Kabupaten Garut', 
        'Kabupaten Indramayu', 'Kabupaten Karawang', 'Kabupaten Kuningan', 
        'Kabupaten Majalengka', 'Kabupaten Pangandaran', 'Kabupaten Purwakarta', 
        'Kabupaten Subang', 'Kabupaten Sumedang', 'Kabupaten Indramayu'
    ]

    # Daftar kategori usaha
    kategori_usaha_list = [
        'Bahan Pokok', 'Toserba', 'Bahan Bangunan', 'Farmasi/Apotek', 
        'Elektronik', 'Pakaian', 'Material Konstruksi', 'Perlengkapan Rumah Tangga'
    ]

    # Query untuk filter
    query = DataPelakuUsaha.query

    if nama_daerah_filter:
        query = query.filter(DataPelakuUsaha.nama_daerah == nama_daerah_filter)
    
    if kategori_usaha_filter:
        query = query.filter(DataPelakuUsaha.kategori_usaha == kategori_usaha_filter)

    # Filter berdasarkan pencarian (opsional)
    if search_query:
        query = query.filter(
            (DataPelakuUsaha.nama_pelaku_usaha.ilike(f'%{search_query}%')) |
            (DataPelakuUsaha.nama_daerah.ilike(f'%{search_query}%'))
        )

    pelaku_usaha = query.all()
    
    return render_template('data_pelaku_usaha.html', 
                           pelaku_usaha=pelaku_usaha,
                           nama_daerah_list=nama_daerah_list,
                           kategori_usaha_list=kategori_usaha_list)

@app.route('/tambah_pelaku_usaha', methods=['GET', 'POST'])
@login_required
def tambah_pelaku_usaha():
    if request.method == 'POST':
        nama_daerah = request.form['nama_daerah']
        nama_pelaku_usaha = request.form['nama_pelaku_usaha']
        kategori_usaha = request.form['kategori_usaha']
        
        # Jika kategori usaha adalah 'Lainnya', gunakan input dari kategori_usaha_lainnya
        if kategori_usaha == 'Lainnya':
            kategori_usaha = request.form['kategori_usaha_lainnya']
        
        alamat = request.form['alamat']
        
        # Membuat objek DataPelakuUsaha baru
        pelaku_usaha = DataPelakuUsaha(
            nama_daerah=nama_daerah,
            nama_pelaku_usaha=nama_pelaku_usaha,
            kategori_usaha=kategori_usaha,
            alamat=alamat,
            jumlah_diawasi=0,
            jumlah_pelanggaran=0,
            tanggal_pengawasan=None  # Set ini ke None atau tanggal yang sesuai, sesuai kebutuhan
        )
        
        # Simpan ke database
        db.session.add(pelaku_usaha)
        db.session.commit()
        
        flash('Data Pelaku Usaha berhasil ditambahkan!', 'success')
        return redirect(url_for('data_pelaku_usaha'))
    
    # Jika GET request, tampilkan form
    nama_daerah_list = [
        'Kota Bandung', 'Kabupaten Bandung', 'Kota Bekasi', 'Kabupaten Bekasi', 
        'Kota Bogor', 'Kabupaten Bogor', 'Kota Cimahi', 'Kabupaten Cirebon', 
        'Kota Cirebon', 'Kota Depok', 'Kota Sukabumi', 'Kabupaten Sukabumi', 
        'Kota Tasikmalaya', 'Kabupaten Tasikmalaya', 'Kabupaten Bandung Barat', 
        'Kabupaten Ciamis', 'Kabupaten Cianjur', 'Kabupaten Garut', 
        'Kabupaten Indramayu', 'Kabupaten Karawang', 'Kabupaten Kuningan', 
        'Kabupaten Majalengka', 'Kabupaten Pangandaran', 'Kabupaten Purwakarta', 
        'Kabupaten Subang', 'Kabupaten Sumedang', 'Kabupaten Indramayu'
    ]

    kategori_usaha_list = [
        'Bahan Pokok', 'Toserba', 'Bahan Bangunan', 'Farmasi/Apotek', 
        'Elektronik', 'Pakaian', 'Material Konstruksi', 'Perlengkapan Rumah Tangga'
    ]
    
    return render_template('tambah_pelaku_usaha.html', 
                           nama_daerah_list=nama_daerah_list,
                           kategori_usaha_list=kategori_usaha_list)

@app.route('/ubah_pelaku_usaha/<int:id>', methods=['GET', 'POST'])
@login_required
def ubah_pelaku_usaha(id):
    pelaku_usaha = DataPelakuUsaha.query.get_or_404(id)
    
    if request.method == 'POST':
        pelaku_usaha.nama_daerah = request.form['nama_daerah']
        pelaku_usaha.nama_pelaku_usaha = request.form['nama_pelaku_usaha']
        pelaku_usaha.kategori_usaha = request.form['kategori_usaha']
        pelaku_usaha.alamat = request.form['alamat']
        
        if pelaku_usaha.kategori_usaha == 'Lainnya':
            pelaku_usaha.kategori_usaha_lainnya = request.form['kategori_usaha_lainnya']
        else:
            pelaku_usaha.kategori_usaha_lainnya = None
        
        db.session.commit()
        flash('Informasi pelaku usaha berhasil diperbarui', 'success')
        return redirect(url_for('data_pelaku_usaha'))
    
    nama_daerah_list = [
        'Kota Bandung', 'Kabupaten Bandung', 'Kota Bekasi', 'Kabupaten Bekasi',
        'Kota Bogor', 'Kabupaten Bogor', 'Kota Cimahi', 'Kabupaten Cirebon',
        'Kota Cirebon', 'Kota Depok', 'Kota Sukabumi', 'Kabupaten Sukabumi',
        'Kota Tasikmalaya', 'Kabupaten Tasikmalaya', 'Kabupaten Bandung Barat',
        'Kabupaten Ciamis', 'Kabupaten Cianjur', 'Kabupaten Garut',
        'Kabupaten Indramayu', 'Kabupaten Karawang', 'Kabupaten Kuningan',
        'Kabupaten Majalengka', 'Kabupaten Pangandaran', 'Kabupaten Purwakarta',
        'Kabupaten Subang', 'Kabupaten Sumedang', 'Kabupaten Indramayu'
    ]

    kategori_usaha_list = [
        'Bahan Pokok', 'Toserba', 'Bahan Bangunan', 'Farmasi/Apotek',
        'Elektronik', 'Pakaian', 'Material Konstruksi', 'Perlengkapan Rumah Tangga'
    ]

    return render_template('ubah_pelaku_usaha.html', 
                           pelaku_usaha=pelaku_usaha,
                           nama_daerah_list=nama_daerah_list,
                           kategori_usaha_list=kategori_usaha_list)


@app.route('/detail_riwayat_pengawasan/<int:id>')
@login_required
def detail_riwayat_pengawasan(id):
    pelaku_usaha = DataPelakuUsaha.query.get_or_404(id)
    print(pelaku_usaha.id) #debugging
    # Di sini, Anda bisa mengambil data riwayat pengawasan dari tabel hasilperhitungan nanti
    return render_template('detail_riwayat_pengawasan.html', pelaku_usaha=pelaku_usaha)


@app.route('/data_pelanggaran')
@login_required
def data_pelanggaran():
    # Ambil nilai filter dari request
    tanggal_pelaporan = request.args.get('tanggal_pelaporan', '')
    nama_daerah = request.args.get('nama_daerah', '')
    nama_pelaku_usaha = request.args.get('nama_pelaku_usaha', '')
    jenis_pelanggaran = request.args.get('jenis_pelanggaran', '')

    # Filter untuk tabel Pelaporan Pelanggaran
    query_pelaporan = PelaporanPelanggaran.query
    if tanggal_pelaporan:
        query_pelaporan = query_pelaporan.filter(func.date(PelaporanPelanggaran.tanggal_pelaporan) == tanggal_pelaporan)
    if nama_daerah:
        query_pelaporan = query_pelaporan.filter(PelaporanPelanggaran.nama_daerah == nama_daerah)
    if nama_pelaku_usaha:
        query_pelaporan = query_pelaporan.filter(PelaporanPelanggaran.nama_pelaku_usaha.ilike(f'%{nama_pelaku_usaha}%'))
    if jenis_pelanggaran:
        query_pelaporan = query_pelaporan.filter(PelaporanPelanggaran.jenis_pelanggaran.ilike(f'%{jenis_pelanggaran}%'))
    pelaporan_pelanggaran = query_pelaporan.all()

    # Filter untuk tabel Pelanggaran Sedang Diproses
    search_diproses_tanggal = request.args.get('search_diproses_tanggal', '')
    search_diproses_daerah = request.args.get('search_diproses_daerah', '')
    search_diproses_nama_pelaku_usaha = request.args.get('search_diproses_nama_pelaku_usaha', '')
    search_diproses_jenis_pelanggaran = request.args.get('search_diproses_jenis_pelanggaran', '')

    query_diproses = PelanggaranPengawasan.query.filter_by(status_pelanggaran='Sedang Diproses')
    if search_diproses_tanggal:
        query_diproses = query_diproses.filter(func.date(PelanggaranPengawasan.tanggal_pengawasan) == search_diproses_tanggal)
    if search_diproses_daerah:
        query_diproses = query_diproses.filter(PelanggaranPengawasan.nama_daerah == search_diproses_daerah)
    if search_diproses_nama_pelaku_usaha:
        query_diproses = query_diproses.filter(PelanggaranPengawasan.nama_pelaku_usaha.ilike(f'%{search_diproses_nama_pelaku_usaha}%'))
    if search_diproses_jenis_pelanggaran:
        query_diproses = query_diproses.filter(PelanggaranPengawasan.jenis_pelanggaran.ilike(f'%{search_diproses_jenis_pelanggaran}%'))
    pengawasan_diproses = query_diproses.all()

    # Filter untuk tabel Pelanggaran Selesai
    search_selesai_tanggal = request.args.get('search_selesai_tanggal', '')
    search_selesai_daerah = request.args.get('search_selesai_daerah', '')
    search_selesai_nama_pelaku_usaha = request.args.get('search_selesai_nama_pelaku_usaha', '')
    search_selesai_jenis_pelanggaran = request.args.get('search_selesai_jenis_pelanggaran', '')

    query_selesai = PelanggaranPengawasan.query.filter_by(status_pelanggaran='Selesai')
    if search_selesai_tanggal:
        query_selesai = query_selesai.filter(func.date(PelanggaranPengawasan.tanggal_pengawasan) == search_selesai_tanggal)
    if search_selesai_daerah:
        query_selesai = query_selesai.filter(PelanggaranPengawasan.nama_daerah == search_selesai_daerah)
    if search_selesai_nama_pelaku_usaha:
        query_selesai = query_selesai.filter(PelanggaranPengawasan.nama_pelaku_usaha.ilike(f'%{search_selesai_nama_pelaku_usaha}%'))
    if search_selesai_jenis_pelanggaran:
        query_selesai = query_selesai.filter(PelanggaranPengawasan.jenis_pelanggaran.ilike(f'%{search_selesai_jenis_pelanggaran}%'))
    pengawasan_selesai = query_selesai.all()

    # Daftar nama daerah (sesuaikan dengan data yang ada)
    nama_daerah_list = [
        'Kota Bandung', 'Kabupaten Bandung', 'Kota Bekasi', 'Kabupaten Bekasi', 
        'Kota Bogor', 'Kabupaten Bogor', 'Kota Cimahi', 'Kabupaten Cirebon',
        'Kota Cirebon', 'Kota Depok', 'Kota Sukabumi', 'Kabupaten Sukabumi',
        'Kota Tasikmalaya', 'Kabupaten Tasikmalaya', 'Kabupaten Bandung Barat',
        'Kabupaten Ciamis', 'Kabupaten Cianjur', 'Kabupaten Garut', 
        'Kabupaten Indramayu', 'Kabupaten Karawang', 'Kabupaten Kuningan', 
        'Kabupaten Majalengka', 'Kabupaten Pangandaran', 'Kabupaten Purwakarta', 
        'Kabupaten Subang', 'Kabupaten Sumedang', 'Kabupaten Indramayu'
    ]

    return render_template('data_pelanggaran.html', 
                           pelaporan_pelanggaran=pelaporan_pelanggaran, 
                           pengawasan_diproses=pengawasan_diproses,
                           pengawasan_selesai=pengawasan_selesai,
                           nama_daerah_list=nama_daerah_list)


@app.route('/tambah_laporan_pelanggaran', methods=['GET', 'POST'])
@login_required
def tambah_laporan_pelanggaran():
    if request.method == 'POST':
        files = request.files.getlist('bukti_pelanggaran')
        file_paths = []
        if 'bukti_pelanggaran' in request.files:
            files = request.files.getlist('bukti_pelanggaran')

            for file in files:
                # Debug: print out file names to confirm they are being processed
                if file and allowed_file(file.filename):
                    filename = secure_filename(file.filename)
                    file_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)
                    file.save(file_path)
                    file_paths.append(filename)

        # jenis_pelanggaran_terpilih = ', '.join(request.form.getlist('jenis_pelanggaran'))
        jenis_pelanggaran_list = request.form.getlist('jenis_pelanggaran')
        jenis_pelanggaran_str = ', '.join(jenis_pelanggaran_list)
        

        # Simpan data pelaporan ke database
        new_laporan = PelaporanPelanggaran(
            tanggal_pelaporan=request.form['tanggal_pelaporan'],
            nama_pelapor=request.form['nama_pelapor'],
            nama_daerah=request.form['nama_daerah'],
            nama_pelaku_usaha=request.form['nama_pelaku_usaha'],
            nama_produk=request.form['nama_produk'],
            nama_merk_produk=request.form['nama_merk_produk'],
            jenis_pelanggaran=jenis_pelanggaran_str,
            keterangan=request.form['keterangan'],
            bukti_pelanggaran=', '.join(file_paths),
            status_pelanggaran="Sedang Diproses",  # atau nilai default lainnya
            status_tindak_lanjut_pelanggaran="Pemanggilan"  # atau nilai default lainnya
        )

        db.session.add(new_laporan)
        db.session.commit()
        
        flash('Laporan pelanggaran berhasil ditambahkan!', 'success')
        return redirect(url_for('data_pelanggaran'))

    # Jika metode GET, tampilkan form
    nama_daerah_list = [
        'Kota Bandung', 'Kabupaten Bandung', 'Kota Bekasi', 'Kabupaten Bekasi',
        'Kota Bogor', 'Kabupaten Bogor', 'Kota Cimahi', 'Kabupaten Cirebon',
        'Kota Cirebon', 'Kota Depok', 'Kota Sukabumi', 'Kabupaten Sukabumi',
        'Kota Tasikmalaya', 'Kabupaten Tasikmalaya', 'Kabupaten Bandung Barat',
        'Kabupaten Ciamis', 'Kabupaten Cianjur', 'Kabupaten Garut',
        'Kabupaten Indramayu', 'Kabupaten Karawang', 'Kabupaten Kuningan',
        'Kabupaten Majalengka', 'Kabupaten Pangandaran', 'Kabupaten Purwakarta',
        'Kabupaten Subang', 'Kabupaten Sumedang', 'Kabupaten Indramayu'
    ]

    pelaku_usaha_list = DataPelakuUsaha.query.all()  # Mengambil semua pelaku usaha dari database

    return render_template('laporan_pelanggaran.html', 
                           nama_daerah_list=nama_daerah_list, 
                           pelaku_usaha_list=pelaku_usaha_list)

@app.route('/detail_pelaporan_pelanggaran/<int:id>', methods=['GET', 'POST'])
@login_required
def detail_pelaporan_pelanggaran(id):
    laporan = PelaporanPelanggaran.query.get_or_404(id)

    # Debugging untuk memastikan nama pelaku usaha
    print(f"Nama Pelaku Usaha: {laporan.pelaku_usaha.nama_pelaku_usaha}")

    if request.method == 'POST':
        laporan.status_pelanggaran = request.form['status_pelanggaran']
        laporan.status_tindak_lanjut_pelanggaran = request.form['status_tindak_lanjut']

        # Jika status tindak lanjut adalah Pemanggilan atau Surat Peringatan, simpan bukti pengembalian
        if laporan.status_tindak_lanjut_pelanggaran in ['Pemanggilan', 'Surat Peringatan']:
            if 'bukti_pengembalian' in request.files:
                bukti_files = request.files.getlist('bukti_pengembalian')
                for file in bukti_files:
                    if file and allowed_file(file.filename):
                        filename = secure_filename(file.filename)
                        file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
                        # Lakukan sesuatu dengan path file, misalnya simpan ke database
                        laporan.bukti_pengembalian = laporan.bukti_pengembalian + ', ' + filename if laporan.bukti_pengembalian else filename

        db.session.commit()
        flash('Data pelaporan pelanggaran berhasil diperbarui.', 'success')
        return redirect(url_for('data_pelanggaran'))

    return render_template('detail_pelaporan_pelanggaran.html', laporan=laporan)

@app.route('/get_pelaku_usaha_by_daerah', methods=['GET'])
@login_required
def get_pelaku_usaha_by_daerah():
    nama_daerah = request.args.get('nama_daerah')
    pelaku_usaha_list = DataPelakuUsaha.query.filter_by(nama_daerah=nama_daerah).all()
    
    pelaku_usaha_data = [{'id': pelaku_usaha.id, 'nama_pelaku_usaha': pelaku_usaha.nama_pelaku_usaha} for pelaku_usaha in pelaku_usaha_list]
    
    return jsonify(pelaku_usaha=pelaku_usaha_data)



logging.basicConfig(level=logging.DEBUG)

if __name__ == '__main__':
    app.run(debug=True)

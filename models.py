from flask_sqlalchemy import SQLAlchemy
from flask_login import UserMixin
from datetime import datetime


db = SQLAlchemy()

class User(UserMixin, db.Model):
    __tablename__ = 'users'
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(50), unique=True, nullable=False)
    password = db.Column(db.String(100), nullable=False)
    roles = db.Column(db.String(50), nullable=True)
    nama_pengguna = db.Column(db.String(50), nullable=True)

class DataPegawai(db.Model):
    __tablename__ = 'data_pegawai'
    id = db.Column(db.Integer, primary_key=True)
    nama_pegawai = db.Column(db.String(100), nullable=False)
    nip = db.Column(db.String(50), nullable=False)
    jabatan = db.Column(db.String(100), nullable=False)

class BiayaTransportasi(db.Model):
    __tablename__ = 'biaya_transportasi'
    id = db.Column(db.Integer, primary_key=True)
    nama_daerah = db.Column(db.String(100), nullable=False)
    harga_tol = db.Column(db.Float, nullable=False)
    total_biaya_bahan_bakar = db.Column(db.Float, nullable=True)
    estimasi_perjalanan = db.Column(db.Float, nullable=False)
    jarak_daerah = db.Column(db.Float, nullable=False)
    total_biaya_transportasi = db.Column(db.Float, nullable=True)


class SkalaBiayaBahanBakar(db.Model):
    __tablename__ = 'skala_biaya_bahan_bakar'
    id = db.Column(db.Integer, primary_key=True)
    rentang_jarak_minimal = db.Column(db.Float, nullable=False)
    rentang_jarak_maksimal = db.Column(db.Float, nullable=False)
    biaya_bensin = db.Column(db.Float, nullable=False)

class HargaBensin(db.Model):
    __tablename__ = 'harga_bensin'
    id = db.Column(db.Integer, primary_key=True)
    harga = db.Column(db.Float, nullable=False)

class BobotKriteria(db.Model):
    __tablename__ = 'bobot_kriteria'
    id = db.Column(db.Integer, primary_key=True)
    kriteria = db.Column(db.String(100), nullable=False)
    nilai_kriteria = db.Column(db.Float, nullable=False)


class LogPerhitungan(db.Model):
    __tablename__ = 'logperhitungan'
    id = db.Column(db.Integer, primary_key=True)
    tanggal = db.Column(db.DateTime, default=db.func.current_timestamp(), nullable=False)
    username = db.Column(db.String(50), nullable=False)
    status = db.Column(db.String(50), nullable=False, default='Lengkapi Data')
    hasil_perhitungan = db.relationship('HasilPerhitungan', backref='log_perhitungan', lazy=True)


class HasilPerhitungan(db.Model):
    __tablename__ = 'hasilperhitungan'
    id = db.Column(db.Integer, primary_key=True)
    log_id = db.Column(db.Integer, db.ForeignKey('logperhitungan.id'), nullable=False)
    nama_daerah = db.Column(db.String(100), nullable=False)
    weighted_sum = db.Column(db.Float, nullable=False)
    adjusted_weighted_sum = db.Column(db.Float, nullable=True)
    anggaran_biaya = db.Column(db.Float, nullable=False)
    peringkat = db.Column(db.Integer, nullable=False)
    jumlah_lokasi = db.Column(db.Integer, nullable=False)
    nama_pelaku_usaha = db.Column(db.JSON, nullable=True)
    status_lokasi = db.Column(db.JSON(db.Boolean), nullable=True)
    pengawas = db.Column(db.JSON, nullable=False, default=["", "", "", ""])
    status_pengawasan = db.Column(db.String(50), nullable=False, default='Belum')
    gagal = db.Column(db.Boolean, default=False)
    terdapat_pelanggaran = db.Column(db.Boolean, default=False)
    catatan = db.Column(db.Text, nullable=True)
    status_pelanggaran = db.Column(db.String(255), nullable=False, default='Tidak Ada')
    status_tindak_lanjut_pelanggaran = db.Column(db.String(255), nullable=False, default='Tidak Ada')
    indikasi_pelanggaran = db.Column(db.String(10), nullable=False, default='Tidak')
    log = db.relationship('LogPerhitungan', backref='hasil_perhitungan_entries')

class DataPelakuUsaha(db.Model):
    __tablename__ = 'pelakuusaha'
    id = db.Column(db.Integer, primary_key=True)
    nama_daerah = db.Column(db.String(255), nullable=False)
    nama_pelaku_usaha = db.Column(db.String(255), nullable=False)
    alamat = db.Column(db.String(255), nullable=False)
    kategori_usaha = db.Column(db.String(255), nullable=False)
    jumlah_diawasi = db.Column(db.Integer, nullable=False, default=0)
    jumlah_pelanggaran = db.Column(db.Integer, nullable=False, default=0)
    tanggal_pengawasan = db.Column(db.DateTime, nullable=False)


class PelaporanPelanggaran(db.Model):
    __tablename__ = 'pelaporan_pelanggaran'
    id = db.Column(db.Integer, primary_key=True)
    tanggal_pelaporan = db.Column(db.DateTime, nullable=False, default=db.func.current_timestamp())
    nama_pelapor = db.Column(db.String(255), nullable=False)
    nama_daerah = db.Column(db.String(255), nullable=False)
    nama_pelaku_usaha = db.Column(db.Integer, db.ForeignKey('pelakuusaha.id'), nullable=False)
    nama_produk = db.Column(db.String(255), nullable=False)
    nama_merk_produk = db.Column(db.String(255), nullable=False)
    jenis_pelanggaran = db.Column(db.String(255), nullable=False)
    keterangan = db.Column(db.Text, nullable=True)
    bukti_pelanggaran = db.Column(db.Text, nullable=True)
    status_pelanggaran = db.Column(db.String(50), nullable=False)  # Kolom untuk status pelanggaran
    status_tindak_lanjut_pelanggaran = db.Column(db.String(255), nullable=False)  # Kolom untuk status tindak lanjut
    bukti_pengembalian = db.Column(db.Text, nullable=True) 
    pelaku_usaha = db.relationship('DataPelakuUsaha', backref='pelanggaran')

class PelanggaranPengawasan(db.Model):
    __tablename__ = 'pelanggaran_pengawasan'
    id = db.Column(db.Integer, primary_key=True)
    tanggal_pengawasan = db.Column(db.DateTime, nullable=False, default=db.func.current_timestamp())
    nama_daerah = db.Column(db.String(255), nullable=False)
    nama_pelaku_usaha = db.Column(db.String(255), nullable=False)
    alamat = db.Column(db.String(255), nullable=False)
    jenis_pelanggaran = db.Column(db.String(255), nullable=False)
    keterangan = db.Column(db.Text, nullable=True)
    status_pelanggaran = db.Column(db.String(50), nullable=False)
    status_tindak_lanjut_pelanggaran = db.Column(db.String(255), nullable=False)

class HasilPerencanaan(db.Model):
    __tablename__ = 'hasilperencanaan'
    id = db.Column(db.Integer, primary_key=True)
    log_id = db.Column(db.Integer, db.ForeignKey('logperhitungan.id'), nullable=False)
    nama_daerah = db.Column(db.String(255), nullable=False)
    pelaku_usaha_id_1 = db.Column(db.Integer, db.ForeignKey('pelakuusaha.id'), nullable=True)
    pelaku_usaha_id_2 = db.Column(db.Integer, db.ForeignKey('pelakuusaha.id'), nullable=True)
    pengawas_1 = db.Column(db.String(255))
    pengawas_2 = db.Column(db.String(255))
    pengawas_3 = db.Column(db.String(255))
    pengawas_4 = db.Column(db.String(255))
    anggaran_biaya = db.Column(db.Float, nullable=False)
    status_lokasi_1 = db.Column(db.String(50), default='Belum Terawasi')
    status_lokasi_2 = db.Column(db.String(50), default='Belum Terawasi')
    status_pengawasan = db.Column(db.String(255))  # Tambahkan status pengawasan
    catatan = db.Column(db.Text)  # Tambahkan catatan
    status_pelanggaran = db.Column(db.String(50))  # Tambahkan status pelanggaran
    status_tindak_lanjut_pelanggaran = db.Column(db.String(255))  # Tambahkan status tindak lanjut pelanggaran
    indikasi_pelanggaran = db.Column(db.String(50), nullable=False, default='Tidak') # Tambahkan indikasi pelanggaran
    pelaku_usaha_1 = db.relationship('DataPelakuUsaha', foreign_keys=[pelaku_usaha_id_1])
    pelaku_usaha_2 = db.relationship('DataPelakuUsaha', foreign_keys=[pelaku_usaha_id_2])

class BarangPengawasan(db.Model):
    __tablename__ = 'barang_pengawasan'
    id = db.Column(db.Integer, primary_key=True)
    log_id = db.Column(db.Integer, db.ForeignKey('logperhitungan.id'), nullable=False)
    pelaku_usaha_id = db.Column(db.Integer, db.ForeignKey('hasilperencanaan.id'), nullable=False)
    penanggung_jawab = db.Column(db.String(255), nullable=False)
    nama_barang = db.Column(db.String(255), nullable=False)
    merk_barang = db.Column(db.String(255), nullable=False)
    sni = db.Column(db.String(50), default='Tidak Dicek')
    mkg = db.Column(db.String(50), default='Tidak Dicek')
    label = db.Column(db.String(50), default='Tidak Dicek')
    k3l = db.Column(db.String(50), default='Tidak Dicek')
    keterangan = db.Column(db.Text)
    berkas_hasil_pengawasan = db.Column(db.String(255))
    nama_distributor = db.Column(db.String(255))
    bukti_pengembalian_barang = db.Column(db.String(255))
    jenis_pelanggaran = db.Column(db.String(255))
    log = db.relationship('LogPerhitungan', backref=db.backref('barang_pengawasan', lazy=True))
    pelaku_usaha = db.relationship('HasilPerencanaan', backref=db.backref('barang_pengawasan', lazy=True))

    def __repr__(self):
        return f'<BarangPengawasan {self.nama_barang} - {self.merk_barang}>'

# Pastikan ini diletakkan setelah semua kelas didefinisikan
LogPerhitungan.hasil_perhitungan = db.relationship('HasilPerhitungan', backref='log_perhitungan', lazy=True)
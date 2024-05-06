-- CreateTable
CREATE TABLE `angsuran` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `psb_id` INTEGER NOT NULL,
    `biaya_angsuran` INTEGER NOT NULL,
    `indek_angsuran` SMALLINT NULL,
    `periode` VARCHAR(6) NULL,
    `user_id` INTEGER NOT NULL,
    `flaglunas` BOOLEAN NULL DEFAULT false,
    `flagjatuhtempo` BOOLEAN NULL DEFAULT false,
    `created_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),

    INDEX `periode`(`periode`),
    INDEX `psb_id`(`psb_id`),
    INDEX `user_id`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `diameters` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nama` VARCHAR(100) NOT NULL,
    `by_pemeliharaan` INTEGER NOT NULL,
    `by_administrasi` INTEGER NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `aktif` BOOLEAN NULL DEFAULT true,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `divisi` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nama` VARCHAR(255) NOT NULL,
    `is_active` BOOLEAN NULL DEFAULT true,
    `deleted_at` DATETIME(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `drd` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `no_pelanggan` VARCHAR(20) NOT NULL DEFAULT '',
    `periode` VARCHAR(6) NULL,
    `periode_rek` VARCHAR(6) NULL,
    `nama` VARCHAR(100) NOT NULL DEFAULT '',
    `alamat` VARCHAR(100) NOT NULL DEFAULT '',
    `kec_id` INTEGER NULL,
    `kec` VARCHAR(100) NULL,
    `kel_id` INTEGER NULL,
    `kel` VARCHAR(100) NULL,
    `rayon_id` INTEGER NULL,
    `kode_rayon` VARCHAR(20) NULL,
    `rayon` VARCHAR(100) NULL,
    `jalan_id` INTEGER NULL,
    `jalan` VARCHAR(100) NULL,
    `wilayah_id` VARCHAR(50) NULL,
    `wilayah` VARCHAR(100) NULL,
    `diameter_id` INTEGER NULL,
    `diameter` VARCHAR(20) NULL,
    `gol_id` INTEGER NULL,
    `kodegol` VARCHAR(50) NULL,
    `golongan` VARCHAR(100) NULL,
    `merek_id` INTEGER NULL,
    `merek_meter` VARCHAR(50) NULL,
    `stanlalu` INTEGER NULL DEFAULT 0,
    `stanskrg` INTEGER NULL DEFAULT 0,
    `pakaiskrg` INTEGER NULL DEFAULT 0,
    `stanangkat` INTEGER NULL DEFAULT 0,
    `harga_air` INTEGER NULL DEFAULT 0,
    `airlimbah` INTEGER NULL DEFAULT 0,
    `administrasi` INTEGER NULL DEFAULT 0,
    `pemeliharaan` INTEGER NULL DEFAULT 0,
    `retribusi` INTEGER NULL DEFAULT 0,
    `pelayanan` INTEGER NULL DEFAULT 0,
    `meterai` INTEGER NULL DEFAULT 0,
    `denda` INTEGER NULL DEFAULT 0,
    `angsuran` INTEGER NULL DEFAULT 0,
    `angsuranke` SMALLINT NULL DEFAULT 0,
    `ansguran_id` INTEGER NULL,
    `totalrekening` INTEGER NULL DEFAULT 0,
    `tglbayar` DATETIME(0) NULL,
    `flaglunas` TINYINT NULL DEFAULT 0,
    `flagrekening` SMALLINT NULL DEFAULT 0,
    `flagkorrekening` TINYINT NULL DEFAULT 0,
    `petugas_id_baca` INTEGER NULL,
    `petugas_baca` VARCHAR(50) NULL,
    `kelainan` VARCHAR(50) NULL,
    `created_at` DATETIME(0) NULL,
    `update_at` DATETIME(0) NULL,
    `waktuposting` DATETIME(0) NULL,
    `waktuimport` DATETIME(0) NULL,
    `stanlalu_k` INTEGER NULL DEFAULT 0,
    `stanskrg_k` INTEGER NULL DEFAULT 0,
    `pakaiskrg_k` INTEGER NULL DEFAULT 0,
    `stanangkat_k` INTEGER NULL DEFAULT 0,
    `harga_air_k` INTEGER NULL DEFAULT 0,
    `airlimbah_k` INTEGER NULL DEFAULT 0,
    `administrasi_k` INTEGER NULL DEFAULT 0,
    `pemeliharaan_k` INTEGER NULL DEFAULT 0,
    `retribusi_k` INTEGER NULL DEFAULT 0,
    `pelayanan_k` INTEGER NULL DEFAULT 0,
    `meterai_k` INTEGER NULL DEFAULT 0,
    `totalrekening_k` INTEGER NULL DEFAULT 0,
    `admin_ppob` INTEGER NULL DEFAULT 0,
    `user_id` INTEGER NULL,
    `nama_user` VARCHAR(50) NULL,
    `loket_id` INTEGER NULL,
    `nama_loket` VARCHAR(50) NULL,

    INDEX `flagrekening`(`flagrekening`),
    INDEX `iddiameter_FK`(`diameter_id`),
    INDEX `idgol_FK`(`gol_id`),
    INDEX `idkec_FK`(`kec_id`),
    INDEX `idkel_FK`(`kel_id`),
    INDEX `idrayon_FK`(`rayon_id`),
    INDEX `jalan_id`(`jalan_id`),
    INDEX `merek_id`(`merek_id`),
    INDEX `no_pelanggan_2`(`no_pelanggan`),
    INDEX `pakaiskrg_IDX`(`pakaiskrg`),
    INDEX `periode`(`periode`),
    INDEX `petugas_id_baca`(`petugas_id_baca`),
    INDEX `stanlalu_IDX`(`stanlalu`),
    INDEX `stanskrg_IDX`(`stanskrg`),
    INDEX `waktuimport`(`waktuimport`),
    INDEX `wilayah_id`(`wilayah_id`),
    UNIQUE INDEX `no_pelanggan`(`no_pelanggan`, `periode`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `golongan` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `kode_golongan` VARCHAR(10) NOT NULL,
    `nama` VARCHAR(50) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `kode_akun` VARCHAR(20) NULL,
    `administrasi` INTEGER NULL DEFAULT 0,
    `pemeliharaan` INTEGER NULL DEFAULT 0,
    `retribusi` INTEGER NULL DEFAULT 0,
    `pelayanan` INTEGER NULL DEFAULT 0,
    `denda1` INTEGER NULL DEFAULT 0,
    `persendenda1` SMALLINT NULL DEFAULT 0,
    `denda2` INTEGER NULL DEFAULT 0,
    `denda3` INTEGER NULL DEFAULT 0,
    `minpakai` SMALLINT NULL DEFAULT 0,
    `idsktarif` TINYINT NULL DEFAULT 0,
    `aktif` TINYINT NULL DEFAULT 1,

    INDEX `idsktarif`(`idsktarif`),
    UNIQUE INDEX `golongan_kode_golongan_unique`(`kode_golongan`, `idsktarif`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `jalan` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nama` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `aktif` BOOLEAN NULL DEFAULT true,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `jenis_aduan` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nama` VARCHAR(255) NOT NULL,
    `is_active` BOOLEAN NULL DEFAULT true,
    `created_at` DATETIME(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` DATETIME(0) NULL DEFAULT CURRENT_TIMESTAMP(0),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `jenis_nonair` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `jenis` VARCHAR(5) NOT NULL,
    `namajenis` VARCHAR(255) NOT NULL,
    `by_pelayanan` INTEGER NOT NULL,
    `created_at` DATETIME(0) NULL,
    `updated_at` DATETIME(0) NULL,
    `flagpajak` BOOLEAN NOT NULL DEFAULT false,
    `flagpel` BOOLEAN NULL DEFAULT false,
    `flagproses` BOOLEAN NULL DEFAULT false,
    `flagrealisasi` BOOLEAN NULL DEFAULT false,

    UNIQUE INDEX `jenis`(`jenis`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `jenis_penyelesaian` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nama_penyelesaian` VARCHAR(255) NOT NULL,
    `created_at` DATETIME(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` DATETIME(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `is_active` BOOLEAN NULL DEFAULT true,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `kecamatan` (
    `id` INTEGER NOT NULL,
    `nama` VARCHAR(100) NOT NULL DEFAULT '',

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `kelurahan` (
    `id` INTEGER NOT NULL,
    `kec_id` INTEGER NULL,
    `nama` VARCHAR(100) NOT NULL DEFAULT '',

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `kolektif` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nama` VARCHAR(255) NULL,
    `telp` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `kolektif_pelanggan` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `kolektif_id` BIGINT UNSIGNED NOT NULL,
    `pelanggan_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `loket` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `kodeloket` VARCHAR(50) NOT NULL DEFAULT '-',
    `loket` VARCHAR(50) NULL DEFAULT '-',
    `aktif` BOOLEAN NULL DEFAULT true,

    UNIQUE INDEX `id`(`kodeloket`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `materai` (
    `id` INTEGER NOT NULL,
    `min` INTEGER NOT NULL,
    `max` INTEGER NOT NULL,
    `by_materai` INTEGER NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `merek_meters` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nama` VARCHAR(100) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pasangbaru` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `tglrab` DATE NULL,
    `no_rab` VARCHAR(50) NOT NULL,
    `reg_id` BIGINT NOT NULL,
    `keterangan` VARCHAR(100) NULL,
    `biaya_peralatan` INTEGER NULL DEFAULT 0,
    `biaya_ongkos` INTEGER NULL DEFAULT 0,
    `biaya_lainnya` INTEGER NULL DEFAULT 0,
    `diskon` INTEGER NULL DEFAULT 0,
    `ppn` INTEGER NULL,
    `total` INTEGER NULL,
    `user_input` INTEGER NULL,
    `flagsetuju` BOOLEAN NULL DEFAULT false,
    `flagangsur` BOOLEAN NULL DEFAULT false,
    `flaglunas` BOOLEAN NULL DEFAULT false,
    `uangmuka` INTEGER NULL DEFAULT 0,
    `angsurkali` INTEGER NULL DEFAULT 0,
    `angsuranperbulan` INTEGER NULL DEFAULT 0,
    `no_pelanggan` VARCHAR(25) NULL,
    `user_setuju` INTEGER NULL,
    `golongan_id` INTEGER NULL,
    `flagsudahpasang` BOOLEAN NULL DEFAULT false,
    `tglpasang` DATE NULL,
    `petugas_id` INTEGER NULL,
    `flagrealisasi` BOOLEAN NULL DEFAULT false,
    `user_realisasi` INTEGER NULL,
    `tglrealisasi` DATE NULL,
    `realisasi_periode` VARCHAR(6) NULL,
    `stan` INTEGER NULL DEFAULT 0,
    `created_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),

    UNIQUE INDEX `no_rab`(`no_rab`),
    UNIQUE INDEX `no_pelanggan`(`no_pelanggan`),
    INDEX `golongan_id`(`golongan_id`),
    INDEX `petugas_id`(`petugas_id`),
    INDEX `reg_id`(`reg_id`),
    INDEX `user_input`(`user_input`),
    INDEX `user_realisasi`(`user_realisasi`),
    INDEX `user_setuju`(`user_setuju`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pelanggan` (
    `id` INTEGER NOT NULL,
    `status` TINYINT NOT NULL,
    `no_pelanggan` VARCHAR(50) NOT NULL,
    `no_lama` VARCHAR(50) NULL,
    `no_kartu` VARCHAR(100) NULL,
    `nama` VARCHAR(100) NOT NULL,
    `alamat` VARCHAR(255) NOT NULL,
    `tmp_lahir` VARCHAR(100) NULL,
    `tgl_lahir` DATE NULL,
    `no_ktp` VARCHAR(50) NULL,
    `no_kk` VARCHAR(50) NULL,
    `no_telp` VARCHAR(15) NULL,
    `no_hp` VARCHAR(15) NULL,
    `email` VARCHAR(100) NULL,
    `pekerjaan` VARCHAR(100) NULL,
    `jumlah_penghuni` INTEGER NULL,
    `jenis_bangunan` VARCHAR(100) NULL,
    `kepemilikan` VARCHAR(100) NULL,
    `nama_pemilik` VARCHAR(100) NULL,
    `merek_id` INTEGER NULL,
    `no_meter` VARCHAR(20) NOT NULL,
    `golongan_id` INTEGER NOT NULL,
    `wilayah_id` INTEGER NOT NULL,
    `rayon_id` INTEGER NOT NULL,
    `jalan_id` INTEGER NOT NULL,
    `diameter_id` INTEGER NOT NULL,
    `kec_id` INTEGER NOT NULL DEFAULT 1,
    `kel_id` INTEGER NOT NULL DEFAULT 1,
    `kolektif_id` INTEGER NOT NULL DEFAULT 0,
    `latitude` VARCHAR(35) NULL,
    `longitude` VARCHAR(35) NULL,
    `tgl_pasif` DATE NULL,
    `tgl_pasang` DATE NULL,
    `tgl_aktif` DATE NULL,
    `mbr` BOOLEAN NOT NULL,
    `urutanbaca` INTEGER NULL DEFAULT 0,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `pelanggan_no_pelanggan_unique`(`no_pelanggan`),
    UNIQUE INDEX `pelanggan_no_kartu_unique`(`no_kartu`),
    INDEX `kec_id`(`kec_id`),
    INDEX `kel_id`(`kel_id`),
    INDEX `kolektif_id`(`kolektif_id`),
    INDEX `merek_id`(`merek_id`),
    INDEX `pelanggan_diameter_id_foreign`(`diameter_id`),
    INDEX `pelanggan_golongan_id_foreign`(`golongan_id`),
    INDEX `pelanggan_jalan_id_foreign`(`jalan_id`),
    INDEX `pelanggan_rayon_id_foreign`(`rayon_id`),
    INDEX `pelanggan_unit_id_foreign`(`wilayah_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pendaftaran_lain` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `no_regis` VARCHAR(50) NOT NULL,
    `tanggal` DATE NULL,
    `pelanggan_id` INTEGER NULL DEFAULT 0,
    `no_pelanggan` VARCHAR(50) NULL,
    `nama` VARCHAR(100) NOT NULL,
    `alamat` VARCHAR(255) NOT NULL,
    `keterangan` VARCHAR(200) NULL,
    `created_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `flaglunas` BOOLEAN NULL DEFAULT false,
    `jenis_nonair_id` INTEGER NULL,
    `flexiblebiaya` BOOLEAN NULL DEFAULT false,
    `flagpajak` BOOLEAN NULL DEFAULT false,
    `jenis` VARCHAR(5) NULL,
    `biaya` INTEGER NULL,
    `user_input` INTEGER NULL,
    `flagproses` BOOLEAN NULL DEFAULT false,
    `petugas_id` INTEGER NULL,
    `tglproses` DATE NULL,
    `flagrealisasi` BOOLEAN NULL DEFAULT false,
    `user_realisasi` INTEGER NULL,
    `tglrealisasi` DATE NULL,

    UNIQUE INDEX `no_regis`(`no_regis`),
    INDEX `jenis_nonair_id`(`jenis_nonair_id`),
    INDEX `no_pelanggan`(`no_pelanggan`),
    INDEX `pelanggan_id`(`pelanggan_id`),
    INDEX `petugas_id`(`petugas_id`),
    INDEX `user_input`(`user_input`),
    INDEX `user_realisasi`(`user_realisasi`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pendaftaranpel` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `no_regis` VARCHAR(50) NOT NULL,
    `tanggal` DATE NULL,
    `nama` VARCHAR(100) NOT NULL,
    `alamat` VARCHAR(255) NOT NULL,
    `tmp_lahir` VARCHAR(100) NULL,
    `tgl_lahir` DATE NULL,
    `no_ktp` VARCHAR(50) NOT NULL,
    `no_kk` VARCHAR(50) NULL,
    `no_telp` VARCHAR(15) NULL,
    `no_hp` VARCHAR(15) NULL,
    `email` VARCHAR(100) NULL,
    `pekerjaan` VARCHAR(100) NULL,
    `jumlah_penghuni` INTEGER NULL,
    `jenis_bangunan` VARCHAR(100) NULL,
    `kepemilikan` VARCHAR(100) NULL,
    `kec_id` INTEGER NOT NULL,
    `rayon_id` INTEGER NOT NULL,
    `kel_id` INTEGER NOT NULL,
    `jalan_id` INTEGER NOT NULL,
    `longlat` VARCHAR(100) NULL,
    `is_mbr` BOOLEAN NOT NULL DEFAULT false,
    `created_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `flaglunas` BOOLEAN NULL DEFAULT false,
    `jenis_nonair_id` INTEGER NULL,
    `flexiblebiaya` BOOLEAN NULL DEFAULT false,
    `flagpajak` BOOLEAN NULL DEFAULT false,
    `jenis` VARCHAR(5) NULL,
    `biaya` INTEGER NULL,
    `user_id` INTEGER NULL,
    `flag_tidakpasang` BOOLEAN NULL DEFAULT false,

    UNIQUE INDEX `no_regis`(`no_regis`),
    INDEX `jalan_id`(`jalan_id`),
    INDEX `jenis_nonair_id`(`jenis_nonair_id`),
    INDEX `kec_id`(`kec_id`),
    INDEX `kel_id`(`kel_id`),
    INDEX `rayon_id`(`rayon_id`),
    INDEX `user_id`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `penerimaan_nonair` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `no_pembayaran` VARCHAR(255) NULL,
    `tglbayar` DATETIME(0) NULL,
    `jenisnonair_id` INTEGER NULL,
    `jenisnonair` VARCHAR(5) NOT NULL,
    `namajenis` VARCHAR(255) NULL,
    `nama` VARCHAR(100) NOT NULL,
    `alamat` VARCHAR(200) NOT NULL,
    `user_id` INTEGER NOT NULL,
    `pendaftaranpel_id` INTEGER NULL,
    `pelayananlain_id` INTEGER NULL,
    `pasangbaru_id` INTEGER NULL,
    `jumlah` INTEGER NOT NULL DEFAULT 0,
    `ppn` INTEGER NOT NULL DEFAULT 0,
    `total` INTEGER NOT NULL DEFAULT 0,
    `loket_id` INTEGER NULL,
    `kode_loket` VARCHAR(50) NULL,
    `nama_loket` VARCHAR(50) NULL,
    `angsuran_id` INTEGER NULL,
    `periode_agbjt` VARCHAR(6) NULL,
    `created_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `flagproses` TINYINT NULL DEFAULT 0,
    `keterangan` VARCHAR(200) NULL,

    UNIQUE INDEX `no_pembayaran`(`no_pembayaran`),
    INDEX `jenisnonair_id`(`jenisnonair_id`),
    INDEX `loket_id`(`loket_id`),
    INDEX `user_id`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pengaduan` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nomor` VARCHAR(255) NOT NULL,
    `is_pelanggan` BOOLEAN NULL DEFAULT false,
    `pelanggan_id` INTEGER NULL,
    `jenis_aduan_id` INTEGER NULL,
    `nama` VARCHAR(255) NOT NULL,
    `no_identitas` VARCHAR(255) NOT NULL,
    `no_telp` VARCHAR(20) NOT NULL,
    `alamat` TEXT NULL,
    `is_processed` BOOLEAN NULL DEFAULT false,
    `processed_at` DATETIME(0) NULL,
    `processed_by` INTEGER NULL,
    `is_complete` BOOLEAN NULL DEFAULT false,
    `completed_at` DATETIME(0) NULL,
    `created_at` DATETIME(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` DATETIME(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `keterangan` TEXT NULL,
    `tgl_target` DATE NULL,
    `penyelesaian` TEXT NULL,
    `ket_selesai` TEXT NULL,
    `jenis_penyelesaian_id` INTEGER NULL,
    `foto_penyelesaian` TEXT NULL,
    `petugas_id` INTEGER NULL,
    `sumber_laporan` VARCHAR(50) NULL,
    `diameter_id` INTEGER NULL,

    INDEX `diameter_id`(`diameter_id`),
    INDEX `jenis_aduan_id`(`jenis_aduan_id`),
    INDEX `jenis_penyelesaian_id`(`jenis_penyelesaian_id`),
    INDEX `pelanggan_id`(`pelanggan_id`),
    INDEX `petugas_id`(`petugas_id`),
    INDEX `processed_by`(`processed_by`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `penugasan` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nomor_penugasan` VARCHAR(50) NULL,
    `divisi_id` INTEGER NOT NULL,
    `created_at` DATETIME(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` DATETIME(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `deleted_at` DATETIME(0) NULL,

    INDEX `divisi_id`(`divisi_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `penugasan_pengaduan` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `pengaduan_id` INTEGER NOT NULL,
    `penugasan_id` INTEGER NOT NULL,
    `created_at` DATETIME(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` DATETIME(0) NULL DEFAULT CURRENT_TIMESTAMP(0),

    INDEX `pengaduan_id`(`pengaduan_id`),
    INDEX `penugasan_id`(`penugasan_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `petugas` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nama` VARCHAR(255) NOT NULL,
    `role` VARCHAR(50) NULL,
    `no_telp` VARCHAR(20) NULL,
    `divisi_id` INTEGER NOT NULL,
    `username` VARCHAR(255) NOT NULL,
    `password` VARCHAR(255) NOT NULL,
    `is_active` BOOLEAN NULL DEFAULT true,
    `deleted_at` DATETIME(0) NULL,

    UNIQUE INDEX `username`(`username`),
    INDEX `divisi_id`(`divisi_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `rayon` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `kode_rayon` VARCHAR(35) NULL,
    `nama` VARCHAR(100) NOT NULL,
    `wilayah_id` INTEGER NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `aktif` BOOLEAN NULL DEFAULT true,

    INDEX `rayons_unit_id_foreign`(`wilayah_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `setting` (
    `id` INTEGER NOT NULL,
    `lokalpathftp` VARCHAR(256) NULL,
    `lokalfolderfoto` VARCHAR(256) NULL,
    `remotefolderfoto` VARCHAR(256) NULL,
    `virtualdirfoto` VARCHAR(256) NULL,
    `alamatwebinfo` VARCHAR(256) NULL,
    `flagstaticmap` VARCHAR(1) NULL,
    `folderbackup` VARCHAR(256) NULL,
    `bolehbc2step` SMALLINT NULL DEFAULT 1,
    `bolehbcbarcode` SMALLINT NULL DEFAULT 1,
    `bolehbclastdigit` SMALLINT NULL DEFAULT 1,
    `bolehbcdatabase` SMALLINT NULL DEFAULT 1,
    `strictbcbylatlong` SMALLINT NULL DEFAULT 0,
    `strictbcgps` SMALLINT NULL DEFAULT 0,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `settingdesktop` (
    `idx` SMALLINT NOT NULL,
    `mundurtglbyr` SMALLINT NULL,
    `headerlap1` VARCHAR(55) NULL,
    `headerlap2` VARCHAR(55) NULL,
    `alamat1` VARCHAR(100) NULL,
    `alamat2` VARCHAR(100) NULL,
    `footerkota` VARCHAR(45) NULL,

    PRIMARY KEY (`idx`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `setup_denda` (
    `idx` INTEGER NOT NULL AUTO_INCREMENT,
    `tgl` SMALLINT NULL,
    `flagpersen` BOOLEAN NULL DEFAULT false,
    `denda1` INTEGER NULL,
    `denda2` INTEGER NULL,

    PRIMARY KEY (`idx`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `setup_ppn` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `jml` DECIMAL(4, 2) NULL,
    `mulaitgl` DATE NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `sktarif` (
    `id` TINYINT NOT NULL AUTO_INCREMENT,
    `tahun` INTEGER NOT NULL,
    `nomor_sk` VARCHAR(50) NOT NULL,
    `aktif` BOOLEAN NOT NULL DEFAULT true,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tarif` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `golongan_id` INTEGER NOT NULL,
    `min` INTEGER NOT NULL,
    `max` INTEGER NOT NULL,
    `harga` INTEGER NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `istetap` SMALLINT NULL DEFAULT 0,

    INDEX `tarif_details_golongan_id_foreign`(`golongan_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ttdlap` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `kode` VARCHAR(5) NULL,
    `namalap` VARCHAR(45) NULL,
    `id1` INTEGER NULL,
    `id2` INTEGER NULL,
    `id3` INTEGER NULL,
    `id4` INTEGER NULL,
    `header1` VARCHAR(35) NULL,
    `header2` VARCHAR(35) NULL,
    `header3` VARCHAR(35) NULL,
    `header4` VARCHAR(35) NULL,

    UNIQUE INDEX `UNIQUE`(`kode`),
    INDEX `id1`(`id1`),
    INDEX `id2`(`id2`),
    INDEX `id3`(`id3`),
    INDEX `id4`(`id4`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `user_loket` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `user_id` INTEGER NOT NULL,
    `loket_id` INTEGER NOT NULL,
    `aktif` BOOLEAN NOT NULL,

    INDEX `user_id`(`user_id`),
    INDEX `user_loket_ibfk_2`(`loket_id`),
    UNIQUE INDEX `user_id_2`(`user_id`, `loket_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `userparaf` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nama` VARCHAR(50) NULL,
    `jabatan` VARCHAR(50) NULL DEFAULT '-',
    `nik` VARCHAR(15) NULL DEFAULT '-',

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `users` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `username` CHAR(50) NOT NULL,
    `password` CHAR(100) NOT NULL,
    `nama` CHAR(50) NOT NULL,
    `jabatan` CHAR(50) NOT NULL,
    `role` CHAR(50) NOT NULL,
    `is_user_ppob` BOOLEAN NOT NULL,
    `list_authorized_page` JSON NOT NULL,
    `is_active` BOOLEAN NOT NULL,

    UNIQUE INDEX `username`(`username`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `wilayah` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nama` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `angsuran` ADD CONSTRAINT `angsuran_ibfk_1` FOREIGN KEY (`psb_id`) REFERENCES `pasangbaru`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `angsuran` ADD CONSTRAINT `angsuran_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `golongan` ADD CONSTRAINT `golongan_ibfk_1` FOREIGN KEY (`idsktarif`) REFERENCES `sktarif`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `pasangbaru` ADD CONSTRAINT `pasangbaru_ibfk_1` FOREIGN KEY (`reg_id`) REFERENCES `pendaftaranpel`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `pasangbaru` ADD CONSTRAINT `pasangbaru_ibfk_2` FOREIGN KEY (`golongan_id`) REFERENCES `golongan`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `pasangbaru` ADD CONSTRAINT `pasangbaru_ibfk_3` FOREIGN KEY (`user_input`) REFERENCES `users`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `pasangbaru` ADD CONSTRAINT `pasangbaru_ibfk_4` FOREIGN KEY (`user_setuju`) REFERENCES `users`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `pasangbaru` ADD CONSTRAINT `pasangbaru_ibfk_5` FOREIGN KEY (`user_realisasi`) REFERENCES `users`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `pasangbaru` ADD CONSTRAINT `pasangbaru_ibfk_6` FOREIGN KEY (`petugas_id`) REFERENCES `petugas`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `pelanggan` ADD CONSTRAINT `pelanggan_ibfk_1` FOREIGN KEY (`rayon_id`) REFERENCES `rayon`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `pelanggan` ADD CONSTRAINT `pelanggan_ibfk_2` FOREIGN KEY (`jalan_id`) REFERENCES `jalan`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `pelanggan` ADD CONSTRAINT `pelanggan_ibfk_3` FOREIGN KEY (`wilayah_id`) REFERENCES `wilayah`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `pelanggan` ADD CONSTRAINT `pelanggan_ibfk_4` FOREIGN KEY (`golongan_id`) REFERENCES `golongan`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `pelanggan` ADD CONSTRAINT `pelanggan_ibfk_5` FOREIGN KEY (`diameter_id`) REFERENCES `diameters`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `pelanggan` ADD CONSTRAINT `pelanggan_ibfk_6` FOREIGN KEY (`kec_id`) REFERENCES `kecamatan`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `pelanggan` ADD CONSTRAINT `pelanggan_ibfk_7` FOREIGN KEY (`kel_id`) REFERENCES `kelurahan`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `pelanggan` ADD CONSTRAINT `pelanggan_ibfk_8` FOREIGN KEY (`merek_id`) REFERENCES `merek_meters`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `pelanggan` ADD CONSTRAINT `pelanggan_ibfk_9` FOREIGN KEY (`kolektif_id`) REFERENCES `kolektif`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `pendaftaran_lain` ADD CONSTRAINT `pendaftaran_lain_ibfk_1` FOREIGN KEY (`pelanggan_id`) REFERENCES `pelanggan`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `pendaftaran_lain` ADD CONSTRAINT `pendaftaran_lain_ibfk_2` FOREIGN KEY (`jenis_nonair_id`) REFERENCES `jenis_nonair`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `pendaftaran_lain` ADD CONSTRAINT `pendaftaran_lain_ibfk_3` FOREIGN KEY (`user_input`) REFERENCES `users`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `pendaftaran_lain` ADD CONSTRAINT `pendaftaran_lain_ibfk_4` FOREIGN KEY (`petugas_id`) REFERENCES `petugas`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `pendaftaran_lain` ADD CONSTRAINT `pendaftaran_lain_ibfk_5` FOREIGN KEY (`user_realisasi`) REFERENCES `users`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `pendaftaranpel` ADD CONSTRAINT `pendaftaranpel_ibfk_1` FOREIGN KEY (`kec_id`) REFERENCES `kecamatan`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `pendaftaranpel` ADD CONSTRAINT `pendaftaranpel_ibfk_2` FOREIGN KEY (`rayon_id`) REFERENCES `rayon`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `pendaftaranpel` ADD CONSTRAINT `pendaftaranpel_ibfk_3` FOREIGN KEY (`kel_id`) REFERENCES `kelurahan`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `pendaftaranpel` ADD CONSTRAINT `pendaftaranpel_ibfk_4` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `pendaftaranpel` ADD CONSTRAINT `pendaftaranpel_ibfk_5` FOREIGN KEY (`jenis_nonair_id`) REFERENCES `jenis_nonair`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `penerimaan_nonair` ADD CONSTRAINT `penerimaan_nonair_ibfk_1` FOREIGN KEY (`jenisnonair_id`) REFERENCES `jenis_nonair`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `penerimaan_nonair` ADD CONSTRAINT `penerimaan_nonair_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `penerimaan_nonair` ADD CONSTRAINT `penerimaan_nonair_ibfk_3` FOREIGN KEY (`loket_id`) REFERENCES `loket`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `pengaduan` ADD CONSTRAINT `pengaduan_ibfk_1` FOREIGN KEY (`jenis_aduan_id`) REFERENCES `jenis_aduan`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `pengaduan` ADD CONSTRAINT `pengaduan_ibfk_2` FOREIGN KEY (`petugas_id`) REFERENCES `petugas`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `pengaduan` ADD CONSTRAINT `pengaduan_ibfk_3` FOREIGN KEY (`pelanggan_id`) REFERENCES `pelanggan`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `pengaduan` ADD CONSTRAINT `pengaduan_ibfk_4` FOREIGN KEY (`processed_by`) REFERENCES `petugas`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `pengaduan` ADD CONSTRAINT `pengaduan_ibfk_5` FOREIGN KEY (`jenis_penyelesaian_id`) REFERENCES `jenis_penyelesaian`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `pengaduan` ADD CONSTRAINT `pengaduan_ibfk_6` FOREIGN KEY (`diameter_id`) REFERENCES `diameters`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `penugasan` ADD CONSTRAINT `penugasan_ibfk_1` FOREIGN KEY (`divisi_id`) REFERENCES `divisi`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `penugasan_pengaduan` ADD CONSTRAINT `penugasan_pengaduan_ibfk_1` FOREIGN KEY (`pengaduan_id`) REFERENCES `pengaduan`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `penugasan_pengaduan` ADD CONSTRAINT `penugasan_pengaduan_ibfk_2` FOREIGN KEY (`penugasan_id`) REFERENCES `penugasan`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `petugas` ADD CONSTRAINT `petugas_ibfk_1` FOREIGN KEY (`divisi_id`) REFERENCES `divisi`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `rayon` ADD CONSTRAINT `rayon_ibfk_1` FOREIGN KEY (`wilayah_id`) REFERENCES `wilayah`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tarif` ADD CONSTRAINT `tarif_ibfk_1` FOREIGN KEY (`golongan_id`) REFERENCES `golongan`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `ttdlap` ADD CONSTRAINT `ttdlap_ibfk_1` FOREIGN KEY (`id1`) REFERENCES `userparaf`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `ttdlap` ADD CONSTRAINT `ttdlap_ibfk_2` FOREIGN KEY (`id2`) REFERENCES `userparaf`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `ttdlap` ADD CONSTRAINT `ttdlap_ibfk_3` FOREIGN KEY (`id3`) REFERENCES `userparaf`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `ttdlap` ADD CONSTRAINT `ttdlap_ibfk_4` FOREIGN KEY (`id4`) REFERENCES `userparaf`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `user_loket` ADD CONSTRAINT `user_loket_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `user_loket` ADD CONSTRAINT `user_loket_ibfk_2` FOREIGN KEY (`loket_id`) REFERENCES `loket`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;


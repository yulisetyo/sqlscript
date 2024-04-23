/* Formatted on 20/03/2023 16:40:35 (QP5 v5.215.12089.38647) */
  SELECT LOWER (tname) AS tname
    FROM tab
   WHERE LOWER (tname) LIKE 'ssrg%'
ORDER BY 1;

  SELECT *
    FROM kur_r_level
   WHERE SUBSTR (kdlevel, 1, 1) = '5'
ORDER BY 1;

SELECT * FROM ssrg_t_gudang;

SELECT * FROM ssrg_r_komoditas;

SELECT * FROM ssrg_r_skema;

SELECT * FROM ssrg_t_pengelola;

SELECT * FROM ssrg_t_resigudang;

SELECT * FROM kur_r_marital_sts;

--UPDATE ssrg_t_debitur
--   SET is_aktif = 1
-- WHERE id = 9;

SELECT * FROM ssrg_t_debitur;

SELECT a.id,
       a.nik,
       a.nama,
       TO_CHAR (a.tgl_lahir, 'dd-mm-yyyy') AS tgl_lahir,
       b.nama AS jns_kelamin,
       c.deskripsi AS maritas_sts,
       d.deskripsi AS pendidikan,
       e.deskripsi AS pekerjaan,
       a.alamat,
       f.nama_wilayah,
       a.kode_pos,
       a.npwp,
       a.no_hp,
       TO_CHAR (a.mulai_usaha, 'dd-mm-yyyy') AS mulai_usaha,
       a.ijin_usaha,
       a.alamat_usaha,
       a.modal_usaha,
       a.jumlah_pekerja,
       a.jumlah_kredit AS nilai_pengajuan,
       a.is_subsidized,
       a.is_linkage,
       a.is_aktif,
       a.is_api,
       CASE WHEN a.is_aktif IS NULL THEN 'N/A' ELSE CASE WHEN a.is_aktif = 1 THEN 'Aktif' ELSE 'Inaktif' END END AS sts_aktif
  FROM ssrg_t_debitur a
       LEFT JOIN kur_r_jenis_kelamin b
          ON (a.jns_kelamin = b.kode)
       LEFT JOIN kur_r_marital_sts c
          ON (a.maritas_sts = c.marital_sts)
       LEFT JOIN kur_r_pendidikan d
          ON (a.pendidikan = d.pendidikan)
       LEFT JOIN kur_r_pekerjaan e
          ON (a.pekerjaan = e.pekerjaan)
       LEFT JOIN kur_r_wilayah f
          ON (a.kode_kabkota = f.kode_wilayah)
 WHERE a.nik IS NOT NULL AND a.is_aktif = 1;

--UPDATE ssrg_t_debitur
--   SET is_aktif = 0
-- WHERE npwp IS NULL;

SELECT * FROM ssrg_t_resigudang;

SELECT a.id,
       a.id_debitur,
       b.nama,
       a.id_gudang,
       c.nama_gudang,
       a.nomor_resi,
       a.komoditas,
       d.deskripsi AS nama_komoditas,
       a.nilai_komoditas,
       a.nilai_pembiayaan,
       TO_CHAR (a.tgl_penjaminan, 'dd-mm-yyyy') AS tgl_penjaminan,
       TO_CHAR (a.tgl_terbit, 'dd-mm-yyyy') AS tgl_terbit,
       TO_CHAR (a.tgl_jatuh_tempo, 'dd-mm-yyyy') AS tgl_jatuh_tempo,
       TO_CHAR (a.tgl_pengeluaran, 'dd-mm-yyyy') AS tgl_pengeluaran,
       CASE WHEN a.is_aktif = 1 THEN 'aktif' WHEN a.is_aktif IS NULL THEN 'N/A' ELSE 'Inaktif' END AS sts_aktif,
       a.id_user_kirim,
       TO_CHAR (a.tgl_upload, 'dd-mm-yyyy') AS tgl_upload
  FROM ssrg_t_resigudang a
       LEFT JOIN ssrg_t_debitur b
          ON (a.id_debitur = b.id)
       LEFT JOIN ssrg_t_gudang c
          ON (a.id_gudang = c.id)
       LEFT JOIN ssrg_r_komoditas d
          ON (a.komoditas = d.kode_komoditas)
 WHERE a.is_aktif = 1;

SELECT * FROM ssrg_t_gudang;

SELECT a.id,
       a.kode_registrasi,
       a.nama_gudang,
       a.alamat_gudang,
       a.telp_gudang,
       a.email_gudang,
       a.kode_kabkota,
       TRIM (c.nama_wilayah) AS nama_wilayah,
       a.kode_pos,
       a.id_pengelola,
       b.nama AS nama_pengelola,
       CASE WHEN a.is_aktif = 1 THEN 'aktif' WHEN a.is_aktif IS NULL THEN 'N/A' ELSE 'Inaktif' END AS sts_aktif
  FROM ssrg_t_gudang a
       LEFT JOIN ssrg_t_pengelola b
          ON (a.id_pengelola = b.id)
       LEFT JOIN kur_r_wilayah c
          ON (a.kode_kabkota = c.kode_wilayah)
 WHERE a.is_aktif = 1;


SELECT * FROM ssrg_t_pengelola;

SELECT a.id,
       a.kode_registrasi,
       a.nama,
       a.nik,
       a.npwp,
       a.no_hp,
       a.alamat_pengelola,
       a.kode_kabkota,
       a.kode_pos,
       TRIM (UPPER (b.nama_wilayah)) AS nama_wilayah,
       CASE WHEN a.is_aktif = 1 THEN 'aktif' WHEN a.is_aktif IS NULL THEN 'N/A' ELSE 'Inaktif' END AS sts_aktif
  FROM ssrg_t_pengelola a LEFT JOIN kur_r_wilayah b ON (a.kode_kabkota = b.kode_wilayah)
 WHERE a.is_aktif = 1;


SELECT TO_DATE (TO_CHAR (SYSDATE, 'mm/dd/yyyy hh24:mi:ss'), 'mm/dd/yyyy hh24:mi:ss') AS tgl_update FROM DUAL;


SELECT a.*,
       TO_CHAR (a.tgl_penjaminan, 'mm/dd/yyyy') AS tg_penjaminan,
       TO_CHAR (a.tgl_terbit, 'mm/dd/yyyy') AS tg_terbit,
       TO_CHAR (a.tgl_jatuh_tempo, 'mm/dd/yyyy') AS tg_jatuh_tempo,
       TO_CHAR (a.tgl_pengeluaran, 'mm/dd/yyyy') AS tg_pengeluaran
  FROM ssrg_t_resigudang a;

-- REALISASI PENYALURAN SSRG  
  SELECT a.nik,
       d.nama,
       d.kode_kabkota,
       d.pendidikan,
       d.pekerjaan,
       a.nilai_akad,
       a.nomor_akad,
       TO_CHAR (a.tgl_akad, 'yyyy-mm-dd') AS tgl_akad,
       TO_CHAR (a.tgl_jatuh_tempo, 'yyyy-mm-dd') AS tgl_jatuh_tempo,
       TO_CHAR (a.tgl_akad, 'yyyy') AS tahun_akad,
       TO_CHAR (a.tgl_akad, 'mm') AS bulan_akad,
       a.skema,
       a.sektor,
       f.deskripsi AS nmsektor,
       f.sektor2 AS sektorg,
       g.deskripsi2 AS nmsektorg,
       h.outstanding
  FROM ssrg_t_akad a
       LEFT JOIN ssrg_t_debitur d
          ON (a.nik = d.nik AND a.kode_bank = d.kode_bank)
       LEFT JOIN kur_r_bank k
          ON (a.kode_bank = k.kode_bank)
       LEFT JOIN kur_r_sektor f
          ON (a.sektor = f.sektor)
       LEFT JOIN kur_r_sektor_group g
          ON (f.sektor2 = g.sektor2)
       LEFT JOIN ((SELECT nik,
                          kdbank AS kode_bank,
                          tahun,
                          skema,
                          norek AS nomor_rekening,
                          TO_CHAR (tgl_akad, 'yyyy-mm-dd') AS tgl_akad,
                          akad AS nilai_akad,
                          kredit,
                          outstanding
                     FROM ssrg_t_balance)) h
          ON (a.nik = h.nik AND a.kode_bank = h.kode_bank AND a.rekening_baru = h.nomor_rekening AND TO_CHAR (a.tgl_akad, 'yyyymmdd') = h.tgl_akad)
 WHERE a.nomor_akad IS NOT NULL;

/* Formatted on 18/01/2024 17:21:14 (QP5 v5.215.12089.38647) */
  SELECT *
    FROM tab
   WHERE LOWER (tname) LIKE 'kur_r_%'                                                                                                              --AND LOWER (tname) LIKE '%ssrg%'
ORDER BY 1;

  SELECT *
    FROM kur_r_level
   WHERE SUBSTR (kdlevel, 1, 1) = '5'
ORDER BY 1;

SELECT sektor2 AS grup_sektor,
       sektor,
       deskripsi,
       DECODE (status, 1, 'aktif', 'suspen') AS status,
       is_produksi,
       id_skenario
  FROM kur_r_sektor
 WHERE status = 1 AND id_skenario IS NOT NULL;

SELECT * FROM kur_r_sektor_group;

  SELECT sektor2 AS group_sektor,
         UPPER (deskripsi2) AS deskripsi_group_sektor,
         DECODE (status, 1, 'aktif', 'suspen') AS status,
         produksi AS is_produksi
    FROM kur_r_sektor_group
   WHERE sektor2 = :p_kode_group AND status = 1 AND produksi = 1
ORDER BY group_sektor ASC;

SELECT * FROM kur_r_pendidikan;

SELECT * FROM kur_r_wilayah;

SELECT * FROM kur_r_wilayah_propinsi;

SELECT * FROM kur_r_sektor;


SELECT * FROM kur_r_grup_map;


SELECT * FROM kur_r_api_user_level;


SELECT a.id,
       a.id_api_user,
       a.kdlevel,
       a.username,
       a.kdgrup,
       b.kddept,
       b.kdunit,
       b.kdsatker,
       b.kdbank,
       b.kdwilayah
  FROM kur_r_api_user_level a LEFT JOIN kur_r_grup_map b ON (a.kdgrup = b.kdgrup)
 WHERE a.id_api_user = 61;


SELECT * FROM ssrg_chck_overlimit;


SELECT * FROM ssrg_t_debitur;


SELECT a.nik,
       a.nama,
       TO_CHAR (a.tgl_lahir, 'dd-mm-yyyy') tgl_lahir,
       a.jns_kelamin,
       a.maritas_sts,
       CASE WHEN a.jns_kelamin = 1 THEN 'LAKI-LAKI' WHEN a.jns_kelamin = 2 THEN 'PEREMPUAN' WHEN a.jns_kelamin = 9 THEN 'BADAN USAHA' END AS nm_jns_kelamin,
       CASE WHEN a.maritas_sts = 0 THEN 'BELUM KAWIN' WHEN a.maritas_sts = 1 THEN 'KAWIN' WHEN a.maritas_sts = 9 THEN 'BADAN USAHA' END AS nm_maritas_sts,
       a.pendidikan,
       a.pekerjaan,
       UPPER (a.alamat) AS alamat,
       a.kode_kabkota,
       a.kode_pos,
       a.npwp,
       a.no_hp,
       TO_CHAR (a.mulai_usaha, 'dd-mm-yyyy') mulai_usaha,
       a.alamat_usaha,
       a.modal_usaha,
       a.jumlah_pekerja,
       a.jumlah_kredit,
       a.ijin_usaha,
       TO_CHAR (a.tgl_upload, 'dd-mm-yyyy hh24:mi:ss') AS tgl_upload,
       a.kode_bank,
       UPPER (b.nama_bank) AS nama_bank,
       c.deskripsi AS nama_pendidikan,
       d.deskripsi AS nama_pekerjaan,
       UPPER (e.nama_wilayah) AS nama_kabkota,
       UPPER (f.nama_wilayah) AS nama_provinsi
  FROM ssrg_t_debitur a
       LEFT JOIN kur_r_bank b
          ON (a.kode_bank = b.kode_bank)
       LEFT JOIN kur_r_pendidikan c
          ON (a.pendidikan = c.pendidikan)
       LEFT JOIN kur_r_pekerjaan d
          ON (a.pekerjaan = d.pekerjaan)
       LEFT JOIN kur_r_wilayah e
          ON (a.kode_kabkota = e.kode_wilayah)
       LEFT JOIN kur_r_wilayah_propinsi f
          ON (SUBSTR (a.kode_kabkota, 1, 2) = f.kode_wilayah)
 WHERE a.nik = :p_nik;


  SELECT a.skema,
         a.total_limit_def,
         a.limit_def,
         NVL (b.total_limit, 0) AS total_limit,
         NVL (c.limit_aktif, 0) AS limit_aktif,
         NVL (c.total_akad, 0) AS total_akad,
         NVL (c.nik, b.nik) AS nik,
         CASE WHEN c.limit_aktif <= a.total_limit_def AND c.total_akad <= a.total_limit_def THEN 1 ELSE 0 END AS status,
         CASE WHEN c.limit_aktif <= a.total_limit_def AND c.total_akad <= a.total_limit_def THEN 'Limit masih tersedia' ELSE 'Sudah melewati limit' END AS keterangan,
         NVL (d.nama, 'N/A') AS nama
    FROM (SELECT a.kdskema AS skema, a.LIMIT AS total_limit_def, a.LIMIT AS limit_def
            FROM kur_r_skema_parent a
           WHERE a.kdskema = 8) a
         JOIN (  SELECT nik,
                        TO_CHAR (tgl_akad, 'yyyy') AS tahun,
                        SUBSTR (skema, 1, 1) AS skema,
                        SUM (nilai_akad) AS total_limit
                   FROM ssrg_t_akad
                  WHERE TO_CHAR (tgl_akad, 'yyyy') = '2023' AND nik = '3315085902810001' AND kode_bank = '110' AND SUBSTR (skema, 1, 1) = 8
               GROUP BY nik, TO_CHAR (tgl_akad, 'yyyy'), SUBSTR (skema, 1, 1)) b
            ON (a.skema = b.skema)
         LEFT JOIN (  SELECT nik,
                             TO_CHAR (tgl_akad, 'yyyy') AS tahun,
                             SUBSTR (skema, 1, 1) AS skema,
                             SUM (akad) AS total_akad,
                             SUM (outstanding) AS limit_aktif
                        FROM ssrg_t_balance
                       WHERE TO_CHAR (tgl_akad, 'yyyy') = '2023' AND nik = '3315085902810001' AND kdbank = '110' AND SUBSTR (skema, 1, 1) = 8
                    GROUP BY nik, TO_CHAR (tgl_akad, 'yyyy'), SUBSTR (skema, 1, 1)) c
            ON (a.skema = c.skema AND b.nik = c.nik)
         JOIN (SELECT kode_bank, nik, TRIM (nama) AS nama
                 FROM ssrg_t_debitur
                WHERE nik IS NOT NULL AND kode_bank = '110') d
            ON (b.nik = d.nik)
ORDER BY 1 ASC;


SELECT a.id,
       a.client_id,
       a.client_secret,
       a.username,
       a.ket AS keterangan,
       b.kdlevel,
       b.kdgrup,
       c.nmlevel,
       FLOOR (DBMS_RANDOM.VALUE (1, 999999)) AS rand_key,
       TO_CHAR (SYSDATE, 'yyyymmddhh24miss') || FLOOR (DBMS_RANDOM.VALUE (1, 999999)) AS start_access
  FROM kur_r_api_user a
       LEFT JOIN kur_r_api_user_level b
          ON (b.id_api_user = a.id)
       LEFT JOIN kur_r_level c
          ON (b.kdlevel = c.kdlevel)
 WHERE SUBSTR (b.kdlevel, 1, 1) = '5' AND a.username = '199108082013101004';


SELECT TO_CHAR (SYSDATE, 'yyyy-mm-dd'), TO_CHAR ( (SYSDATE - 90), 'yyyy-mm-dd') FROM DUAL;


SELECT * FROM ssrg_t_akad;


SELECT a.id,
       a.client_id,
       a.client_secret,
       a.username,
       a.ket AS keterangan,
       b.kdlevel,
       b.kdgrup,
       c.nmlevel,
       TO_CHAR (SYSDATE, 'yyyymmddhh24miss') AS tgl_akses,
       d.kddept,
       d.kdunit,
       d.kdsatker,
       d.kdbank,
       d.kdwilayah
  FROM kur_r_api_user a
       LEFT JOIN kur_r_api_user_level b
          ON (b.id_api_user = a.id)
       LEFT JOIN kur_r_level c
          ON (b.kdlevel = c.kdlevel)
       LEFT JOIN kur_r_grup_map d
          ON (b.kdgrup = d.kdgrup)
 WHERE SUBSTR (b.kdlevel, 1, 1) = '5' AND a.username = :p_username;


SELECT * FROM ssrg_t_tagihan_detail;

SELECT * FROM ssrg_t_tagihan_rekap;

SELECT * FROM ssrg_t_transaksi;

  SELECT a.id,
         a.no_rek,
         TO_CHAR (a.tgl_transaksi, 'dd-mm-yyyy') AS tgl_transaksi,
         TO_CHAR (a.tgl_pelaporan, 'dd-mm-yyyy') AS tgl_pelaporan,
         a.LIMIT,
         a.outstanding,
         a.angsuran_pokok,
         a.kolektibilitas,
         a.kode_transaksi,
         NVL (a.status_data, '-') AS status_data,
         a.b_limit,
         TO_CHAR (a.tgl_upload, 'dd-mm-yyyy') AS tgl_kirim,
         TO_CHAR (a.tgl_update, 'dd-mm-yyyy') AS tgl_update,
         a.kode_bank,
         TO_CHAR (a.tgl_transaksi, 'yyyymmdd') AS urutan
    FROM ssrg_t_transaksi a
   WHERE a.kode_bank = '110' AND a.no_rek = '0170B131220427000751'
ORDER BY urutan ASC;

INSERT INTO ssrg_t_transaksi (no_rek,
                              tgl_transaksi,
                              tgl_pelaporan,
                              LIMIT,
                              outstanding,
                              angsuran_pokok,
                              kolektibilitas,
                              kode_transaksi,
                              status_data,
                              b_limit,
                              kode_bank)
     VALUES (:p_no_rek,
             :p_tgl_transaksi,
             :p_tgl_pelaporan,
             :p_limit,
             :p_outstanding,
             :p_angsuran_pokok,
             :p_kolektibilitas,
             :p_kode_transaksi,
             :p_status_data,
             :p_b_limit,
             :p_kode_bank);


SELECT * FROM ssrg_t_resigudang;


SELECT * FROM ssrg_r_komoditas;


  SELECT a.kode_komoditas,
         a.deskripsi,
         a.satuan,
         a.dasar_hukum,
         a.is_aktif,
         TO_CHAR (a.tgl_upload, 'yyyy-mm-dd hh24:mi:ss') AS tgl_upload
    FROM ssrg_r_komoditas a
   WHERE a.is_aktif = 1
ORDER BY a.tgl_upload, kode_komoditas;


SELECT a.id,
       a.nik,
       a.reg_gudang,
       a.nomor_resi,
       a.komoditas,
       a.nilai_komoditas,
       TO_CHAR (a.tgl_penjaminan, 'dd-mm-yyyy') AS tgl_penjaminan,
       TO_CHAR (a.tgl_terbit, 'dd-mm-yyyy') AS tgl_terbit,
       TO_CHAR (a.tgl_jatuh_tempo, 'dd-mm-yyyy') AS tgl_jatuh_tempo,
       TO_CHAR (a.tgl_pengeluaran, 'dd-mm-yyyy') AS tgl_pengeluaran,
       TO_CHAR (a.tgl_upload, 'dd-mm-yyyy hh24:mi:ss') AS tgl_kirim,
       TO_CHAR (a.tgl_upload, 'yyyymmdd') AS urutan,
       a.nama_pemilik
  FROM ssrg_t_resigudang a
 WHERE a.nik = :p_nik;

INSERT INTO ssrg_t_resigudang (nik,
                               reg_gudang,
                               nomor_resi,
                               komoditas,
                               nilai_komoditas,
                               tgl_penjaminan,
                               tgl_terbit,
                               tgl_jatuh_tempo,
                               tgl_pengeluaran,
                               is_kelompok,
                               nama_pemilik,
                               id_user_kirim,
                               is_aktif,
                               tgl_upload)
     VALUES (:p_nik,
             :p_reg_gudang,
             :p_nomor_resi,
             :p_komoditas,
             :p_nilai_komoditas,
             :p_tgl_penjaminan,
             :p_tgl_terbit,
             :p_tgl_jatuh_tempo,
             :p_tgl_pengeluaran,
             :p_is_kelompok,
             :p_nama_pemilik,
             :p_id_user_kirim,
             :p_is_aktif,
             SYSDATE);


  SELECT a.id,
         a.kode_registrasi,
         a.nama_gudang,
         a.alamat_gudang,
         a.telp_gudang,
         a.email_gudang,
         a.kode_kabkota,
         a.kode_pos,
         a.nm_pengelola,
         TO_CHAR (a.tgl_upload, 'dd-mm-yyyy') AS tgl_kirim,
         a.id_user_kirim,
         b.nama_wilayah AS nama_kabkota
    FROM ssrg_t_gudang a LEFT JOIN kur_r_wilayah b ON (a.kode_kabkota = b.kode_wilayah)
ORDER BY id ASC;


INSERT INTO ssrg_t_gudang (kode_registrasi,
                           nama_gudang,
                           alamat_gudang,
                           telp_gudang,
                           email_gudang,
                           kode_kabkota,
                           kode_pos,
                           nm_pengelola,
                           id_user_kirim,
                           tgl_upload)
     VALUES (:p_kode_registrasi,
             :p_nama_gudang,
             :p_alamat_gudang,
             :p_telp_gudang,
             :p_email_gudang,
             :p_kode_kabkota,
             :p_kode_pos,
             :p_nm_pengelola,
             :p_id_user_kirim,
             SYSDATE)
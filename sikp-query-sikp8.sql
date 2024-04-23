/* Formatted on 14/06/2023 11:41:47 (QP5 v5.215.12089.38647) */
/*
1. SSRG_T_STS_UPLOAD_TAGIHAN_BANK
2. SSRG_T_STS_UPLOAD_TAGIHAN_PUSREG
3. SSRG_T_STS_UPLOAD_TAGIHAN_KPA
4. SSRG_T_TAGIHAN_DETAIL_BANK
5. SSRG_T_TAGIHAN_DETAIL_REKON
6. SSRG_T_TAGIHAN_REKAP
7. SSRG_T_PLAFONBANK
8. SSRG_R_KOMODITAS
9. SSRG_T_STATUS_UPLOAD
*/

SELECT *
  FROM tab
 WHERE LOWER (tname) LIKE '%ssrg%';

  SELECT *
    FROM kur_r_menu_2023
   WHERE LOWER (title) LIKE '%komod%'
ORDER BY id DESC;

  SELECT *
    FROM kur_r_menu_2023
ORDER BY 1 DESC;

  SELECT *
    FROM kur_r_level
ORDER BY 1;

SELECT * FROM kur_r_level_akses;

  SELECT *
    FROM kur_r_modul
ORDER BY 1;

  SELECT *
    FROM kur_r_modul_akses
ORDER BY 1;

SELECT * FROM kur_r_skema;

SELECT * FROM kur_t_rekap_bank_skema;

SELECT * FROM ssrg_t_sts_upload_tagihan_bank;

SELECT * FROM ssrg_t_sts_upload_tagihan_kpa;

SELECT * FROM ssrg_t_sts_upload_tagihan_pusreg;

SELECT * FROM ssrg_t_plafonbank;

DESC ssrg_t_sts_upload_tagihan_bank;

SELECT * FROM kur_t_status_upload_tagihan;

/*
INSERT INTO SSRG_T_STS_UPLOAD_TAGIHAN_BANK (KDBANK,
                                            TAHUN,
                                            PERIODE,
                                            NAMA_FILE,
                                            TGL_UPLOAD,
                                            USERNAME,
                                            STATUS,
                                            NAMA_LOG_FILE,
                                            JENIS,
                                            NOSURAT,
                                            TGSURAT,
                                            JMLTAGIHAN,
                                            NOSP2D,
                                            TGSP2D,
                                            JMLSP2D,
                                            UPLOAD_KE,
                                            TGL_REKON)
     VALUES ('008', '2023', '03');*/

DESC kur_r_menu_2023;

DESC ssrg_t_plafonbank;

SELECT *
  FROM kur_r_user_level
 WHERE username LIKE '19830703%';

UPDATE kur_r_user_level
   SET kdbank = '002'
 WHERE kdlevel = '51' AND username = '198307032002121006';

DESC ssrg_t_sts_upload_tagihan_bank;

SELECT * FROM ssrg_t_sts_upload_tagihan_pusreg;

SELECT * FROM ssrg_t_sts_upload_tagihan_bank;

SELECT * FROM ssrg_r_komoditas;

  SELECT kode_komoditas,
         deskripsi,
         satuan,
         dasar_hukum
    FROM ssrg_r_komoditas
   WHERE is_aktif = 1
ORDER BY 1 ASC;

SELECT * FROM ssrg_t_gudang;

SELECT * FROM ssrg_t_resigudang;

SELECT * FROM ssrg_t_status_upload;

SELECT * FROM kur_r_level_akses;

SELECT * FROM kur_r_menu_akses;

SELECT *
  FROM kur_r_modul
 WHERE LOWER (kdmodul) LIKE 'ssrg%';

SELECT * FROM kur_r_modul_akses;

  SELECT a.id,
         a.nik,
         b.nama,
         a.reg_gudang,
         a.nomor_resi,
         a.komoditas,
         c.deskripsi,
         a.nilai_komoditas,
         TO_CHAR (a.tgl_penjaminan, 'dd-mm-yyyy') AS tgl_penjaminan,
         TO_CHAR (a.tgl_terbit, 'dd-mm-yyyy') AS tgl_terbit,
         TO_CHAR (a.tgl_jatuh_tempo, 'dd-mm-yyyy') AS tgl_jatuh_tempo,
         TO_CHAR (a.tgl_pengeluaran, 'dd-mm-yyyy') AS tgl_pengeluaran,
         a.is_aktif,
         a.is_api,
         a.id_user_kirim,
         TO_CHAR (a.tgl_upload, 'dd-mm-yyyy') AS tgl_upload,
         TO_CHAR (a.tgl_update, 'dd-mm-yyyy') AS tgl_update,
         a.nama_pemilik
    FROM ssrg_t_resigudang a
         LEFT JOIN ssrg_t_debitur b
            ON (a.nik = b.nik)
         LEFT JOIN ssrg_r_komoditas c
            ON (a.komoditas = c.kode_komoditas)
ORDER BY 1;

SELECT * FROM ssrg_t_status_upload;

  SELECT a.id,
         a.kdbank,
         a.nama_file,
         TO_CHAR (a.tgl_upload, 'yyyy-mm-dd hh24:mi:ss') tgl_upload,
         a.username,
         a.status,
         a.nama_log_file,
         a.tahun,
         b.bulan1 AS nm_bulan
    FROM SSRG_T_STATUS_UPLOAD a LEFT JOIN KUR_R_PERIODE b ON (a.bulan = b.periode)
   WHERE a.nama_file LIKE 'RESI%'
ORDER BY 1 ASC;

SELECT NIK, TGL_LAHIR,
       CASE 
          WHEN SUBSTR (tgl_lahir, 1, 4) BETWEEN '1979' AND '1988' THEN 'GEN Y'
          WHEN SUBSTR (tgl_lahir, 1, 4) BETWEEN '1989' AND '1998' THEN 'GEN Z'
          WHEN SUBSTR (tgl_lahir, 1, 4) > 1998 THEN 'Milenial'
          ELSE 'GEN X'
       END AS KETERANGAN
  FROM (WITH temp_srg_debitur
             AS (SELECT nik,
                        nama,
                        TO_CHAR (tgl_lahir, 'yyyymmdd') AS tgl_lahir,
                        jns_kelamin,
                        maritas_sts,
                        pendidikan,
                        pekerjaan,
                        UPPER (TRIM (alamat)) AS alamat,
                        kode_kabkota,
                        kode_pos,
                        NVL (npwp, '000000000000000') AS npwp,
                        no_hp,
                        TO_CHAR (mulai_usaha, 'yyyymmdd') AS mulai_usaha,
                        alamat_usaha,
                        modal_usaha,
                        jml_pekerja AS jumlah_pekerja,
                        jml_kredit ASjumlah_kredit,
                        ijin_usaha,
                        is_subsidized,
                        subsidi_sebelumnya AS subsidi_sblm,
                        is_linkage,
                        linkage,
                        kode_bank
                   FROM kur_t_debitur
                  WHERE SUBSTR (kode_kabkota, 1, 3) = '320')
        SELECT *
          FROM temp_srg_debitur) --SAMPLE (0.1));
          ; 
SELECT * FROM TAB WHERE tname LIKE 'SSRG_%';

select * from SSRG_R_ERRMSG;

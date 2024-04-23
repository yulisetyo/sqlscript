/* Formatted on 12/13/2023 5:02:31 PM (QP5 v5.215.12089.38647) */
SELECT *
  FROM user_objects
 WHERE LOWER (object_name) LIKE '%debitur%';

SELECT *
  FROM tab
 WHERE LOWER (tname) LIKE 'ssrg_tmp%';

SELECT *
  FROM ssrg_t_debitur
 WHERE kode_bank = '002' AND TO_CHAR (tgl_upload, 'yyyy') = '2023';

SELECT *
  FROM ssrg_t_akad
 WHERE kode_bank = '002' AND TO_CHAR (tgl_upload, 'yyyy') = '2023';

SELECT *
  FROM ssrg_t_resigudang
 WHERE nomor_resi = '12200104230011' and nik = '3513050611810002';
                                  --           '3513050611810003'; 

SELECT a.nik,
       b.nama,
       a.no_resi,
       a.rekening_baru,
       TO_CHAR (a.tgl_jatuh_tempo, 'yyyy-mm-dd') AS tgl_jatuh_tempo,
       b.tgl_tempo,
       a.nilai_akad,
       NVL (b.nilai_komoditas, 0) AS nilai_komoditas,
       (0.7 * b.nilai_komoditas) nilai_70persen_resi,
       ( (0.7 * NVL (b.nilai_komoditas, 0)) - a.nilai_akad),
       CASE
          WHEN a.nilai_akad <= (0.7 * NVL (b.nilai_komoditas, 0)) THEN 'OK'
          WHEN b.nilai_komoditas IS NULL THEN 'Resigudang tidak ditemukan'
          ELSE 'Akad melebihi 70% nilai penjaminan komoditas'
       END
          AS keterangan
  FROM    ssrg_t_akad a
       LEFT JOIN
          (SELECT a.nik,
                  NVL (b.nama, 'NIK tidak ditemukan di tabel debitur') nama,
                  a.nomor_resi,
                  a.nilai_komoditas,
                  TO_CHAR (a.tgl_penjaminan, 'yyyy-mm-dd') tgl_jamin,
                  TO_CHAR (a.tgl_terbit, 'yyyy-mm-dd') tgl_terbit,
                  TO_CHAR (a.tgl_jatuh_tempo, 'yyyy-mm-dd') tgl_tempo
             FROM    ssrg_t_resigudang a
                  LEFT JOIN
                     ssrg_t_debitur b
                  ON (a.nik = b.nik)) b
       ON (a.no_resi = b.nomor_resi)
 WHERE a.kode_bank = '002';

SELECT a.*, 'NO_RESI tidak sesuai referensi' AS keterangan
  FROM ssrg_t_akad a
 WHERE no_resi IN (SELECT nomor_resi FROM ssrg_t_resigudang);

SELECT * FROM ssrg_tmp_debitur
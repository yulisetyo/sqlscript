/* Formatted on 25/10/2023 06:18:18 (QP5 v5.215.12089.38647) */
SELECT *
  FROM tab
 WHERE LOWER (tname) LIKE '%ssrg%';

  SELECT *
    FROM kur_r_menu_2023
   WHERE LOWER (title) LIKE 'subsidi%'
ORDER BY id DESC;

  SELECT *
    FROM kur_r_level
ORDER BY 1;

/* TAGIHAN REKAP */

  SELECT a.*,
         TRIM (UPPER (b.nama_bank)) AS nama_bank,
         c.bulan1 AS periode,
         a.kode_bank || '|' || a.tahun || '|' || a.bulan AS id
    FROM kur_t_tagihan_rekap a
         LEFT JOIN kur_r_bank b
            ON (a.kode_bank = b.kode_bank)
         LEFT JOIN kur_r_periode c
            ON (a.bulan = c.periode)
         LEFT JOIN kur_r_sektor_group d
            ON (a.sektor_negara_tujuan = d.sektor2)
         LEFT JOIN kur_r_negara_tujuan e
            ON (a.sektor_negara_tujuan = e.id_negara)
   WHERE a.tahun = '2023'
ORDER BY id_tagihan_rekap DESC;

/* TAGIHAN DETAIL */

  SELECT a.*, TRIM (UPPER (b.nama_bank)) AS nama_bank, c.bulan1 AS periode
    FROM ssrg_t_tagihan_detail a
         LEFT JOIN kur_r_bank b
            ON (a.kode_bank = b.kode_bank)
         LEFT JOIN kur_r_periode c
            ON (a.bulan = c.periode)
         LEFT JOIN kur_r_sektor_group d
            ON (a.sektor_negara_tujuan = d.sektor2)
         LEFT JOIN kur_r_negara_tujuan e
            ON (a.sektor_negara_tujuan = e.id_negara)
   WHERE a.tahun = '2023'
ORDER BY id_tagihan_detail DESC;

/* data hitung bunga */

SELECT a.kd_bank AS kode_bank,
       TRIM (UPPER (b.nama_bank)) AS nama_bank,
       a.tahun,
       a.bulan,
       d.bulan1 AS periode,
       TO_CHAR (a.tgl_eksekusi, 'dd-mm-yyyy hh24:mi:ss') AS tgl_mulai,
       TO_CHAR (a.tgl_selesai, 'dd-mm-yyyy hh24:mi:ss') AS tgl_selesai,
       a.bunga,
       a.detail,
       a.rekap
  FROM ssrg_t_status_hitung_bunga a
       LEFT JOIN kur_r_bank b
          ON (a.kd_bank = b.kode_bank)
       LEFT JOIN kur_r_periode d
          ON (a.bulan = d.periode)
 WHERE a.tahun = '2023'
--ORDER BY a.tgl_eksekusi DESC;
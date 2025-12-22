/* Formatted on 22/12/2025 11:43:03 (QP5 v5.215.12089.38647) */
  SELECT nik,
         UPPER (nama) AS nama,
         TO_CHAR (tgl_lahir, 'yyyy/mm/dd') AS tgl_lahir,
         kode_kabkota
    FROM kur_t_debitur@sikp_19c
   WHERE kode_bank = '002' AND SUBSTR (kode_kabkota, 1, 4) = '3208' AND (LOWER (nama) LIKE '% pratama' AND LOWER (nama) LIKE '%azril%')
ORDER BY nama;

SELECT *
  FROM kur_t_akad@sikp_19c
 WHERE kode_bank = '002' AND nik = '3208310903020001';

  SELECT *
    FROM kur_t_transaksi@sikp_19c
   WHERE kode_bank = '002' AND nomor_rekening = '428501016563105'
ORDER BY tgl_transaksi;


  SELECT nik,
         UPPER (nama) AS nama,
         TO_CHAR (tgl_lahir, 'yyyy/mm/dd') AS tgl_lahir,
         kode_kabkota,
         no_hp,
         kode_pos,
         alamat
    FROM kur_t_debitur@sikp_19c
   WHERE kode_bank = '002' AND SUBSTR (kode_kabkota, 1, 4) = '3503' AND kode_pos = '66364' AND LOWER (nama) LIKE '%romadon%'
ORDER BY nama;

SELECT *
  FROM kur_t_akad@sikp_19c
 WHERE kode_bank = '002' AND nik = '3503012704890003';

  SELECT *
    FROM kur_t_transaksi@sikp_19c
   WHERE kode_bank = '002' AND nomor_rekening = '655301017577108'
ORDER BY tgl_transaksi;
/* Formatted on 22/12/2025 11:18:57 (QP5 v5.215.12089.38647) */
SELECT a.kode_bank,
       a.nik,
       a.rekening_baru,
       TO_CHAR (a.tgl_akad, 'yyyy/mm/dd') tgl_akad,
       TO_CHAR (a.tgl_jatuh_tempo, 'yyyy/mm/dd') tgl_jatuh_tempo,
       a.nilai_akad
  FROM kur_t_akad a
 WHERE kode_bank = '110';

SELECT d.nik,
       d.nama,
       TO_CHAR (d.tgl_lahir, 'yyyy/mm/dd') tgl_lahir,
       FLOOR (MONTHS_BETWEEN (SYSDATE, d.tgl_lahir) / 12) AS usia
  FROM kur_t_debitur d
 WHERE kode_bank = :pkode_bank;

SELECT nik,
       UPPER (nama) nama,
       TO_CHAR (tgl_lahir, 'yyyy/mm/dd') tgl_lahir,
       FLOOR (MONTHS_BETWEEN (SYSDATE, tgl_lahir) / 12) AS tahun,
       FLOOR (MONTHS_BETWEEN (SYSDATE, tgl_lahir) - FLOOR (MONTHS_BETWEEN (SYSDATE, tgl_lahir) / 12) * 12) AS bulan,
       FLOOR (SYSDATE - ADD_MONTHS (tgl_lahir, FLOOR (MONTHS_BETWEEN (SYSDATE, tgl_lahir)))) AS hari
  FROM kur_t_debitur
 WHERE kode_bank = :pkode_bank;

SELECT a.kode_bank,
       a.nik,
       UPPER (b.nama) AS nama,
       TO_CHAR (a.tgl_akad, 'yyyy/mm/dd') AS tgl_akad,
       TO_CHAR (a.tgl_jatuh_tempo, 'yyyy/mm/dd') AS tgl_jatuh_tempo,
       --a.rekening_baru,
       TO_CHAR (b.tgl_lahir, 'yyyy/mm/dd') AS tgl_lahir,
       -- Menghitung usia dalam tahun, bulan, hari
       FLOOR (MONTHS_BETWEEN (a.tgl_akad, tgl_lahir) / 12) AS us_tahun,
       FLOOR (MONTHS_BETWEEN (a.tgl_akad, b.tgl_lahir) - FLOOR (MONTHS_BETWEEN (a.tgl_akad, b.tgl_lahir) / 12) * 12) AS us_bulan,
       FLOOR (a.tgl_akad - ADD_MONTHS (tgl_lahir, FLOOR (MONTHS_BETWEEN (a.tgl_akad, b.tgl_lahir)))) AS us_hari,
       -- Mengecek apakah usia pada tgl_jatuh_tempo melebihi 59 tahun
       CASE WHEN FLOOR (MONTHS_BETWEEN (a.tgl_jatuh_tempo, b.tgl_lahir) / 12) > 59 THEN 'Tidak bisa mendapatkan kredit' ELSE 'Bisa mendapatkan kredit' END
           AS status_pemberian_kredit,
       -- Mengecek apakah usia pada tgl_akad lebih dari 17 tahun
       CASE
           WHEN FLOOR (MONTHS_BETWEEN (a.tgl_akad, b.tgl_lahir) / 12) < 18 THEN 'Tidak Bisa Mendapatkan Kredit (Usia Kurang dari 18)'
           ELSE 'Bisa Mendapatkan Kredit (Usia Lebih dari 17)'
       END
           AS status_usia_akad_kredit
  FROM     (SELECT kode_bank,
                   nik,
                   tgl_akad,
                   tgl_jatuh_tempo
              FROM kur_t_akad
             WHERE kode_bank = :pkode_bank) a
       JOIN
           (SELECT nik, nama, tgl_lahir
              FROM kur_t_debitur
             WHERE kode_bank = :pkode_bank) b
       ON (a.nik = b.nik)
 -- Usia saat akad kredit tidak boleh lebih dari 56 tahun
 WHERE a.kode_bank = :pkode_bank AND FLOOR (MONTHS_BETWEEN (a.tgl_akad, b.tgl_lahir) / 12) <= 56 AND a.tgl_akad <= a.tgl_jatuh_tempo;
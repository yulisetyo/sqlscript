/* Formatted on 05/11/2025 11:02:09 (QP5 v5.215.12089.38647) */
SELECT a.kode_bank,
       a.rekening_baru,
       b.nomor_rekening,
       a.nilai_akad,
       b.nilai_limit,
       (b.nilai_limit - a.nilai_akad) AS nilai_selisih,
       b.outstanding
  FROM     (SELECT kode_bank,
                   skema,
                   rekening_baru,
                   nilai_akad
              FROM kur_t_akad) a
       LEFT JOIN
           (  SELECT kode_bank,
                     nomor_rekening,
                     MAX (LIMIT) AS nilai_limit,
                     MIN (outstanding) AS outstanding
                FROM kur_t_transaksi
            GROUP BY kode_bank, nomor_rekening) b
       ON (a.kode_bank = b.kode_bank AND a.rekening_baru = b.nomor_rekening)
 WHERE a.nilai_akad <> b.nilai_limit;
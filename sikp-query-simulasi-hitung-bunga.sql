/* Formatted on 19/12/2024 15:13:22 (QP5 v5.391) */
  SELECT c.*, (next_transaksi - tgl_transaksi) hari_bunga
    FROM (SELECT a.*, NVL (b.tgl_transaksi, a.tgl_transaksi) AS next_transaksi
            FROM (  SELECT kode_bank,
                           nomor_rekening,
                           tgl_transaksi,
                           angsuran_pokok,
                           outstanding,
                           ROW_NUMBER () OVER (PARTITION BY nomor_rekening ORDER BY outstanding DESC) AS seq
                      FROM kur_t_transaksi
                     WHERE nomor_rekening = '000901502774157'
                  ORDER BY outstanding DESC) a
                 LEFT JOIN (  SELECT kode_bank,
                                     nomor_rekening,
                                     tgl_transaksi,
                                     angsuran_pokok,
                                     outstanding,
                                     ROW_NUMBER () OVER (PARTITION BY nomor_rekening ORDER BY outstanding DESC) AS seq
                                FROM kur_t_transaksi
                               WHERE nomor_rekening = '000901502774157' AND angsuran_pokok <> 0
                            ORDER BY outstanding DESC) b
                     ON (a.nomor_rekening = b.nomor_rekening AND a.seq = b.seq)) c
ORDER BY tgl_transaksi;

  SELECT c.*, (next_transaksi - tgl_transaksi) hari_bunga, ROUND ((((next_transaksi - tgl_transaksi) / 360) * 0.03 * outstanding), 0) AS subsidi_bunga
    FROM (SELECT a.*, NVL (b.tgl_transaksi, c.tgl_jatuh_tempo) AS next_transaksi
            FROM (  SELECT kode_bank,
                           nomor_rekening,
                           tgl_transaksi,
                           angsuran_pokok,
                           outstanding,
                           ROW_NUMBER () OVER (PARTITION BY nomor_rekening ORDER BY outstanding DESC) AS seq
                      FROM kur_t_transaksi
                     WHERE nomor_rekening = '000901502774157'
                  ORDER BY outstanding DESC) a
                 LEFT JOIN (  SELECT kode_bank,
                                     nomor_rekening,
                                     tgl_transaksi,
                                     angsuran_pokok,
                                     outstanding,
                                     ROW_NUMBER () OVER (PARTITION BY nomor_rekening ORDER BY outstanding DESC) AS seq
                                FROM kur_t_transaksi
                               WHERE nomor_rekening = '000901502774157' AND angsuran_pokok <> 0
                            ORDER BY outstanding DESC) b
                     ON (a.nomor_rekening = b.nomor_rekening AND a.seq = b.seq)
                 LEFT JOIN (SELECT kode_bank, rekening_baru AS nomor_rekening, tgl_jatuh_tempo
                              FROM kur_t_akad
                             WHERE kode_bank = '002' AND rekening_baru = '000901502774157') c
                     ON (a.kode_bank = c.kode_bank AND a.nomor_rekening = c.nomor_rekening)) c
ORDER BY tgl_transaksi;

SELECT kode_bank, rekening_baru AS nomor_rekening, tgl_jatuh_tempo
  FROM kur_t_akad
 WHERE kode_bank = '002' AND rekening_baru = '000901502774157';

SELECT *
  FROM tab
 WHERE LOWER (tname) LIKE '%reko%';

  SELECT *
    FROM kur_t_tagihan_detail_rekon
   WHERE tahun = '2022' AND kode_bank = '008' AND rekening_baru = '1150011444306'
ORDER BY rekening_baru;

SELECT a.*, (next_trans - tgl_transaksi) jml_hari
  FROM (SELECT a.kode_bank,
               nomor_rekening,
               tgl_transaksi,
               ADD_MONTHS (a.tgl_transaksi, 1) next_trans,
               outstanding,
               angsuran_pokok
          FROM kur_t_transaksi a
         WHERE nomor_rekening = '1150011444306') a;



  SELECT t.*, (t.next_transaksi - t.tgl_transaksi) AS hari_bunga, ROUND ((((t.next_transaksi - t.tgl_transaksi) / 360) * 0.03 * outstanding), 0) AS subsidi_bunga
    FROM (SELECT a.*, NVL (b.tgl_transaksi, a.ld_transaksi) AS next_transaksi
            FROM (  SELECT kode_bank,
                           nomor_rekening,
                           TRUNC (tgl_transaksi, 'MM') AS fd_transaksi,
                           tgl_transaksi,
                           LAST_DAY (tgl_transaksi) AS ld_transaksi,
                           angsuran_pokok,
                           outstanding,
                           ROW_NUMBER () OVER (PARTITION BY nomor_rekening ORDER BY outstanding DESC) AS seq
                      FROM kur_t_transaksi
                     WHERE nomor_rekening = '000901502774157'
                  ORDER BY outstanding DESC) a
                 LEFT JOIN (  SELECT kode_bank,
                                     nomor_rekening,
                                     TRUNC (tgl_transaksi, 'MM') AS fd_transaksi,
                                     tgl_transaksi,
                                     LAST_DAY (tgl_transaksi) AS ld_transaksi,
                                     angsuran_pokok,
                                     outstanding,
                                     ROW_NUMBER () OVER (PARTITION BY nomor_rekening ORDER BY outstanding DESC) AS seq
                                FROM kur_t_transaksi
                               WHERE nomor_rekening = '000901502774157' AND angsuran_pokok <> 0
                            ORDER BY outstanding DESC) b
                     ON (a.nomor_rekening = b.nomor_rekening AND a.seq = b.seq)
                 LEFT JOIN (SELECT kode_bank, rekening_baru AS nomor_rekening, tgl_jatuh_tempo
                              FROM kur_t_akad
                             WHERE kode_bank = '002' AND rekening_baru = '000901502774157') c
                     ON (a.kode_bank = c.kode_bank AND a.nomor_rekening = c.nomor_rekening)) t
ORDER BY tgl_transaksi;


SELECT ADD_MONTHS (SYSDATE, -1) prev_date,
       LAST_DAY (ADD_MONTHS (SYSDATE, -1)) last_day_of_prev_date,
       SYSDATE,
       ADD_MONTHS (SYSDATE, 1) next_date,
       TRUNC (SYSDATE, 'MM') AS first_day
  FROM DUAL
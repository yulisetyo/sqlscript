/* Formatted on 17/01/2025 14:38:15 (QP5 v5.215.12089.38647) */
  SELECT nomor_rekening,
         nilai_pinjaman,
         outstanding,
         angsuran_pokok,
         hari_bunga,
         urutan
    FROM (SELECT a.*,
                 NVL (b.next_tgl_transaksi, a.akhir_bulan) AS next_tgl_transaksi,
                 c.tgl_jatuh_tempo,
                 TRUNC (a.tgl_transaksi, 'MM') AS awal_bulan,
                 (NVL (b.next_tgl_transaksi, a.akhir_bulan) - a.tgl_transaksi) AS hari_bunga
            FROM (SELECT kode_bank,
                         nomor_rekening,
                         LIMIT AS nilai_pinjaman,
                         outstanding,
                         angsuran_pokok,
                         tgl_transaksi,
                         LAST_DAY (tgl_transaksi) AS akhir_bulan,
                         id_transaksi,
                         ROW_NUMBER () OVER (PARTITION BY nomor_rekening ORDER BY tgl_transaksi ASC) AS urutan
                    FROM kur_t_transaksi
                   WHERE nomor_rekening = '000901502774157') a
                 LEFT JOIN (SELECT kode_bank,
                                   nomor_rekening,
                                   LIMIT AS nilai_pinjaman,
                                   outstanding,
                                   angsuran_pokok,
                                   tgl_transaksi AS next_tgl_transaksi,
                                   LAST_DAY (tgl_transaksi) AS akhir_bulan,
                                   id_transaksi,
                                   ROW_NUMBER () OVER (PARTITION BY nomor_rekening ORDER BY tgl_transaksi ASC) AS urutan
                              FROM kur_t_transaksi
                             WHERE nomor_rekening = '000901502774157' AND angsuran_pokok > 0) b
                     ON (a.kode_bank = b.kode_bank AND a.nomor_rekening = b.nomor_rekening AND a.urutan = b.urutan)
                 LEFT JOIN (SELECT kode_bank, rekening_baru AS nomor_rekening, tgl_jatuh_tempo
                              FROM kur_t_akad
                             WHERE kode_bank = '002' AND rekening_baru = '000901502774157') c
                     ON (a.kode_bank = c.kode_bank AND a.nomor_rekening = c.nomor_rekening))
ORDER BY urutan ASC;



  SELECT nomor_rekening,
         --nilai_pinjaman,
         outstanding,
         angsuran_pokok,
         --tgl_transaksi,
         --next_tgl_transaksi,
         hari_bunga,
         --urutan,
         ROUND ( (hari_bunga / 360) * outstanding * 0.06) AS subsidi_bunga
    FROM (SELECT a.*,
                 NVL (b.next_tgl_transaksi, a.akhir_bulan) AS next_tgl_transaksi,
                 c.tgl_jatuh_tempo,
                 TRUNC (a.tgl_transaksi, 'MM') AS awal_bulan,
                 (NVL (b.next_tgl_transaksi, a.akhir_bulan) - a.tgl_transaksi) AS hari_bunga
            FROM (SELECT kode_bank,
                         nomor_rekening,
                         LIMIT AS nilai_pinjaman,
                         outstanding,
                         angsuran_pokok,
                         tgl_transaksi,
                         LAST_DAY (tgl_transaksi) AS akhir_bulan,
                         id_transaksi,
                         ROW_NUMBER () OVER (PARTITION BY nomor_rekening ORDER BY tgl_transaksi ASC) AS urutan
                    FROM kur_t_transaksi
                   WHERE kode_bank = '002' AND nomor_rekening = '000901502774157') a
                 LEFT JOIN (SELECT kode_bank,
                                   nomor_rekening,
                                   LIMIT AS nilai_pinjaman,
                                   outstanding,
                                   angsuran_pokok,
                                   tgl_transaksi AS next_tgl_transaksi,
                                   LAST_DAY (tgl_transaksi) AS akhir_bulan,
                                   id_transaksi,
                                   ROW_NUMBER () OVER (PARTITION BY nomor_rekening ORDER BY tgl_transaksi ASC) AS urutan
                              FROM kur_t_transaksi
                             WHERE kode_bank = '002' AND nomor_rekening = '000901502774157' AND angsuran_pokok > 0) b
                     ON (a.kode_bank = b.kode_bank AND a.nomor_rekening = b.nomor_rekening AND a.urutan = b.urutan)
                 LEFT JOIN (SELECT kode_bank, rekening_baru AS nomor_rekening, tgl_jatuh_tempo
                              FROM kur_t_akad
                             WHERE kode_bank = '002' AND rekening_baru = '000901502774157') c
                     ON (a.kode_bank = c.kode_bank AND a.nomor_rekening = c.nomor_rekening))
ORDER BY nomor_rekening ASC, urutan ASC;
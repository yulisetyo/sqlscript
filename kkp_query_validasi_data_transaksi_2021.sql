/* Formatted on 26/03/2022 13:09:30 (QP5 v5.215.12089.38647) */
  SELECT kdsatker,
         kdbank,
         tahun,
         bulan,
         jns_byr,
         nilai_tag,
         LISTAGG (keterangan, ', ')
            WITHIN GROUP (ORDER BY
                             kdsatker,
                             kdbank,
                             tahun,
                             bulan,
                             jns_byr)
            AS keterangan
    FROM (SELECT kdsatker,
                 kdbank,
                 tahun,
                 bulan,
                 jns_byr,
                 nilai_tag,
                 'KDSATKER kurang dari 6 digit' AS keterangan
            FROM kkp_t_trans
           WHERE tahun = '2021' AND LENGTH (TRIM (kdsatker)) < 6
          UNION
          SELECT kdsatker,
                 kdbank,
                 tahun,
                 bulan,
                 jns_byr,
                 nilai_tag,
                 'KDSATKER tidak ada di referensi' AS keterangan
            FROM kkp_t_trans
           WHERE     tahun = '2021'
                 AND kdsatker NOT IN (SELECT kdsatker FROM t_satker)
          UNION
          SELECT kdsatker,
                 kdbank,
                 tahun,
                 bulan,
                 jns_byr,
                 nilai_tag,
                 'KDBANK kurang dari 3 digit' AS keterangan
            FROM kkp_t_trans
           WHERE tahun = '2021' AND LENGTH (TRIM (kdbank)) < 3
          UNION
          SELECT kdsatker,
                 kdbank,
                 tahun,
                 bulan,
                 jns_byr,
                 nilai_tag,
                 'KDBANK tidak ada di referensi' AS keterangan
            FROM kkp_t_trans
           WHERE     tahun = '2021'
                 AND kdbank NOT IN (SELECT kdbank FROM dgp_r_bank)
          UNION
          SELECT kdsatker,
                 kdbank,
                 tahun,
                 bulan,
                 jns_byr,
                 nilai_tag,
                 'JNS_BYR kurang dari 2 digit' AS keterangan
            FROM kkp_t_trans
           WHERE tahun = '2021' AND LENGTH (TRIM (jns_byr)) < 2
          UNION
          SELECT kdsatker,
                 kdbank,
                 tahun,
                 bulan,
                 jns_byr,
                 nilai_tag,
                 'JNS_BYR tidak ada di referensi' AS keterangan
            FROM kkp_t_trans
           WHERE     tahun = '2021'
                 AND jns_byr NOT IN
                        (SELECT id_transaksi FROM kkp_r_jns_transaksi)
          UNION
          SELECT kdsatker,
                 kdbank,
                 tahun,
                 bulan,
                 jns_byr,
                 nilai_tag,
                 'NILAI_TAG minus' AS keterangan
            FROM kkp_t_trans
           WHERE tahun = '2021' AND nilai_tag < 0)
GROUP BY kdsatker,
         kdbank,
         tahun,
         bulan,
         jns_byr,
         nilai_tag
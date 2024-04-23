/*****************/
          SELECT t1.kdsatker,
                 t1.kdbank,
                 t1.tahun,
                 t1.jml_satker,
                 t2.jterbit,
                 t2.jaktif,
                 t3.jns_byr,
                 NVL (t3.nilai_tag, 0) AS nilai_tag
            FROM (  SELECT a.kdsatker,
                           a.kdbank,
                           a.tahun,
                           COUNT (DISTINCT (a.kdsatker)) jml_satker
                      FROM (  SELECT a.kdsatker,
                                     a.kdbank,
                                     a.tahun,
                                     MAX (a.bulan) AS maxbulan
                                FROM kkp_t_kartu a LEFT JOIN t_satker b ON (a.kdsatker = b.kdsatker)
                               WHERE     a.tahun = '2022'
                                     AND b.kdsatker IS NOT NULL
                                     AND a.kdsatker IN (SELECT kdsatker FROM t_satker)
                                     AND LENGTH (TRIM (a.kdsatker)) = 6
                                     AND LENGTH (TRIM (a.kdbank)) = 3
                            GROUP BY b.kddept,
                                     a.kdsatker,
                                     a.kdbank,
                                     a.tahun) a
                  GROUP BY a.kdsatker, a.kdbank, a.tahun) t1
                 LEFT JOIN (  SELECT a.kdsatker,
                                     a.kdbank,
                                     a.tahun,
                                     SUM (b.kartu_terbit) AS jterbit,
                                     SUM (b.kartu_aktif) AS jaktif
                                FROM    (  SELECT a.kdsatker,
                                                  a.kdbank,
                                                  a.tahun,
                                                  MAX (a.bulan) AS maxbulan
                                             FROM kkp_t_kartu a LEFT JOIN t_satker b ON (a.kdsatker = b.kdsatker)
                                            WHERE     a.tahun = '2022'
                                                  AND b.kdsatker IS NOT NULL
                                                  AND a.kdsatker IN (SELECT kdsatker FROM t_satker)
                                                  AND LENGTH (TRIM (a.kdsatker)) = 6
                                                  AND LENGTH (TRIM (a.kdbank)) = 3
                                         GROUP BY b.kddept,
                                                  a.kdsatker,
                                                  a.kdbank,
                                                  a.tahun) a
                                     LEFT JOIN
                                        kkp_t_kartu b
                                     ON (a.kdsatker || a.kdbank || a.tahun || a.maxbulan = b.kdsatker || b.kdbank || b.tahun || b.bulan)
                            GROUP BY a.kdsatker, a.kdbank, a.tahun) t2
                    ON (t1.kdbank = t2.kdbank AND t1.tahun = t2.tahun AND t1.kdsatker = t2.kdsatker)
                 LEFT JOIN (  SELECT kdsatker,
                                     kdbank,
                                     tahun,
                                     jns_byr,
                                     SUM (nilai_tag) nilai_tag
                                FROM kkp_t_trans
                               WHERE     tahun = '2022'
                                     AND LENGTH (TRIM (kdsatker)) = 6
                                     AND LENGTH (TRIM (kdbank)) = 3
                                     AND LENGTH (TRIM (jns_byr)) = 2
                                     AND nilai_tag > 0
                                     AND kdsatker IN (SELECT kdsatker FROM t_satker)
                                     AND jns_byr IN (SELECT id_transaksi FROM kkp_r_jns_transaksi)
                            GROUP BY kdsatker,
                                     kdbank,
                                     tahun,
                                     jns_byr) t3
                    ON (t1.kdbank = t3.kdbank AND t1.tahun = t3.tahun AND t1.kdsatker = t3.kdsatker)/*****************/
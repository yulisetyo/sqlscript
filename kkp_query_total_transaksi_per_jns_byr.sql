/* Formatted on 29/03/2022 22:20:48 (QP5 v5.215.12089.38647) */
              SELECT a.jns_byr,
                     b.nm_transaksi AS nm_jns_byr,
                     NVL (SUM (DECODE (a.tahun, '2019', a.nilai_tag, 0)), 0) AS tr1,
                     NVL (SUM (DECODE (a.tahun, '2020', a.nilai_tag, 0)), 0) AS tr2,
                     NVL (SUM (DECODE (a.tahun, '2021', a.nilai_tag, 0)), 0) AS tr3,
                     NVL (SUM (DECODE (a.tahun, '2022', a.nilai_tag, 0)), 0) AS tr4,
                     NVL (SUM (CASE WHEN a.tahun IN ('2019', '2020', '2021', '2022') THEN a.nilai_tag ELSE 0 END), 0) AS total
                FROM    (  SELECT tahun,
                                  jns_byr,
                                  SUM (jml_satker) jml_satker,
                                  SUM (jterbit) jterbit,
                                  SUM (jaktif) jaktif,
                                  SUM (nilai_tag) nilai_tag
                             FROM (SELECT t1.kdsatker,
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
                                                        WHERE     a.tahun <= '2022'
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
                                                                     WHERE     a.tahun <= '2022'
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
                                                        WHERE     tahun <= '2022'
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
                                             ON (t1.kdbank = t3.kdbank AND t1.tahun = t3.tahun AND t1.kdsatker = t3.kdsatker))
                         GROUP BY tahun, jns_byr) a
                     LEFT JOIN
                        kkp_r_jns_transaksi b
                     ON (a.jns_byr = b.id_transaksi)
            GROUP BY a.jns_byr, nm_transaksi
              HAVING jns_byr IS NOT NULL
            UNION
            SELECT NULL AS jns_byr,
                   'TOTAL' AS nm_jns_byr,
                   SUM (tr1) AS tr1,
                   SUM (tr2) AS tr2,
                   SUM (tr3) AS tr3,
                   SUM (tr4) AS tr4,
                   SUM (total) AS total
              FROM (  SELECT a.jns_byr,
                             b.nm_transaksi AS nm_jns_byr,
                             NVL (SUM (DECODE (a.tahun, '2019', a.nilai_tag, 0)), 0) AS tr1,
                             NVL (SUM (DECODE (a.tahun, '2020', a.nilai_tag, 0)), 0) AS tr2,
                             NVL (SUM (DECODE (a.tahun, '2021', a.nilai_tag, 0)), 0) AS tr3,
                             NVL (SUM (DECODE (a.tahun, '2022', a.nilai_tag, 0)), 0) AS tr4,
                             NVL (SUM (CASE WHEN a.tahun IN ('2019', '2020', '2021', '2022') THEN a.nilai_tag ELSE 0 END), 0) AS total
                        FROM    (  SELECT tahun,
                                          jns_byr,
                                          SUM (jml_satker) jml_satker,
                                          SUM (jterbit) jterbit,
                                          SUM (jaktif) jaktif,
                                          SUM (nilai_tag) nilai_tag
                                     FROM (SELECT t1.kdsatker,
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
                                                                WHERE     a.tahun <= '2022'
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
                                                                             WHERE     a.tahun <= '2022'
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
                                                                WHERE     tahun <= '2022'
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
                                                     ON (t1.kdbank = t3.kdbank AND t1.tahun = t3.tahun AND t1.kdsatker = t3.kdsatker))
                                 GROUP BY tahun, jns_byr) a
                             LEFT JOIN
                                kkp_r_jns_transaksi b
                             ON (a.jns_byr = b.id_transaksi)
                    GROUP BY a.jns_byr, nm_transaksi
                      HAVING jns_byr IS NOT NULL)
            ORDER BY jns_byr ASC
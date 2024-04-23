/* Formatted on 24/03/2022 16:54:27 (QP5 v5.215.12089.38647) */
  SELECT kdsatker,
         kdbank,
--         COUNT (kdsatker) jsatker,
         SUM (jterbit) jterbit,
         SUM (jaktif) jaktif,
         SUM (CASE WHEN maxbulan = '01' THEN jterbit ELSE 0 END) jt01,
         SUM (CASE WHEN maxbulan = '01' THEN jaktif ELSE 0 END) ja01,
         SUM (CASE WHEN maxbulan = '02' THEN jterbit ELSE 0 END) jt02,
         SUM (CASE WHEN maxbulan = '02' THEN jaktif ELSE 0 END) ja02,
         SUM (CASE WHEN maxbulan = '03' THEN jterbit ELSE 0 END) jt03,
         SUM (CASE WHEN maxbulan = '03' THEN jaktif ELSE 0 END) ja03,
         SUM (CASE WHEN maxbulan = '04' THEN jterbit ELSE 0 END) jt04,
         SUM (CASE WHEN maxbulan = '04' THEN jaktif ELSE 0 END) ja04,
         SUM (CASE WHEN maxbulan = '05' THEN jterbit ELSE 0 END) jt05,
         SUM (CASE WHEN maxbulan = '05' THEN jaktif ELSE 0 END) ja05,
         SUM (CASE WHEN maxbulan = '06' THEN jterbit ELSE 0 END) jt06,
         SUM (CASE WHEN maxbulan = '06' THEN jaktif ELSE 0 END) ja06,
         SUM (CASE WHEN maxbulan = '07' THEN jterbit ELSE 0 END) jt07,
         SUM (CASE WHEN maxbulan = '07' THEN jaktif ELSE 0 END) ja07,
         SUM (CASE WHEN maxbulan = '08' THEN jterbit ELSE 0 END) jt08,
         SUM (CASE WHEN maxbulan = '08' THEN jaktif ELSE 0 END) ja08,
         SUM (CASE WHEN maxbulan = '09' THEN jterbit ELSE 0 END) jt09,
         SUM (CASE WHEN maxbulan = '09' THEN jaktif ELSE 0 END) ja09,
         SUM (CASE WHEN maxbulan = '10' THEN jterbit ELSE 0 END) jt10,
         SUM (CASE WHEN maxbulan = '10' THEN jaktif ELSE 0 END) ja10,
         SUM (CASE WHEN maxbulan = '11' THEN jterbit ELSE 0 END) jt11,
         SUM (CASE WHEN maxbulan = '11' THEN jaktif ELSE 0 END) ja11,
         SUM (CASE WHEN maxbulan = '12' THEN jterbit ELSE 0 END) jt12,
         SUM (CASE WHEN maxbulan = '12' THEN jaktif ELSE 0 END) ja12,
         
         SUM (CASE WHEN maxbulan = '01' THEN nilai_tag ELSE 0 END) tr01,
         SUM (CASE WHEN maxbulan = '02' THEN nilai_tag ELSE 0 END) tr02,
         SUM (CASE WHEN maxbulan = '03' THEN nilai_tag ELSE 0 END) tr03,
         SUM (CASE WHEN maxbulan = '04' THEN nilai_tag ELSE 0 END) tr04,
         SUM (CASE WHEN maxbulan = '05' THEN nilai_tag ELSE 0 END) tr05,
         SUM (CASE WHEN maxbulan = '06' THEN nilai_tag ELSE 0 END) tr06,
         SUM (CASE WHEN maxbulan = '07' THEN nilai_tag ELSE 0 END) tr07,
         SUM (CASE WHEN maxbulan = '08' THEN nilai_tag ELSE 0 END) tr08,
         SUM (CASE WHEN maxbulan = '09' THEN nilai_tag ELSE 0 END) tr09,
         SUM (CASE WHEN maxbulan = '10' THEN nilai_tag ELSE 0 END) tr10,
         SUM (CASE WHEN maxbulan = '11' THEN nilai_tag ELSE 0 END) tr11,
         SUM (CASE WHEN maxbulan = '12' THEN nilai_tag ELSE 0 END) tr12,
         SUM (
            CASE
               WHEN maxbulan IN
                       ('01',
                        '02',
                        '03',
                        '04',
                        '05',
                        '06',
                        '07',
                        '08',
                        '09',
                        '10',
                        '11',
                        '12')
               THEN
                  nilai_tag
               ELSE
                  0
            END)
            trxx,
         SUM (nilai_tag) nilai_trans
    FROM (                                                               /***/
                                                                         /***/
         SELECT a.kddept,
                a.kdsatker,
                a.kdbank,
                a.tahun,
                a.maxbulan,
                a.jns_byr,
                a.nilai_tag,
                b.jterbit,
                b.jaktif
           FROM    (SELECT a.kdsatker,
                           a.kdbank,
                           a.tahun,
                           a.maxbulan,
                           b.jns_byr,
                           b.nilai_tag,
                           c.kddept
                      FROM (  SELECT kdsatker,
                                     kdbank,
                                     tahun,
                                     MAX (bulan) maxbulan
                                FROM kkp_t_trans
                               WHERE     tahun = '2021'
                                     AND nilai_tag > 0
                                     AND LENGTH (TRIM (kdsatker)) = 6
                                     AND LENGTH (TRIM (kdbank)) = 3
                                     AND LENGTH (TRIM (jns_byr)) = 2
                                     AND kdsatker IN
                                            (SELECT kdsatker FROM t_satker)
                                     AND jns_byr IN
                                            (SELECT id_transaksi
                                               FROM kkp_r_jns_transaksi)
                            GROUP BY kdsatker, kdbank, tahun) a
                           LEFT JOIN kkp_t_trans b
                              ON (   a.kdsatker
                                  || a.kdbank
                                  || a.tahun
                                  || a.maxbulan =
                                        b.kdsatker
                                     || b.kdbank
                                     || b.tahun
                                     || b.bulan)
                           LEFT JOIN t_satker c
                              ON (a.kdsatker = c.kdsatker)) a
                /***/
                /***/
                JOIN                                                     /***/
                                                                         /***/
                   (                                                     /***/
                    /***/
                    SELECT a.kdsatker,
                           a.kdbank,
                           a.tahun,
                           a.maxbulan,
                           b.kartu_terbit AS jterbit,
                           b.kartu_aktif AS jaktif,
                           c.kddept
                      FROM (  SELECT kdsatker,
                                     kdbank,
                                     tahun,
                                     MAX (bulan) maxbulan
                                FROM kkp_t_kartu
                               WHERE     tahun = '2021'
                                     AND LENGTH (TRIM (kdsatker)) = 6
                                     AND LENGTH (TRIM (kdbank)) = 3
                                     AND kdsatker IN
                                            (SELECT kdsatker FROM t_satker)
                            GROUP BY kdsatker, kdbank, tahun) a
                           LEFT JOIN kkp_t_kartu b
                              ON (   a.kdsatker
                                  || a.kdbank
                                  || a.tahun
                                  || a.maxbulan =
                                        b.kdsatker
                                     || b.kdbank
                                     || b.tahun
                                     || b.bulan)
                           LEFT JOIN t_satker c
                              ON (a.kdsatker = c.kdsatker)) b            /***/
                                                                         /***/
                ON (a.kddept || a.kdsatker || a.kdbank || a.tahun || a.maxbulan =
                          b.kddept
                       || b.kdsatker
                       || b.kdbank
                       || b.tahun
                       || b.maxbulan))
GROUP BY kdsatker, kdbank
ORDER BY 1, 2
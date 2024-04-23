/* Formatted on 06/10/2021 13:39:02 (QP5 v5.215.12089.38647) */
SELECT a.*, b.*
  FROM    (SELECT a.kdsatker,
                  a.kdbank,
                  a.tahun,
                  a.maxbulan,
                  b.kartu_terbit,
                  b.kartu_aktif
             FROM    (  SELECT kdsatker,
                               kdbank,
                               tahun,
                               MAX (bulan) maxbulan
                          FROM kkp_t_kartu
                         WHERE     LENGTH (TRIM (kdsatker)) = 6
                               AND tahun = '2020'
                               AND kdsatker IN
                                      (SELECT kdsatker
                                         FROM t_satker
                                        WHERE kddept || kdunit = '01508')
                      GROUP BY kdsatker, kdbank, tahun) a
                  LEFT JOIN
                     kkp_t_kartu b
                  ON (a.kdsatker || a.kdbank || a.tahun || a.maxbulan =
                         b.kdsatker || b.kdbank || b.tahun || b.bulan)) a
       JOIN
          (  SELECT c.kdkanwil,
                    b.kdsatker,
                    b.nmsatker,
                    SUM (CASE WHEN tahun = '2017' THEN nilai_tag ELSE 0 END)
                       tr1,
                    SUM (CASE WHEN tahun = '2018' THEN nilai_tag ELSE 0 END)
                       tr2,
                    SUM (CASE WHEN tahun = '2019' THEN nilai_tag ELSE 0 END)
                       tr3,
                    SUM (CASE WHEN tahun = '20120' THEN nilai_tag ELSE 0 END)
                       tr4,
                    SUM (
                       CASE
                          WHEN tahun IN ('2017', '2018', '2019', '2020')
                          THEN
                             nilai_tag
                          ELSE
                             0
                       END)
                       total
               FROM kkp_t_trans a
                    LEFT JOIN t_satker b
                       ON (a.kdsatker = b.kdsatker)
                    LEFT JOIN t_kppn c
                       ON (b.kdkppn = c.kdkppn)
                    LEFT JOIN t_kanwil d
                       ON (c.kdkanwil = d.kdkanwil)
              WHERE b.kddept || b.kdunit = '01508'
           GROUP BY c.kdkanwil, b.kdsatker, b.nmsatker) b
       ON (a.kdsatker = b.kdsatker)
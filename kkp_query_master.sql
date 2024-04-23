/* Formatted on 29/03/2022 09:40:44 (QP5 v5.215.12089.38647) */
  SELECT kdbank, ROUND ( (SUM (nilai_tag) / 1000000000), 2) AS totrans
    FROM kkp_t_trans
   WHERE     kdbank IN ('002', '008', '009')
         AND tahun = '2021'
         AND nilai_tag > 0
         AND LENGTH (TRIM (kdsatker)) = 6
         AND LENGTH (TRIM (kdbank)) = 3
         AND LENGTH (TRIM (jns_byr)) = 2
         AND kdsatker IN (SELECT kdsatker FROM t_satker)
         AND jns_byr IN (SELECT id_transaksi FROM kkp_r_jns_transaksi)
GROUP BY ROLLUP (kdbank);


SELECT *
  FROM kkp_t_trans
 WHERE jns_byr NOT IN (SELECT id_transaksi FROM kkp_r_jns_transaksi);

/*####################################*/

  SELECT a.kddept, a.nmdept, b.id_transaksi AS jns_byr
    FROM t_dept a, kkp_r_jns_transaksi b
ORDER BY 1, 3;

/*####################################*/

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
                 AND kdbank IN (SELECT kdbank FROM dgp_r_bank)
                 AND kdsatker IN (SELECT kdsatker FROM t_satker)
        GROUP BY kdsatker, kdbank, tahun) a
       LEFT JOIN kkp_t_kartu b
          ON (a.kdsatker || a.kdbank || a.tahun || a.maxbulan =
                 b.kdsatker || b.kdbank || b.tahun || b.bulan)
       LEFT JOIN t_satker c
          ON (a.kdsatker = c.kdsatker);

/*####################################*/

SELECT c.kddept,
       a.kdsatker,
       a.kdbank,
       a.tahun,
       a.bulan,
       b.jns_byr,
       b.nilai_tag
  FROM (SELECT b.kddept,
               b.kdunit,
               a.kdsatker,
               a.kdbank,
               a.tahun,
               a.bulan,
               a.jns_byr,
               a.nilai_tag
          FROM    kkp_t_trans a
               LEFT JOIN
                  t_satker b
               ON (a.kdsatker = b.kdsatker)
         WHERE     b.kdsatker IS NOT NULL
               AND LENGTH (TRIM (a.kdsatker)) = 6
               AND a.kdsatker IN (SELECT kdsatker FROM t_satker)
               AND LENGTH (TRIM (a.kdbank)) = 3
               AND a.kdbank IN (SELECT kdbank FROM dgp_r_bank)
               AND LENGTH (TRIM (a.jns_byr)) = 2
               AND a.jns_byr IN
                      (SELECT id_transaksi FROM kkp_r_jns_transaksi)
               AND a.nilai_tag > 0) a
       LEFT JOIN kkp_t_trans b
          ON (a.kdsatker || a.kdbank || a.tahun || a.bulan =
                 b.kdsatker || b.kdbank || b.tahun || b.bulan)
       LEFT JOIN t_satker c
          ON (a.kdsatker = c.kdsatker);

          /*####################################*/
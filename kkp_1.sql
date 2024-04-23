/* Formatted on 23/03/2022 23:51:50 (QP5 v5.215.12089.38647) */
SELECT *
  FROM kkp_t_trans
 WHERE tahun = '2021';

SELECT * FROM kkp_r_jns_transaksi;

  SELECT kdbank,
         jns_byr,
         SUM (CASE WHEN bulan = '01' THEN nilai_tag ELSE 0 END) AS r01,
         SUM (CASE WHEN bulan = '02' THEN nilai_tag ELSE 0 END) AS r02,
         SUM (CASE WHEN bulan = '03' THEN nilai_tag ELSE 0 END) AS r03,
         SUM (CASE WHEN bulan = '04' THEN nilai_tag ELSE 0 END) AS r04,
         SUM (CASE WHEN bulan = '05' THEN nilai_tag ELSE 0 END) AS r05,
         SUM (CASE WHEN bulan = '06' THEN nilai_tag ELSE 0 END) AS r06,
         SUM (CASE WHEN bulan = '07' THEN nilai_tag ELSE 0 END) AS r07,
         SUM (CASE WHEN bulan = '08' THEN nilai_tag ELSE 0 END) AS r08,
         SUM (CASE WHEN bulan = '09' THEN nilai_tag ELSE 0 END) AS r09,
         SUM (CASE WHEN bulan = '10' THEN nilai_tag ELSE 0 END) AS r10,
         SUM (CASE WHEN bulan = '11' THEN nilai_tag ELSE 0 END) AS r11,
         SUM (CASE WHEN bulan = '12' THEN nilai_tag ELSE 0 END) AS r12,
         ROUND(SUM (CASE WHEN tahun = '2021' THEN nilai_tag ELSE 0 END),0) AS rtotal
    FROM kkp_t_trans
   WHERE     tahun = '2021'
         AND nilai_tag > 0
         AND LENGTH (TRIM (kdsatker)) = 6
         AND LENGTH (TRIM (kdbank)) = 3
         AND LENGTH (TRIM (jns_byr)) = 2
         AND kdsatker IN (SELECT kdsatker FROM t_satker)
GROUP BY ROLLUP (kdbank, jns_byr)
ORDER BY 1, 2
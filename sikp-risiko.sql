/* Formatted on 05/08/2025 14:35:51 (QP5 v5.391) */
  SELECT a.id_risiko,
         a.kd_kemungkinan,
         c.nm_kemungkinan,
         a.kd_lvl_dampak,
         d.nm_lvl_dampak,
         b.nilai_risiko,
         CASE WHEN nilai_risiko > 11 THEN 'ya' ELSE 'tidak' END AS rencana_penanganan
    FROM (SELECT 1 AS id_risiko, '2025' AS tahun, '01' AS kd_kemungkinan, '04' AS kd_lvl_dampak FROM DUAL
          UNION
          SELECT 2 AS id_risiko, '2025' AS tahun, '01' AS kd_kemungkinan, '04' AS kd_lvl_dampak FROM DUAL
          UNION
          SELECT 3 AS id_risiko, '2025' AS tahun, '02' AS kd_kemungkinan, '03' AS kd_lvl_dampak FROM DUAL
          UNION
          SELECT 4 AS id_risiko, '2025' AS tahun, '02' AS kd_kemungkinan, '03' AS kd_lvl_dampak FROM DUAL
          UNION
          SELECT 5 AS id_risiko, '2025' AS tahun, '02' AS kd_kemungkinan, '03' AS kd_lvl_dampak FROM DUAL
          UNION
          SELECT 6 AS id_risiko, '2025' AS tahun, '02' AS kd_kemungkinan, '03' AS kd_lvl_dampak FROM DUAL
          UNION
          SELECT 7 AS id_risiko, '2025' AS tahun, '02' AS kd_kemungkinan, '03' AS kd_lvl_dampak FROM DUAL
          UNION
          SELECT 8 AS id_risiko, '2025' AS tahun, '02' AS kd_kemungkinan, '02' AS kd_lvl_dampak FROM DUAL
          UNION
          SELECT 9 AS id_risiko, '2025' AS tahun, '03' AS kd_kemungkinan, '03' AS kd_lvl_dampak FROM DUAL
          UNION
          SELECT 10 AS id_risiko, '2025' AS tahun, '02' AS kd_kemungkinan, '03' AS kd_lvl_dampak FROM DUAL
          UNION
          SELECT 11 AS id_risiko, '2025' AS tahun, '02' AS kd_kemungkinan, '02' AS kd_lvl_dampak FROM DUAL
          UNION
          SELECT 12 AS id_risiko, '2025' AS tahun, '02' AS kd_kemungkinan, '03' AS kd_lvl_dampak FROM DUAL
          UNION
          SELECT 13 AS id_risiko, '2025' AS tahun, '03' AS kd_kemungkinan, '02' AS kd_lvl_dampak FROM DUAL
          UNION
          SELECT 14 AS id_risiko, '2025' AS tahun, '02' AS kd_kemungkinan, '03' AS kd_lvl_dampak FROM DUAL
          UNION
          SELECT 15 AS id_risiko, '2025' AS tahun, '02' AS kd_kemungkinan, '02' AS kd_lvl_dampak FROM DUAL
          UNION
          SELECT 16 AS id_risiko, '2025' AS tahun, '01' AS kd_kemungkinan, '03' AS kd_lvl_dampak FROM DUAL) a
         LEFT JOIN r_matriks_risiko_2020 b ON (a.kd_kemungkinan = b.kd_kemungkinan AND a.kd_lvl_dampak = b.kd_lvl_dampak)
         LEFT JOIN r_kemungkinan c ON (a.kd_kemungkinan = c.kd_kemungkinan)
         LEFT JOIN r_lvl_dampak d ON (a.kd_lvl_dampak = d.kd_lvl_dampak)
ORDER BY 1;

select * from t_rp_risiko
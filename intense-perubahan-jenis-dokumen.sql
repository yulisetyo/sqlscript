/* Formatted on 14/08/2024 10:13:36 (QP5 v5.215.12089.38647) */
  SELECT *
    FROM TAB
   WHERE TNAME LIKE '%DOK%'
ORDER BY 1;

  SELECT *
    FROM T_LVLDOK
ORDER BY 1;

  SELECT *
    FROM T_JNSDOK
   WHERE ID > 84
ORDER BY 1;

SELECT '85' AS ID,
       'Hasil Evaluasi Kinerja (HEK) Triwulan I' AS JNSDOK,
       1 AS IDLVLDOK,
       1 AS AKTIF,
       1 AS FLAG,
       1 AS TIPE,
       1 AS Q1,
       NULL AS Q2,
       NULL AS Q3,
       NULL AS Q4,
       'NSKP Triwulanan I' AS JNSDOK1
  FROM DUAL
UNION
SELECT '86' AS ID,
       'Dokumen Evaluasi Kinerja (DEK) Triwulan I' AS JNSDOK,
       1 AS IDLVLDOK,
       1 AS AKTIF,
       1 AS FLAG,
       1 AS TIPE,
       1 AS Q1,
       NULL AS Q2,
       NULL AS Q3,
       NULL AS Q4,
       'NKPNS/DP3 Triwulan I' AS JNSDOK1
  FROM DUAL
UNION
SELECT '87' AS ID,
       'Hasil Evaluasi Kinerja (HEK) Triwulan II' AS JNSDOK,
       1 AS IDLVLDOK,
       1 AS AKTIF,
       1 AS FLAG,
       1 AS TIPE,
       NULL AS Q1,
       1 AS Q2,
       NULL AS Q3,
       NULL AS Q4,
       'NSKP Triwulanan II' AS JNSDOK1
  FROM DUAL
UNION
SELECT '88' AS ID,
       'Dokumen Evaluasi Kinerja (DEK) Triwulan II' AS JNSDOK,
       1 AS IDLVLDOK,
       1 AS AKTIF,
       1 AS FLAG,
       1 AS TIPE,
       NULL AS Q1,
       1 AS Q2,
       NULL AS Q3,
       NULL AS Q4,
       'NKPNS/DP3 Triwulan II' AS JNSDOK1
  FROM DUAL
UNION
SELECT '89' AS ID,
       'Hasil Evaluasi Kinerja (HEK) Triwulan III' AS JNSDOK,
       1 AS IDLVLDOK,
       1 AS AKTIF,
       1 AS FLAG,
       1 AS TIPE,
       NULL AS Q1,
       NULL AS Q2,
       1 AS Q3,
       NULL AS Q4,
       'NSKP Triwulanan III' AS JNSDOK1
  FROM DUAL
UNION
SELECT '90' AS ID,
       'Dokumen Evaluasi Kinerja (DEK) Triwulan III' AS JNSDOK,
       1 AS IDLVLDOK,
       1 AS AKTIF,
       1 AS FLAG,
       1 AS TIPE,
       NULL AS Q1,
       NULL AS Q2,
       1 AS Q3,
       NULL AS Q4,
       'NKPNS/DP3 Triwulan III' AS JNSDOK1
  FROM DUAL
UNION
SELECT '91' AS ID,
       'Hasil Evaluasi Kinerja (HEK) Triwulan IV' AS JNSDOK,
       1 AS IDLVLDOK,
       1 AS AKTIF,
       1 AS FLAG,
       1 AS TIPE,
       NULL AS Q1,
       NULL AS Q2,
       NULL AS Q3,
       1 AS Q4,
       'NSKP Triwulanan IV' AS JNSDOK1
  FROM DUAL
UNION
SELECT '92' AS ID,
       'Dokumen Evaluasi Kinerja (DEK) Triwulan IV' AS JNSDOK,
       1 AS IDLVLDOK,
       1 AS AKTIF,
       1 AS FLAG,
       1 AS TIPE,
       NULL AS Q1,
       NULL AS Q2,
       NULL AS Q3,
       1 AS Q4,
       'NKPNS/DP3 Triwulan IV' AS JNSDOK1
  FROM DUAL
UNION
SELECT '93' AS ID,
       'Adendum Perjanjian Kinerja' AS JNSDOK,
       1 AS IDLVLDOK,
       1 AS AKTIF,
       1 AS FLAG,
       1 AS TIPE,
       NULL AS Q1,
       NULL AS Q2,
       NULL AS Q3,
       NULL AS Q4,
       'Adendum Perjanjian Kinerja' AS JNSDOK1
  FROM DUAL;
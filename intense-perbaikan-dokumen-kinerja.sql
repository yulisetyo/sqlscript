/* Formatted on 19/11/2024 16:30:00 (QP5 v5.215.12089.38647) */
  SELECT *
    FROM t_jnsdok
   WHERE aktif = 1
ORDER BY 1;


SELECT a.*
  FROM (SELECT 1 AS id,
               'SKP Awal Tahun - pdf' AS jnsdok,
               1 AS idlvldok,
               1 AS aktif,
               1 AS flag,
               1 AS tipe,
               1 AS Q1,
               1 AS Q2,
               1 AS Q3,
               1 AS Q4,
               '' AS jnsdok1
          FROM DUAL
        UNION
        SELECT 2 AS id,
               'Manual IKI Awal Tahun - excel' AS jnsdok,
               1 AS idlvldok,
               1 AS aktif,
               1 AS flag,
               1 AS tipe,
               1 AS Q1,
               1 AS Q2,
               1 AS Q3,
               1 AS Q4,
               '' AS jnsdok1
          FROM DUAL
        UNION
        SELECT 3 AS id,
               'Individual Performance Review (IPR) Triwulan I – pdf' AS jnsdok,
               1 AS idlvldok,
               1 AS aktif,
               1 AS flag,
               1 AS tipe,
               1 AS Q1,
               0 AS Q2,
               0 AS Q3,
               0 AS Q4,
               '' AS jnsdok1
          FROM DUAL
        UNION
        SELECT 4 AS id,
               'Individual Performance Review (IPR) Triwulan II – pdf' AS jnsdok,
               1 AS idlvldok,
               1 AS aktif,
               1 AS flag,
               1 AS tipe,
               0 AS Q1,
               1 AS Q2,
               0 AS Q3,
               0 AS Q4,
               '' AS jnsdok1
          FROM DUAL
        UNION
        SELECT 5 AS id,
               'Individual Performance Review (IPR) Triwulan III – pdf' AS jnsdok,
               1 AS idlvldok,
               1 AS aktif,
               1 AS flag,
               1 AS tipe,
               0 AS Q1,
               0 AS Q2,
               1 AS Q3,
               0 AS Q4,
               '' AS jnsdok1
          FROM DUAL
        UNION
        SELECT 6 AS id,
               'Individual Performance Review (IPR) Triwulan IV – pdf' AS jnsdok,
               1 AS idlvldok,
               1 AS aktif,
               1 AS flag,
               1 AS tipe,
               0 AS Q1,
               0 AS Q2,
               0 AS Q3,
               1 AS Q4,
               '' AS jnsdok1
          FROM DUAL
        UNION
        SELECT 7 AS id,
               'HEK Triwulan I - pdf' AS jnsdok,
               1 AS idlvldok,
               1 AS aktif,
               1 AS flag,
               1 AS tipe,
               1 AS Q1,
               0 AS Q2,
               0 AS Q3,
               0 AS Q4,
               '' AS jnsdok1
          FROM DUAL
        UNION
        SELECT 8 AS id,
               'HEK Triwulan II - pdf' AS jnsdok,
               1 AS idlvldok,
               1 AS aktif,
               1 AS flag,
               1 AS tipe,
               0 AS Q1,
               1 AS Q2,
               0 AS Q3,
               0 AS Q4,
               '' AS jnsdok1
          FROM DUAL
        UNION
        SELECT 9 AS id,
               'HEK Triwulan III - pdf' AS jnsdok,
               1 AS idlvldok,
               1 AS aktif,
               1 AS flag,
               1 AS tipe,
               0 AS Q1,
               0 AS Q2,
               1 AS Q3,
               0 AS Q4,
               '' AS jnsdok1
          FROM DUAL
        UNION
        SELECT 10 AS id,
               'HEK Triwulan IV (Tahunan) - pdf' AS jnsdok,
               1 AS idlvldok,
               1 AS aktif,
               1 AS flag,
               1 AS tipe,
               0 AS Q1,
               0 AS Q2,
               0 AS Q3,
               1 AS Q4,
               '' AS jnsdok1
          FROM DUAL
        UNION
        SELECT 11 AS id,
               'DEK Triwulan I - pdf' AS jnsdok,
               1 AS idlvldok,
               1 AS aktif,
               1 AS flag,
               1 AS tipe,
               1 AS Q1,
               0 AS Q2,
               0 AS Q3,
               0 AS Q4,
               '' AS jnsdok1
          FROM DUAL
        UNION
        SELECT 12 AS id,
               'DEK Triwulan II - pdf' AS jnsdok,
               1 AS idlvldok,
               1 AS aktif,
               1 AS flag,
               1 AS tipe,
               0 AS Q1,
               1 AS Q2,
               0 AS Q3,
               0 AS Q4,
               '' AS jnsdok1
          FROM DUAL
        UNION
        SELECT 13 AS id,
               'DEK Triwulan III - pdf' AS jnsdok,
               1 AS idlvldok,
               1 AS aktif,
               1 AS flag,
               1 AS tipe,
               0 AS Q1,
               0 AS Q2,
               1 AS Q3,
               0 AS Q4,
               '' AS jnsdok1
          FROM DUAL
        UNION
        SELECT 14 AS id,
               'DEK Triwulan IV (Tahunan) - pdf' AS jnsdok,
               1 AS idlvldok,
               1 AS aktif,
               1 AS flag,
               1 AS tipe,
               0 AS Q1,
               0 AS Q2,
               0 AS Q3,
               1 AS Q4,
               '' AS jnsdok1
          FROM DUAL
        UNION
        SELECT 15 AS id,
               'Bukti dukung IKI Triwulan I - zip' AS jnsdok,
               1 AS idlvldok,
               1 AS aktif,
               1 AS flag,
               2 AS tipe,
               1 AS Q1,
               0 AS Q2,
               0 AS Q3,
               0 AS Q4,
               '' AS jnsdok1
          FROM DUAL
        UNION
        SELECT 16 AS id,
               'Bukti dukung IKI Triwulan III - zip' AS jnsdok,
               1 AS idlvldok,
               1 AS aktif,
               1 AS flag,
               2 AS tipe,
               0 AS Q1,
               1 AS Q2,
               0 AS Q3,
               0 AS Q4,
               '' AS jnsdok1
          FROM DUAL
        UNION
        SELECT 17 AS id,
               'Bukti dukung IKI Triwulan III - zip' AS jnsdok,
               1 AS idlvldok,
               1 AS aktif,
               1 AS flag,
               2 AS tipe,
               0 AS Q1,
               0 AS Q2,
               1 AS Q3,
               0 AS Q4,
               '' AS jnsdok1
          FROM DUAL
        UNION
        SELECT 18 AS id,
               'Bukti dukung IKI Triwulan IV - zip' AS jnsdok,
               1 AS idlvldok,
               1 AS aktif,
               1 AS flag,
               2 AS tipe,
               0 AS Q1,
               0 AS Q2,
               0 AS Q3,
               1 AS Q4,
               '' AS jnsdok1
          FROM DUAL
        UNION
        /*optional*/
        SELECT 19 AS id,
               'SKP Komplemen 1 - pdf' AS jnsdok,
               2 AS idlvldok,
               1 AS aktif,
               1 AS flag,
               1 AS tipe,
               1 AS Q1,
               1 AS Q2,
               1 AS Q3,
               1 AS Q4,
               '' AS jnsdok1
          FROM DUAL
        UNION
        SELECT 20 AS id,
               'SKP Komplemen 2 - pdf' AS jnsdok,
               2 AS idlvldok,
               1 AS aktif,
               1 AS flag,
               1 AS tipe,
               1 AS Q1,
               1 AS Q2,
               1 AS Q3,
               1 AS Q4,
               '' AS jnsdok1
          FROM DUAL
        UNION
        SELECT 21 AS id,
               'SKP Komplemen 3 - pdf' AS jnsdok,
               2 AS idlvldok,
               1 AS aktif,
               1 AS flag,
               1 AS tipe,
               1 AS Q1,
               1 AS Q2,
               1 AS Q3,
               1 AS Q4,
               '' AS jnsdok1
          FROM DUAL
        UNION
        SELECT 22 AS id,
               'SKP Addendum 1 - pdf' AS jnsdok,
               2 AS idlvldok,
               1 AS aktif,
               1 AS flag,
               1 AS tipe,
               1 AS Q1,
               1 AS Q2,
               1 AS Q3,
               1 AS Q4,
               '' AS jnsdok1
          FROM DUAL
        UNION
        SELECT 23 AS id,
               'SKP Addendum 1 - pdf' AS jnsdok,
               2 AS idlvldok,
               1 AS aktif,
               1 AS flag,
               1 AS tipe,
               1 AS Q1,
               1 AS Q2,
               1 AS Q3,
               1 AS Q4,
               '' AS jnsdok1
          FROM DUAL
        UNION
        SELECT 24 AS id,
               'SKP Addendum 1 - pdf' AS jnsdok,
               2 AS idlvldok,
               1 AS aktif,
               1 AS flag,
               1 AS tipe,
               1 AS Q1,
               1 AS Q2,
               1 AS Q3,
               1 AS Q4,
               '' AS jnsdok1
          FROM DUAL
        UNION
        SELECT 25 AS id,
               'Manual IKI Perubahan 1 - zip' AS jnsdok,
               2 AS idlvldok,
               1 AS aktif,
               1 AS flag,
               2 AS tipe,
               1 AS Q1,
               1 AS Q2,
               1 AS Q3,
               1 AS Q4,
               '' AS jnsdok1
          FROM DUAL
        UNION
        SELECT 26 AS id,
               'Manual IKI Perubahan 2 - zip' AS jnsdok,
               2 AS idlvldok,
               1 AS aktif,
               1 AS flag,
               2 AS tipe,
               1 AS Q1,
               1 AS Q2,
               1 AS Q3,
               1 AS Q4,
               '' AS jnsdok1
          FROM DUAL
        UNION
        SELECT 27 AS id,
               'Manual IKI Perubahan 3 - zip' AS jnsdok,
               2 AS idlvldok,
               1 AS aktif,
               1 AS flag,
               2 AS tipe,
               1 AS Q1,
               1 AS Q2,
               1 AS Q3,
               1 AS Q4,
               '' AS jnsdok1
          FROM DUAL) a
/* Formatted on 15/06/2023 15:14:21 (QP5 v5.215.12089.38647) */
SELECT *
  FROM TAB
 WHERE LOWER (TNAME) LIKE '%unit%';

SELECT *
  FROM T_PEGAWAI
 WHERE NIP LIKE ('19830703%');

SELECT *
  FROM T_USER_LEVEL
 WHERE ID_USER = 41;

SELECT *
  FROM T_UNIT_JABATAN
 WHERE IDUNIT LIKE '1121101505008%' AND SUBSTR (ESELON, 1, 1) IN ('2', '3', '4', '9');

  SELECT *
    FROM T_MENU
ORDER BY 1 DESC;

SELECT * FROM D_IKIT;

SELECT * FROM T_STATUS_IKIT;

  SELECT A.ID,
         A.NAMA,
         A.ID_STATUS,
         A.KET,
         A.DSR_HUKUM,
         A.T_Q1,
         A.T_Q2,
         A.T_Q3,
         A.T_Q4,
         A.TAHUN,
         A.ID_UNITDTL,
         A.JK_WAKTU,
         B.STATUS,
         NVL (C.JNS_IKIT, '-') AS JNS_IKIT,
         NVL (D.LINGKUP_TUGAS, '-') AS LINGKUP_TUGAS
    FROM D_IKIT A
         LEFT JOIN T_STATUS_IKIT B
            ON (A.ID_STATUS = B.ID)
         LEFT JOIN T_JNS_IKIT C
            ON (A.ID_JNS_IKIT = C.ID)
         LEFT JOIN T_LINGKUP_TUGAS D
            ON (A.ID_LINGKUP_TUGAS = D.ID)
   WHERE TAHUN = '2023' AND ID_UNITDTL IS NOT NULL
ORDER BY ID ASC;

  SELECT *
    FROM T_TTJ
ORDER BY 1;

  SELECT ID, JNS_IKIT, CASE WHEN LOWER (JNS_IKIT) = 'squad team' THEN 1 ELSE 0 END AS SQUAD
    FROM T_JNS_IKIT
ORDER BY 1;

SELECT * FROM T_LINGKUP_TUGAS;

  SELECT ID, LINGKUP_TUGAS, IF_SQUAD
    FROM T_LINGKUP_TUGAS
   WHERE IF_SQUAD = 0
ORDER BY 1 ASC;

  SELECT A.ID,
         --         a.nama,
         A.ID_STATUS,
         --         a.ket,
         A.DSR_HUKUM,
         A.JK_WAKTU,
         A.T_Q1,
         A.T_Q2,
         A.T_Q3,
         A.T_Q4,
         A.TAHUN,
         A.ID_UNITDTL,
         A.KD_TTJ,
         B.STATUS,
         NVL (C.JNS_IKIT, '-') AS JNS_IKIT,
         NVL (D.LINGKUP_TUGAS, '-') AS LINGKUP_TUGAS,
         NVL (E.NM_UNITDTL, '-') AS NM_UNITDTL,
         F.NAMA AS NM_PEGAWAI,
         G.NM_TTJ
    FROM D_IKIT A
         LEFT JOIN T_STATUS_IKIT B
            ON (A.ID_STATUS = B.ID)
         LEFT JOIN T_JNS_IKIT C
            ON (A.ID_JNS_IKIT = C.ID)
         LEFT JOIN T_LINGKUP_TUGAS D
            ON (A.ID_LINGKUP_TUGAS = D.ID)
         LEFT JOIN T_UNIT_DTL E
            ON (A.ID_UNITDTL = E.ID_UNITDTL)
         LEFT JOIN T_USER F
            ON (A.ID_USER = F.ID)
         LEFT JOIN T_TTJ G
            ON (A.KD_TTJ = G.KD_TTJ)
   --   WHERE a.tahun = 2023 AND a.id_unitdtl = '1121101505008' AND a.kd_ttj = '01' OR (a.kd_ttj IN ('06'))
   WHERE A.TAHUN = 2023 AND (A.KD_TTJ IN ('04', '06'))
ORDER BY ID DESC;

  SELECT KD_TTJ, NM_TTJ
    FROM T_TTJ
   WHERE KD_TTJ IN ('01', '03', '04', '06')
ORDER BY 1 DESC;

SELECT *
  FROM T_USER
 WHERE ID = '41';

SELECT *
  FROM T_USER_UNIT
 WHERE ID = '41';
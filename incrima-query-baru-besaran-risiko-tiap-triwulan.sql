  SELECT A.TAHUN,
         A.ID_UNIT,
         A.ID_RISIKO,
         A.BESARAN_00,
         NVL (B.BESARAN_03, A.BESARAN_00) AS BESARAN_03,
         NVL (B.BESARAN_06, A.BESARAN_00) AS BESARAN_06,
         NVL (B.BESARAN_09, A.BESARAN_00) AS BESARAN_09,
         NVL (B.BESARAN_12, A.BESARAN_00) AS BESARAN_12
         /*NVL (B.BESARAN_03, A.BESARAN_00) AS BESARAN_03,
         NVL (B.BESARAN_06, NVL (B.BESARAN_03, A.BESARAN_00)) AS BESARAN_06,
         NVL (B.BESARAN_09, NVL (B.BESARAN_06, NVL (B.BESARAN_03, A.BESARAN_00))) AS BESARAN_09,
         NVL (B.BESARAN_12, NVL (B.BESARAN_09, NVL (B.BESARAN_06, NVL (B.BESARAN_03, A.BESARAN_00)))) AS BESARAN_12*/
    FROM    (SELECT A.TAHUN,
                    A.ID_UNIT,
                    A.ID AS ID_RISIKO,
                    A.KEJADIAN,
                    B.NILAI_RISIKO AS BESARAN_00
               FROM T_KRITERIA_RISIKO A LEFT JOIN R_MATRIKS_RISIKO_2020 B ON (A.KD_KEMUNGKINAN = B.KD_KEMUNGKINAN AND A.KD_LVL_DAMPAK = B.KD_LVL_DAMPAK)
              WHERE A.TAHUN = '2023' AND A.ID_UNIT = '350711') A
         LEFT JOIN
            (  SELECT TAHUN,
                      ID_UNIT,
                      ID_RISIKO,
                      MAX (CASE WHEN PERIODE = '03' THEN BESARAN END) AS BESARAN_03,
                      MAX (CASE WHEN PERIODE = '06' THEN BESARAN END) AS BESARAN_06,
                      MAX (CASE WHEN PERIODE = '09' THEN BESARAN END) AS BESARAN_09,
                      MAX (CASE WHEN PERIODE = '12' THEN BESARAN END) AS BESARAN_12
                 FROM (  SELECT A.TAHUN,
                                A.ID_UNIT,
                                B.ID_RISIKO,
                                A.PERIODE,
                                MAX (C.NILAI_RISIKO) AS BESARAN
                           FROM USRINCRIMA.T_REVIU_IRU A
                                LEFT JOIN USRINCRIMA.T_KRITERIA_IRU B
                                   ON (A.ID_IRU = B.ID)
                                LEFT JOIN USRINCRIMA.R_MATRIKS_RISIKO_2020 C
                                   ON (A.LK_OUTLOOK = C.KD_LVL_DAMPAK AND A.LD_OUTLOOK = C.KD_KEMUNGKINAN)
                          WHERE A.TAHUN = '2023' AND A.ID_UNIT = '350711'
                       GROUP BY A.TAHUN,
                                A.ID_UNIT,
                                B.ID_RISIKO,
                                A.PERIODE)
             GROUP BY TAHUN, ID_UNIT, ID_RISIKO) B
         ON (A.TAHUN = B.TAHUN AND A.ID_UNIT = B.ID_UNIT AND A.ID_RISIKO = B.ID_RISIKO)
ORDER BY TAHUN, ID_UNIT, BESARAN_00 DESC;
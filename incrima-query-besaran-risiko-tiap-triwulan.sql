/* Formatted on 14/12/2023 18:03:39 (QP5 v5.215.12089.38647) */
  SELECT *
    FROM t_led
ORDER BY id DESC;

SELECT * FROM t_reviu_rp;

SELECT * FROM t_reviu_iru;

SELECT * FROM t_kriteria_iru;

  SELECT id_risiko, COUNT (id)
    FROM t_kriteria_iru
GROUP BY id_risiko
  HAVING COUNT (id) > 1
ORDER BY 1 DESC;

SELECT *
  FROM t_kriteria_iru
 WHERE id_risiko = '4066';

  SELECT id_risiko,
         MAX (CASE WHEN periode = '03' THEN besaran END) AS besaran_03,
         MAX (CASE WHEN periode = '06' THEN besaran END) AS besaran_06,
         MAX (CASE WHEN periode = '09' THEN besaran END) AS besaran_09,
         MAX (CASE WHEN periode = '12' THEN besaran END) AS besaran_12
    FROM (  SELECT b.id_risiko, a.periode, MAX (c.nilai_risiko) AS besaran
              FROM usrincrima.t_reviu_iru a
                   LEFT JOIN usrincrima.t_kriteria_iru b
                      ON (a.id_iru = b.id)
                   LEFT JOIN usrincrima.r_matriks_risiko_2020 c
                      ON (a.lk_outlook = c.kd_lvl_dampak AND a.ld_outlook = c.kd_kemungkinan)
          GROUP BY b.id_risiko, a.periode)
GROUP BY id_risiko;

  SELECT a.id_risiko,
         a.besaran_00,
         NVL (b.besaran_03, a.besaran_00) AS besaran_03,
         NVL (b.besaran_06, a.besaran_00) AS besaran_06,
         NVL (b.besaran_09, a.besaran_00) AS besaran_09,
         NVL (b.besaran_12, a.besaran_00) AS besaran_12
    FROM    (SELECT a.id AS id_risiko, b.nilai_risiko AS besaran_00
               FROM t_kriteria_risiko a LEFT JOIN r_matriks_risiko_2020 b ON (a.kd_kemungkinan = b.kd_kemungkinan AND a.kd_lvl_dampak = b.kd_lvl_dampak)
              WHERE a.tahun = '2023' AND a.id_unit = '350704') a
         LEFT JOIN
            (  SELECT id_risiko,
                      MAX (CASE WHEN periode = '03' THEN besaran END) AS besaran_03,
                      MAX (CASE WHEN periode = '06' THEN besaran END) AS besaran_06,
                      MAX (CASE WHEN periode = '09' THEN besaran END) AS besaran_09,
                      MAX (CASE WHEN periode = '12' THEN besaran END) AS besaran_12
                 FROM (  SELECT b.id_risiko, a.periode, MAX (c.nilai_risiko) AS besaran
                           FROM usrincrima.t_reviu_iru a
                                LEFT JOIN usrincrima.t_kriteria_iru b
                                   ON (a.id_iru = b.id)
                                LEFT JOIN usrincrima.r_matriks_risiko_2020 c
                                   ON (a.lk_outlook = c.kd_kemungkinan AND a.ld_outlook = c.kd_lvl_dampak)
                          WHERE a.tahun = '2023' AND a.id_unit = '350704'
                       GROUP BY b.id_risiko, a.periode)
             GROUP BY id_risiko) b
         ON (a.id_risiko = b.id_risiko)
ORDER BY besaran_00 DESC
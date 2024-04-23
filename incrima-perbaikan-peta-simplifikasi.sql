/* Formatted on 05/12/2023 23:39:17 (QP5 v5.215.12089.38647) */
  SELECT a.id_unit,
         a.tahun,
         '00' AS periode,
         a.id AS id_risiko,
         b.nilai_risiko
    FROM t_kriteria_risiko a LEFT JOIN r_matriks_risiko_2020 b ON (a.kd_lvl_dampak = b.kd_lvl_dampak AND a.kd_kemungkinan = b.kd_kemungkinan)
   WHERE a.tahun = '2023' AND a.id_unit = '350704'
ORDER BY nilai_risiko DESC;


  SELECT b.id_unit,
         b.tahun,
         b.periode,
         a.id_risiko,
         c.nilai_risiko
    FROM t_kriteria_iru a
         RIGHT JOIN t_reviu_iru b
            ON (a.id = b.id_iru)
         LEFT JOIN r_matriks_risiko_2020 c
            ON (b.lk_outlook = c.kd_kemungkinan AND b.ld_outlook = c.kd_lvl_dampak)
         LEFT JOIN r_matriks_risiko_2020 d
            ON (b.lk_outlook = d.kd_kemungkinan AND b.ld_outlook = d.kd_lvl_dampak)
   WHERE a.id_risiko IN (SELECT a.id
                           FROM t_kriteria_risiko a LEFT JOIN r_matriks_risiko_2020 b ON (a.kd_lvl_dampak = b.kd_lvl_dampak AND a.kd_kemungkinan = b.kd_kemungkinan)
                          WHERE a.tahun = '2023' AND a.id_unit = '350704' AND b.nilai_risiko > 11)
ORDER BY nilai_risiko DESC;


  SELECT a.id_unit,
         a.tahun,
         '00' AS periode,
         a.id AS id_risiko,
         b.nilai_risiko
    FROM t_kriteria_risiko a LEFT JOIN r_matriks_risiko_2020 b ON (a.kd_lvl_dampak = b.kd_lvl_dampak AND a.kd_kemungkinan = b.kd_kemungkinan)
   WHERE a.tahun = '2023' AND a.id_unit = '350704' AND b.nilai_risiko <= 11
ORDER BY nilai_risiko DESC;

SELECT '00' AS periode, 'Awal Tahun' AS nmperiode FROM DUAL
UNION
SELECT '03' AS periode, 'Triwulan I' AS nmperiode FROM DUAL
UNION
SELECT '06' AS periode, 'Triwulan II' AS nmperiode FROM DUAL
UNION
SELECT '09' AS periode, 'Triwulan III' AS nmperiode FROM DUAL
UNION
SELECT '12' AS periode, 'Triwulan IV' AS nmperiode FROM DUAL;


  SELECT                                                                                                                                                           /*a.*, b.*, c.**/
        a.id_unit,
         a.tahun,
         a.periode AS periode00,
         a.id_risiko,
         a.nilai_risiko AS nilai00,
         NVL (b.periode, a.periode) AS periodexx,
         NVL (b.nilai_risiko, a.nilai_risiko) AS nilaixx
    FROM (                                                                                                                                                            /*AWAL TAHUN*/
          SELECT a.id_unit,
                 a.tahun,
                 '00' AS periode,
                 a.id AS id_risiko,
                 b.nilai_risiko
            FROM t_kriteria_risiko a LEFT JOIN r_matriks_risiko_2020 b ON (a.kd_lvl_dampak = b.kd_lvl_dampak AND a.kd_kemungkinan = b.kd_kemungkinan)
           WHERE a.tahun = '2023' AND a.id_unit = '350642') a
         LEFT JOIN (                                                                                                                                                /*PER TRIWULAN*/
                    SELECT b.id_unit,
                           b.tahun,
                           b.periode,
                           a.id_risiko,
                           c.nilai_risiko
                      FROM t_kriteria_iru a
                           RIGHT JOIN t_reviu_iru b
                              ON (a.id = b.id_iru)
                           LEFT JOIN r_matriks_risiko_2020 c
                              ON (b.lk_outlook = c.kd_kemungkinan AND b.ld_outlook = c.kd_lvl_dampak)
                           LEFT JOIN r_matriks_risiko_2020 d
                              ON (b.lk_outlook = d.kd_kemungkinan AND b.ld_outlook = d.kd_lvl_dampak)
                     WHERE a.id_risiko IN (SELECT a.id
                                             FROM    t_kriteria_risiko a
                                                  LEFT JOIN
                                                     r_matriks_risiko_2020 b
                                                  ON (a.kd_lvl_dampak = b.kd_lvl_dampak AND a.kd_kemungkinan = b.kd_kemungkinan)
                                            WHERE a.tahun = '2023' AND a.id_unit = '350642' AND b.nilai_risiko > 11)) b
            ON (a.id_risiko = b.id_risiko AND a.id_unit = b.id_unit)
         LEFT JOIN (                                                                                                                                   /*RISIKO YG TIDAK DITANGANI*/
                    SELECT a.id_unit,
                           a.tahun,
                           '00' AS periode,
                           a.id AS id_risiko,
                           b.nilai_risiko
                      FROM t_kriteria_risiko a LEFT JOIN r_matriks_risiko_2020 b ON (a.kd_lvl_dampak = b.kd_lvl_dampak AND a.kd_kemungkinan = b.kd_kemungkinan)
                     WHERE a.tahun = '2023' AND a.id_unit = '350642' AND b.nilai_risiko <= 11) c
            ON (a.id_risiko = c.id_risiko AND a.id_unit = c.id_unit                                                                                /*AND b.id_risiko = c.id_risiko*/
                                                                   )
--WHERE b.periode = '06'
ORDER BY nilai00 DESC;


  SELECT a.prioritas AS id,
         b.kejadian,
         (e.nosasaran || '.' || b.nourut) AS norisiko,
         a.nilai_risiko,
         d.jenis_dampak,
         c.nourut
    FROM t_prioritas_risiko a
         LEFT JOIN t_kriteria_risiko b
            ON (a.id_risiko = b.id)
         LEFT JOIN r_matriks_risiko_2020 c
            ON (a.nilai_risiko = c.nilai_risiko)
         LEFT JOIN r_area_dampak d
            ON (b.kd_area_dampak = d.kd_area_dampak)
         LEFT JOIN (  SELECT kodeorganisasi,
                             tahun,
                             id_sasaran,
                             DBMS_LOB.SUBSTR (nm_sasaran, 4000) AS nm_sasaran,
                             MIN (nourut) AS nosasaran
                        FROM d_sasaran
                    GROUP BY kodeorganisasi,
                             tahun,
                             id_sasaran,
                             DBMS_LOB.SUBSTR (nm_sasaran, 4000)) e
            ON (b.id_sasaran = e.id_sasaran AND b.id_unit = e.kodeorganisasi AND b.tahun = e.tahun)
   WHERE b.id_unit = '350704' AND b.tahun = '2023' AND b.kejadian IS NOT NULL                                                                                     --and c.nourut = ?
ORDER BY c.nourut ASC;

  SELECT a.*,
         --b.id AS id_iru,
         c.tahun,
         c.periode, /*
          c.ld_outlook,
          c.lk_outlook,
          c.ld_proyeksi,
          c.lk_proyeksi,*/
         NVL (c.nilai_outlook, a.nilai_risiko) AS nilai_outlook
    FROM (SELECT a.prioritas AS id,
                 --b.kejadian,
                 (e.nosasaran || '.' || b.nourut) AS norisiko,
                 a.nilai_risiko,
                 --d.jenis_dampak,
                 c.nourut,
                 a.id_risiko
            FROM t_prioritas_risiko a
                 LEFT JOIN t_kriteria_risiko b
                    ON (a.id_risiko = b.id)
                 LEFT JOIN r_matriks_risiko_2020 c
                    /*ON (a.nilai_risiko = c.nilai_risiko)*/
                 ON (b.kd_lvl_dampak = c.kd_lvl_dampak AND b.kd_kemungkinan = c.kd_kemungkinan)
                 LEFT JOIN r_area_dampak d
                    ON (b.kd_area_dampak = d.kd_area_dampak)
                 LEFT JOIN (  SELECT kodeorganisasi,
                                     tahun,
                                     id_sasaran,
                                     DBMS_LOB.SUBSTR (nm_sasaran, 4000) AS nm_sasaran,
                                     MIN (nourut) AS nosasaran
                                FROM d_sasaran
                            GROUP BY kodeorganisasi,
                                     tahun,
                                     id_sasaran,
                                     DBMS_LOB.SUBSTR (nm_sasaran, 4000)) e
                    ON (b.id_sasaran = e.id_sasaran AND b.id_unit = e.kodeorganisasi AND b.tahun = e.tahun)
           WHERE b.tahun = '2023' AND b.id_unit = '350704' AND b.kejadian IS NOT NULL                                                                             --and c.nourut = ?
                                                                                     ) a
         LEFT JOIN t_kriteria_iru b
            ON (a.id_risiko = b.id_risiko)
         LEFT JOIN (SELECT a.id_unit,
                           a.tahun,
                           a.periode,
                           a.id_iru,
                           b.nilai_risiko AS nilai_outlook,
                           a.ld_outlook,
                           a.ld_proyeksi,
                           a.lk_outlook,
                           a.lk_proyeksi
                      FROM t_reviu_iru a LEFT JOIN r_matriks_risiko_2020 b ON (a.ld_outlook = b.kd_lvl_dampak AND a.lk_outlook = b.kd_kemungkinan)
                     WHERE a.tahun = '2023' AND a.id_unit = '350704') c
            ON (b.id = c.id_iru)
ORDER BY nilai_risiko DESC;


/* PETA RISIKO */

  SELECT a.prioritas AS id,
         l.nourut || '.' || b.nourut AS norisiko,
         b.kejadian,
         m.jenis_dampak,
         o.nourut,
         a.nilai_risiko AS nilai_risiko_00,
         DECODE (c.triwulan1, NULL, a.nilai_risiko, c.triwulan1) AS nilai_risiko_03,
         DECODE (d.triwulan2, NULL, DECODE (c.triwulan1, NULL, a.nilai_risiko, c.triwulan1), d.triwulan2) AS nilai_risiko_06,
         DECODE (e.triwulan3, NULL, DECODE (d.triwulan2, NULL, DECODE (c.triwulan1, NULL, a.nilai_risiko, c.triwulan1), d.triwulan2), e.triwulan3) AS nilai_risiko_09,
         DECODE (f.triwulan4,
                 NULL, DECODE (e.triwulan3, NULL, DECODE (d.triwulan2, NULL, DECODE (c.triwulan1, NULL, a.nilai_risiko, c.triwulan1), d.triwulan2), e.triwulan3),
                 f.triwulan4)
            AS nilai_risiko_12,
         UPPER (g.warna) AS color_00,
         UPPER (DECODE (h.warna, NULL, g.warna, h.warna)) AS color_03,
         UPPER (DECODE (i.warna, NULL, DECODE (h.warna, NULL, g.warna, h.warna), i.warna)) AS color_06,
         UPPER (DECODE (j.warna, NULL, DECODE (i.warna, NULL, DECODE (h.warna, NULL, g.warna, h.warna), i.warna), j.warna)) AS color_09,
         UPPER (DECODE (k.warna, NULL, DECODE (j.warna, NULL, DECODE (i.warna, NULL, DECODE (h.warna, NULL, g.warna, h.warna), i.warna), j.warna), k.warna)) AS color_12,
         k.warna AS color_99,
         NVL (p.nilai_residual, a.nilai_risiko) AS nilai_residual,
         p.color_residual AS color_99,
         '2023' AS tahun
    FROM t_prioritas_risiko a
         LEFT JOIN t_kriteria_risiko b
            ON (a.id_risiko = b.id)
         LEFT JOIN (                                                                                                                                                   /*triwulan1*/
                    SELECT a.id_unit,
                           a.id_risiko,
                           a.tahun,
                           c.nilai_risiko AS triwulan1
                      FROM (  SELECT a.id_unit,
                                     b.id_risiko,
                                     a.tahun,
                                     a.periode,
                                     MAX (a.id) AS max_id
                                FROM t_reviu_iru a LEFT JOIN t_kriteria_iru b ON (a.id_iru = b.id)
                            GROUP BY a.id_unit,
                                     b.id_risiko,
                                     a.tahun,
                                     a.periode) a
                           LEFT JOIN t_reviu_iru b
                              ON (a.max_id = b.id)
                           LEFT JOIN r_matriks_risiko_2020 c
                              ON (b.lk_outlook = c.kd_kemungkinan AND b.ld_outlook = c.kd_lvl_dampak)
                     WHERE a.periode = '03') c
            ON (b.id_unit = c.id_unit AND a.id_risiko = c.id_risiko AND b.tahun = c.tahun)
         LEFT OUTER JOIN (                                                                                                                                             /*triwulan2*/
                          SELECT a.id_unit,
                                 a.id_risiko,
                                 a.tahun,
                                 c.nilai_risiko AS triwulan2
                            FROM (  SELECT a.id_unit,
                                           b.id_risiko,
                                           a.tahun,
                                           a.periode,
                                           MAX (a.id) AS max_id
                                      FROM t_reviu_iru a LEFT OUTER JOIN t_kriteria_iru b ON (a.id_iru = b.id)
                                  GROUP BY a.id_unit,
                                           b.id_risiko,
                                           a.tahun,
                                           a.periode) a
                                 LEFT OUTER JOIN t_reviu_iru b
                                    ON (a.max_id = b.id)
                                 LEFT OUTER JOIN r_matriks_risiko_2020 c
                                    ON (b.lk_outlook = c.kd_kemungkinan AND b.ld_outlook = c.kd_lvl_dampak)
                           WHERE a.periode = '06') d
            ON (b.id_unit = d.id_unit AND a.id_risiko = d.id_risiko AND b.tahun = d.tahun)
         LEFT OUTER JOIN (                                                                                                                                             /*triwulan2*/
                          SELECT a.id_unit,
                                 a.id_risiko,
                                 a.tahun,
                                 c.nilai_risiko AS triwulan3
                            FROM (  SELECT a.id_unit,
                                           b.id_risiko,
                                           a.tahun,
                                           a.periode,
                                           MAX (a.id) AS max_id
                                      FROM t_reviu_iru a LEFT OUTER JOIN t_kriteria_iru b ON (a.id_iru = b.id)
                                  GROUP BY a.id_unit,
                                           b.id_risiko,
                                           a.tahun,
                                           a.periode) a
                                 LEFT OUTER JOIN t_reviu_iru b
                                    ON (a.max_id = b.id)
                                 LEFT OUTER JOIN r_matriks_risiko_2020 c
                                    ON (b.lk_outlook = c.kd_kemungkinan AND b.ld_outlook = c.kd_lvl_dampak)
                           WHERE a.periode = '09') e
            ON (b.id_unit = e.id_unit AND a.id_risiko = e.id_risiko AND b.tahun = e.tahun)
         LEFT OUTER JOIN (                                                                                                                                             /*triwulan4*/
                          SELECT a.id_unit,
                                 a.id_risiko,
                                 a.tahun,
                                 c.nilai_risiko AS triwulan4
                            FROM (  SELECT a.id_unit,
                                           b.id_risiko,
                                           a.tahun,
                                           a.periode,
                                           MAX (a.id) AS max_id
                                      FROM t_reviu_iru a LEFT OUTER JOIN t_kriteria_iru b ON (a.id_iru = b.id)
                                  GROUP BY a.id_unit,
                                           b.id_risiko,
                                           a.tahun,
                                           a.periode) a
                                 LEFT OUTER JOIN t_reviu_iru b
                                    ON (a.max_id = b.id)
                                 LEFT OUTER JOIN r_matriks_risiko_2020 c
                                    ON (b.lk_outlook = c.kd_kemungkinan AND b.ld_outlook = c.kd_lvl_dampak)
                           WHERE a.periode = '12') f
            ON (b.id_unit = f.id_unit AND a.id_risiko = f.id_risiko AND b.tahun = f.tahun)
         LEFT OUTER JOIN r_lvl_risiko g
            ON (a.nilai_risiko BETWEEN g.MIN AND g.MAX)
         LEFT OUTER JOIN r_lvl_risiko h
            ON (c.triwulan1 BETWEEN h.MIN AND h.MAX)
         LEFT OUTER JOIN r_lvl_risiko i
            ON (d.triwulan2 BETWEEN i.MIN AND i.MAX)
         LEFT OUTER JOIN r_lvl_risiko j
            ON (e.triwulan3 BETWEEN j.MIN AND j.MAX)
         LEFT OUTER JOIN r_lvl_risiko k
            ON (f.triwulan4 BETWEEN k.MIN AND k.MAX)
         LEFT OUTER JOIN d_sasaran l
            ON (b.id_sasaran = l.id AND b.tahun = l.tahun)
         LEFT OUTER JOIN r_area_dampak m
            ON (b.kd_area_dampak = m.kd_area_dampak)
         LEFT OUTER JOIN (SELECT DISTINCT id_risiko FROM t_penyebab_risiko                                                                                         /*".$kategori."*/
                                                                          ) n
            ON (a.id_risiko = n.id_risiko)
         LEFT OUTER JOIN r_matriks_risiko_2020 o
            ON (b.kd_lvl_dampak = o.kd_lvl_dampak AND b.kd_kemungkinan = o.kd_kemungkinan)
         LEFT OUTER JOIN ((SELECT a.id_kriteria, b.nilai_risiko AS nilai_residual, LOWER (b.color) AS color_residual
                             FROM t_rp_risiko a LEFT OUTER JOIN r_matriks_risiko_2020 b ON (a.ld_residual = b.kd_lvl_dampak AND a.lk_residual = b.kd_kemungkinan)
                            WHERE a.id_unit = '350704' AND a.tahun = '2023')) p
            ON (b.id = p.id_kriteria)
   WHERE b.id_unit = '350704' AND b.tahun = '2023' AND b.kejadian IS NOT NULL AND n.id_risiko IS NOT NULL
ORDER BY id ASC;


                                                                                                                                                   /*triwulan1*/

/*
SELECT a.id_unit,
       a.id_risiko,
       a.tahun,
       c.nilai_risiko,
       d.nourut,
       e.jenis_dampak
  FROM (  SELECT a.id_unit,
                 b.id_risiko,
                 a.tahun,
                 a.periode,
                 MAX (a.id) AS max_id
            FROM t_reviu_iru a LEFT JOIN t_kriteria_iru b ON (a.id_iru = b.id)
        GROUP BY a.id_unit,
                 b.id_risiko,
                 a.tahun,
                 a.periode) a
       LEFT JOIN t_reviu_iru b
          ON (a.max_id = b.id)
       LEFT JOIN r_matriks_risiko_2020 c
          ON (b.lk_outlook = c.kd_kemungkinan AND b.ld_outlook = c.kd_lvl_dampak)
       LEFT JOIN t_kriteria_risiko d
          ON (a.id_risiko = d.id)
       LEFT JOIN r_area_dampak e
          ON (d.kd_area_dampak = e.kd_area_dampak)
 WHERE a.tahun = '2023' AND a.id_unit = '350704' AND a.periode = '03';
 */
 
 /* Formatted on 06/12/2023 00:00:46 (QP5 v5.215.12089.38647) */
  SELECT a.id, a.norisiko, a.idris, a.kejadian, a.jenis_dampak, a.nourut,a.nilai_risiko_00, a.nilai_risiko_03, a.nilai_risiko_06, a.nilai_risiko_09, a.nilai_risiko_12, nilai_residual AS nilai_risiko_99, a.color_00, a.color_03, a.color_06, a.color_09, a.color_12, a.color_99
    FROM (  SELECT a.prioritas AS id,
                   l.nourut || '.' || b.nourut AS norisiko,
                   b.id as idris, b.kejadian,
                   m.jenis_dampak,
                   o.nourut,
                   a.nilai_risiko AS nilai_risiko_00,
                   DECODE (c.triwulan1, NULL, a.nilai_risiko, c.triwulan1) AS nilai_risiko_03,
                   DECODE (d.triwulan2, NULL, DECODE (c.triwulan1, NULL, a.nilai_risiko, c.triwulan1), d.triwulan2) AS nilai_risiko_06,
                   DECODE (e.triwulan3, NULL, DECODE (d.triwulan2, NULL, DECODE (c.triwulan1, NULL, a.nilai_risiko, c.triwulan1), d.triwulan2), e.triwulan3) AS nilai_risiko_09,
                   DECODE (f.triwulan4,
                           NULL, DECODE (e.triwulan3, NULL, DECODE (d.triwulan2, NULL, DECODE (c.triwulan1, NULL, a.nilai_risiko, c.triwulan1), d.triwulan2), e.triwulan3),
                           f.triwulan4)
                      AS nilai_risiko_12,
                   UPPER (g.warna) AS color_00,
                   UPPER (DECODE (h.warna, NULL, g.warna, h.warna)) AS color_03,
                   UPPER (DECODE (i.warna, NULL, DECODE (h.warna, NULL, g.warna, h.warna), i.warna)) AS color_06,
                   UPPER (DECODE (j.warna, NULL, DECODE (i.warna, NULL, DECODE (h.warna, NULL, g.warna, h.warna), i.warna), j.warna)) AS color_09,
                   UPPER (DECODE (k.warna, NULL, DECODE (j.warna, NULL, DECODE (i.warna, NULL, DECODE (h.warna, NULL, g.warna, h.warna), i.warna), j.warna), k.warna)) AS color_12,
                   /*k.warna AS color_99,*/
                   NVL (p.nilai_residual, a.nilai_risiko) AS nilai_residual,
                   p.color_residual AS color_99,
                   '2023' AS tahun
              FROM t_prioritas_risiko a
                   LEFT JOIN t_kriteria_risiko b
                      ON (a.id_risiko = b.id)
                   LEFT JOIN (                                                                                                                                         /*triwulan1*/
                              SELECT a.id_unit,
                                     a.id_risiko,
                                     a.tahun,
                                     c.nilai_risiko AS triwulan1
                                FROM (  SELECT a.id_unit,
                                               b.id_risiko,
                                               a.tahun,
                                               a.periode,
                                               MAX (a.id) AS max_id
                                          FROM t_reviu_iru a LEFT JOIN t_kriteria_iru b ON (a.id_iru = b.id)
                                      GROUP BY a.id_unit,
                                               b.id_risiko,
                                               a.tahun,
                                               a.periode) a
                                     LEFT JOIN t_reviu_iru b
                                        ON (a.max_id = b.id)
                                     LEFT JOIN r_matriks_risiko_2020 c
                                        ON (b.lk_outlook = c.kd_kemungkinan AND b.ld_outlook = c.kd_lvl_dampak)
                               WHERE a.periode = '03') c
                      ON (b.id_unit = c.id_unit AND a.id_risiko = c.id_risiko AND b.tahun = c.tahun)
                   LEFT OUTER JOIN (                                                                                                                                   /*triwulan2*/
                                    SELECT a.id_unit,
                                           a.id_risiko,
                                           a.tahun,
                                           c.nilai_risiko AS triwulan2
                                      FROM (  SELECT a.id_unit,
                                                     b.id_risiko,
                                                     a.tahun,
                                                     a.periode,
                                                     MAX (a.id) AS max_id
                                                FROM t_reviu_iru a LEFT OUTER JOIN t_kriteria_iru b ON (a.id_iru = b.id)
                                            GROUP BY a.id_unit,
                                                     b.id_risiko,
                                                     a.tahun,
                                                     a.periode) a
                                           LEFT OUTER JOIN t_reviu_iru b
                                              ON (a.max_id = b.id)
                                           LEFT OUTER JOIN r_matriks_risiko_2020 c
                                              ON (b.lk_outlook = c.kd_kemungkinan AND b.ld_outlook = c.kd_lvl_dampak)
                                     WHERE a.periode = '06') d
                      ON (b.id_unit = d.id_unit AND a.id_risiko = d.id_risiko AND b.tahun = d.tahun)
                   LEFT OUTER JOIN (                                                                                                                                   /*triwulan3*/
                                    SELECT a.id_unit,
                                           a.id_risiko,
                                           a.tahun,
                                           c.nilai_risiko AS triwulan3
                                      FROM (  SELECT a.id_unit,
                                                     b.id_risiko,
                                                     a.tahun,
                                                     a.periode,
                                                     MAX (a.id) AS max_id
                                                FROM t_reviu_iru a LEFT OUTER JOIN t_kriteria_iru b ON (a.id_iru = b.id)
                                            GROUP BY a.id_unit,
                                                     b.id_risiko,
                                                     a.tahun,
                                                     a.periode) a
                                           LEFT OUTER JOIN t_reviu_iru b
                                              ON (a.max_id = b.id)
                                           LEFT OUTER JOIN r_matriks_risiko_2020 c
                                              ON (b.lk_outlook = c.kd_kemungkinan AND b.ld_outlook = c.kd_lvl_dampak)
                                     WHERE a.periode = '09') e
                      ON (b.id_unit = e.id_unit AND a.id_risiko = e.id_risiko AND b.tahun = e.tahun)
                   LEFT OUTER JOIN (                                                                                                                                   /*triwulan4*/
                                    SELECT a.id_unit,
                                           a.id_risiko,
                                           a.tahun,
                                           c.nilai_risiko AS triwulan4
                                      FROM (  SELECT a.id_unit,
                                                     b.id_risiko,
                                                     a.tahun,
                                                     a.periode,
                                                     MAX (a.id) AS max_id
                                                FROM t_reviu_iru a LEFT OUTER JOIN t_kriteria_iru b ON (a.id_iru = b.id)
                                            GROUP BY a.id_unit,
                                                     b.id_risiko,
                                                     a.tahun,
                                                     a.periode) a
                                           LEFT OUTER JOIN t_reviu_iru b
                                              ON (a.max_id = b.id)
                                           LEFT OUTER JOIN r_matriks_risiko_2020 c
                                              ON (b.lk_outlook = c.kd_kemungkinan AND b.ld_outlook = c.kd_lvl_dampak)
                                     WHERE a.periode = '12') f
                      ON (b.id_unit = f.id_unit AND a.id_risiko = f.id_risiko AND b.tahun = f.tahun)
                   LEFT OUTER JOIN r_lvl_risiko g
                      ON (a.nilai_risiko BETWEEN g.MIN AND g.MAX)
                   LEFT OUTER JOIN r_lvl_risiko h
                      ON (c.triwulan1 BETWEEN h.MIN AND h.MAX)
                   LEFT OUTER JOIN r_lvl_risiko i
                      ON (d.triwulan2 BETWEEN i.MIN AND i.MAX)
                   LEFT OUTER JOIN r_lvl_risiko j
                      ON (e.triwulan3 BETWEEN j.MIN AND j.MAX)
                   LEFT OUTER JOIN r_lvl_risiko k
                      ON (f.triwulan4 BETWEEN k.MIN AND k.MAX)
                   LEFT OUTER JOIN d_sasaran l
                      ON (b.id_sasaran = l.id AND b.tahun = l.tahun)
                   LEFT OUTER JOIN r_area_dampak m
                      ON (b.kd_area_dampak = m.kd_area_dampak)
                   LEFT OUTER JOIN (SELECT DISTINCT id_risiko FROM t_penyebab_risiko) n
                      ON (a.id_risiko = n.id_risiko)
                   LEFT OUTER JOIN r_matriks_risiko_2020 o
                      ON (b.kd_lvl_dampak = o.kd_lvl_dampak AND b.kd_kemungkinan = o.kd_kemungkinan)
                   LEFT OUTER JOIN ((SELECT a.id_kriteria, b.nilai_risiko AS nilai_residual, LOWER (b.color) AS color_residual
                                       FROM t_rp_risiko a LEFT OUTER JOIN r_matriks_risiko_2020 b ON (a.ld_residual = b.kd_lvl_dampak AND a.lk_residual = b.kd_kemungkinan)
                                      WHERE a.id_unit = '350704' AND a.tahun = '2023')) p
                      ON (b.id = p.id_kriteria)
             WHERE b.id_unit = '350704' AND b.tahun = '2023' AND b.kejadian IS NOT NULL AND n.id_risiko IS NOT NULL
          ORDER BY id ASC) a
ORDER BY 1 ASC
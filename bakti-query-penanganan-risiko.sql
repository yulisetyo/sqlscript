/* Formatted on 31/05/2023 18:43:09 (QP5 v5.215.12089.38647) */
SELECT *
  FROM tab
 WHERE LOWER (tname) LIKE '%risiko%';

SELECT * FROM r_matriks_risiko;

SELECT * FROM r_lvl_risiko;

SELECT * FROM t_kriteria_risiko;

SELECT * FROM t_prioritas_risiko;

SELECT * FROM t_rp_risiko;

SELECT * FROM t_rp_ra;

SELECT * FROM t_kriteria_iru;

SELECT * FROM t_reviu_iru;

/* PEMANTAUAN RENCANA PENANGAN */

  SELECT a.*, b.prioritas
    FROM    (SELECT a.id,
                    a.kejadian,
                    a.kd_lvl_dampak,
                    a.kd_kemungkinan,
                    b.nilai_risiko
               FROM t_kriteria_risiko a LEFT JOIN r_matriks_risiko b ON (a.kd_lvl_dampak = b.kd_lvl_dampak AND a.kd_kemungkinan = b.kd_kemungkinan)
              WHERE a.id_unit = '31.1' AND a.tahun = '2022') a
         LEFT JOIN
            t_prioritas_risiko b
         ON (a.id = b.id_risiko)
ORDER BY prioritas ASC;

/* PEMANTAUAN IRU */

/** SELECT a.*,
       b.nilai_risiko,
       c.kd_lvl_dampak,
       c.kd_kemungkinan
  FROM t_rp_risiko a
       LEFT JOIN r_matriks_risiko b
          ON (a.ld_residual = b.kd_lvl_dampak AND a.lk_residual = b.kd_kemungkinan)
       LEFT JOIN t_kriteria_risiko c
          ON (a.id_kriteria = c.id)
 WHERE a.tahun = '2022' AND a.id_unit = '31.5'; **/

  SELECT a.id,
         a.id_unit,
         a.tahun,
         /*a.kd_lvl_dampak,*/
         /*a.kd_kemungkinan,*/
         b.nilai_risiko
    FROM t_kriteria_risiko a LEFT JOIN r_matriks_risiko b ON (a.kd_lvl_dampak = b.kd_lvl_dampak AND a.kd_kemungkinan = b.kd_kemungkinan)
   WHERE a.tahun = '2022' AND a.id_unit = '31.5'
ORDER BY nilai_risiko DESC;

  SELECT a.id,
         a.id_risiko,
         b.kejadian,
         a.nm_iru,
         a.deskripsi_iru,
         c.tahun,
         c.periode,
         a.kd_periode_lapor AS kdpl,
         CASE
            WHEN a.jenis_iru = 1 THEN 'BA: ' || a.batas_atas_iru || ' | ' || 'BM: ' || a.batas_aman_iru
            WHEN a.jenis_iru = 2 THEN 'BM: ' || a.batas_aman_iru || ' | ' || 'BB: ' || a.batas_bawah_iru
            WHEN a.jenis_iru = 3 THEN 'BA: ' || a.batas_atas_iru || ' | ' || 'BM: ' || a.batas_aman_iru || ' | ' || 'BB: ' || a.batas_bawah_iru
         END
            AS batasan_nilai,
         NVL (c.aktual_hasil, 0) AS aktual_hasil,
         d.nilai_risiko,
         UPPER (d.color) AS warna_status,
         e.nm_lvl_risiko || ' (' || c.lr_outlook || ')' AS outlook_besaran
    FROM t_kriteria_iru a
         LEFT JOIN t_kriteria_risiko b
            ON (a.id_risiko = b.id)
         LEFT JOIN t_reviu_iru c
            ON (a.id = c.id_iru AND b.tahun = c.tahun AND b.id_unit = c.id_unit)
         LEFT JOIN r_matriks_risiko d
            ON (c.ld_outlook = d.kd_lvl_dampak AND c.lk_outlook = d.kd_kemungkinan)
         LEFT JOIN r_lvl_risiko e
            ON (c.lr_outlook = e.kd_lvl_risiko)
   WHERE c.tahun = '2022' AND c.periode = '03' AND c.id_unit = '31.1'
ORDER BY nilai_risiko DESC;

SELECT *
  FROM t_kriteria_iru
 WHERE kd_periode_lapor != '01';

                                                                             /***************************************************************************************/

SELECT a.id_unit,
       a.tahun, /*
        a.periode AS prd0,
        f.prioritas,
        a.id AS id_risiko,
        a.kejadian,
        b.nm_iru,*/
       b.batasan_nilai,
       a.nilai_risiko AS nr0,
       b.kdpl AS kdpl1,
       b.periode AS prd1,
       b.nilai_risiko AS nr1,
       b.aktual_hasil AS akt1,
       b.warna AS wrn1,
       c.kdpl AS kdpl2,
       c.periode AS prd2,
       c.nilai_risiko AS nr2,
       c.aktual_hasil AS akt2,
       c.warna AS wrn2,
       d.kdpl AS kdpl3,
       d.periode AS prd3,
       d.nilai_risiko AS nr3,
       d.aktual_hasil AS akt3,
       d.warna AS wrn3,
       e.kdpl AS kdpl4,
       e.periode AS prd4,
       e.nilai_risiko AS nr4,
       e.aktual_hasil AS akt4,
       e.warna AS wrn4,
       CASE WHEN a.nilai_risiko > b.nilai_risiko THEN 'turun' WHEN a.nilai_risiko > b.nilai_risiko THEN 'naik' ELSE 'tetap' END AS tr1,
       CASE WHEN b.nilai_risiko > c.nilai_risiko THEN 'turun' WHEN b.nilai_risiko > c.nilai_risiko THEN 'naik' ELSE 'tetap' END AS tr2,
       CASE WHEN c.nilai_risiko > d.nilai_risiko THEN 'turun' WHEN c.nilai_risiko > d.nilai_risiko THEN 'naik' ELSE 'tetap' END AS tr3,
       CASE WHEN d.nilai_risiko > e.nilai_risiko THEN 'turun' WHEN d.nilai_risiko > e.nilai_risiko THEN 'naik' ELSE 'tetap' END AS tr4
  FROM (SELECT a.id,
               a.kejadian,
               a.id_unit,
               a.tahun,
               '00' AS periode,
               b.nilai_risiko
          FROM t_kriteria_risiko a LEFT JOIN r_matriks_risiko b ON (a.kd_lvl_dampak = b.kd_lvl_dampak AND a.kd_kemungkinan = b.kd_kemungkinan)
         WHERE a.tahun = '2022' AND a.id_unit = '31.5' AND b.nilai_risiko > 11) a
       LEFT JOIN (SELECT a.id,
                         a.id_risiko,
                         b.kejadian,
                         a.nm_iru,
                         a.deskripsi_iru,
                         c.tahun,
                         c.periode,
                         a.kd_periode_lapor AS kdpl,
                         CASE
                            WHEN a.jenis_iru = 1 THEN 'BA: ' || a.batas_atas_iru || ' | ' || 'BM: ' || a.batas_aman_iru
                            WHEN a.jenis_iru = 2 THEN 'BM: ' || a.batas_aman_iru || ' | ' || 'BB: ' || a.batas_bawah_iru
                            WHEN a.jenis_iru = 3 THEN 'BA: ' || a.batas_atas_iru || ' | ' || 'BM: ' || a.batas_aman_iru || ' | ' || 'BB: ' || a.batas_bawah_iru
                         END
                            AS batasan_nilai,
                         NVL (c.aktual_hasil, 0) AS aktual_hasil,
                         d.nilai_risiko,
                         UPPER (d.color) AS warna,
                         e.nm_lvl_risiko || ' (' || c.lr_outlook || ')' AS outlook_besaran
                    FROM t_kriteria_iru a
                         LEFT JOIN t_kriteria_risiko b
                            ON (a.id_risiko = b.id)
                         LEFT JOIN t_reviu_iru c
                            ON (a.id = c.id_iru AND b.tahun = c.tahun AND b.id_unit = c.id_unit)
                         LEFT JOIN r_matriks_risiko d
                            ON (c.ld_outlook = d.kd_lvl_dampak AND c.lk_outlook = d.kd_kemungkinan)
                         LEFT JOIN r_lvl_risiko e
                            ON (c.lr_outlook = e.kd_lvl_risiko)
                   WHERE c.tahun = '2022' AND c.periode = '03' AND c.id_unit = '31.5') b
          ON (a.id = b.id_risiko)
       LEFT JOIN (SELECT a.id,
                         a.id_risiko,
                         b.kejadian,
                         a.nm_iru,
                         a.deskripsi_iru,
                         c.tahun,
                         c.periode,
                         a.kd_periode_lapor AS kdpl,
                         CASE
                            WHEN a.jenis_iru = 1 THEN 'BA: ' || a.batas_atas_iru || ' | ' || 'BM: ' || a.batas_aman_iru
                            WHEN a.jenis_iru = 2 THEN 'BM: ' || a.batas_aman_iru || ' | ' || 'BB: ' || a.batas_bawah_iru
                            WHEN a.jenis_iru = 3 THEN 'BA: ' || a.batas_atas_iru || ' | ' || 'BM: ' || a.batas_aman_iru || ' | ' || 'BB: ' || a.batas_bawah_iru
                         END
                            AS batasan_nilai,
                         NVL (c.aktual_hasil, 0) AS aktual_hasil,
                         d.nilai_risiko,
                         UPPER (d.color) AS warna,
                         e.nm_lvl_risiko || ' (' || c.lr_outlook || ')' AS outlook_besaran
                    FROM t_kriteria_iru a
                         LEFT JOIN t_kriteria_risiko b
                            ON (a.id_risiko = b.id)
                         LEFT JOIN t_reviu_iru c
                            ON (a.id = c.id_iru AND b.tahun = c.tahun AND b.id_unit = c.id_unit)
                         LEFT JOIN r_matriks_risiko d
                            ON (c.ld_outlook = d.kd_lvl_dampak AND c.lk_outlook = d.kd_kemungkinan)
                         LEFT JOIN r_lvl_risiko e
                            ON (c.lr_outlook = e.kd_lvl_risiko)
                   WHERE c.tahun = '2022' AND c.periode = '06' AND c.id_unit = '31.5') c
          ON (a.id = c.id_risiko AND b.id = c.id)
       LEFT JOIN (SELECT a.id,
                         a.id_risiko,
                         b.kejadian,
                         a.nm_iru,
                         a.deskripsi_iru,
                         c.tahun,
                         c.periode,
                         a.kd_periode_lapor AS kdpl,
                         CASE
                            WHEN a.jenis_iru = 1 THEN 'BA: ' || a.batas_atas_iru || ' | ' || 'BM: ' || a.batas_aman_iru
                            WHEN a.jenis_iru = 2 THEN 'BM: ' || a.batas_aman_iru || ' | ' || 'BB: ' || a.batas_bawah_iru
                            WHEN a.jenis_iru = 3 THEN 'BA: ' || a.batas_atas_iru || ' | ' || 'BM: ' || a.batas_aman_iru || ' | ' || 'BB: ' || a.batas_bawah_iru
                         END
                            AS batasan_nilai,
                         NVL (c.aktual_hasil, 0) AS aktual_hasil,
                         d.nilai_risiko,
                         UPPER (d.color) AS warna,
                         e.nm_lvl_risiko || ' (' || c.lr_outlook || ')' AS outlook_besaran
                    FROM t_kriteria_iru a
                         LEFT JOIN t_kriteria_risiko b
                            ON (a.id_risiko = b.id)
                         LEFT JOIN t_reviu_iru c
                            ON (a.id = c.id_iru AND b.tahun = c.tahun AND b.id_unit = c.id_unit)
                         LEFT JOIN r_matriks_risiko d
                            ON (c.ld_outlook = d.kd_lvl_dampak AND c.lk_outlook = d.kd_kemungkinan)
                         LEFT JOIN r_lvl_risiko e
                            ON (c.lr_outlook = e.kd_lvl_risiko)
                   WHERE c.tahun = '2022' AND c.periode = '09' AND c.id_unit = '31.5') d
          ON (a.id = d.id_risiko AND b.id = d.id)
       LEFT JOIN (SELECT a.id,
                         a.id_risiko,
                         b.kejadian,
                         a.nm_iru,
                         a.deskripsi_iru,
                         c.tahun,
                         c.periode,
                         a.kd_periode_lapor AS kdpl,
                         CASE
                            WHEN a.jenis_iru = 1 THEN 'BA: ' || a.batas_atas_iru || ' | ' || 'BM: ' || a.batas_aman_iru
                            WHEN a.jenis_iru = 2 THEN 'BM: ' || a.batas_aman_iru || ' | ' || 'BB: ' || a.batas_bawah_iru
                            WHEN a.jenis_iru = 3 THEN 'BA: ' || a.batas_atas_iru || ' | ' || 'BM: ' || a.batas_aman_iru || ' | ' || 'BB: ' || a.batas_bawah_iru
                         END
                            AS batasan_nilai,
                         NVL (c.aktual_hasil, 0) AS aktual_hasil,
                         d.nilai_risiko,
                         UPPER (d.color) AS warna,
                         e.nm_lvl_risiko || ' (' || c.lr_outlook || ')' AS outlook_besaran
                    FROM t_kriteria_iru a
                         LEFT JOIN t_kriteria_risiko b
                            ON (a.id_risiko = b.id)
                         LEFT JOIN t_reviu_iru c
                            ON (a.id = c.id_iru AND b.tahun = c.tahun AND b.id_unit = c.id_unit)
                         LEFT JOIN r_matriks_risiko d
                            ON (c.ld_outlook = d.kd_lvl_dampak AND c.lk_outlook = d.kd_kemungkinan)
                         LEFT JOIN r_lvl_risiko e
                            ON (c.lr_outlook = e.kd_lvl_risiko)
                   WHERE c.tahun = '2022' AND c.periode = '12' AND c.id_unit = '31.5') e
          ON (a.id = e.id_risiko AND b.id = e.id)
       LEFT JOIN t_prioritas_risiko f
          ON (a.id = f.id_risiko)                                                          /***************************************************************************************/
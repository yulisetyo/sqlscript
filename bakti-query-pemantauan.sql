/* Formatted on 20/09/2023 12:55:11 (QP5 v5.215.12089.38647) */
  SELECT DISTINCT a.id_unit,
                  a.id_kriteria,
                  a.tahun,
                  b.periode,
                  LISTAGG (b.realisasi, '|') WITHIN GROUP (ORDER BY a.id_unit, a.id_kriteria) OVER (PARTITION BY a.id_unit, a.id_kriteria, a.tahun, b.periode) AS realisasi,
                  LISTAGG (b.waktu, '|') WITHIN GROUP (ORDER BY a.id_unit, a.id_kriteria) OVER (PARTITION BY a.id_unit, a.id_kriteria, a.tahun, b.periode) AS waktu,
                  LISTAGG (c.ren_aksi, '|') WITHIN GROUP (ORDER BY a.id_unit, a.id_kriteria) OVER (PARTITION BY a.id_unit, a.id_kriteria, a.tahun, b.periode) AS ren_aksi,
                  LISTAGG (c.output, '|') WITHIN GROUP (ORDER BY a.id_unit, a.id_kriteria) OVER (PARTITION BY a.id_unit, a.id_kriteria, a.tahun, b.periode) AS output,
                  LISTAGG (c.target, '|') WITHIN GROUP (ORDER BY a.id_unit, a.id_kriteria) OVER (PARTITION BY a.id_unit, a.id_kriteria, a.tahun, b.periode) AS target,
                  LISTAGG (c.pjawab, '|') WITHIN GROUP (ORDER BY a.id_unit, a.id_kriteria) OVER (PARTITION BY a.id_unit, a.id_kriteria, a.tahun, b.periode) AS pjawab
    FROM t_rp_risiko a
         LEFT JOIN t_reviu_rp b
            ON (a.id = b.id_rp AND a.tahun = b.tahun AND a.id_unit = b.id_unit)
         LEFT JOIN (SELECT id_rp,
                           LISTAGG (NVL (DBMS_LOB.SUBSTR (TRIM (ren_aksi), 8000), 'N/A'), '|') WITHIN GROUP (ORDER BY id_rp) OVER (PARTITION BY id_rp) ren_aksi,
                           LISTAGG (output, '|') WITHIN GROUP (ORDER BY id_rp) OVER (PARTITION BY id_rp) output,
                           LISTAGG (target, '|') WITHIN GROUP (ORDER BY id_rp) OVER (PARTITION BY id_rp) target,
                           LISTAGG (pjawab, '|') WITHIN GROUP (ORDER BY id_rp) OVER (PARTITION BY id_rp) pjawab
                      FROM t_rp_ra) c
            ON (a.id = c.id_rp)
   WHERE a.tahun = '2023' AND b.periode = '03' AND a.id_unit LIKE '31.2%'
ORDER BY ren_aksi;


  SELECT DISTINCT a.tahun,
                  a.id_unit,
                  a.id_kriteria,
                  LISTAGG (c.ren_aksi, '|') WITHIN GROUP (ORDER BY a.id_unit, a.id_kriteria) OVER (PARTITION BY a.id_unit, a.id_kriteria, a.tahun, b.periode) AS ren_aksi,
                  LISTAGG (c.output, '|') WITHIN GROUP (ORDER BY a.id_unit, a.id_kriteria) OVER (PARTITION BY a.id_unit, a.id_kriteria, a.tahun, b.periode) AS output,
                  LISTAGG (c.target, '|') WITHIN GROUP (ORDER BY a.id_unit, a.id_kriteria) OVER (PARTITION BY a.id_unit, a.id_kriteria, a.tahun, b.periode) AS target,
                  LISTAGG (b.realisasi, '|') WITHIN GROUP (ORDER BY a.id_unit, a.id_kriteria) OVER (PARTITION BY a.id_unit, a.id_kriteria, a.tahun, b.periode) AS realisasi,
                  LISTAGG (b.waktu, '|') WITHIN GROUP (ORDER BY a.id_unit, a.id_kriteria) OVER (PARTITION BY a.id_unit, a.id_kriteria, a.tahun, b.periode) AS waktu,
                  LISTAGG (c.pjawab, '|') WITHIN GROUP (ORDER BY a.id_unit, a.id_kriteria) OVER (PARTITION BY a.id_unit, a.id_kriteria, a.tahun, b.periode) AS pjawab
    FROM t_rp_risiko a
         LEFT JOIN t_reviu_rp b
            ON (a.id = b.id_rp AND a.tahun = b.tahun AND a.id_unit = b.id_unit)
         LEFT JOIN (SELECT id_rp,
                           LISTAGG (NVL (DBMS_LOB.SUBSTR (TRIM (ren_aksi), 8000), 'N/A'), '|') WITHIN GROUP (ORDER BY id_rp) OVER (PARTITION BY id_rp) ren_aksi,
                           LISTAGG (output, '|') WITHIN GROUP (ORDER BY id_rp) OVER (PARTITION BY id_rp) output,
                           LISTAGG (target, '|') WITHIN GROUP (ORDER BY id_rp) OVER (PARTITION BY id_rp) target,
                           LISTAGG (pjawab, '|') WITHIN GROUP (ORDER BY id_rp) OVER (PARTITION BY id_rp) pjawab
                      FROM t_rp_ra) c
            ON (a.id = c.id_rp)
   WHERE a.tahun = '2023' AND b.periode = '03' AND a.id_unit LIKE '31%'
ORDER BY id_unit, id_kriteria;

  SELECT j.tahun,
         j.id_unit,
         j.id_sasaran,
         j.id,
         j.kejadian,
         k.prioritas,
         l.id_unitdtl,
         m.tahun,
         --m.ren_aksi,
         m.output,
         m.target,
         m.realisasi,
         m.waktu,
         m.pjawab
    FROM t_kriteria_risiko j
         LEFT JOIN t_prioritas_risiko k
            ON (j.id = k.id_risiko)
         LEFT JOIN d_sasaran_unit l
            ON (j.id_sasaran = l.id_sasaran)
         LEFT JOIN (SELECT DISTINCT
                           a.tahun,
                           --a.id_unit,
                           a.id_kriteria,
                           --LISTAGG (c.ren_aksi, '|') WITHIN GROUP (ORDER BY a.tahun, a.id_kriteria) OVER (PARTITION BY a.id_unit, a.id_kriteria, a.tahun, b.periode) AS ren_aksi,
                           LISTAGG (c.output, '|') WITHIN GROUP (ORDER BY a.tahun, a.id_kriteria) OVER (PARTITION BY a.id_unit, a.id_kriteria, a.tahun, b.periode) AS output,
                           LISTAGG (c.target, '|') WITHIN GROUP (ORDER BY a.tahun, a.id_kriteria) OVER (PARTITION BY a.id_unit, a.id_kriteria, a.tahun, b.periode) AS target,
                           LISTAGG (b.realisasi, '|') WITHIN GROUP (ORDER BY a.tahun, a.id_kriteria) OVER (PARTITION BY a.id_unit, a.id_kriteria, a.tahun, b.periode) AS realisasi,
                           LISTAGG (b.waktu, '|') WITHIN GROUP (ORDER BY a.tahun, a.id_kriteria) OVER (PARTITION BY a.id_unit, a.id_kriteria, a.tahun, b.periode) AS waktu,
                           LISTAGG (c.pjawab, '|') WITHIN GROUP (ORDER BY a.tahun, a.id_kriteria) OVER (PARTITION BY a.id_unit, a.id_kriteria, a.tahun, b.periode) AS pjawab
                      FROM t_rp_risiko a
                           LEFT JOIN t_reviu_rp b
                              ON (a.id = b.id_rp AND a.tahun = b.tahun AND a.id_unit = b.id_unit)
                           LEFT JOIN (SELECT id_rp,
                                             LISTAGG (NVL (DBMS_LOB.SUBSTR (TRIM (ren_aksi), 8000), 'N/A'), '|') WITHIN GROUP (ORDER BY id_rp) OVER (PARTITION BY id_rp) ren_aksi,
                                             LISTAGG (output, '|') WITHIN GROUP (ORDER BY id_rp) OVER (PARTITION BY id_rp) output,
                                             LISTAGG (target, '|') WITHIN GROUP (ORDER BY id_rp) OVER (PARTITION BY id_rp) target,
                                             LISTAGG (pjawab, '|') WITHIN GROUP (ORDER BY id_rp) OVER (PARTITION BY id_rp) pjawab
                                        FROM t_rp_ra) c
                              ON (a.id = c.id_rp)
                     WHERE a.tahun = '2023' AND b.periode = '03') m
            ON (j.id = m.id_kriteria AND j.tahun = m.tahun)
   WHERE j.tahun = '2023' AND l.id_unitdtl LIKE '31.2%' AND j.is_badan IS NULL
ORDER BY prioritas;

/*SELECT id_rp,
       LISTAGG (NVL (DBMS_LOB.SUBSTR (TRIM (ren_aksi), 8000), 'N/A'), '|') WITHIN GROUP (ORDER BY id_rp) OVER (PARTITION BY id_rp) renaksi,
       LISTAGG (output, '|') WITHIN GROUP (ORDER BY id_rp) OVER (PARTITION BY id_rp) output,
       LISTAGG (target, '|') WITHIN GROUP (ORDER BY id_rp) OVER (PARTITION BY id_rp) target,
       LISTAGG (pjawab, '|') WITHIN GROUP (ORDER BY id_rp) OVER (PARTITION BY id_rp) pjawab
  FROM t_rp_ra */


SELECT DISTINCT a.tahun,
                a.id_kriteria,
                a.id,
                LISTAGG (b.id, '|') WITHIN GROUP (ORDER BY a.tahun, a.id_kriteria, a.id) OVER (PARTITION BY a.tahun, a.id_kriteria, a.id) AS id_ra,
                LISTAGG (TRIM (b.output), '|') WITHIN GROUP (ORDER BY a.tahun, a.id_kriteria, a.id) OVER (PARTITION BY a.tahun, a.id_kriteria, a.id) AS output,
                LISTAGG (TRIM (b.target), '|') WITHIN GROUP (ORDER BY a.tahun, a.id_kriteria, a.id) OVER (PARTITION BY a.tahun, a.id_kriteria, a.id) AS target,
                LISTAGG (TRIM (b.pjawab), '|') WITHIN GROUP (ORDER BY a.tahun, a.id_kriteria, a.id) OVER (PARTITION BY a.tahun, a.id_kriteria, a.id) AS pjawab
  FROM t_rp_risiko a LEFT JOIN t_rp_ra b ON (a.id = b.id_rp)
 WHERE a.tahun = '2023';

SELECT DISTINCT
       a.tahun,
       a.id_kriteria,
       a.id,
       /*LISTAGG (b.id_ra, '|') WITHIN GROUP (ORDER BY a.tahun, a.id_kriteria, a.id) OVER (PARTITION BY a.tahun, a.id_kriteria, a.id) AS id_ra,
       LISTAGG (b.id, '|') WITHIN GROUP (ORDER BY a.tahun, a.id_kriteria, a.id) OVER (PARTITION BY a.tahun, a.id_kriteria, a.id) AS id_rv,*/
       LISTAGG (TRIM (b.realisasi), '|') WITHIN GROUP (ORDER BY a.tahun, a.id_kriteria, a.id) OVER (PARTITION BY a.tahun, a.id_kriteria, a.id) AS realisasi,
       LISTAGG (TRIM (b.waktu), '|') WITHIN GROUP (ORDER BY a.tahun, a.id_kriteria, a.id) OVER (PARTITION BY a.tahun, a.id_kriteria, a.id) AS waktu,
       LISTAGG (TRIM (c.output), '|') WITHIN GROUP (ORDER BY a.tahun, a.id_kriteria, a.id) OVER (PARTITION BY a.tahun, a.id_kriteria, a.id) AS output,
       LISTAGG (TRIM (c.target), '|') WITHIN GROUP (ORDER BY a.tahun, a.id_kriteria, a.id) OVER (PARTITION BY a.tahun, a.id_kriteria, a.id) AS target,
       LISTAGG (TRIM (c.pjawab), '|') WITHIN GROUP (ORDER BY a.tahun, a.id_kriteria, a.id) OVER (PARTITION BY a.tahun, a.id_kriteria, a.id) AS pjawab,
       LISTAGG (NVL (DBMS_LOB.SUBSTR (TRIM (c.ren_aksi), 8000), 'N/A'), '|') WITHIN GROUP (ORDER BY a.tahun, a.id_kriteria, a.id) OVER (PARTITION BY a.tahun, a.id_kriteria, a.id)
          AS ren_aksi
  FROM t_rp_risiko a
       LEFT JOIN t_reviu_rp b
          ON (a.id = b.id_rp AND a.tahun = b.tahun)
       LEFT JOIN t_rp_ra c
          ON (a.id = c.id_rp AND b.id_ra = c.id)
 WHERE a.tahun = '2023' AND b.periode = '03';

  SELECT DISTINCT p.id,
                  --p.id_unit,
                  --p.id_unitdtl,
                  p.is_badan,
                  p.prioritas,
                  p.kejadian,
                  NVL (q.ren_aksi, 'N/A') AS ren_aksi,
                  NVL (q.output, 'N/A') AS output,
                  NVL (q.target, 0) AS target,
                  NVL (q.realisasi, 0) AS realisasi,
                  NVL (q.waktu, 'N/A') AS waktu,
                  NVL (q.pjawab, 'N/A') AS pjawab
    FROM    (SELECT a.tahun,
                    a.id_unit,
                    a.id,
                    a.kejadian,
                    b.is_badan,
                    b.prioritas,
                    c.id_unitdtl
               FROM t_kriteria_risiko a
                    LEFT JOIN t_prioritas_risiko b
                       ON (a.id = b.id_risiko)
                    LEFT JOIN d_sasaran_unit c
                       ON (a.id_sasaran = c.id_sasaran)
              WHERE a.tahun = '2023') p
         LEFT JOIN
            (SELECT DISTINCT
                    a.tahun,
                    a.id_kriteria,
                    a.id,
                    LISTAGG (TRIM (b.realisasi), '|') WITHIN GROUP (ORDER BY a.tahun, a.id_kriteria, a.id) OVER (PARTITION BY a.tahun, a.id_kriteria, a.id) AS realisasi,
                    LISTAGG (TRIM (b.waktu), '|') WITHIN GROUP (ORDER BY a.tahun, a.id_kriteria, a.id) OVER (PARTITION BY a.tahun, a.id_kriteria, a.id) AS waktu,
                    LISTAGG (TRIM (c.output), '|') WITHIN GROUP (ORDER BY a.tahun, a.id_kriteria, a.id) OVER (PARTITION BY a.tahun, a.id_kriteria, a.id) AS output,
                    LISTAGG (TRIM (c.target), '|') WITHIN GROUP (ORDER BY a.tahun, a.id_kriteria, a.id) OVER (PARTITION BY a.tahun, a.id_kriteria, a.id) AS target,
                    LISTAGG (TRIM (c.pjawab), '|') WITHIN GROUP (ORDER BY a.tahun, a.id_kriteria, a.id) OVER (PARTITION BY a.tahun, a.id_kriteria, a.id) AS pjawab,
                    LISTAGG (NVL (DBMS_LOB.SUBSTR (TRIM (c.ren_aksi), 8000), 'N/A'), '|')
                       WITHIN GROUP (ORDER BY a.tahun, a.id_kriteria, a.id)
                       OVER (PARTITION BY a.tahun, a.id_kriteria, a.id)
                       AS ren_aksi
               FROM t_rp_risiko a
                    LEFT JOIN t_reviu_rp b
                       ON (a.id = b.id_rp AND a.tahun = b.tahun)
                    LEFT JOIN t_rp_ra c
                       ON (a.id = c.id_rp AND b.id_ra = c.id)
              WHERE a.tahun = '2023' AND b.periode = '03') q
         ON (p.tahun = q.tahun AND p.id = q.id_kriteria)
   WHERE p.id_unitdtl LIKE '31.%' AND p.is_badan IS NULL                                                                                                                        --IS NULL
ORDER BY prioritas ASC;

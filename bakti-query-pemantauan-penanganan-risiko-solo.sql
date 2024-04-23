/* Formatted on 07/03/2024 18:45:08 (QP5 v5.215.12089.38647) */
SELECT * FROM T_UNIT_DTL;

SELECT * FROM T_USER;

SELECT p.id,
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
                  NVL (c.id_unitdtl, a.id_unit) AS id_unitdtl,
                  a.id,
                  a.kejadian,
                  a.is_badan,
                  b.prioritas,
                  b.nilai_risiko,
                  c.id_unitdtl AS id_unitdtlx
             FROM t_kriteria_risiko a
                  LEFT JOIN (  SELECT r.id_risiko, r.nilai_risiko, MAX (r.prioritas) AS prioritas
                                 FROM t_prioritas_risiko r
                             GROUP BY id_risiko, nilai_risiko) b
                     ON (a.id = b.id_risiko)
                  LEFT JOIN d_sasaran_unit c
                     ON (a.id_sasaran = c.id_sasaran)
            WHERE a.tahun = '2024' AND a.id_unit = '31.4') p
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
            WHERE a.tahun = '2024' AND b.periode = '03') q
       ON (p.tahun = q.tahun AND p.id = q.id_kriteria)
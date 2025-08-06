  SELECT a.periode,
         a.nama,
         f.jml_risiko,
         NVL (c.jml_ma, 0) AS jml_ma,
         NVL (d.jml_mi, 0) AS jml_mi,
         NVL (b.id, 0) AS id,
         b.status,
         e.nm_status,
         e.alert,
         CASE WHEN b.status IS NULL THEN '04' WHEN b.status IS NOT NULL THEN e.kd_ttj END AS kd_ttj,
         NVL (TO_CHAR (b.tgl_rekam, 'DD-MON-YYYY, HH24:MI:SS'), '-') AS tgl_rekam,
         NVL (TO_CHAR (b.tgl_update, 'DD-MON-YYYY, HH24:MI:SS'), '-') AS tgl_update
    FROM                 r_periode a
                     LEFT JOIN
                         (SELECT b.*
                            FROM     (  SELECT id_unit,
                                               tahun,
                                               periode,
                                               MAX (id) maxid
                                          FROM t_status_pemantauan
                                         WHERE id_unit = '350714' AND tahun = '2025'
                                      GROUP BY id_unit, tahun, periode) a
                                 LEFT JOIN
                                     t_status_pemantauan b
                                 ON (a.maxid = b.id)) b
                     ON (a.periode = b.periode)
                 LEFT JOIN
                     (  SELECT a.id_unit,
                               a.tahun,
                               a.periode,
                               COUNT (b.id_kriteria) AS jml_ma
                          FROM t_reviu_rp a LEFT JOIN t_rp_risiko b ON (a.id_rp = b.id)
                         WHERE a.id_unit = '350714' AND a.tahun = '2025'
                      GROUP BY a.id_unit, a.tahun, a.periode) c
                 ON (a.periode = c.periode)
             LEFT JOIN
                 (  SELECT c.id_unit,
                           c.tahun,
                           a.periode,
                           COUNT (b.id_risiko) AS jml_mi
                      FROM t_reviu_iru a
                           LEFT JOIN t_kriteria_iru b
                               ON (a.id_iru = b.id)
                           LEFT JOIN t_kriteria_risiko c
                               ON (b.id_risiko = c.id)
                     WHERE c.id_unit = '350714' AND c.tahun = '2025'
                  GROUP BY c.id_unit, c.tahun, a.periode) d
             ON (a.periode = d.periode)
         LEFT JOIN
             r_status_pemantauan e
         ON (b.status = e.kd_status),
         (SELECT COUNT (id) AS jml_risiko
            FROM t_kriteria_risiko
           WHERE id_unit = '350714' AND tahun = '2025') f
   WHERE a.periode <> '00'
ORDER BY a.periode;

SELECT a.id,
       b.id_risiko,
       b.id_iru,
       b.nm_iru
  FROM     (SELECT a.id, a.id_iru, a.periode
              FROM t_reviu_iru a
             WHERE a.id_unit = '350712' AND a.tahun = '2025') a
       JOIN
           (SELECT a.id AS id_risiko,
                   a.kejadian AS nama_risiko,
                   b.id AS id_iru,
                   b.nm_iru
              FROM t_kriteria_risiko a JOIN t_kriteria_iru b ON (a.id = b.id_risiko)
             WHERE a.id_unit = '350712' AND a.tahun = '2025') b
       ON (a.id_iru = b.id_iru);
	   

SELECT *
  FROM t_unit_dtl
 WHERE id_unitdtl LIKE '350714%';

SELECT a.id,
       b.id_risiko,
       b.id_iru,
       b.nm_iru
  FROM (SELECT a.id, a.id_iru, a.periode
          FROM t_reviu_iru a
         WHERE a.id_unit = '350714' AND a.tahun = '2025') a
       JOIN
       (SELECT a.id           AS id_risiko,
               a.kejadian     AS nama_risiko,
               b.id           AS id_iru,
               b.nm_iru
          FROM t_kriteria_risiko  a
               JOIN t_kriteria_iru b ON (a.id = b.id_risiko)
         WHERE a.id_unit = '350714' AND a.tahun = '2025') b
           ON (a.id_iru = b.id_iru);

SELECT *
  FROM t_kriteria_iru
 WHERE id_risiko IN (SELECT id
                       FROM t_kriteria_risiko
                      WHERE id_unit = '350714' AND tahun = '2025');

SELECT *
  FROM t_reviu_iru
 WHERE id_unit = '350714' AND tahun = '2025';

SELECT b.id_unit,
       c.nm_unitdtl,
       a.nm_iru,
       b.tahun,
       b.periode
  FROM t_kriteria_iru  a
       LEFT JOIN t_reviu_iru b ON (a.id = b.id_iru)
       LEFT JOIN t_unit_dtl c ON (b.id_unit = c.id_unitdtl)
 WHERE a.id_risiko IN (SELECT id
                         FROM t_kriteria_risiko
                        WHERE id_unit = '350714' AND tahun = '2025');


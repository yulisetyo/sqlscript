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
    FROM r_periode a
         LEFT JOIN (SELECT b.*
                      FROM (  SELECT id_unit,
                                     tahun,
                                     periode,
                                     MAX (id) maxid
                                FROM t_status_pemantauan
                               WHERE id_unit = '35072516' AND tahun = '2024'
                            GROUP BY id_unit, tahun, periode) a
                           LEFT JOIN t_status_pemantauan b ON (a.maxid = b.id)) b
             ON (a.periode = b.periode)
         LEFT JOIN (  SELECT a.id_unit,
                             a.tahun,
                             a.periode,
                             COUNT (DISTINCT (b.id_kriteria)) AS jml_ma
                        FROM t_reviu_rp a LEFT JOIN t_rp_risiko b ON (a.id_rp = b.id)
                       WHERE a.id_unit = '35072516' AND a.tahun = '2024'
                    GROUP BY a.id_unit, a.tahun, a.periode) c
             ON (a.periode = c.periode)
         LEFT JOIN (  SELECT a.id_unit,
                             a.tahun,
                             a.periode,
                             COUNT (DISTINCT (b.id_risiko)) AS jml_mi
                        FROM t_reviu_iru a LEFT JOIN t_kriteria_iru b ON (a.id_iru = b.id)
                       WHERE a.id_unit = '35072516' AND a.tahun = '2024'
                    GROUP BY a.id_unit, a.tahun, a.periode) d
             ON (a.periode = d.periode)
         LEFT JOIN r_status_pemantauan e ON (b.status = e.kd_status),
         (SELECT COUNT (id) AS jml_risiko
            FROM t_kriteria_risiko
           WHERE id_unit = '35072516' AND tahun = '2024') f
   WHERE a.periode <> '00'
ORDER BY a.periode
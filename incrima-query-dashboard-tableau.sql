/* Formatted on 14/03/2024 03:52:58 (QP5 v5.215.12089.38647) */
  SELECT a.*
    FROM (SELECT a.id_unitdtl,
                 a.nm_unitdtl,
                 'Penetapan Profil Risiko' AS jenis_pelaporan,
                 b.tahun,
                 NULL AS periode,
                 NVL (d.nm_status, '-') AS nm_status,
                 NVL (TO_CHAR (c.tgl_update, 'DD-MON-YYYY, HH24:MI:SS'), '-') AS tgl_update
            FROM usrincrima.t_unit_dtl a
                 LEFT JOIN (  SELECT MAX (id) AS max_id, id_unit, tahun
                                FROM usrincrima.t_status_profil_risiko
                            GROUP BY id_unit, tahun) b
                    ON (a.id_unitdtl = b.id_unit)
                 LEFT JOIN usrincrima.t_status_profil_risiko c
                    ON (b.max_id = c.id)
                 LEFT JOIN usrincrima.r_status_risiko d
                    ON (c.status = d.kd_status)
           WHERE c.id IS NOT NULL
          UNION ALL
          SELECT a.id_unitdtl,
                 a.nm_unitdtl,
                 'Penyampaian LPMR' AS jenis_pelaporan,
                 b.tahun,
                 b.periode,
                 NVL (c.nm_status, '-') AS nm_status,
                 NVL (TO_CHAR (b.tgl_update, 'DD-MON-YYYY, HH24:MI:SS'), '-') AS tgl_update
            FROM usrincrima.t_unit_dtl a
                 LEFT JOIN usrincrima.t_status_pemantauan b
                    ON (a.id_unitdtl = b.id_unit)
                 LEFT JOIN usrincrima.r_status_pemantauan c
                    ON (b.status = c.kd_status)
           WHERE b.id IS NOT NULL
          UNION ALL
          SELECT a.id_unitdtl,
                 a.nm_unitdtl,
                 'Penyampaian LED' AS jenis_pelaporan,
                 b.tahun,
                 b.periode,
                 DECODE (b.status, NULL, 'Belum dikirim', 'Sudah dikirim') AS nmstatus,
                 NVL (TO_CHAR (b.updated_at, 'DD-MON-YYYY, HH24:MI:SS'), '-') AS tgl_update
            FROM usrincrima.t_unit_dtl a LEFT JOIN usrincrima.t_led b ON (a.id_unitdtl = b.id_unitdtl)
           WHERE b.id IS NOT NULL) a
   WHERE SUBSTR (a.id_unitdtl, 1, 4) = '3507'
ORDER BY a.id_unitdtl, a.tahun DESC, a.tgl_update;
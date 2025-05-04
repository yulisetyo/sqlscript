/* Formatted on 14/12/2024 09:41:08 (QP5 v5.215.12089.38647) */
  SELECT a.id,
         a.nm_iru,
         --a.deskripsi_iru,
         a.id_risiko,
         b.id_unit
    FROM t_kriteria_iru a LEFT JOIN t_kriteria_risiko b ON (a.id_risiko = b.id)
   WHERE a.id_risiko IN (SELECT id
                           FROM t_kriteria_risiko
                          WHERE tahun = :ptahun AND SUBSTR (id_unit, 1, 4) = '3507')
ORDER BY id_unit ASC, id_risiko ASC;

  SELECT a.id,
         a.nm_iru,
         --a.deskripsi_iru,
         a.id_risiko,
         b.id_unit
    FROM t_kriteria_iru a LEFT JOIN t_kriteria_risiko b ON (a.id_risiko = b.id)
   WHERE a.id_risiko IN (SELECT id
                           FROM t_kriteria_risiko
                          WHERE tahun = :ptahun AND SUBSTR (id_unit, 1, 6) = '350718')
ORDER BY id_unit ASC, id_risiko ASC;

  SELECT id_risiko, LISTAGG (id, '|') WITHIN GROUP (ORDER BY id ASC) AS list_iru
    FROM t_kriteria_iru
   WHERE id_risiko IN (SELECT id
                         FROM t_kriteria_risiko
                        WHERE tahun = '2024' AND SUBSTR (id_unit, 1, 4) = '3507')
GROUP BY id_risiko;


select id_unitdtl, nm_unitdtl from t_unit_dtl where substr(id_unitdtl,1,4) = '3507' and pemilik_peta='true' order by 1
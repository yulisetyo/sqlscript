/* Formatted on 08/03/2024 19:23:06 (QP5 v5.215.12089.38647) */
  SELECT a.*
    FROM (SELECT a.id_unit,
                 --NVL (b.id_unitdtl, a.id_unit) AS id_unitdtl,
                 b.id_unitdtl,
                 NVL (b.id_sasaran, c.id) || '|' || NVL (b.id_unitdtl, a.id_unit) AS id_sasaran_unit,
                 a.tahun,
                 NVL (b.id_sasaran, c.id) AS id_sasaran,
                 c.nm_sasaran,
                 a.id AS idris,
                 a.kejadian,
                 g.penyebab_risiko AS penyebab,
                 f.nm_area_dampak AS dampak,
                 g.kategori_risiko,
                 a.pengendalian,
                 d.nm_kemungkinan AS lvl_kemungkinan,
                 TRIM (a.ket_kemungkinan) AS ket_kemungkinan,
                 e.nm_lvl_dampak AS lvl_dampak,
                 TRIM (a.ket_dampak) AS ket_dampak,
                 k.nm_lvl_risiko AS lvl_risiko,
                 h.nilai_risiko AS besaran,
                 i.prioritas,
                 CASE WHEN h.nilai_risiko > 11 THEN 'Ya' ELSE 'Tidak' END AS keputusan,
                 CASE WHEN h.nilai_risiko > 11 THEN NVL (j.nama_iru, 'N/A') ELSE '-' END AS nama_iru,
                 CASE WHEN h.nilai_risiko > 11 THEN NVL (j.batas_iru, 'N/A') ELSE '-' END AS batas_iru,
                 a.is_badan,
                 ROW_NUMBER () OVER (PARTITION BY NVL (b.id_unitdtl, a.id_unit), a.tahun ORDER BY a.id) AS snum
            FROM t_kriteria_risiko a
                 LEFT JOIN d_sasaran_unit b
                    ON (a.id_sasaran = b.id_sasaran)
                 LEFT JOIN d_sasaran c
                    ON (a.id_sasaran = c.id)
                 LEFT JOIN r_kemungkinan d
                    ON (a.kd_kemungkinan = d.kd_kemungkinan)
                 LEFT JOIN r_lvl_dampak e
                    ON (a.kd_lvl_dampak = e.kd_lvl_dampak)
                 LEFT JOIN r_area_dampak f
                    ON (a.kd_area_dampak = f.kd_area_dampak)
                 LEFT JOIN (  SELECT a.id_risiko,
                                     LISTAGG (a.nm_penyebab, '|') WITHIN GROUP (ORDER BY id) AS penyebab_risiko,
                                     LISTAGG (b.nm_ktg_risiko, '|') WITHIN GROUP (ORDER BY id) AS kategori_risiko
                                FROM t_penyebab_risiko a LEFT JOIN r_ktg_risiko b ON (a.kd_ktg_risiko = b.kd_ktg_risiko)
                            GROUP BY id_risiko) g
                    ON (a.id = g.id_risiko)
                 LEFT JOIN r_matriks_risiko h
                    ON (a.kd_kemungkinan = h.kd_kemungkinan AND a.kd_lvl_dampak = h.kd_lvl_dampak)
                 LEFT JOIN (  SELECT id_risiko, nilai_risiko, MAX (prioritas) AS prioritas
                                FROM t_prioritas_risiko
                            GROUP BY id_risiko, nilai_risiko) i
                    ON (a.id = i.id_risiko)
                 LEFT JOIN (  SELECT id_risiko, LISTAGG (nm_iru, '|') WITHIN GROUP (ORDER BY id ASC) AS nama_iru, LISTAGG (batas_iru, '|') WITHIN GROUP (ORDER BY id ASC) AS batas_iru
                                FROM (SELECT id,
                                             id_risiko,
                                             TRIM (nm_iru) AS nm_iru,
                                             CASE
                                                WHEN jenis_iru = 1 THEN 'Batas Aman:' || batas_aman_iru || ', Batas Atas:' || batas_atas_iru
                                                WHEN jenis_iru = 2 THEN 'Batas Bawah:' || batas_bawah_iru || ', Batas Aman:' || batas_aman_iru
                                                WHEN jenis_iru = 3 THEN 'Batas Atas:' || batas_atas_iru || ', Batas Aman:' || batas_aman_iru || ', Batas Bawah:' || batas_bawah_iru
                                                ELSE 'N/A'
                                             END
                                                AS batas_iru
                                        FROM t_kriteria_iru)
                            GROUP BY id_risiko) j
                    ON (a.id = j.id_risiko)
                 LEFT JOIN r_lvl_risiko k
                    ON (UPPER (h.color) = UPPER (k.warna))
           WHERE a.tahun = '2024') a
   WHERE a.id_unitdtl LIKE '31%'
--ORDER BY id_unit, id_unitdtl;
ORDER BY kejadian;

SELECT LOWER (tname)
  FROM tab
 WHERE LOWER (tname) LIKE '%lvl%';

  SELECT c.tahun,
         c.id,
         c.id_unit,
         c.id_kriteria AS id_risiko,
         a.kejadian AS nm_risiko,
         b.nilai_risiko AS nilai_risiko_awal,
         c.kd_opsi,
         d.nm_opsi,
         c.ld_residual || ' -- ' || f.nm_lvl_dampak AS nm_ld_residual,
         c.lk_residual || ' -- ' || e.nm_kemungkinan AS nm_lk_residual,
         c.lr_residual || ' -- ' || h.nm_lvl_risiko AS nm_lr_residual,
         g.nilai_risiko AS nilai_risiko_residual
    FROM (SELECT *
            FROM t_kriteria_risiko
           WHERE tahun = '2024') a
         LEFT JOIN r_matriks_risiko b
            ON (a.kd_kemungkinan = b.kd_kemungkinan AND a.kd_lvl_dampak = b.kd_lvl_dampak)
         LEFT JOIN t_rp_risiko c
            ON (a.id = c.id_kriteria)
         LEFT JOIN r_opsi d
            ON (c.kd_opsi = d.kd_opsi)
         LEFT JOIN r_kemungkinan e
            ON (c.lk_residual = e.kd_kemungkinan)
         LEFT JOIN r_lvl_dampak f
            ON (c.ld_residual = f.kd_lvl_dampak)
         LEFT JOIN r_matriks_risiko g
            ON (c.lk_residual = g.kd_kemungkinan AND c.ld_residual = g.kd_lvl_dampak)
         LEFT JOIN r_lvl_risiko h
            ON (c.lr_residual = h.kd_lvl_risiko)
   WHERE b.nilai_risiko > 11
ORDER BY nilai_risiko_awal DESC;

SELECT c.*, NVL (DBMS_LOB.SUBSTR (c.ren_aksi, 8000), 'N/A') AS rencana_aksi
  FROM (SELECT *
          FROM t_kriteria_risiko
         WHERE tahun = '2024') a
       LEFT JOIN t_rp_risiko b
          ON (a.id = b.id_kriteria)
       LEFT JOIN t_rp_ra c
          ON (b.id = c.id_rp);
          
          
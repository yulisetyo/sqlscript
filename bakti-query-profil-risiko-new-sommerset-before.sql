/* Formatted on 29/10/2025 13:25:38 (QP5 v5.391) */
  SELECT x.*
    FROM (SELECT a.id,
                 a.tahun,
                 a.id_unit,
                 NVL (a.id_unitdtl, a.id_unit) AS id_unitdtl,
                 a.id_sasaran,
                 c.nm_sasaran,
                 a.is_badan,
                 a.snum,
                 a.kejadian,
                 d.penyebab_risiko AS penyebab,
                 d.penyebab_risiko AS nm_penyebab,
                 f.nm_area_dampak AS dampak,
                 d.kategori_risiko,
                 d.kategori_risiko AS nm_ktg_risiko,
                 a.pengendalian,
                 e.nm_kemungkinan AS lvl_kemungkinan,
                 a.ket_kemungkinan,
                 g.nm_lvl_dampak AS lvl_dampak,
                 a.ket_dampak,
                 k.nm_lvl_risiko AS lvl_risiko,
                 h.nilai_risiko AS besaran,
                 i.prioritas,
                 CASE WHEN h.nilai_risiko > 11 THEN 'Ya' ELSE 'Tidak' END AS keputusan,
                 CASE WHEN h.nilai_risiko > 11 THEN NVL (j.nama_iru, 'wajib dibuatkan IRU') ELSE '-' END AS nama_iru,
                 CASE WHEN h.nilai_risiko > 11 THEN NVL (j.batas_iru, 'NULL') ELSE '-' END AS batas_iru
            FROM (SELECT a.id,
                         a.tahun,
                         a.id_unit,
                         CASE
                             WHEN LOWER (a.kejadian) LIKE 'renstra%' THEN '31.1.1'
                             WHEN LOWER (a.kejadian) LIKE 'sdm%' THEN '31.1.2'
                             WHEN LOWER (a.kejadian) LIKE 'sumber%' THEN '31.1.2'
                             WHEN LOWER (a.kejadian) LIKE 'hukum%' THEN '31.1.3'
                             WHEN LOWER (a.kejadian) LIKE 'pengadaan%' THEN '31.1.4'
                             WHEN LOWER (a.kejadian) LIKE 'pendapatan%' THEN '31.2.1'
                             WHEN LOWER (a.kejadian) LIKE 'perbendaharaan%' THEN '31.2.2'
                             WHEN LOWER (a.kejadian) LIKE 'anggaran%' THEN '31.2.3'
                             WHEN LOWER (a.kejadian) LIKE 'mr%' THEN '31.2.4'
                             WHEN LOWER (a.kejadian) LIKE 'manris%' THEN '31.2.4'
                             WHEN LOWER (a.kejadian) LIKE 'bts%' THEN '31.3.1'
                             WHEN LOWER (a.kejadian) LIKE 'palapa%' THEN '31.3.2'
                             WHEN LOWER (a.kejadian) LIKE 'aksi%' THEN '31.3.3'
                             WHEN LOWER (a.kejadian) LIKE 'satelit%' THEN '31.3.3'
                             WHEN LOWER (a.kejadian) LIKE 'lti masyarakat%' THEN '31.4.1'
                             WHEN LOWER (a.kejadian) LIKE 'masyarakat%' THEN '31.4.1'
                             WHEN LOWER (a.kejadian) LIKE 'pemerintah%' THEN '31.4.2'
                             WHEN LOWER (a.kejadian) LIKE 'bu ii%' THEN '31.5.2'
                             WHEN LOWER (a.kejadian) LIKE 'badan usaha ii%' THEN '31.5.2'
                             WHEN LOWER (a.kejadian) LIKE 'badan usaha ii:%' THEN '31.5.2'
                             WHEN LOWER (a.kejadian) LIKE 'bu i %' THEN '31.5.1'
                             WHEN LOWER (a.kejadian) LIKE 'badan usaha i %' THEN '31.5.1'
                             WHEN LOWER (a.kejadian) LIKE 'badan usaha i: %' THEN '31.5.1'
                         END AS id_unitdtl,
                         CASE WHEN a.is_badan IS NULL THEN '0' ELSE a.is_badan END AS is_badan,
                         a.kejadian,
                         a.id_sasaran,
                         a.pengendalian,
                         a.kd_kemungkinan,
                         a.kd_lvl_dampak,
                         a.kd_area_dampak,
                         a.ket_kemungkinan,
                         a.ket_dampak,
                         ROW_NUMBER () OVER (PARTITION BY a.id_unit, tahun ORDER BY a.id) AS snum
                    FROM t_kriteria_risiko a) a
                 LEFT JOIN (SELECT a.id_sasaran, a.id_unitdtl, b.tahun
                              FROM d_sasaran_unit a LEFT JOIN d_sasaran b ON (a.id_sasaran = b.id)
                             WHERE     b.tahun = :ptahun
                                   AND id_sasaran IN (SELECT id
                                                        FROM d_sasaran
                                                       WHERE tahun = :ptahun)) b
                     ON (a.id_unitdtl = b.id_unitdtl AND a.id_sasaran = b.id_sasaran)
                 LEFT JOIN d_sasaran c ON (a.id_sasaran = c.id)
                 LEFT JOIN
                 (  SELECT a.id_risiko,
                           LISTAGG (a.nm_penyebab, '|') WITHIN GROUP (ORDER BY id) AS penyebab_risiko,
                           LISTAGG (b.nm_ktg_risiko, '|') WITHIN GROUP (ORDER BY id) AS kategori_risiko
                      FROM t_penyebab_risiko a LEFT JOIN r_ktg_risiko b ON (a.kd_ktg_risiko = b.kd_ktg_risiko)
                  GROUP BY id_risiko) d
                     ON (a.id = d.id_risiko)
                 LEFT JOIN r_kemungkinan e ON (a.kd_kemungkinan = e.kd_kemungkinan)
                 LEFT JOIN r_area_dampak f ON (a.kd_area_dampak = f.kd_area_dampak)
                 LEFT JOIN r_lvl_dampak g ON (a.kd_lvl_dampak = g.kd_lvl_dampak)
                 LEFT JOIN r_matriks_risiko h ON (a.kd_kemungkinan = h.kd_kemungkinan AND a.kd_lvl_dampak = h.kd_lvl_dampak)
                 LEFT JOIN t_prioritas_risiko i ON (a.id = i.id_risiko)
                 LEFT JOIN
                 (  SELECT id_risiko, LISTAGG (nm_iru, '|') WITHIN GROUP (ORDER BY id ASC) AS nama_iru, LISTAGG (batas_iru, '|') WITHIN GROUP (ORDER BY id ASC) AS batas_iru
                      FROM (SELECT id,
                                   id_risiko,
                                   TRIM (nm_iru) AS nm_iru,
                                   CASE
                                       WHEN jenis_iru = 1 THEN 'Batas Aman:' || batas_aman_iru || ', Batas Atas:' || batas_atas_iru
                                       WHEN jenis_iru = 2 THEN 'Batas Bawah:' || batas_bawah_iru || ', Batas Aman:' || batas_aman_iru
                                       WHEN jenis_iru = 3 THEN 'Batas Atas:' || batas_atas_iru || ', Batas Aman:' || batas_aman_iru || ', Batas Bawah:' || batas_bawah_iru
                                       ELSE 'N/A'
                                   END AS batas_iru
                              FROM t_kriteria_iru)
                  GROUP BY id_risiko) j
                     ON (a.id = j.id_risiko)
                 LEFT JOIN r_lvl_risiko k ON (UPPER (h.color) = UPPER (k.warna))
           WHERE a.tahun = :ptahun) x
   WHERE x.tahun IS NOT NULL AND x.id_unitdtl = :pidunitdtl
ORDER BY id_unit ASC, id_unitdtl ASC, prioritas ASC
--ORDER BY prioritas
/* Formatted on 25/01/2024 09:56:42 (QP5 v5.215.12089.38647) */
SELECT *
  FROM tab
 WHERE LOWER (tname) LIKE '%iru%';

SELECT * FROM r_ktg_risiko;

SELECT * FROM r_ktg_penyebab_risiko;

SELECT * FROM r_kriteria_dampak;

SELECT * FROM r_lvl_dampak;

SELECT * FROM r_area_dampak;

SELECT * FROM r_kemungkinan;

SELECT * FROM r_lvl_risiko;

  SELECT a.id_unit,
         a.tahun,
         b.nm_sasaran,
         a.id,
         a.kejadian,
         d.penyebab_risiko,
         e.nm_area_dampak AS are_dampak,
         d.kategori_risiko,
         a.pengendalian,
         g.nm_kemungkinan AS level_kemungkinan,
         a.ket_kemungkinan,
         f.nm_lvl_dampak AS level_dampak,
         a.ket_dampak,
         h.nm_lvl_risiko AS level_risiko,
         c.nilai_risiko,
         i.prioritas,
         CASE WHEN c.nilai_risiko > 11 THEN 'Ya' ELSE 'Tidak' END AS penanganan,
         NVL (CASE WHEN c.nilai_risiko > 11 THEN j.nama_iru ELSE 'Tidak perlu dibuatkan IRU' END, 'N/A') AS nama_iru,
         NVL (CASE WHEN c.nilai_risiko > 11 THEN j.batas_iru ELSE '-' END, 'N/A') AS batas_iru,
         i.is_badan
    FROM t_kriteria_risiko a
         LEFT JOIN d_sasaran b
            ON (a.id_sasaran = b.id AND a.tahun = b.tahun)
         LEFT JOIN r_matriks_risiko c
            ON (a.kd_kemungkinan = c.kd_kemungkinan AND a.kd_lvl_dampak = c.kd_lvl_dampak)
         LEFT JOIN (  SELECT a.id_risiko,
                             LISTAGG (a.nm_penyebab, '|') WITHIN GROUP (ORDER BY id) AS penyebab_risiko,
                             LISTAGG (b.nm_ktg_risiko, '|') WITHIN GROUP (ORDER BY id) AS kategori_risiko
                        FROM t_penyebab_risiko a LEFT JOIN r_ktg_risiko b ON (a.kd_ktg_risiko = b.kd_ktg_risiko)
                    GROUP BY id_risiko) d
            ON (a.id = d.id_risiko)
         LEFT JOIN r_area_dampak e
            ON (a.kd_area_dampak = e.kd_area_dampak)
         LEFT JOIN r_lvl_dampak f
            ON (a.kd_lvl_dampak = f.kd_lvl_dampak)
         LEFT JOIN r_kemungkinan g
            ON (a.kd_kemungkinan = g.kd_kemungkinan)
         LEFT JOIN r_lvl_risiko h
            ON (LOWER (c.color) = LOWER (h.warna))
         LEFT JOIN t_prioritas_risiko i
            ON (a.id = i.id_risiko)
         LEFT JOIN (  SELECT id_risiko, LISTAGG (nm_iru, '|') WITHIN GROUP (ORDER BY id ASC) AS nama_iru, LISTAGG (batas_iru, '|') WITHIN GROUP (ORDER BY id ASC) AS batas_iru
                        FROM (SELECT id,
                                     id_risiko,
                                     TRIM (nm_iru) AS nm_iru,
                                     CASE
                                        WHEN jenis_iru = 1 THEN 'Batas aman:' || batas_aman_iru || ', Batas atas:' || batas_atas_iru
                                        WHEN jenis_iru = 2 THEN 'Batas bawah:' || batas_bawah_iru || ', Batas aman:' || batas_aman_iru
                                        WHEN jenis_iru = 3 THEN 'Batas atas:' || batas_atas_iru || ', Batas aman:' || batas_aman_iru || ', Batas bawah:' || batas_bawah_iru
                                        ELSE 'N/A'
                                     END
                                        AS batas_iru
                                FROM t_kriteria_iru)
                    GROUP BY id_risiko) j
            ON (a.id = j.id_risiko)
   WHERE a.tahun = '2024' AND a.id_unit LIKE '31%'
ORDER BY id_unit ASC,
         tahun DESC,
         prioritas ASC,
         nilai_risiko DESC;

  SELECT a.id_risiko, LISTAGG (a.nm_penyebab, '|') WITHIN GROUP (ORDER BY id) AS penyebab_risiko, LISTAGG (b.nm_ktg_risiko, '|') WITHIN GROUP (ORDER BY id) AS kategori_risiko
    FROM t_penyebab_risiko a LEFT JOIN r_ktg_risiko b ON (a.kd_ktg_risiko = b.kd_ktg_risiko)
GROUP BY id_risiko;

SELECT * FROM r_jenis_iru;

SELECT id,
       id_risiko,
       TRIM (nm_iru) AS nm_iru,
       jenis_iru,
       batas_bawah_iru AS bb,
       batas_aman_iru AS bm,
       batas_atas_iru AS ba,
       CASE
          WHEN jenis_iru = 1 THEN 'Batas aman:' || batas_aman_iru || ', Batas atas:' || batas_atas_iru
          WHEN jenis_iru = 2 THEN 'Batas bawah:' || batas_bawah_iru || ', Batas aman:' || batas_aman_iru
          WHEN jenis_iru = 3 THEN 'Batas atas:' || batas_atas_iru || ', Batas aman:' || batas_aman_iru || ', Batas bawah:' || batas_bawah_iru
          ELSE 'N/A'
       END
          AS batas_iru
  FROM t_kriteria_iru;

  SELECT id_risiko, LISTAGG (nm_iru, '|') WITHIN GROUP (ORDER BY id ASC) AS nama_iru
    FROM t_kriteria_iru
GROUP BY id_risiko;

  SELECT id_risiko, LISTAGG (nm_iru, '|') WITHIN GROUP (ORDER BY id ASC) AS nama_iru, LISTAGG (batas_iru, '|') WITHIN GROUP (ORDER BY id ASC) AS batas_iru
    FROM (SELECT id,
                 id_risiko,
                 TRIM (nm_iru) AS nm_iru,
                 CASE
                    WHEN jenis_iru = 1 THEN 'Batas aman:' || batas_aman_iru || ', Batas atas:' || batas_atas_iru
                    WHEN jenis_iru = 2 THEN 'Batas bawah:' || batas_bawah_iru || ', Batas aman:' || batas_aman_iru
                    WHEN jenis_iru = 3 THEN 'Batas atas:' || batas_atas_iru || ', Batas aman:' || batas_aman_iru || ', Batas bawah:' || batas_bawah_iru
                    ELSE 'N/A'
                 END
                    AS batas_iru
            FROM t_kriteria_iru)
GROUP BY id_risiko;


/*** QUERY LAPORAN BARU UNTUK PROFIL RISIKO ***/

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
                 f.nm_area_dampak AS dampak,
                 d.kategori_risiko,
                 a.pengendalian,
                 e.nm_kemungkinan AS lvl_kemungkinan,
                 a.ket_kemungkinan,
                 g.nm_lvl_dampak AS lvl_dampak,
                 a.ket_dampak,
                 k.nm_lvl_risiko AS lvl_risiko,
                 h.nilai_risiko AS besaran,
                 i.prioritas,
                 CASE WHEN h.nilai_risiko > 11 THEN 'Ya' ELSE 'Tidak' END AS keputusan,
                 CASE WHEN h.nilai_risiko > 11 THEN NVL (j.nama_iru, 'wajib dibuatkan IRU') ELSE 'tidak wajib dibuatkan IRU' END AS nama_iru,
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
                         END
                            AS id_unitdtl,
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
                             WHERE     b.tahun = '2024'
                                   AND id_sasaran IN (SELECT id
                                                        FROM d_sasaran
                                                       WHERE tahun = '2024')) b
                    ON (a.id_unitdtl = b.id_unitdtl AND a.id_sasaran = b.id_sasaran)
                 LEFT JOIN d_sasaran c
                    ON (a.id_sasaran = c.id)
                 LEFT JOIN (  SELECT a.id_risiko,
                                     LISTAGG (a.nm_penyebab, '|') WITHIN GROUP (ORDER BY id) AS penyebab_risiko,
                                     LISTAGG (b.nm_ktg_risiko, '|') WITHIN GROUP (ORDER BY id) AS kategori_risiko
                                FROM t_penyebab_risiko a LEFT JOIN r_ktg_risiko b ON (a.kd_ktg_risiko = b.kd_ktg_risiko)
                            GROUP BY id_risiko) d
                    ON (a.id = d.id_risiko)
                 LEFT JOIN r_kemungkinan e
                    ON (a.kd_kemungkinan = e.kd_kemungkinan)
                 LEFT JOIN r_area_dampak f
                    ON (a.kd_area_dampak = f.kd_area_dampak)
                 LEFT JOIN r_lvl_dampak g
                    ON (a.kd_lvl_dampak = g.kd_lvl_dampak)
                 LEFT JOIN r_matriks_risiko h
                    ON (a.kd_kemungkinan = h.kd_kemungkinan AND a.kd_lvl_dampak = h.kd_lvl_dampak)
                 LEFT JOIN t_prioritas_risiko i
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
           WHERE a.tahun = '2024') x
   --WHERE x.id_unitdtl LIKE '31.2%'
   --WHERE x.is_badan = 0
   WHERE x.tahun IS NOT NULL AND x.id_unitdtl LIKE '31.2%'                                                                                                --AND x.is_badan IN (0, 1)
ORDER BY id_unit ASC, id_unitdtl ASC, prioritas ASC;

SELECT NULL AS id,
       NULL AS tahun,
       NULL AS id_unit,
       NULL AS id_sasaran,
       NULL AS nm_sasaran,
       NULL AS is_badan,
       NULL AS snum,
       NULL AS kejadian,
       NULL AS penyebab,
       NULL AS dampak,
       NULL AS kategori_risiko,
       NULL AS pengendalian,
       NULL AS lvl_kemungkinan,
       NULL AS ket_kemungkinan,
       NULL AS lvl_dampak,
       NULL AS ket_dampak,
       NULL AS lvl_risiko,
       NULL besaran,
       NULL AS prioritas,
       NULL AS keputusan,
       NULL AS nama_iru,
       NULL AS batas_iru
  FROM DUAL;

SELECT a.id_unit, a.kejadian, b.nilai_risiko
  FROM t_kriteria_risiko a LEFT JOIN r_matriks_risiko b ON (a.kd_kemungkinan = b.kd_kemungkinan AND a.kd_lvl_dampak = b.kd_lvl_dampak)
 WHERE a.tahun = '2024' AND b.nilai_risiko < 12;

SELECT id,
       nm_iru,
       jenis_iru,
       batas_bawah_iru,
       batas_aman_iru,
       batas_atas_iru,
       jenis_formula,
       formula_jumlah,
       formula_pembilang,
       formula - penyebut,
       stuan_ukur,
       pjawab,
       penyedia,
       sumber
  FROM t_kriteria_iru
 WHERE id_risiko IN (SELECT a.id
                       FROM t_kriteria_risiko a LEFT JOIN r_matriks_risiko b ON (a.kd_kemungkinan = b.kd_kemungkinan AND a.kd_lvl_dampak = b.kd_lvl_dampak)
                      WHERE a.tahun = '2024' AND b.nilai_risiko < 12);

SELECT *
  FROM t_reviu_iru
 WHERE tahun = '2024'
/* Formatted on 13/11/2024 14:30:05 (QP5 v5.391) */
SELECT tahun, id AS id_program, uraian
  FROM t_epite
 WHERE tahun = :p_tahun;

  SELECT a.id,
         a.kode,
         a.nm_faktor,
         TRIM (a.kode_faktor_dtl) kode_faktor_dtl,
         a.nm_faktor_dtl,
         TRIM (a.kode_faktor_dtl_butir) kode_faktor_dtl_butir,
         a.nm_faktor_dtl_butir,
         a.rev,
         a.wwc,
         a.sur,
         a.obs,
         NVL (a.rev_nilai, 2) AS rev_nilai,
         NVL (a.wwc_nilai, 2) AS wwc_nilai,
         NVL (a.sur_nilai, 2) AS sur_nilai,
         NVL (a.obs_nilai, 2) AS obs_nilai,
         a.skor_akhir,
         a.kesimpulan,
         a.jawaban,
         CASE
             WHEN a.skor_akhir IS NOT NULL THEN a.skor_akhir
             WHEN a.rev_nilai IS NULL AND a.wwc_nilai IS NULL AND a.sur_nilai IS NULL AND a.obs_nilai IS NULL THEN NULL
             ELSE a.rev_nilai * a.wwc_nilai * a.sur_nilai * a.obs_nilai
         END AS skor,
         (a.kode || a.kode_faktor_dtl || a.kode_faktor_dtl_butir) AS kode_unik,
         a.id_unit,
         a.id_program
    FROM (SELECT a.id,
                 c.kode AS kode,
                 c.nm_faktor AS nm_faktor,
                 b.kode AS kode_faktor_dtl,
                 b.nm_faktor_dtl,
                 a.kode AS kode_faktor_dtl_butir,
                 a.nm_faktor_dtl_butir,
                 a.rev,
                 a.wwc,
                 a.sur,
                 a.obs,
                 NVL (d.nilai, 1) AS rev_nilai,
                 NVL (e.nilai, 1) AS wwc_nilai,
                 NVL (f.nilai, 1) AS sur_nilai,
                 NVL (g.nilai, 1) AS obs_nilai,
                 NVL (h.skor, 0) AS skor_akhir,
                 h.kesimpulan,
                 a.jawaban,
                 h.id_unit,
                 h.id_program
            FROM r_faktor_dtl_butir a
                 LEFT OUTER JOIN r_faktor_dtl b ON (a.id_faktor_dtl = b.id)
                 LEFT OUTER JOIN r_faktor c ON (b.id_faktor = c.id)
                 LEFT OUTER JOIN ( --/**ambil data reviu dokumen**/
                                  SELECT a.id_faktor, a.simpulan AS nilai
                                    FROM ic_epite_reviu_dokumen a LEFT JOIN ic_epite_rev_header b ON (a.id_reviu = b.id) --/*WHERE b.id_program = :p_id*/
                                                                                                                        ) d
                     ON (a.id = d.id_faktor)
                 LEFT OUTER JOIN ( --/**ambil data wawancara**/
                                  SELECT a.id_faktor, a.simpulan AS nilaixxx, CASE WHEN a.simpulan = NULL THEN 0 WHEN LENGTH (a.simpulan) > 0 THEN 1 END AS nilai
                                    FROM ic_epite_wawancara a LEFT JOIN ic_epite_waw_header b ON (a.id_wawancara = b.id) --/*WHERE b.id_program = :p_id*/
                                                                                                                        ) e
                     ON (a.id = e.id_faktor)
                 LEFT OUTER JOIN ( --/**ambil data survei**/
                                  SELECT a.id_faktor, a.simpulan AS nilai
                                    FROM ic_epite_srv_detail a LEFT JOIN ic_epite_srv_header b ON (a.id_survey = b.id) --/*(WHERE b.id_program = :p_id*/
                                                                                                                      ) f
                     ON (a.id = f.id_faktor)
                 LEFT OUTER JOIN ( --/**ambil data observasi**/
                                  SELECT a.id_faktor, a.simpulan AS nilai
                                    FROM ic_epite_observasi a LEFT JOIN ic_epite_obs_header b ON (a.id_observasi = b.id) --/*WHERE b.id_program = :p_id*/
                                                                                                                        ) g
                     ON (a.id = g.id_faktor)
                 LEFT OUTER JOIN ( --/**ambil data yang sudah disimpan**/
                                  SELECT a.id_faktor_dtl_butir,
                                         a.skor,
                                         a.kesimpulan,
                                         b.id_unitdtl AS id_unit,
                                         b.id AS id_program
                                    FROM t_epite_hasil a
                                         LEFT OUTER JOIN (SELECT *
                                                            FROM t_epite
                                                           WHERE tahun = '2024') b
                                             ON (a.id_epite = b.id) --/*WHERE b.tahun = :p_tahun AND b.id = :p_id*/
                                                                   ) h
                     ON (a.id = h.id_faktor_dtl_butir)) a
   WHERE id_unit IS NOT NULL
ORDER BY a.id_unit,
         a.id_program,
         kode_unik,
         a.id ASC;
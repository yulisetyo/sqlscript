/* Formatted on 04/02/2023 05:21:36 (QP5 v5.215.12089.38647) */
SELECT * FROM kur_t_akad;

SELECT * FROM kur_r_wilayah_propinsi;

SELECT kode_wilayah || '00' AS kode_prov FROM kur_r_wilayah_propinsi;

  SELECT *
    FROM kur_r_skema
ORDER BY skema;

SELECT * FROM kur_r_sektor;

SELECT * FROM kur_r_sektor_group;

SELECT * FROM kur_t_debitur;

SELECT * FROM kur_t_balance;

  SELECT kode_bank,
         kode_prov,
         nama_prov,
         lbu,
         nm_lbu,
         /*** TOTAL ***/
         SUM (CASE WHEN thn_akad <= '2022' AND skema IN (SELECT skema FROM kur_r_skema) THEN nilai_akad ELSE 0 END) AS ttl_plf_ak,
         SUM (CASE WHEN thn_akad = '2022' AND skema IN (SELECT skema FROM kur_r_skema) THEN nilai_akad ELSE 0 END) AS ttl_plf_tb,
         SUM (CASE WHEN thn_akad <= '2022' AND skema IN (SELECT skema FROM kur_r_skema) THEN outstanding ELSE 0 END) AS ttl_out_ak,
         SUM (CASE WHEN thn_akad = '2022' AND skema IN (SELECT skema FROM kur_r_skema) THEN outstanding ELSE 0 END) AS ttl_out_tb,
         SUM (CASE WHEN thn_akad <= '2022' AND skema IN (SELECT skema FROM kur_r_skema) THEN cnt ELSE 0 END) AS ttl_deb_ak,
         SUM (CASE WHEN thn_akad = '2022' AND skema IN (SELECT skema FROM kur_r_skema) THEN cnt ELSE 0 END) AS ttl_deb_tb,
         /*ROUND (AVG (CASE WHEN thn_akad <= '2022' AND skema IN (SELECT skema FROM kur_r_skema) THEN npl_rasio ELSE 0 END), 2) AS ttl_psn_npl_ak,*/
         /*ROUND (AVG (CASE WHEN thn_akad = '2022' AND skema IN (SELECT skema FROM kur_r_skema) THEN npl_rasio ELSE 0 END), 2) AS ttl_psn_npl_tb,*/
         /*SUM (CASE WHEN thn_akad <= '2022' AND skema IN (SELECT skema FROM kur_r_skema) THEN npl_nominal ELSE 0 END) AS ttl_nom_npl_ak,*/
         /*SUM (CASE WHEN thn_akad = '2022' AND skema IN (SELECT skema FROM kur_r_skema) THEN npl_nominal ELSE 0 END) AS ttl_nom_npl_tb,*/
         /*** SUPER MIKRO ***/
         SUM (CASE WHEN thn_akad <= '2022' AND skema IN ('51', '52') THEN nilai_akad ELSE 0 END) AS sup_plf_ak,
         SUM (CASE WHEN thn_akad = '2022' AND skema IN ('51', '52') THEN nilai_akad ELSE 0 END) AS sup_plf_tb,
         SUM (CASE WHEN thn_akad <= '2022' AND skema IN ('51', '52') THEN outstanding ELSE 0 END) AS sup_out_ak,
         SUM (CASE WHEN thn_akad = '2022' AND skema IN ('51', '52') THEN outstanding ELSE 0 END) AS sup_out_tb,
         SUM (CASE WHEN thn_akad <= '2022' AND skema IN ('51', '52') THEN cnt ELSE 0 END) AS sup_deb_ak,
         SUM (CASE WHEN thn_akad = '2022' AND skema IN ('51', '52') THEN cnt ELSE 0 END) AS sup_deb_tb,
         /*ROUND (AVG (CASE WHEN thn_akad <= '2022' AND skema IN ('51', '52') THEN npl_rasio ELSE 0 END), 2) AS sup_psn_npl_ak,*/
         /*ROUND (AVG (CASE WHEN thn_akad = '2022' AND skema IN ('51', '52') THEN npl_rasio ELSE 0 END), 2) AS sup_psn_npl_tb,*/
         /*SUM (CASE WHEN thn_akad <= '2022' AND skema IN ('51', '52') THEN npl_nominal ELSE 0 END) AS sup_nom_npl_ak,*/
         /*SUM (CASE WHEN thn_akad = '2022' AND skema IN ('51', '52') THEN npl_nominal ELSE 0 END) AS sup_nom_npl_tb,*/
         /*** MIKRO ***/
         SUM (CASE WHEN thn_akad <= '2022' AND skema IN ('11', '12') THEN nilai_akad ELSE 0 END) AS mik_plf_ak,
         SUM (CASE WHEN thn_akad = '2022' AND skema IN ('11', '12') THEN nilai_akad ELSE 0 END) AS mik_plf_tb,
         SUM (CASE WHEN thn_akad <= '2022' AND skema IN ('11', '12') THEN outstanding ELSE 0 END) AS mik_out_ak,
         SUM (CASE WHEN thn_akad = '2022' AND skema IN ('11', '12') THEN outstanding ELSE 0 END) AS mik_out_tb,
         SUM (CASE WHEN thn_akad <= '2022' AND skema IN ('11', '12') THEN cnt ELSE 0 END) AS mik_deb_ak,
         SUM (CASE WHEN thn_akad = '2022' AND skema IN ('11', '12') THEN cnt ELSE 0 END) AS mik_deb_tb,
         /*ROUND (AVG (CASE WHEN thn_akad <= '2022' AND skema IN ('11', '12') THEN npl_rasio ELSE 0 END), 2) AS mik_psn_npl_ak,*/
         /*ROUND (AVG (CASE WHEN thn_akad = '2022' AND skema IN ('11', '12') THEN npl_rasio ELSE 0 END), 2) AS mik_psn_npl_tb,*/
         /*SUM (CASE WHEN thn_akad <= '2022' AND skema IN ('11', '12') THEN npl_nominal ELSE 0 END) AS mik_nom_npl_ak,*/
         /*SUM (CASE WHEN thn_akad = '2022' AND skema IN ('11', '12') THEN npl_nominal ELSE 0 END) AS mik_nom_npl_tb,*/
         /*** KECIL ***/
         SUM (CASE WHEN thn_akad <= '2022' AND skema IN ('31', '32') THEN nilai_akad ELSE 0 END) AS kec_plf_ak,
         SUM (CASE WHEN thn_akad = '2022' AND skema IN ('31', '32') THEN nilai_akad ELSE 0 END) AS kec_plf_tb,
         SUM (CASE WHEN thn_akad <= '2022' AND skema IN ('31', '32') THEN outstanding ELSE 0 END) AS kec_out_ak,
         SUM (CASE WHEN thn_akad = '2022' AND skema IN ('31', '32') THEN outstanding ELSE 0 END) AS kec_out_tb,
         SUM (CASE WHEN thn_akad <= '2022' AND skema IN ('31', '32') THEN cnt ELSE 0 END) AS kec_deb_ak,
         SUM (CASE WHEN thn_akad = '2022' AND skema IN ('31', '32') THEN cnt ELSE 0 END) AS kec_deb_tb,
         /*ROUND (AVG (CASE WHEN thn_akad <= '2022' AND skema IN ('31', '32') THEN npl_rasio ELSE 0 END), 2) AS kec_psn_npl_ak,*/
         /*ROUND (AVG (CASE WHEN thn_akad = '2022' AND skema IN ('31', '32') THEN npl_rasio ELSE 0 END), 2) AS kec_psn_npl_tb,*/
         /*SUM (CASE WHEN thn_akad <= '2022' AND skema IN ('31', '32') THEN npl_nominal ELSE 0 END) AS kec_nom_npl_ak,*/
         /*SUM (CASE WHEN thn_akad = '2022' AND skema IN ('31', '32') THEN npl_nominal ELSE 0 END) AS kec_nom_npl_tb,*/
         /*** PMI ***/
         SUM (CASE WHEN thn_akad <= '2022' AND skema IN ('20') THEN nilai_akad ELSE 0 END) AS pmi_plf_ak,
         SUM (CASE WHEN thn_akad = '2022' AND skema IN ('20') THEN nilai_akad ELSE 0 END) AS pmi_plf_tb,
         SUM (CASE WHEN thn_akad <= '2022' AND skema IN ('20') THEN outstanding ELSE 0 END) AS pmi_out_ak,
         SUM (CASE WHEN thn_akad = '2022' AND skema IN ('20') THEN outstanding ELSE 0 END) AS pmi_out_tb,
         SUM (CASE WHEN thn_akad <= '2022' AND skema IN ('20') THEN cnt ELSE 0 END) AS pmi_deb_ak,
         SUM (CASE WHEN thn_akad = '2022' AND skema IN ('20') THEN cnt ELSE 0 END) AS pmi_deb_tb
		 /*ROUND (AVG (CASE WHEN thn_akad <= '2022' AND skema IN ('20') THEN npl_rasio ELSE 0 END), 2) AS pmi_psn_npl_ak,*/
		 /*ROUND (AVG (CASE WHEN thn_akad = '2022' AND skema IN ('20') THEN npl_rasio ELSE 0 END), 2) AS pmi_psn_npl_tb,*/
		 /*SUM (CASE WHEN thn_akad <= '2022' AND skema IN ('20') THEN npl_nominal ELSE 0 END) AS pmi_nom_npl_ak,*/
		 /*SUM (CASE WHEN thn_akad = '2022' AND skema IN ('20') THEN npl_nominal ELSE 0 END) AS pmi_nom_npl_tb*/
    FROM (SELECT a.kode_bank,
                 a.nik,
                 a.rekening_lama,
                 a.rekening_baru,
                 TO_CHAR (a.tgl_akad, 'yyyy') AS thn_akad,
                 a.nomor_akad,
                 a.nilai_akad,
                 e.kode_kabkota,
                 SUBSTR (e.kode_kabkota, 1, 2) || '00' AS kode_prov,
                 g.nama_wilayah AS nama_prov,
                 f.outstanding,
                 f.debet,
                 f.kredit,
                 ROUND ( (f.kredit / f.debet), 3) AS npl_rasio,
                 f.kredit AS npl_nominal,
                 TO_CHAR (f.tgl_pencairan, 'dd-mm-yyyy') AS tgl_pencairan,
                 TO_CHAR (f.tgl_pelunasan, 'dd-mm-yyyy') AS tgl_pelunasan,
                 TO_CHAR (a.tgl_jatuh_tempo, 'dd-mm-yyyy') AS tgl_jatuh_tempo,
                 a.skema,
                 b.deskripsi AS nm_skema,
                 c.sektor2 AS lbu,
                 d.deskripsi2 AS nm_lbu,
                 1 AS cnt
            FROM kur_t_akad PARTITION (bank014) a
                 LEFT JOIN kur_r_skema b
                    ON (a.skema = b.skema)
                 LEFT JOIN kur_r_sektor c
                    ON (a.sektor = c.sektor)
                 LEFT JOIN kur_r_sektor_group d
                    ON (c.sektor2 = d.sektor2)
                 LEFT JOIN kur_t_debitur e
                    ON (a.nik = e.nik AND a.kode_bank = e.kode_bank)
                 LEFT JOIN kur_t_balance f
                    ON (a.rekening_baru = f.nomor_rekening AND a.kode_bank = f.kode_bank AND SUBSTR (a.skema, 1, 1) = f.skema)
                 LEFT JOIN kur_r_wilayah_propinsi g
                    ON (SUBSTR (e.kode_kabkota, 1, 2) = g.kode_wilayah)
           WHERE e.kode_kabkota IS NOT NULL)
   WHERE kode_prov IN (SELECT kode_wilayah || '00' FROM kur_r_wilayah_propinsi) /*('1500', '1600', '1700', '1800', '1900', '2100', '3100', '3200', '3300', '3400', '3500', '3600')*/
GROUP BY kode_bank,
         kode_prov,
         nama_prov,
         lbu,
         nm_lbu
ORDER BY kode_prov, lbu;

/* Formatted on 04/02/2023 07:42:44 (QP5 v5.215.12089.38647) */
  SELECT kode_prov,
         nama_prov,
         skema,
         lbu,
         SUM (CASE WHEN thn_akad <= '2022' THEN nilai_akad ELSE 0 END) AS nil_akad_sd_2022,
         SUM (CASE WHEN thn_akad = '2022' THEN nilai_akad ELSE 0 END) AS nil_akad_di_2022,
         SUM (CASE WHEN thn_akad <= '2022' THEN cnt ELSE 0 END) AS jml_akad_sd_2022,
         SUM (CASE WHEN thn_akad = '2022' THEN cnt ELSE 0 END) AS jml_akad_di_2022
    FROM (SELECT a.kode_bank,
                 a.nik,
                 a.rekening_lama,
                 a.rekening_baru,
                 TO_CHAR (a.tgl_akad, 'yyyy') AS thn_akad,
                 a.nomor_akad,
                 a.nilai_akad,
                 e.kode_kabkota,
                 SUBSTR (e.kode_kabkota, 1, 2) || '00' AS kode_prov,
                 g.nama_wilayah AS nama_prov,
                 f.outstanding,
                 f.debet,
                 f.kredit,
                 ROUND ( (f.kredit / f.debet), 3) AS npl_rasio,
                 f.kredit AS npl_nominal,
                 TO_CHAR (f.tgl_pencairan, 'dd-mm-yyyy') AS tgl_pencairan,
                 TO_CHAR (f.tgl_pelunasan, 'dd-mm-yyyy') AS tgl_pelunasan,
                 TO_CHAR (a.tgl_jatuh_tempo, 'dd-mm-yyyy') AS tgl_jatuh_tempo,
                 a.skema,
                 b.deskripsi AS nm_skema,
                 c.sektor2 AS lbu,
                 d.deskripsi2 AS nm_lbu,
                 1 AS cnt
            FROM kur_t_akad PARTITION (bank008) a
                 LEFT JOIN kur_r_skema b
                    ON (a.skema = b.skema)
                 LEFT JOIN kur_r_sektor c
                    ON (a.sektor = c.sektor)
                 LEFT JOIN kur_r_sektor_group d
                    ON (c.sektor2 = d.sektor2)
                 LEFT JOIN kur_t_debitur e
                    ON (a.nik = e.nik AND a.kode_bank = e.kode_bank)
                 LEFT JOIN kur_t_balance f
                    ON (a.rekening_baru = f.nomor_rekening AND a.kode_bank = f.kode_bank AND SUBSTR (a.skema, 1, 1) = f.skema)
                 LEFT JOIN kur_r_wilayah_propinsi g
                    ON (SUBSTR (e.kode_kabkota, 1, 2) = g.kode_wilayah)
           WHERE e.kode_kabkota IN (SELECT kode_kabkota FROM kur_r_wilayah)                                                                                                    /***/
                                                                           )
GROUP BY kode_prov,
         nama_prov,
         skema,
         lbu
ORDER BY kode_prov, skema, lbu
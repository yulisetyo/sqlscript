/* Formatted on 18/11/2024 12:43:50 (QP5 v5.215.12089.38647) */
SELECT *
  FROM tab
 WHERE LOWER (tname) LIKE '%trpu%';

  SELECT *
    FROM t_ttj
   WHERE SUBSTR (kd_ttj, 1, 1) = '2'
ORDER BY kd_ttj;

SELECT * FROM ic_r_probis_giat_kendali;

SELECT * FROM d_menu_m;

SELECT * FROM ic_r_probis_giat;

  SELECT a.id, a.uraian
    FROM ic_r_probis_giat a
ORDER BY id ASC;

SELECT * FROM ic_r_probis_giat_kendali;

  SELECT a.id_probis_giat,
         b.uraian AS nm_kegiatan,
         a.uraian AS pengendalian,
         a.aup,
         a.aul,
         a.penetapan_kendali,
         a.tujuan_kendali,
         a.jenis_kendali,
         a.pelaksana_kendali
    FROM ic_r_probis_giat_kendali a LEFT JOIN ic_r_probis_giat b ON (a.id_probis_giat = b.id)
ORDER BY a.id_probis_giat ASC;

SELECT * FROM ic_r_probis_giat_kendali_trpu;

SELECT * FROM ic_t_dupu;

SELECT * FROM ic_t_dupu_dtl;

SELECT * FROM ic_t_dupu_dtl_trpu;

SELECT * FROM ic_t_dupu_dtl_topu;

/* Formatted on 18/11/2024 13:01:35 (QP5 v5.215.12089.38647) */
SELECT *
  FROM ic_r_probis_giat_kendali_trpu
 WHERE id_probis_giat_kendali = (SELECT id_probis_giat_kendali
                                   FROM IC_T_DUPU
                                  WHERE id = :id_dupu);

  SELECT a.*, b.kondisi, b.akurat
    FROM     (-- list pertanyaan
              SELECT a.*
                FROM ic_r_probis_giat_kendali_trpu a
               WHERE a.id_probis_giat_kendali = (SELECT id_probis_giat_kendali
                                                   FROM ic_t_dupu
                                                  WHERE id = 2)) a
         LEFT JOIN
             (-- list jawaban
              SELECT a.id_probis_giat_kendali_trpu, a.kondisi, a.akurat
                FROM ic_t_dupu_dtl_trpu a
               WHERE a.id_dupu_dtl = 21) b
         ON (a.id = b.id_probis_giat_kendali_trpu)
ORDER BY a.id

/*
IC_R_PROBIS_GIAT
IC_R_PROBIS_GIAT_KENDALI

T_EPITE_WAWANCARA_DTL    TABLE    
T_EPITE_WAWANCARA    TABLE    
T_EPITE_SURVEY_DTL    TABLE    
T_EPITE_SURVEY    TABLE    
T_EPITE_REVIEW_DTL    TABLE    
T_EPITE_REVIEW    TABLE    
T_EPITE_PANTAU    TABLE    
T_EPITE_OBSERVASI_DTL    TABLE    
T_EPITE_OBSERVASI    TABLE    
T_EPITE_LANGKAH    TABLE    
T_EPITE_KODE_ETIK    TABLE    
T_EPITE_KESIMPULAN    TABLE    
T_EPITE_HASIL    TABLE    
T_EPITE    TABLE    
TEMP_R_FAKTOR_EPITE    TABLE    
R_EPITE_HASIL    TABLE    
IC_R_FAKTOR_EPITE    TABLE    
IC_EPITE_WAW_HEADER    TABLE    
IC_EPITE_WAWANCARA    TABLE    
IC_EPITE_SURVEY    TABLE    
IC_EPITE_SRV_HEADER    TABLE    
IC_EPITE_SRV_DETAIL    TABLE    
IC_EPITE_REV_HEADER    TABLE    
IC_EPITE_REVIU_DOKUMEN    TABLE    
IC_EPITE_PROGRAM_KERJA    TABLE    
IC_EPITE_OBS_HEADER    TABLE    
IC_EPITE_OBSERVASI    TABLE    
IC_EPITE_LANGKAH    TABLE    
*/
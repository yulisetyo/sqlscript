/* Formatted on 11/09/2025 18:05:30 (QP5 v5.215.12089.38647) */
  SELECT *
    FROM tab
   WHERE LOWER (tname) LIKE '%rm_t%'
ORDER BY 1;

SELECT * FROM RM_T_RISK_FAK;

SELECT * FROM RM_T_RISK_UNIT_FAK;

SELECT a.*, DBMS_LOB.SUBSTR (uraian, 255) uraian
  FROM rm_t_risk_fak_mtg a;

SELECT id, id_risk_fak, kdmtg
  FROM rm_t_risk_fak_mtg a
 WHERE id_risk_fak = 68 AND kdmtg = '03';

SELECT * FROM rm_t_risk_fak_mtg_aksi;

SELECT a.id,
       a.id_risk_fak_mtg,
       b.kdmtg,
       c.nmmtg,
       DBMS_LOB.SUBSTR (b.uraian, 255) AS urmtg,
       a.uraian,
       a.nourut
  FROM rm_t_risk_fak_mtg_aksi a
       LEFT JOIN rm_t_risk_fak_mtg b
           ON (a.id_risk_fak_mtg = b.id)
       LEFT JOIN rm_r_mtg c
           ON (b.kdmtg = c.kdmtg)
 WHERE a.id_risk_fak_mtg = '';


SELECT a.id,
       a.id_risk_tema,
       a.uraian,
       a.kd_ktg_risiko,
       a.ir_kemungkinan,
       a.ir_dampak,
       a.ir_nilai,
       a.rc_besaran,
       a.rc_level,
       a.nilai_rp,
       a.nilai_ra,
       a.status,
       a.id_user,
       a.nourut,
       b.id_risk_unit
  FROM rm_t_risk_fak a LEFT JOIN rm_t_risk_unit_fak b ON (a.id = b.id_risk_fak)
 WHERE a.id = 81;

  SELECT *
    FROM rm_t_risk_unit
ORDER BY id DESC;

SELECT id,
       no_dok,
       TO_CHAR (tgl_dok, 'yyyy-mm-dd') tgl_dok,
       keterangan,
       status
  FROM rm_t_risk_unit;

SELECT * FROM rm_t_risk_unit_fak;

SELECT id_risk_unit
  FROM rm_t_risk_unit_fak
 WHERE id_risk_unit = 81;

SELECT id_risk_fak
  FROM rm_t_risk_fak_mtg
 WHERE id_risk_fak = 81;

  SELECT a.id,
         a.id_risk_tema,
         b.uraian AS tema_risiko,
         a.uraian AS faktor_risiko,
         a.kd_ktg_risiko,
         d.nm_ktg_risiko,
         a.ir_kemungkinan,
         a.ir_dampak,
         a.ir_nilai,
         c.nilai_risiko,
         a.rc_besaran,
         a.rc_level,
         f.nama_rc,
         a.nilai_rp,
         a.nilai_ra,
         a.status,
         a.id_user,
         a.nourut
    FROM rm_t_risk_fak a
         LEFT JOIN rm_t_risk_tema b
             ON (a.id_risk_tema = b.id)
         LEFT JOIN r_matriks_risiko_2020 c
             ON (a.ir_kemungkinan = c.kd_kemungkinan AND a.ir_dampak = c.kd_lvl_dampak)
         LEFT JOIN r_ktg_risiko d
             ON (a.kd_ktg_risiko = d.kd_ktg_risiko)
         LEFT JOIN rm_r_rc f
             ON (a.rc_level = f.level_rc)
   WHERE a.id IS NOT NULL
ORDER BY id DESC;

SELECT nilai_risiko, LOWER (color) warna
  FROM r_matriks_risiko_2020
 WHERE kd_lvl_dampak = '04' AND kd_kemungkinan = '03';

SELECT kd_lvl_risiko AS kd_level, nm_lvl_risiko AS nm_level, TO_NUMBER (kd_lvl_risiko) AS risk_level
  FROM r_lvl_risiko
 WHERE LOWER (warna) = 'ff9934';

SELECT id_risk_tema, NVL (nextid, 0) nextid
  FROM (  SELECT id_risk_tema, MAX (id) nextid
            FROM rm_t_risk_fak
           WHERE id_risk_tema = 0
        GROUP BY id_risk_tema);


SELECT level_ir,
       nama_ir,
       ir_nilai_awal,
       ir_nilai_akhir
  FROM rm_r_ir;

SELECT level_rc,
       nama_rc,
       rc_nilai_awal,
       rc_nilai_akhir
  FROM rm_r_rc;

SELECT * FROM rm_r_rp;


/* query mendapatkan ir_nilai dari ir_dampak='04' dan ir_kemungkinan='04'*/

SELECT nilai_risiko AS ir_nilai, LOWER (color) warna
  FROM r_matriks_risiko_2020
 WHERE kd_lvl_dampak = '04' AND kd_kemungkinan = '04';

 --hasilnya ir_nilai sebesar 19


/* query mendapatkan rc_besaran berdasarkan ir_nilai=19 */

SELECT level_ir, nama_ir
  FROM rm_r_ir
 WHERE 19 BETWEEN ir_nilai_awal AND ir_nilai_akhir;

 --hasilnya ir_level sebesar 4


-- misal rc_besaran yng diinput adalah 24
-- query untuk mendapatkan rc_level dari rc_besaran=24

SELECT level_rc, nama_rc
  FROM rm_r_rc
 WHERE 24 BETWEEN rc_nilai_awal AND rc_nilai_akhir;

 -- hasilnya rc_level sebesar 5
-- query untuk mendapatkan nilai_rp berdasarkan ir_level dan rc_level

SELECT risk_profile AS nilai_rp
  FROM rm_r_rp
 WHERE level_ir = 4 AND level_rc = 5;

  SELECT a.id,
         a.id_risk_fak,
         c.uraian AS ur_faktor,
         a.kdmtg,
         b.nmmtg,
         a.uraian,
         a.catatan
    FROM rm_t_risk_fak_mtg a
         LEFT JOIN rm_r_mtg b
             ON (a.kdmtg = b.kdmtg)
         LEFT JOIN rm_t_risk_fak c
             ON (a.id_risk_fak = c.id)
ORDER BY id DESC;

SELECT a.id,
       a.id_risk_unit,
       a.periode,
       a.no_dok,
       a.tgl_dok,
       a.ket,
       a.status,
       a.id_user
  FROM rm_t_risk_unit_lpmr a
 WHERE a.id = 22;

  SELECT periode, nama, nama1 AS kuarter
    FROM r_periode
ORDER BY periode ASC;

/*
table RM_T_RISK_FAK
- ID_RISK_TEMA: diambilkan dari dropdown RM_T_RISK_TEMA
- URAIAN: diisi inputan bebas
- KD_KTG_RISIKO: dari dropdown ref kategori risiko
- IR_KEMUNGKINAN: dari dropdown ref kemungkinan
- IR_DAMPAK: dari dropdown ref level dampak
- IR_NILAI: dari kombinasi kemungkinan dan level dampak
- RC_BESARAN: sementara input manual -> rc_besaran dipetakan klasifikasi mitigasi risiko, maka dapatlah levelnya 
- RC_LEVEL: dari rc_besaran lalu dipetakan ke referensi level
- NILAI_RP: (risk profile/profil risiko) didapatkan dari kombinasi inherent risk dan risk mitigation/control dalam bentuk risk heat map
- NILAI_RA: (risk appetite/selera risiko) input manual
- STATUS: default 0
- ID_USER: dari session
*/

/*
                // $inserted = DB::table('rm_t_risk_fak')->insert($data);
                // $inserted = DB::insert("
                //     INSERT INTO rm_t_risk_fak (id_risk_tema,
                //                                uraian,
                //                                kd_ktg_risiko,
                //                                ir_kemungkinan,
                //                                ir_dampak,
                //                                ir_nilai,
                //                                rc_besaran,
                //                                rc_level,
                //                                nilai_rp,
                //                                nilai_ra,
                //                                status,
                //                                id_user,
                //                                nourut)
                //          VALUES (?,
                //                  ?,
                //                  ?,
                //                  ?,
                //                  ?,
                //                  ?,
                //                  ?,
                //                  ?,
                //                  ?,
                //                  ?,
                //                  ?,
                //                  ?,
                //                  ?)
                // ", [
                //     $id_risk_tema,
                //     $inp['uraian'],
                //     $inp['kd_ktg_risiko'],
                //     $ir_kemungkinan,
                //     $ir_dampak,
                //     $ir_nilai,
                //     $rc_besaran,
                //     $rc_level,
                //     $nilai_rp,
                //     $nilai_ra,
                //     $status,
                //     $id_user,
                //     $nourut
                // ]);
*/

SELECT * FROM rm_r_mtg;

SELECT * FROM rm_r_ir;

SELECT * FROM rm_r_rc;

SELECT * FROM rm_r_rp;

SELECT id,
       id_risk_unit_lpmr,
       id_risk_fak,
       ir_kemungkinan,
       ir_dampak,
       ir_nilai,
       rc_besaran,
       rc_level,
       nilai_rp,
       nilai_ra,
       id_user
  FROM rm_t_risk_unit_lpmr_fak;

  SELECT a.id,
         a.id_risk_unit_lpmr,
         a.id_risk_fak,
         a.ir_kemungkinan,
         a.ir_dampak,
         a.ir_nilai,
         a.rc_besaran,
         a.rc_level,
         a.nilai_rp,
         a.nilai_ra,
         a.id_user,
         a.ir_kemungkinan || '-' || b.nm_kemungkinan AS nm_kemungkinan,
         a.ir_dampak || '-' || c.nm_lvl_dampak AS nm_lvl_dampak,
         d.uraian AS risk_fak
    FROM rm_t_risk_unit_lpmr_fak a
         LEFT JOIN r_kemungkinan b
             ON (a.ir_kemungkinan = b.kd_kemungkinan)
         LEFT JOIN r_lvl_dampak c
             ON (a.ir_dampak = c.kd_lvl_dampak)
         LEFT JOIN rm_t_risk_fak d
             ON (a.id_risk_fak = d.id)
   WHERE a.id_risk_unit_lpmr = 1
ORDER BY id ASC;

  SELECT a.id,
         a.id_risk_unit_lpmr,
         a.id_risk_fak_mtg,
         a.skor,
         a.id_user,
         b.ur_risk_fak_mtg
    FROM     rm_t_risk_unit_lpmr_mtg a
         LEFT JOIN
             (SELECT id AS id_risk_fak_mtg, DBMS_LOB.SUBSTR (uraian) AS ur_risk_fak_mtg FROM rm_t_risk_fak_mtg) b
         ON (a.id_risk_fak_mtg = b.id_risk_fak_mtg)
   WHERE a.id_risk_unit_lpmr = 1
ORDER BY id ASC;

SELECT a.id,
       a.id_risk_unit_lpmr,
       a.id_risk_fak_mtg,
       a.skor,
       a.id_user
  FROM rm_t_risk_unit_lpmr_mtg a
 WHERE a.id = 1;

SELECT id,
       id_risk_unit_lpmr,
       id_risk_fak_mtg_aksi,
       hasil_mitigasi,
       rencana_mitigasi,
       output,
       pic,
       jadwal,
       id_user
  FROM rm_t_risk_unit_lpmr_aksi;

SELECT * FROM rm_r_rc;

  SELECT a.id, a.id_risk_fak, (b.nm_risk_fak || ' | ' || DBMS_LOB.SUBSTR (a.uraian, 255)) uraian
    FROM rm_t_risk_fak_mtg a LEFT JOIN (SELECT id AS id_risk_fak, uraian AS nm_risk_fak FROM rm_t_risk_fak) b ON (a.id_risk_fak = b.id_risk_fak)
ORDER BY id_risk_fak ASC, id ASC;


  SELECT id, uraian
    FROM rm_t_risk_fak_mtg_aksi
ORDER BY id
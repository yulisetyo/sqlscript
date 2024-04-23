/* Formatted on 26/09/2023 17:04:52 (QP5 v5.215.12089.38647) */
SELECT *
  FROM tab
 WHERE LOWER (tname) LIKE '%grup%';


--mpt_t_status;
--mp_r_status;

SELECT a.kdgrup,
       a.kddept,
       a.kdunit,
       CASE WHEN SUBSTR (a.kdgrup, 3, 2) = '00' THEN b.nmdept WHEN SUBSTR (a.kdgrup, 3, 2) != '00' THEN c.nmunit || ' ' || b.nmdept ELSE 'unregistered' END AS nmgrup
  FROM mp_r_grup a
       LEFT JOIN t_dept b
          ON (a.kddept = b.kddept)
       LEFT JOIN t_unit c
          ON (a.kddept = c.kddept AND a.kdunit = c.kdunit);

SELECT a.kdsatker, b.nmsatker, b.kdkppn
  FROM mpt_r_satker a LEFT JOIN t_satker b ON (a.kdsatker = b.kdsatker);

  SELECT a.id,
         a.kdgrup,
         a.thang,
         NVL (TO_CHAR (a.tgsurat, 'dd-mm-yyyy'), '01-01-9999') AS tgl_surat,
         NVL (a.ketsurat, '-') AS ket_surat,
         NVL (a.batasalokasi, 0) AS batas_alokasi,
         NVL (a.nilaialokasi, 0) AS nilai_alokasi,
         NVL (a.sisa_tayl, 0) AS sisa_tayl,
         NVL (a.guna_tayl, 0) AS guna_tayl,
         NVL (TO_CHAR (a.tgl_alokasi, 'dd-mm-yyyy'), '01-01-9999') AS tgl_alokasi,
         NVL (TO_CHAR (a.tgl_setuju, 'dd-mm-yyyy'), '01-01-9999') AS tgl_setuju,
         NVL (TO_CHAR (a.tgl_staf, 'dd-mm-yyyy'), '01-01-9999') AS tgl_staf,
         NVL (a.ket_staf, '-') AS ket_staf,
         NVL (TO_CHAR (a.tgl_kasi, 'dd-mm-yyyy'), '01-01-9999') AS tgl_kasi,
         NVL (a.ket_kasi, '-') AS ket_kasi,
         NVL (TO_CHAR (a.tgl_subdit, 'dd-mm-yyyy'), '01-01-9999') AS tgl_subdit,
         NVL (a.ket_subdit, '-') AS ket_subdit,
         a.status,
         NVL (a.no_pa, '-') AS no_pa,
         NVL (TO_CHAR (a.tgl_pa, 'dd-mm-yyyy'), '01-01-9999') AS tgl_pa,
         NVL (a.nilaialokasi_sblm, '') AS nilai_alokasi_sblm,
         NVL (a.nilaialokasi_sd, '') AS nilai_alokasi_sd,
         a.nourut,
         NVL (TO_CHAR (a.tgl_dir, 'dd-mm-yyyy'), '01-01-9999') AS tgl_dir,
         NVL (a.ket_dir, '-') AS ket_dir,
         NVL (TO_CHAR (a.tgl_dirjen, 'dd-mm-yyyy'), '01-01-9999') AS tgl_dirjen,
         NVL (a.ket_dirjen, '-') AS ket_dirjen,
         NVL (a.persen, 0) AS persen,
         NVL (a.lebih_tayl, 0) AS lebih_tayl,
         NVL (a.pagu, 0) AS pagu,
         NVL (a.realisasi, 0) AS realisasi,
         NVL (a.rekomendasi, 0) AS rekomendasi,
         NVL (a.nilaialokasi_final, 0) AS nilaialokasi_final,
         NVL (a.persen_final, 0) AS persen_final,
         NVL (b.ur_status, '-') AS ur_status
    FROM mp_d_alokasi a LEFT JOIN mp_r_status b ON (a.status = b.status)
   WHERE a.thang = '2023' AND a.kdgrup = '99999'
ORDER BY TO_CHAR (a.tgsurat, 'yyyy-mm-dd') ASC;

  SELECT a.kdkanwil,
         a.kdkppn,
         a.kdsatker,
         NVL (c.nmsatker, a.kdsatker || 'Tidak ada di referensi') AS nmskatker,
         a.thang,
         NVL (a.nosurat, '-') AS no_surat,
         TO_CHAR (a.tgsurat, 'dd-mm-yyyy') AS tgl_surat,
         --TO_CHAR (a.tgsurat, 'yyyy-mm-dd') AS tgsu,
         NVL (a.ketsurat, '-') AS ket_surat,
         NVL (a.pagu, 0) AS pagu,
         NVL (a.realisasi, 0) AS realisasi,
         NVL (a.batasalokasi, 0) AS batas_alokasi,
         NVL (a.sisa_tayl, 0) AS sisa_tayl,
         NVL (a.guna_tayl, 0) AS guna_tayl,
         NVL (a.nilaialokasi, 0) AS nilai_alokasi,
         NVL (a.nilaialokasi_sblm, 0) AS nilai_alokasi_sblm,
         NVL (a.nilaialokasi_sd, 0) AS nilai_alokasi_sd,
         NVL (TO_CHAR (a.tgl_oprkanwil, 'dd-mm-yyyy'), '01-01-9999') AS tgl_oprkanwil,
         NVL (TO_CHAR (a.tgl_kasikanwil, 'dd-mm-yyyy'), '01-01-9999') AS tgl_kasi,
         NVL (a.ket_kasikanwil, '-') AS ket_kasi,
         NVL (TO_CHAR (a.tgl_kabidkanwil, 'dd-mm-yyyy'), '01-01-9999') AS tgl_kabid,
         NVL (a.ket_kabidkanwil, '-') AS ket_kabid,
         NVL (TO_CHAR (a.tgl_kakanwil, 'dd-mm-yyyy'), '01-01-9999') AS tgl_kakanwil,
         NVL (a.ket_kakanwil, '-') AS ket_kakanwil,
         NVL (TO_CHAR (a.tgl_kanwil, 'dd-mm-yyyy'), '01-01-9999') AS tgl_kanwil,
         NVL (a.no_kanwil, '-') AS no_kanwil,
         NVL (TO_CHAR (a.tgl_alokasi, 'dd-mm-yyyy'), '01-01-9999') AS tgl_alokasi,
         NVL (a.oleh_kanwil, 0) AS oleh_kanwil,
         NVL (a.kurang_final, 0) AS kurang_final,
         NVL (a.real_up, 0) AS real_up,
         NVL (a.real_tup, 0) AS real_tup,
         NVL (a.real_gup, 0) AS real_gup,
         NVL (a.real_ls, 0) AS real_ls,
         NVL (a.kembali_up, 0) AS kembali_up,
         NVL (a.persen, 0) AS persen,
         NVL (a.lebih_tayl, 0) AS lebih_tayl,
         NVL (a.rekomendasi, 0) AS rekomendasi,
         NVL (a.nilaialokasi_final, 0) AS nilai_alokasi_final,
         NVL (a.persen_final, 0) AS persen_final,
         NVL (b.ur_status, '-') AS ur_status
    FROM mpt_d_alokasi a
         LEFT JOIN mp_r_status b
            ON (a.status = b.status)
         LEFT JOIN (SELECT a.kdsatker, b.nmsatker, b.kdkppn
                      FROM mpt_r_satker a LEFT JOIN t_satker b ON (a.kdsatker = b.kdsatker)) c
            ON (a.kdsatker = c.kdsatker)
   WHERE a.thang = '2022' AND a.kdsatker = '091236'
ORDER BY TO_CHAR (a.tgsurat, 'yyyymmdd') ASC;
/* Formatted on 16/09/2021 16:47:16 (QP5 v5.215.12089.38647) */
  SELECT tname
    FROM tab
   WHERE LOWER (tname) LIKE 'kkp%'
ORDER BY 1;

SELECT * FROM kkp_t_trans_19_20;

SELECT * FROM kkp_tmp_trans_21;

SELECT * FROM kkp_t_kartu;

SELECT * FROM kkp_t_sts_tag;

  SELECT c.kdkanwil,
         SUBSTR (d.nmkanwil, 10, LENGTH (d.nmkanwil)) nmkanwil,
         SUM (CASE WHEN a.jns_byr = '01' THEN a.nilai_tag ELSE 0 END) jb01,
         SUM (CASE WHEN a.jns_byr = '02' THEN a.nilai_tag ELSE 0 END) jb02,
         SUM (CASE WHEN a.jns_byr = '03' THEN a.nilai_tag ELSE 0 END) jb03,
         SUM (CASE WHEN a.jns_byr = '04' THEN a.nilai_tag ELSE 0 END) jb04,
         SUM (CASE WHEN a.jns_byr = '05' THEN a.nilai_tag ELSE 0 END) jb05,
         SUM (CASE WHEN a.jns_byr = '06' THEN a.nilai_tag ELSE 0 END) jb06,
         SUM (CASE WHEN a.jns_byr = '07' THEN a.nilai_tag ELSE 0 END) jb07,
         SUM (CASE WHEN a.jns_byr = '08' THEN a.nilai_tag ELSE 0 END) jb08,
         SUM (CASE WHEN a.jns_byr = '09' THEN a.nilai_tag ELSE 0 END) jb09,
         SUM (CASE WHEN a.jns_byr = '10' THEN a.nilai_tag ELSE 0 END) jb10,
         SUM (CASE WHEN a.jns_byr = '11' THEN a.nilai_tag ELSE 0 END) jb11,
         SUM (a.nilai_tag) total
    FROM kkp_t_trans_19_20 a
         LEFT JOIN t_satker b
            ON (a.kdsatker = b.kdsatker)
         LEFT JOIN t_kppn c
            ON (b.kdkppn = c.kdkppn)
         LEFT JOIN t_kanwil d
            ON (c.kdkanwil = d.kdkanwil)
         LEFT JOIN t_dept e
            ON (b.kddept = e.kddept)
   WHERE LENGTH (a.kdsatker) = 6
GROUP BY c.kdkanwil, SUBSTR (d.nmkanwil, 10, LENGTH (d.nmkanwil))
  HAVING c.kdkanwil IS NOT NULL
ORDER BY kdkanwil ASC
/* Formatted on 29/04/2021 00:45:47 (QP5 v5.215.12089.38647) */
  SELECT LOWER (tname)
    FROM tab
   WHERE LOWER (tname) LIKE '%dko%'
ORDER BY 1;

DESC d_dko;

SELECT * FROM d_dko_umpan_balik;

SELECT * FROM t_jenumpan;

SELECT * FROM t_umpan_balik;

SELECT * FROM t_nilaiumpan;

SELECT * FROM d_dko_catatan;

  SELECT t.*
    FROM (SELECT a.id || 0 AS id_feed, a.uraian AS nm_feed, NULL AS idx
            FROM t_jenumpan a
          UNION
          SELECT a.id || b.id AS id_feed, b.uraian AS nm_feed, b.id AS idx
            FROM    t_jenumpan a
                 LEFT JOIN
                    t_umpan_balik b
                 ON (a.id = b.id_jenumpan)) t
ORDER BY id_feed;

SELECT a.id, a.uraian, NULL AS idx
  FROM t_jenumpan a
UNION
SELECT b.id, b.uraian, b.id_jenumpan AS idx
  FROM t_umpan_balik b;

  SELECT id,
         id_jenumpan,
         uraian,
         DECODE (id_nilai, 4, 'v', NULL) sb,
         DECODE (id_nilai, 3, 'v', NULL) bb,
         DECODE (id_nilai, 2, 'v', NULL) cb,
         DECODE (id_nilai, 1, 'v', NULL) kb
    FROM (SELECT a.id,
                 a.id_jenumpan,
                 a.uraian,
                 b.id_nilai,
                 b.nip,
                 c.uraian AS nm_nilai
            FROM t_umpan_balik a
                 LEFT JOIN d_dko_catatan b
                    ON (a.id = b.id_umpan_balik)
                 LEFT JOIN t_nilaiumpan c
                    ON (b.id_nilai = c.id)
           WHERE b.id_dko = 103)
ORDER BY 1 ASC;
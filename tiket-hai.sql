/* Formatted on 27/07/2025 12:20:16 (QP5 v5.391) */
SELECT * FROM TAB WHERE LOWER (tname) like 'temp_user_tik%';

  SELECT tahun,
         bulan,
         COUNT (a.REF) jml_tiket,
         SUM (waktu_pengerjaan) total_durasi,
         ROUND ((COUNT (a.REF) / SUM (waktu_pengerjaan)), 2) AS rerata_durasi
    FROM temp_user_tiket_omspan a
GROUP BY tahun, bulan
--HAVING tahun IS NOT NULL
ORDER BY bulan;

SELECT DISTINCT kategori
  FROM temp_user_tiket_omspan;

SELECT a.subyek,
       a.kategori,
       a.tahun,
       a.bulan,
       'user_mgmt' AS pnd
  FROM temp_user_tiket_omspan a
 WHERE kategori LIKE '%om span%' AND subyek LIKE '%reset%' OR subyek LIKE '%user%' OR subyek LIKE '%password%';

SELECT a.subyek,
       a.kategori,
       a.tahun,
       a.bulan,
       ''  AS pnd
  FROM temp_user_tiket_omspan a
 WHERE kategori LIKE '%om span%' AND subyek NOT LIKE '%reset%' OR subyek NOT LIKE '%user%' OR subyek NOT LIKE '%password%';

 -- DROP TABLE temp_user_tiket_omspan;

--CREATE TABLE temp_user_tiket_omspan AS

SELECT a.id,
       a.REF AS refid,
       a.subyek,
       a.pertanyaan,
       a.kategori,
       a.agen,
       --a.waktu_pengerjaan,
       --TRIM (REPLACE (a.waktu_pengerjaan, ' jam', ''))  AS waktu_pengerjaan,
       TO_NUMBER (REPLACE (TRIM (REPLACE (a.waktu_pengerjaan, ' jam', '')), '-', '0')) waktu_pengerjaan,
       'jam' AS satuan_pengerjaan,
       SUBSTR (a.created_at, 1, 4) AS tahun,
       SUBSTR (a.created_at, 6, 2) AS bulan,
       SUBSTR (a.created_at, 9, 2) AS tgl,
       'ok' AS flag
  FROM temp_user_tiket_new a
 WHERE (LOWER (a.subyek) LIKE '%omspan%' OR LOWER (a.subyek) LIKE '%om span%') OR (LOWER (a.kategori) LIKE '%omspan%' OR LOWER (a.kategori) LIKE '%om span%');


SELECT a.REF,
       a.subyek,
       a.tahun,
       a.bulan,
       'manajemen user' AS masalah
  FROM temp_user_tiket_omspan a
 WHERE (a.subyek LIKE '%reset%' OR a.subyek LIKE '%user%' OR a.subyek LIKE '%password%');


SELECT a.REF,
       a.subyek,
       a.tahun,
       a.bulan
  FROM (SELECT a.REF,
               a.subyek,
               a.tahun,
               a.bulan
          FROM temp_user_tiket_omspan a
         WHERE a.REF NOT IN (SELECT a.REF
                               FROM temp_user_tiket_omspan a
                              WHERE (a.subyek LIKE '%reset%' OR a.subyek LIKE '%user%' OR a.subyek LIKE '%password%'))) a
 WHERE a.subyek LIKE '%pagu%' OR a.subyek LIKE '%kontrak%' OR a.subyek LIKE '%sup%' OR a.subyek LIKE '%dipa%';


SELECT a.REF,
       a.subyek,
       a.tahun,
       a.bulan
  FROM temp_user_tiket_omspan a
 WHERE     a.REF NOT IN (SELECT a.REF
                           FROM temp_user_tiket_omspan a
                          WHERE (a.subyek LIKE '%reset%' OR a.subyek LIKE '%user%' OR a.subyek LIKE '%password%'))
       AND a.REF NOT IN (SELECT a.REF
                           FROM (SELECT a.REF,
                                        a.subyek,
                                        a.tahun,
                                        a.bulan
                                   FROM temp_user_tiket_omspan a
                                  WHERE a.REF NOT IN (SELECT a.REF
                                                        FROM temp_user_tiket_omspan a
                                                       WHERE (a.subyek LIKE '%reset%' OR a.subyek LIKE '%user%' OR a.subyek LIKE '%password%'))) a
                          WHERE a.subyek LIKE '%pagu%' OR a.subyek LIKE '%kontrak%' OR a.subyek LIKE '%sup%' OR a.subyek LIKE '%dipa%');


SELECT a.REF,
       a.subyek,
       a.tahun,
       a.bulan
  FROM temp_user_tiket_omspan a
 WHERE     a.REF NOT IN (SELECT a.REF
                           FROM temp_user_tiket_omspan a
                          WHERE     a.REF NOT IN (SELECT a.REF
                                                    FROM temp_user_tiket_omspan a
                                                   WHERE (a.subyek LIKE '%reset%' OR a.subyek LIKE '%user%' OR a.subyek LIKE '%password%'))
                                AND a.REF NOT IN (SELECT a.REF
                                                    FROM (SELECT a.REF,
                                                                 a.subyek,
                                                                 a.tahun,
                                                                 a.bulan
                                                            FROM temp_user_tiket_omspan a
                                                           WHERE a.REF NOT IN (SELECT a.REF
                                                                                 FROM temp_user_tiket_omspan a
                                                                                WHERE (a.subyek LIKE '%reset%' OR a.subyek LIKE '%user%' OR a.subyek LIKE '%password%'))) a
                                                   WHERE a.subyek LIKE '%pagu%' OR a.subyek LIKE '%kontrak%' OR a.subyek LIKE '%sup%' OR a.subyek LIKE '%dipa%'))
       AND a.REF NOT IN (SELECT a.REF
                           FROM temp_user_tiket_omspan a
                          WHERE (a.subyek LIKE '%reset%' OR a.subyek LIKE '%user%' OR a.subyek LIKE '%password%'));                                                                                                                    -- 115 rows


SELECT *
  FROM (SELECT a.REF,
               a.subyek,
               a.tahun,
               a.bulan,
               'manajemen user' AS masalah
          FROM temp_user_tiket_omspan a
         WHERE (a.subyek LIKE '%reset%' OR a.subyek LIKE '%user%' OR a.subyek LIKE '%password%'))
 WHERE subyek LIKE '%desa%';
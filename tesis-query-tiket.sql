/* Formatted on 27/08/2025 17:51:26 (QP5 v5.215.12089.38647) */
  SELECT tname
    FROM tab
   WHERE LOWER (tname) LIKE '%temp_ti%'
ORDER BY 1;

SELECT COUNT (refid) FROM temp_user_tiket_tahunan;

  SELECT LOWER (TRIM (refid)) refid,
         SUBSTR (created_at, 1, 4) tahun,
         LOWER (TRIM (subyek)) subyek,
         LOWER (TRIM (departemen)) departemen,
         --         DBMS_LOB.SUBSTR (LOWER (TRIM (pertanyaan)), 3000) part1
         DBMS_LOB.GETLENGTH (pertanyaan) jmlchar
    FROM temp_user_tiket_tahunan
   WHERE    LOWER (TRIM (subyek)) LIKE '%omspan%'
         OR LOWER (TRIM (subyek)) LIKE '%om span%'
         OR LOWER (TRIM (subyek)) LIKE '%spanext%'
         OR LOWER (TRIM (subyek)) LIKE '%span ext%'
         OR LOWER (TRIM (subyek)) LIKE '%span next%'
         OR DBMS_LOB.SUBSTR (LOWER (TRIM (pertanyaan)), 2000) LIKE '%omspan%'
         OR DBMS_LOB.SUBSTR (LOWER (TRIM (pertanyaan)), 2000) LIKE '%om span%'
         OR DBMS_LOB.SUBSTR (LOWER (TRIM (pertanyaan)), 2000) LIKE '%spanext%'
         OR DBMS_LOB.SUBSTR (LOWER (TRIM (pertanyaan)), 2000) LIKE '%span ext%'
ORDER BY TAHUN;

  SELECT tahun, COUNT (refid) jml_tiket
    FROM (  SELECT LOWER (TRIM (refid)) refid,
                   SUBSTR (created_at, 1, 4) tahun,
                   LOWER (TRIM (subyek)) subyek,
                   LOWER (TRIM (departemen)) departemen
              --DBMS_LOB.SUBSTR (LOWER (TRIM (pertanyaan)), 3000) part1 --, DBMS_LOB.SUBSTR (pertanyaan, 4000, 4003) part2
              FROM temp_user_tiket_tahunan
             WHERE    LOWER (TRIM (subyek)) LIKE '%omspan%'
                   OR LOWER (TRIM (subyek)) LIKE '%om span%'
                   OR LOWER (TRIM (subyek)) LIKE '%spanext%'
                   OR LOWER (TRIM (subyek)) LIKE '%span ext%'
                   OR LOWER (TRIM (subyek)) LIKE '%span next%'
                   OR DBMS_LOB.SUBSTR (LOWER (TRIM (pertanyaan)), 2000) LIKE '%omspan%'
                   OR DBMS_LOB.SUBSTR (LOWER (TRIM (pertanyaan)), 2000) LIKE '%om span%'
                   OR DBMS_LOB.SUBSTR (LOWER (TRIM (pertanyaan)), 2000) LIKE '%spanext%'
                   OR DBMS_LOB.SUBSTR (LOWER (TRIM (pertanyaan)), 2000) LIKE '%span ext%'
          ORDER BY TAHUN)
GROUP BY ROLLUP (tahun)
ORDER BY tahun;

/*
-- DROP TABLE TEMP_USER_TIKET_TAHUNAN_NEW;

-- CREATE TABLE TEMP_USER_TIKET_TAHUNAN_NEW AS
    SELECT ROW_NUMBER () OVER (PARTITION BY '' ORDER BY SUBSTR (created_at, 1, 4), SUBSTR (created_at, 6, 2), refid) id,
           refid,
           SUBSTR (created_at, 1, 4) tahun,
           SUBSTR (created_at, 6, 2) bulan,
           DBMS_LOB.GETLENGTH (pertanyaan) jml_karakter,
           LOWER (subyek) subyek,
           DBMS_LOB.SUBSTR (LOWER (pertanyaan), 2000, 1) AS part1,
           DBMS_LOB.SUBSTR (LOWER (pertanyaan), 2000, 3001) AS part2,
           DBMS_LOB.SUBSTR (LOWER (pertanyaan), 2000, 4001) AS part3,
           DBMS_LOB.SUBSTR (LOWER (pertanyaan), 2000, 6001) AS part4,
           LOWER (pengerjaan) pengerjaan
      FROM temp_user_tiket_tahunan;
*/

SELECT *
  FROM (SELECT *
          FROM TEMP_USER_TIKET_TAHUNAN_NEW
         WHERE    LOWER (subyek) LIKE '%span%'
               OR LOWER (subyek) LIKE '%omspan%'
               OR LOWER (subyek) LIKE '%om span%'
               OR LOWER (subyek) LIKE '%om-span%'
               OR LOWER (part1) LIKE '%omspan%'
               OR LOWER (part1) LIKE '%om span%'
               OR LOWER (part2) LIKE '%omspan%'
               OR LOWER (part2) LIKE '%om span%')
 WHERE (LOWER (part1) LIKE '%@kemenkeu%') OR (LOWER (part2) LIKE '%@kemenkeu%');

SELECT *
  FROM (SELECT *
          FROM TEMP_USER_TIKET_TAHUNAN_NEW
         WHERE    LOWER (subyek) LIKE '%span%'
               OR LOWER (subyek) LIKE '%omspan%'
               OR LOWER (subyek) LIKE '%om span%'
               OR LOWER (subyek) LIKE '%om-span%'
               OR LOWER (part1) LIKE '%omspan%'
               OR LOWER (part1) LIKE '%om span%'
               OR LOWER (part2) LIKE '%omspan%'
               OR LOWER (part2) LIKE '%om span%'
               OR LOWER (part3) LIKE '%omspan%'
               OR LOWER (part3) LIKE '%om span%')
 WHERE LOWER (subyek) LIKE '%swor%' OR LOWER (subyek) LIKE '%reset%' OR LOWER (subyek) LIKE '%akses api%' OR LOWER (part1) LIKE '%swor%' OR LOWER (part1) LIKE '%reset%';

SELECT id,
       refid,
       tahun,
       bulan,
       jml_karakter,
       subyek,
       part1,
       part2,
       part3,
       part4
  FROM (SELECT *
          FROM TEMP_USER_TIKET_TAHUNAN_NEW
         WHERE    subyek LIKE '%span%'
               OR subyek LIKE '%omspan%'
               OR subyek LIKE '%om span%'
               OR subyek LIKE '%om-span%'
               OR part1 LIKE '%omspan%'
               OR part1 LIKE '%om span%'
               OR part2 LIKE '%omspan%'
               OR part2 LIKE '%om span%'
               OR part3 LIKE '%omspan%'
               OR part3 LIKE '%om span%')
 WHERE    subyek LIKE '%swor%'
       OR subyek LIKE '%reset%'
       OR subyek LIKE '%akses api%'
       OR subyek LIKE '%akses omspan%'
       OR subyek LIKE '%daftaran omspan%'
       OR subyek LIKE '%daftaran role%'
       OR subyek LIKE '%akun o%'
       OR part1 LIKE '%swor%'
       OR part1 LIKE '%reset%';

/*
SELECT *
  FROM (SELECT *
          FROM TEMP_USER_TIKET_TAHUNAN_NEW
         WHERE    LOWER (subyek) LIKE '%span%'
               OR LOWER (subyek) LIKE '%omspan%'
               OR LOWER (subyek) LIKE '%om span%'
               OR LOWER (subyek) LIKE '%om-span%'
               OR LOWER (part1) LIKE '%omspan%'
               OR LOWER (part1) LIKE '%om span%'
               OR LOWER (part2) LIKE '%omspan%'
               OR LOWER (part2) LIKE '%om span%'
               OR LOWER (part3) LIKE '%omspan%'
               OR LOWER (part3) LIKE '%om span%')
 WHERE     id NOT IN
               (SELECT id
                  FROM (SELECT *
                          FROM TEMP_USER_TIKET_TAHUNAN_NEW
                         WHERE    LOWER (subyek) LIKE '%span%'
                               OR LOWER (subyek) LIKE '%omspan%'
                               OR LOWER (subyek) LIKE '%om span%'
                               OR LOWER (subyek) LIKE '%om-span%'
                               OR LOWER (part1) LIKE '%omspan%'
                               OR LOWER (part1) LIKE '%om span%'
                               OR LOWER (part2) LIKE '%omspan%'
                               OR LOWER (part2) LIKE '%om span%'
                               OR LOWER (part3) LIKE '%omspan%'
                               OR LOWER (part3) LIKE '%om span%')
                 WHERE (   LOWER (subyek) LIKE '%swor%'
                        OR LOWER (subyek) LIKE '%reset%'
                        OR LOWER (subyek) LIKE '%akses api%'
                        OR LOWER (part1) LIKE '%swor%'
                        OR LOWER (part1) LIKE '%reset%'))
       AND (LOWER (subyek) LIKE '%nkro%' OR LOWER (subyek) LIKE '%tidak sama%');
*/

  SELECT tahun, bulan, COUNT (refid) jml_tiket
    FROM temp_user_tiket_tahunan_new
GROUP BY ROLLUP (tahun, bulan)
ORDER BY 1, 2;

  SELECT tahun, COUNT (refid) jml_tiket
    FROM temp_user_tiket_tahunan_new
GROUP BY ROLLUP (tahun)
ORDER BY 1, 2;

/******************************************************************************/

SELECT LENGTH ('temp_tiket_user_password') FROM DUAL;

--DROP TABLE temp_tiket_ktg_user_password;
--CREATE TABLE temp_tiket_ktg_user_password AS

  SELECT id,
         refid,
         tahun,
         bulan,
         TRIM (subyek) subyek,
         'user_password' AS flag
    FROM temp_user_tiket_tahunan_new
   WHERE subyek LIKE '%user%' OR subyek LIKE '%swor%' OR subyek LIKE '% api %' OR subyek LIKE '%reset%'
ORDER BY subyek;

/******************************************************************************/
--DROP TABLE temp_tiket_ktg_dipa_kontrak;
--CREATE TABLE temp_tiket_ktg_dipa_kontrak as

  SELECT id,
         refid,
         tahun,
         bulan,
         TRIM (subyek) subyek,
         'dipa_kontrak' AS flag
    FROM temp_user_tiket_tahunan_new
   WHERE     id IS NOT NULL
         AND (subyek LIKE '%kontrak%' OR subyek LIKE '%karwas%' OR subyek LIKE '%pagu%' OR subyek LIKE '%dipa%' OR subyek LIKE '%evisi%')
         AND subyek NOT LIKE '%ikpa%'
         AND subyek NOT LIKE '%supplier%'
         AND id NOT IN (SELECT id FROM temp_tiket_ktg_user_password)
ORDER BY id;

SELECT * FROM temp_tiket_ktg_dipa_kontrak;

  SELECT id,
         refid,
         tahun,
         bulan,
         TRIM (subyek) subyek,
         'dipa_kontrak' AS flag
    FROM temp_user_tiket_tahunan_new
   WHERE     id IS NOT NULL
         AND (subyek LIKE '%ikpa%' OR subyek LIKE '%output%')
         AND id NOT IN (SELECT id FROM temp_tiket_ktg_user_password)
         AND id NOT IN (SELECT id FROM temp_tiket_ktg_dipa_kontrak)
ORDER BY id;

/******************************************************************************/

  SELECT id,
         refid,
         tahun,
         bulan,
         TRIM (subyek) subyek,
         'selisih_sinkron' AS flag
    FROM temp_user_tiket_tahunan_new
   WHERE     id IS NOT NULL
         --AND (subyek LIKE '%sinkron%' OR subyek LIKE '%rbeda%' OR subyek LIKE '%selisih%')
         AND (subyek LIKE '%anomali%')
         AND id NOT IN (SELECT id FROM temp_tiket_ktg_user_password)
         AND id NOT IN (SELECT id FROM temp_tiket_ktg_dipa_kontrak)
ORDER BY id;

/******************************************************************************/

  SELECT id,
         refid,
         tahun,
         bulan,
         TRIM (subyek) subyek,
         'xxxxxxxxx' AS flag
    FROM temp_user_tiket_tahunan_new
   WHERE     id IS NOT NULL
         --AND (subyek LIKE '%referensi%')
         AND (subyek LIKE '%belanja%' OR subyek LIKE '%penerimaan%')
         AND id NOT IN (SELECT id FROM temp_tiket_ktg_user_password)
         AND id NOT IN (SELECT id FROM temp_tiket_ktg_dipa_kontrak)
ORDER BY id;
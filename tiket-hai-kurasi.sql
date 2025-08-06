/* Formatted on 28/07/2025 12:31:39 (QP5 v5.391) */
SELECT tname
  FROM tab
 WHERE tname LIKE 'TEMP_TIKET%';


--DROP TABLE TEMP_TIKET_MANAJEMEN_USER;
--CREATE TABLE TEMP_TIKET_MANAJEMEN_USER AS

SELECT a.refno,
       a.subyek,
       a.tahun,
       a.bulan,
       a.waktu_pengerjaan,
       'manajemen user' AS masalah
  FROM temp_user_tiket_omspan a
 WHERE (   a.subyek LIKE '%reset%'
        OR a.subyek LIKE '%user%'
        OR a.subyek LIKE '%password%'
        OR a.subyek LIKE '%akses api%'
        OR a.subyek LIKE '%akses omspan%'
        OR a.subyek LIKE '%daftaran omspan%'
        OR a.subyek LIKE '%akun o%');

/*
--DROP TABLE TEMP_TIKET_ANOMALI;
--CREATE TABLE TEMP_TIKET_ANOMALI AS

SELECT a.refno,
       a.subyek,
       a.tahun,
       a.bulan,
       a.waktu_pengerjaan,
       'anomali' AS masalah
  FROM temp_user_tiket_omspan a
 WHERE     a.refno NOT IN (SELECT refno FROM temp_tiket_manajemen_user)
       AND (a.subyek LIKE '%tidak%' OR a.subyek LIKE '%beda%' OR a.subyek LIKE '%anom%' OR a.subyek LIKE '%sinkron%');*/

--DROP TABLE TEMP_TIKET_MASALAH_PAGU;

CREATE TABLE TEMP_TIKET_MASALAH_PAGU
AS
    SELECT a.refno,
           a.subyek,
           a.tahun,
           a.bulan,
           a.waktu_pengerjaan,
           'referensi' AS masalah
      FROM temp_user_tiket_omspan a
     WHERE a.refno NOT IN (SELECT refno FROM temp_tiket_manajemen_user) AND a.subyek LIKE '%pagu%';

--DROP TABLE TEMP_TIKET_MASALAH_REFERENSI;
--CREATE TABLE TEMP_TIKET_MASALAH_REFERENSI AS

SELECT a.refno,
       a.subyek,
       a.tahun,
       a.bulan,
       a.waktu_pengerjaan,
       'referensi' AS masalah
  FROM temp_user_tiket_omspan a
 WHERE     a.refno NOT IN (SELECT refno FROM temp_tiket_manajemen_user)
       AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_pagu)
       AND (a.subyek LIKE '%referensi%' OR a.subyek LIKE '%nama satker%' OR a.subyek LIKE '%nama direk%');

--DROP TABLE TEMP_TIKET_MASALAH_KONTRAK;
-- CREATE TABLE TEMP_TIKET_MASALAH_KONTRAK AS

SELECT a.refno,
       a.subyek,
       a.tahun,
       a.bulan,
       a.waktu_pengerjaan,
       'kontrak' AS masalah
  FROM temp_user_tiket_omspan a
 WHERE     a.refno NOT IN (SELECT refno FROM temp_tiket_manajemen_user)
       AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_pagu)
       AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_referensi)
       AND a.subyek LIKE '%kontrak%';

--DROP TABLE TEMP_TIKET_MASALAH_SUPPLIER;
--CREATE TABLE TEMP_TIKET_MASALAH_SUPPLIER AS  

SELECT a.refno,
       a.subyek,
       a.tahun,
       a.bulan,
       a.waktu_pengerjaan,
       'supplier' AS masalah
  FROM temp_user_tiket_omspan a
 WHERE     a.refno NOT IN (SELECT refno FROM temp_tiket_manajemen_user)
       AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_pagu)
       AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_referensi)
       AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_kontrak)
       AND a.subyek LIKE '%supplier%';

--DROP TABLE TEMP_TIKET_MASALAH_PERIODE;
--CREATE TABLE TEMP_TIKET_MASALAH_PERIODE AS

SELECT a.refno,
       a.subyek,
       a.tahun,
       a.bulan,
       a.waktu_pengerjaan,
       'period' AS masalah
  FROM temp_user_tiket_omspan a
 WHERE     a.refno NOT IN (SELECT refno FROM temp_tiket_manajemen_user)
       AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_pagu)
       AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_referensi)
       AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_kontrak)
       AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_supplier)
       AND a.subyek LIKE '%period%';

--DROP TABLE TEMP_TIKET_MASALAH_PENDAPATAN;
--CREATE TABLE TEMP_TIKET_MASALAH_PENDAPATAN AS       

SELECT a.refno,
       a.subyek,
       a.tahun,
       a.bulan,
       a.waktu_pengerjaan,
       'pendapatan' AS masalah
  FROM temp_user_tiket_omspan a
 WHERE     a.refno NOT IN (SELECT refno FROM temp_tiket_manajemen_user)
       AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_pagu)
       AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_referensi)
       AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_kontrak)
       AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_supplier)
       AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_periode)
       AND (a.subyek LIKE '%pendapatan%' OR a.subyek LIKE '%setoran%' OR a.subyek LIKE '%penerimaan%' OR a.subyek LIKE '%pnbp%');

--DROP TABLE TEMP_TIKET_MASALAH_DANDES;
--CREATE TABLE TEMP_TIKET_MASALAH_DANDES AS   

SELECT a.refno,
       a.subyek,
       a.tahun,
       a.bulan,
       a.waktu_pengerjaan,
       'dakdandes' AS masalah
  FROM temp_user_tiket_omspan a
 WHERE     a.refno NOT IN (SELECT refno FROM temp_tiket_manajemen_user)
       AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_pagu)
       AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_referensi)
       AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_kontrak)
       AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_supplier)
       AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_periode)
       AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_pendapatan)
       AND (a.subyek LIKE '%desa%' OR a.subyek LIKE '% dak%' OR a.subyek LIKE '%tkd%');

--DROP TABLE TEMP_TIKET_MASALAH_BELANJA;
--CREATE TABLE TEMP_TIKET_MASALAH_BELANJA AS  

SELECT a.refno,
       a.subyek,
       a.tahun,
       a.bulan,
       a.waktu_pengerjaan,
       'realisasi' AS masalah
  FROM temp_user_tiket_omspan a
 WHERE     a.refno NOT IN (SELECT refno FROM temp_tiket_manajemen_user)
       AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_pagu)
       AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_referensi)
       AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_kontrak)
       AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_supplier)
       AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_periode)
       AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_pendapatan)
       AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_dandes)
       AND (a.subyek LIKE '%realisasi%' OR a.subyek LIKE '%belanja%' OR a.subyek LIKE '%rpd%');

--DROP TABLE TEMP_TIKET_MASALAH_KOREKSI;
--CREATE TABLE TEMP_TIKET_MASALAH_KOREKSI AS         

SELECT a.refno,
       a.subyek,
       a.tahun,
       a.bulan,
       a.waktu_pengerjaan,
       'koreksi' AS masalah
  FROM temp_user_tiket_omspan a
 WHERE     a.refno NOT IN (SELECT refno FROM temp_tiket_manajemen_user)
       AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_pagu)
       AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_referensi)
       AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_kontrak)
       AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_supplier)
       AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_periode)
       AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_pendapatan)
       AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_dandes)
       AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_belanja)
       AND (a.subyek LIKE '%koreksi%');

--DROP TABLE TEMP_TIKET_MASALAH_KOREKSI;
--CREATE TABLE TEMP_TIKET_MASALAH_KOREKSI AS   

  SELECT a.refno,
         a.subyek,
         a.tahun,
         a.bulan,
         a.waktu_pengerjaan,
         'lainnya' AS masalah
    FROM temp_user_tiket_omspan a
   WHERE     a.refno NOT IN (SELECT refno FROM temp_tiket_manajemen_user)
         AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_pagu)
         AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_referensi)
         AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_kontrak)
         AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_supplier)
         AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_periode)
         AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_pendapatan)
         AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_dandes)
         AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_belanja)
         AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_koreksi)
         AND (a.subyek LIKE '%sinkron%')
ORDER BY 2;


/*SELECT a.refno,
       a.subyek,
       a.tahun,
       a.bulan,
       a.waktu_pengerjaan,
       'lainnya' AS masalah
  FROM temp_user_tiket_omspan a
 WHERE     a.refno NOT IN
               (SELECT a.refno
                  FROM temp_user_tiket_omspan a
                 WHERE (   a.subyek LIKE '%reset%'
                        OR a.subyek LIKE '%user%'
                        OR a.subyek LIKE '%password%'
                        OR a.subyek LIKE '%akses api%'
                        OR a.subyek LIKE '%akses omspan%'
                        OR a.subyek LIKE '%daftaran omspan%'
                        OR a.subyek LIKE '%akun o%'))
       AND a.refno NOT IN
               (SELECT a.refno
                  FROM temp_user_tiket_omspan a
                 WHERE     a.refno NOT IN
                               (SELECT a.refno
                                  FROM temp_user_tiket_omspan a
                                 WHERE (   a.subyek LIKE '%reset%'
                                        OR a.subyek LIKE '%user%'
                                        OR a.subyek LIKE '%password%'
                                        OR a.subyek LIKE '%akses api%'
                                        OR a.subyek LIKE '%akses omspan%'
                                        OR a.subyek LIKE '%daftaran omspan%'
                                        OR a.subyek LIKE '%akun o%'))
                       AND (a.subyek LIKE '%tidak%' OR a.subyek LIKE '%beda%' OR a.subyek LIKE '%anom%'))
       AND a.subyek LIKE '%supplier%'; */

--DROP TABLE TEMP_TIKET_MASALAH_ANOMALI;

--CREATE TABLE TEMP_TIKET_MASALAH_ANOMALI AS

SELECT a.refno,
       a.subyek,
       a.tahun,
       a.bulan,
       a.waktu_pengerjaan,
       'anomali' AS masalah
  FROM temp_user_tiket_omspan a
 WHERE     a.refno NOT IN (SELECT refno FROM temp_tiket_manajemen_user)
       AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_pagu)
       AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_referensi)
       AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_kontrak)
       AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_supplier)
       AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_periode)
       AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_pendapatan)
       AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_dandes)
       AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_belanja)
       AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_koreksi)
       AND (a.subyek LIKE '%tidak%' OR a.subyek LIKE '%beda%' OR a.subyek LIKE '%anom%' OR a.subyek LIKE '%sinkron%');


--DROP TABLE TEMP_TIKET_MASALAH_LOGIN;

--CREATE TABLE TEMP_TIKET_MASALAH_LOGIN AS

SELECT a.refno,
       a.subyek,
       a.tahun,
       a.bulan,
       a.waktu_pengerjaan,
       'login' AS masalah
  FROM temp_user_tiket_omspan a
 WHERE     a.refno NOT IN (SELECT refno FROM temp_tiket_manajemen_user)
       AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_pagu)
       AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_referensi)
       AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_kontrak)
       AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_supplier)
       AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_periode)
       AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_pendapatan)
       AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_dandes)
       AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_belanja)
       AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_koreksi)
       AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_anomali)
       AND a.subyek LIKE '%login%';

--DROP TABLE TEMP_TIKET_MASALAH_OUTPUT;

--CREATE TABLE TEMP_TIKET_MASALAH_OUTPUT AS

SELECT a.refno,
       a.subyek,
       a.tahun,
       a.bulan,
       a.waktu_pengerjaan,
       'output ikpa' AS masalah
  FROM temp_user_tiket_omspan a
 WHERE     a.refno NOT IN (SELECT refno FROM temp_tiket_manajemen_user)
       AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_pagu)
       AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_referensi)
       AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_kontrak)
       AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_supplier)
       AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_periode)
       AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_pendapatan)
       AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_dandes)
       AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_belanja)
       AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_koreksi)
       AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_anomali)
       AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_login)
       AND (a.subyek LIKE '%outp%' OR a.subyek LIKE '%ikpa%' OR a.subyek LIKE '%caput%' OR a.subyek LIKE '%kinerja%');


--DROP TABLE TEMP_TIKET_MASALAH_LAIN;

--CREATE TABLE TEMP_TIKET_MASALAH_LAIN AS

  SELECT a.refno,
         a.subyek,
         a.tahun,
         a.bulan,
         a.waktu_pengerjaan,
         'lainnya' AS masalah
    FROM temp_user_tiket_omspan a
   WHERE     a.refno NOT IN (SELECT refno FROM temp_tiket_manajemen_user)
         AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_pagu)
         AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_referensi)
         AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_kontrak)
         AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_supplier)
         AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_periode)
         AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_pendapatan)
         AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_dandes)
         AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_belanja)
         AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_koreksi)
         AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_anomali)
         AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_login)
         AND a.refno NOT IN (SELECT refno FROM temp_tiket_masalah_output)
         AND a.subyek LIKE '%mbahan%'
ORDER BY subyek;


EXECUTE SP_CREATE_TEMP_TIKET;

EXECUTE SP_DROP_TEMP_TIKET;

DROP PROCEDURE SP_CREATE_TEMP_TIKET;

DROP PROCEDURE SP_DROP_TEMP_TIKET;

  SELECT object_name, status
    FROM user_objects
   WHERE object_type = 'PROCEDURE' AND object_name LIKE '%TEMP_TIKET'
ORDER BY 1;

  SELECT object_name, status
    FROM user_objects
   WHERE object_type = 'TABLE' AND object_name LIKE '%TEMP_TIKET%'
ORDER BY 1;
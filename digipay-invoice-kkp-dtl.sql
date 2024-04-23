/* Formatted on 30/09/2023 08:35:03 (QP5 v5.215.12089.38647) */
SELECT *
  FROM tab
 WHERE LOWER (tname) LIKE '%_vend%';

SELECT * FROM d_vendor;

SELECT v.id,
       NVL (UPPER (v.nama), '_') AS nama_vendor,
       NVL (TRIM (v.alamat), 'N/A') AS alamat_vendor,
       NVL (v.telp, '021-XXX') AS telp_vendor,
       NVL (v.email, 'test@fakemail.info') AS email_vendor,
       NVL (v.npwp, '000000000000000') AS npwp_vendor,
       NVL (w.nmlokasi, '') AS kota_vendor,
       NVL (v.kdpos, 'XXXXX') AS kdpos
  FROM d_vendor v LEFT JOIN t_lokasi w ON (v.kdlokasi = w.kdlokasi);

SELECT * FROM D_VENDOR_UMKM;

SELECT a.*
  FROM d_pemesanan a
 WHERE thang = '2022' AND kdsatker = '527010' AND metodebyr = '02';
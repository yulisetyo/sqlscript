/* Formatted on 23/10/2023 10:32:56 (QP5 v5.215.12089.38647) */
SELECT *
  FROM kur_t_debitur PARTITION (bank008);

SELECT a.nik,
       TRIM (UPPER (a.nama)) nama,
       TO_CHAR (a.tgl_lahir, 'mm/dd/yyyy') tgl_lahir,
       CASE WHEN jns_kelamin = 1 THEN 'PRIA' WHEN jns_kelamin = 2 THEN 'WANITA' ELSE 'BADAN_USAHA' END jns_kelamin,
       UPPER (b.deskripsi) AS sts_kawin,
       UPPER (c.deskripsi) AS pendidikan,
       UPPER (d.deskripsi) AS pekerjaan,
       TRIM (UPPER (a.alamat)) AS alamat,
       TRIM (a.kode_pos) AS kode_pos,
       TRIM (a.npwp) AS npwp,
       TRIM (UPPER (e.nama_wilayah)) AS kab_kota,
       TRIM (UPPER (f.nama_wilayah)) AS provinsi
  FROM kur_t_debitur PARTITION (bank008) a
       LEFT JOIN kur_r_marital_sts b
          ON (a.maritas_sts = b.marital_sts)
       LEFT JOIN kur_r_pendidikan c
          ON (a.pendidikan = c.pendidikan)
       LEFT JOIN kur_r_pekerjaan d
          ON (a.pekerjaan = d.pekerjaan)
       LEFT JOIN kur_r_wilayah e
          ON (a.kode_kabkota = e.kode_wilayah)
       LEFT JOIN kur_r_wilayah_propinsi f
          ON (SUBSTR (a.kode_kabkota, 1, 2) = f.kode_wilayah)
 WHERE kode_bank = '008';

SELECT a.nik,
       TRIM (UPPER (a.nama)) AS nama_debitur,
       a.npwp,
       TO_CHAR (a.mulai_usaha, 'mm/dd/yyyy') AS mulai_usaha,
       TRIM (UPPER (a.alamat_usaha)) AS alamat_usaha,
       TRIM (UPPER (b.nama_wilayah)) AS kab_kota,
       TRIM (UPPER (c.nama_wilayah)) AS provinsi,
       TRIM (UPPER (a.ijin_usaha)) AS ijin_usaha,
       a.modal_usaha,
       a.jml_pekerja,
       a.jml_kredit AS pengajuan_kredit
  FROM kur_t_debitur PARTITION (bank008) a
       LEFT JOIN kur_r_wilayah b
          ON (a.kode_kabkota = b.kode_wilayah)
       LEFT JOIN kur_r_wilayah_propinsi c
          ON (SUBSTR (a.kode_kabkota, 1, 2) = c.kode_wilayah)
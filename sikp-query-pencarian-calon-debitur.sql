/* Formatted on 14/02/2023 16:10:28 (QP5 v5.215.12089.38647) */
SELECT                                                                                                                                                                      --a.nik,
      a.nama,
       a.npwp,
       TO_CHAR (a.tgl_lahir, 'DD-MM-YYYY') tgl_lahir,
       SUBSTR (a.nama_file, 7, 3) AS kode_bank,
       a.alamat,
       a.kode_pos,
       a.kode_kabkota,
       a.ijin_usaha,
       a.jml_pekerja,
       a.modal_usaha,
       a.jml_kredit,
       a.user_upload,
       TO_CHAR (a.tgl_upload, 'DD-MM-YYYY') tgl_upload,
       a.is_debitur,
       b.nik AS bnik,
       b.nama AS jns_kelamin,
       c.deskripsi AS marital_sts,
       d.deskripsi AS pendidikan,
       e.deskripsi AS pekerjaan,
       UPPER (f.nama_wilayah) AS nama_kabkota,
       UPPER (g.nama_wilayah) AS nama_provinsi,
       i.nama_bank
  FROM kur_t_debitur@sikp_19c a
       LEFT JOIN kur_t_akad@sikp_19c b
          ON (a.nik = b.nik)
       LEFT OUTER JOIN kur_r_jenis_kelamin b
          ON (a.jns_kelamin = b.kode)
       LEFT OUTER JOIN kur_r_marital_sts c
          ON (a.maritas_sts = c.marital_sts)
       LEFT OUTER JOIN kur_r_pendidikan d
          ON (a.pendidikan = d.pendidikan)
       LEFT OUTER JOIN kur_r_pekerjaan e
          ON (a.pekerjaan = e.pekerjaan)
       LEFT OUTER JOIN kur_r_wilayah f
          ON (a.kode_kabkota = f.kode_wilayah)
       LEFT OUTER JOIN kur_r_wilayah_propinsi g
          ON (SUBSTR (a.kode_kabkota, 1, 2) = g.kode_wilayah)
       LEFT OUTER JOIN kur_r_user h
          ON (a.user_upload = h.username)
       LEFT OUTER JOIN kur_r_bank i
          ON (h.if_bank = i.kode_bank)
 WHERE TO_CHAR (a.tgl_upload, 'yyyy') = '2022' AND b.nik IS NULL AND SUBSTR (a.nama_file, 7, 3) != '990' AND SUBSTR (a.nama_file, 7, 3) NOT IN ('002', '008', '009')
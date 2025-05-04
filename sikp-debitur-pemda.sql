/* query pencarian debitur pemda tertentu yang isi data kolom NIK bukan karakter angka*/
  SELECT LENGTH (nik) pk,
         nik,
         nama,
         kode_kabkota,
         TO_CHAR (tgl_upload, 'yyyy-mm-dd') tgl_upload,
         nama_file,
         is_debitur
    FROM kur_t_debitur_pmd
   WHERE NOT REGEXP_LIKE (NIK, '^\d{16}$') AND kode_kabkota = '3317'
ORDER BY kode_kabkota ASC, nik ASC;

/* query untuk menampilkan data debitur pemda yang tidak sesuai dengan format NIK - data per pemda */
  SELECT kode_kabkota, COUNT (nik) jml_calon_debitur
    FROM (SELECT LENGTH (nik) pk,
                 nik,
                 nama,
                 kode_kabkota,
                 TO_CHAR (tgl_upload, 'yyyy-mm-dd') tgl_upload,
                 nama_file,
                 is_debitur
            FROM kur_t_debitur_pmd
           WHERE NOT REGEXP_LIKE (NIK, '^\d{16}$'))
GROUP BY kode_kabkota
ORDER BY kode_kabkota ASC;

/* query untuk menampilkan data debitur pemda yang tidak sesuai dengan format NIK */
  SELECT a.nik,
         a.nmr_registry,
         a.nama,
         TO_CHAR (a.tgl_lahir, 'DD-MM-YYYY') tgl_lahir,
         a.jns_kelamin,
         a.maritas_sts,
         a.pendidikan,
         a.pekerjaan,
         a.alamat,
         a.kode_kabkota,
         a.kode_pos,
         a.npwp,
         TO_CHAR (a.mulai_usaha, 'DD-MM-YYYY') mulai_usaha,
         a.alamat_usaha,
         a.ijin_usaha,
         a.modal_usaha,
         a.jml_pekerja,
         a.jml_kredit,
         TO_CHAR (a.tgl_upload, 'DD-MM-YYYY HH24:MI:SS') tgl_upload,
         a.is_linkage,
         a.no_hp,
         a.uraian_agunan,
         a.is_subsidized,
         a.subsidi_sebelumnya,
         a.is_debitur,
         a.nama_file
    FROM kur_t_debitur_pmd a
   WHERE a.kode_kabkota = '7371'                                                                                                          --AND trim(a.nama) = 'deasy dwi adriani'
ORDER BY 1 DESC;


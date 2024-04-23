/* Formatted on 12/12/2023 01:17:17 (QP5 v5.215.12089.38647) */
SELECT nik,
       sekarang,
       tgl_lahir,
       (tahun1 - tahun0) AS thn,
       (bulan1 - bulan0) AS bln,
       (hari1 - hari0) AS hr
  FROM (SELECT nik,
               TO_CHAR (tgl_lahir, 'yyyy-mm-dd') tgl_lahir,
               TO_CHAR (SYSDATE, 'yyyy-mm-dd') AS sekarang,
               TO_CHAR (tgl_lahir, 'yyyy') tahun0,
               TO_CHAR (SYSDATE, 'yyyy') AS tahun1,
               TO_CHAR (tgl_lahir, 'mm') bulan0,
               TO_CHAR (SYSDATE, 'mm') AS bulan1,
               TO_CHAR (tgl_lahir, 'dd') AS hari0,
               TO_CHAR (SYSDATE, 'dd') AS hari1
          FROM kur_t_debitur);


SELECT object_name, object_type
  FROM user_objects
 WHERE object_type = 'TABLE' AND object_name LIKE 'TMP%';

  SELECT nik, LISTAGG (keterangan, ', ') WITHIN GROUP (ORDER BY nik) AS keterangan
    FROM (                                                                                                                                                       /* VALIDASI NAMA */
          SELECT nik, 'kolom NAMA kosong' AS keterangan
            FROM kur_t_debitur
           WHERE nik IN ('1201085207900002') AND nama IS NULL
          UNION
          SELECT nik, 'kolom NAMA kurang dari 1 karakter' AS keterangan
            FROM kur_t_debitur
           WHERE nik IN ('1201085207900002') AND LENGTH (nama) <= 1
          UNION
          /* VALIDASI JNS_KELAMIN */
          SELECT nik, 'kolom JNS_KELAMIN kosong' AS keterangan
            FROM kur_t_debitur
           WHERE nik IN ('1201085207900002') AND jns_kelamin IS NULL
          UNION
          SELECT nik, 'kolom JNS_KELAMIN tidak ada di referensi' AS keterangan
            FROM kur_t_debitur
           WHERE nik IN ('1201085207900002') AND jns_kelamin NOT IN (SELECT kode FROM kur_r_jenis_kelamin)
          UNION
          /* VALIDASI MARITAS_STS */
          SELECT nik, 'kolom MARITAS_STS kosong' AS keterangan
            FROM kur_t_debitur
           WHERE nik IN ('1201085207900002') AND maritas_sts IS NULL
          UNION
          SELECT nik, 'kolom MARITAS_STS tidak ada di referensi' AS keterangan
            FROM kur_t_debitur
           WHERE nik IN ('1201085207900002') AND maritas_sts NOT IN (SELECT marital_sts FROM kur_r_marital_sts)
          UNION
          /* VALIDASI PENDIDIKAN */
          SELECT nik, 'kolom PENDIDIKAN kosong' AS keterangan
            FROM kur_t_debitur
           WHERE nik IN ('1201085207900002') AND pendidikan IS NULL
          UNION
          SELECT nik, 'kolom PENDIDIKAN tidak ada di referensi' AS keterangan
            FROM kur_t_debitur
           WHERE nik IN ('1201085207900002') AND pendidikan NOT IN (SELECT pendidikan FROM kur_r_pendidikan)
          UNION
          /* VALIDASI PEKERJAAN */
          SELECT nik, 'kolom PEKERJAAN kosong' AS keterangan
            FROM kur_t_debitur
           WHERE nik IN ('1201085207900002') AND pekerjaan IS NULL
          UNION
          SELECT nik, 'kolom PEKERJAAN tidak ada di referensi' AS keterangan
            FROM kur_t_debitur
           WHERE nik IN ('1201085207900002') AND pekerjaan NOT IN (SELECT pekerjaan FROM kur_r_pekerjaan)
          UNION
          SELECT nik, 'kolom PEKERJAAN diisi dengan kode 1 dan 2' AS keterangan
            FROM kur_t_debitur
           WHERE nik IN ('1201085207900002') AND pekerjaan IN (1, 2)
          UNION
          /* VALIDASI ALAMAT */
          SELECT nik, 'kolom ALAMAT kosong' AS keterangan
            FROM kur_t_debitur
           WHERE nik IN ('1201085207900002') AND ALAMAT IS NULL
          UNION
          SELECT nik, 'kolom ALAMAT kurang dari 4 karakter' AS keterangan
            FROM kur_t_debitur
           WHERE nik IN ('1201085207900002') AND LENGTH (ALAMAT) < 4
          UNION
          /* VALIDASI KODE_KABKOTA */
          SELECT nik, 'kolom KODE_KABKOTA kosong' AS keterangan
            FROM kur_t_debitur
           WHERE nik IN ('1201085207900002') AND KODE_KABKOTA IS NULL
          UNION
          SELECT nik, 'kolom KODE_KABKOTA kurang dari 4 karakter' AS keterangan
            FROM kur_t_debitur
           WHERE nik IN ('1201085207900002') AND LENGTH (KODE_KABKOTA) < 4
          UNION
          SELECT nik, 'kolom KODE_KABKOTA tidak ada di referensi' AS keterangan
            FROM kur_t_debitur
           WHERE nik IN ('1201085207900002') AND KODE_KABKOTA NOT IN (SELECT kode_wilayah FROM kur_r_wilayah)
          UNION
          /* VALIDASI KODE_POS */
          SELECT nik, 'kolom KODE_POS kosong' AS keterangan
            FROM kur_t_debitur
           WHERE nik IN ('1201085207900002') AND KODE_POS IS NULL
          UNION
          SELECT nik, 'kolom KODE_POS kurang dari 5 karakter' AS keterangan
            FROM kur_t_debitur
           WHERE nik IN ('1201085207900002') AND LENGTH (KODE_POS) < 5
          UNION
          /* VALIDASI NPWP */
          SELECT nik, 'kolom NPWP kosong' AS keterangan
            FROM kur_t_debitur
           WHERE nik IN ('1201085207900002') AND NPWP IS NULL
          UNION
          SELECT nik, 'kolom NPWP kurang dari 15 karakter' AS keterangan
            FROM kur_t_debitur
           WHERE nik IN ('1201085207900002') AND LENGTH (NPWP) < 15
          UNION
          /* VALIDASI MULAI_USAHA */
          SELECT nik, 'kolom MULAI_USAHA kosong' AS keterangan
            FROM kur_t_debitur
           WHERE nik IN ('1201085207900002') AND MULAI_USAHA IS NULL
          UNION
          /* VALIDASI ALAMAT_USAHA */
          SELECT nik, 'kolom ALAMAT_USAHA kosong' AS keterangan
            FROM kur_t_debitur
           WHERE nik IN ('1201085207900002') AND ALAMAT_USAHA IS NULL
          UNION
          /* VALIDASI IJIN_USAHA */
          SELECT nik, 'kolom IJIN_USAHA kosong' AS keterangan
            FROM kur_t_debitur
           WHERE nik IN ('1201085207900002') AND IJIN_USAHA IS NULL
          UNION
          /* VALIDASI MODAL_USAHA */
          SELECT nik, 'kolom MODAL_USAHA kosong' AS keterangan
            FROM kur_t_debitur
           WHERE nik IN ('1201085207900002') AND MODAL_USAHA IS NULL
          UNION
          SELECT nik, 'kolom MODAL_USAHA 0' AS keterangan
            FROM kur_t_debitur
           WHERE nik IN ('1201085207900002') AND MODAL_USAHA = 0
          UNION
          SELECT nik, 'kolom MODAL_USAHA kurang dari 100.000 rupiah' AS keterangan
            FROM kur_t_debitur
           WHERE nik IN ('1201085207900002') AND MODAL_USAHA < 100000
          UNION
          /* VALIDASI JML_PEKERJA */
          SELECT nik, 'kolom JML_PEKERJA kosong' AS keterangan
            FROM kur_t_debitur
           WHERE nik IN ('1201085207900002') AND JML_PEKERJA IS NULL
          UNION
          SELECT nik, 'kolom JML_PEKERJA 0' AS keterangan
            FROM kur_t_debitur
           WHERE nik IN ('1201085207900002') AND JML_PEKERJA < 1
          UNION
          /* VALIDASI JML_KREDIT */
          SELECT nik, 'kolom JML_KREDIT kosong' AS keterangan
            FROM kur_t_debitur
           WHERE nik IN ('1201085207900002') AND JML_KREDIT IS NULL
          UNION
          SELECT nik, 'kolom JML_KREDIT 0' AS keterangan
            FROM kur_t_debitur
           WHERE nik IN ('1201085207900002') AND JML_KREDIT = 0
          UNION
          SELECT nik, 'kolom JML_KREDIT kurang dari 100.000 rupiah' AS keterangan
            FROM kur_t_debitur
           WHERE nik IN ('1201085207900002') AND JML_KREDIT < 100000
          UNION
          /* VALIDASI NO_HP */
          SELECT nik, 'kolom NO_HP kosong' AS keterangan
            FROM kur_t_debitur
           WHERE nik IN ('1201085207900002') AND NO_HP IS NULL
          UNION
          SELECT nik, 'kolom NO_HP kurang dari 10 karakter' AS keterangan
            FROM kur_t_debitur
           WHERE nik IN ('1201085207900002') AND LENGTH (NO_HP) < 10)
GROUP BY nik;

SELECT *
  FROM kur_t_debitur
 WHERE nik IN (SELECT nik
                 FROM kur_t_debitur
                WHERE TO_CHAR (tgl_upload, 'yyyymm') = '202203');

SELECT *
  FROM kur_t_debitur
 WHERE nik = '1201085207900002';

SELECT sekarang,
       tgl_lahir,
       (tahun1 - tahun0) AS thn,
       (bulan1 - bulan0) AS bln,
       (hari1 - hari0) AS hr
  FROM (SELECT TO_CHAR (tgl_lahir, 'yyyy-mm-dd') tgl_lahir,
               TO_CHAR (SYSDATE, 'yyyy-mm-dd') AS sekarang,
               TO_CHAR (tgl_lahir, 'yyyy') tahun0,
               TO_CHAR (SYSDATE, 'yyyy') AS tahun1,
               TO_CHAR (tgl_lahir, 'mm') bulan0,
               TO_CHAR (SYSDATE, 'mm') AS bulan1,
               TO_CHAR (tgl_lahir, 'dd') AS hari0,
               TO_CHAR (SYSDATE, 'dd') AS hari1
          FROM kur_t_debitur
         WHERE nik = '1201085207900002')
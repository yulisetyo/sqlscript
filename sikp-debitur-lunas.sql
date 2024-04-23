/* Formatted on 26/08/2022 17:41:06 (QP5 v5.215.12089.38647) */
  SELECT a.kode_provinsi, a.kode_kabkota, COUNT (*) AS jml_deb_lunas
    FROM (SELECT a.id_pinjaman,
                 a.kode_bank,
                 a.nik,
                 a.rekening_baru AS nomor_rekening,
                 a.nomor_akad,
                 a.nilai_akad,
                 TO_CHAR (a.tgl_akad, 'yyyy-mm-dd') AS tgl_akad,
                 TO_CHAR (a.tgl_jatuh_tempo, 'yyyy-mm-dd') AS tgl_jatuh_tempo,
                 a.nomor_penjaminan,
                 a.nilai_dijamin,
                 a.skema,
                 a.sektor,
                 UPPER (b.nama) AS nama_debitur,
                 UPPER (b.alamat_usaha) AS alamat_usaha,
                 SUBSTR (b.kode_kabkota, 1, 2) AS kode_provinsi,
                 b.kode_kabkota,
                 c.outstanding
            FROM (SELECT * FROM kur_t_akad) a
                 LEFT OUTER JOIN kur_t_debitur b
                    ON (a.kode_bank = b.kode_bank AND a.nik = b.nik)
                 RIGHT OUTER JOIN (  SELECT id_pinjaman,
                                            kode_bank,
                                            nomor_rekening,
                                            MIN (outstanding) AS outstanding
                                       FROM kur_t_transaksi PARTITION (bank008)
                                   GROUP BY id_pinjaman, kode_bank, nomor_rekening) c
                    ON (a.kode_bank = c.kode_bank AND a.rekening_baru = c.nomor_rekening AND a.id_pinjaman = c.id_pinjaman)
           WHERE     a.kode_bank = '008'
                 AND TO_CHAR (a.tgl_akad, 'yyyy') IN ('2019', '2020', '2021', '2022')
                 AND SUBSTR (b.kode_kabkota, 1, 2) = (SELECT kd_wilayah
                                                        FROM kur_r_kanwil
                                                       WHERE kdkanwil = '15')
                 AND c.outstanding = 0) a
GROUP BY a.kode_provinsi, a.kode_kabkota
ORDER BY kode_provinsi, a.kode_kabkota;

  SELECT a.kode_provinsi, a.kode_kabkota, SUM (a.nilai_akad) AS jml_nilai_akad, COUNT (*) AS jml_debitur
    FROM (SELECT a.id_pinjaman,
                 a.kode_bank,
                 a.nik,
                 a.rekening_baru AS nomor_rekening,
                 a.nomor_akad,
                 a.nilai_akad,
                 TO_CHAR (a.tgl_akad, 'yyyy-mm-dd') AS tgl_akad,
                 TO_CHAR (a.tgl_jatuh_tempo, 'yyyy-mm-dd') AS tgl_jatuh_tempo,
                 a.nomor_penjaminan,
                 a.nilai_dijamin,
                 a.skema,
                 a.sektor,
                 UPPER (b.nama) AS nama_debitur,
                 UPPER (b.alamat_usaha) AS alamat_usaha,
                 SUBSTR (b.kode_kabkota, 1, 2) AS kode_provinsi,
                 b.kode_kabkota,
                 c.outstanding
            FROM (SELECT * FROM kur_t_akad) a
                 LEFT OUTER JOIN kur_t_debitur b
                    ON (a.kode_bank = b.kode_bank AND a.nik = b.nik)
                 RIGHT OUTER JOIN (  SELECT id_pinjaman,
                                            kode_bank,
                                            nomor_rekening,
                                            MIN (outstanding) AS outstanding
                                       FROM kur_t_transaksi PARTITION (bank008)
                                      WHERE outstanding > 0
                                   GROUP BY id_pinjaman, kode_bank, nomor_rekening) c
                    ON (a.kode_bank = c.kode_bank AND a.rekening_baru = c.nomor_rekening AND a.id_pinjaman = c.id_pinjaman)
           WHERE     a.kode_bank = '008'
                 AND TO_CHAR (a.tgl_akad, 'yyyy') IN ('2019', '2020', '2021', '2022')
                 AND SUBSTR (b.kode_kabkota, 1, 2) = (SELECT kd_wilayah
                                                        FROM kur_r_kanwil
                                                       WHERE kdkanwil = '15')
                 AND c.outstanding > 0) a
GROUP BY a.kode_provinsi, a.kode_kabkota
ORDER BY kode_provinsi, a.kode_kabkota;
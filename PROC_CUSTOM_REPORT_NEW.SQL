CREATE OR REPLACE PROCEDURE USERKUR.PROC_CUSTOM_REPORT_NEW
AS
BEGIN
	EXECUTE IMMEDIATE 'DROP TABLE KUR_A_CUSTOM_REPORT_NEW';
	
	EXECUTE IMMEDIATE '	
        CREATE TABLE KUR_A_CUSTOM_REPORT_NEW
        AS
             SELECT tahun,
                    bulan,
                    kode_bank,
                    kode_bank_deb,
                    skema,
                    nama_skema,
                    sektor_group,
                    nama_sektor_group,
                    sektor,
                    nama_sektor,
                    kode_provinsi,
                    nama_provinsi,
                    kode_wilayah,
                    nama_wilayah,
                    kode_pendidikan,
                    nama_pendidikan,
                    kode_pekerjaan,
                    nama_pekerjaan,
                    kode_jns_kelamin,
                    nama_jns_kelamin,
                    kode_marital_sts,
                    nama_marital_sts,
                    SUM (jml_debitur) AS jml_debitur,
                    SUM (jml_penyaluran) AS jml_penyaluran,
                    SUM (jml_outstanding) AS jml_outstanding,
                    ROUND (SUM (rencana_kredit), 0) AS rencana_kredit,
                    TO_CHAR (CURRENT_TIMESTAMP, ''yyyy/mm/dd hh24:mi:ss'') AS tgl_update
               FROM (SELECT a.kode_bank,
                            b.kode_bank AS kode_bank_deb,
                            a.skema,
                            d.deskripsi AS nama_skema,
                            a.sektor,
                            e.nama_sektor,
                            e.sektor2 AS sektor_group,
                            f.nama_sektor_group,
                            TO_CHAR (a.tgl_akad, ''mm'') AS bulan,
                            TO_CHAR (a.tgl_akad, ''yyyy'') AS tahun,
                            SUBSTR (b.kode_kabkota, 1, 2) AS kode_provinsi,
                            g.nama_provinsi,
                            SUBSTR (b.kode_kabkota, 1, 4) AS kode_wilayah,
                            h.nama_wilayah,
                            b.pendidikan AS kode_pendidikan,
                            i.nama_pendidikan,
                            b.pekerjaan AS kode_pekerjaan,
                            j.nama_pekerjaan,
                            b.jns_kelamin AS kode_jns_kelamin,
                            k.nama_jns_kelamin,
                            b.maritas_sts AS kode_marital_sts,
                            l.nama_marital_sts,
                            1 AS jml_debitur,
                            b.jml_kredit AS rencana_kredit,
                            a.nilai_akad AS jml_penyaluran,
                            c.outstanding AS jml_outstanding
                       FROM (SELECT kode_bank,
                                    nik,
                                    rekening_baru,
                                    skema,
                                    sektor,
                                    tgl_akad,
                                    nilai_akad
                               FROM kur_t_akad@SIKP_19C) a
                            LEFT JOIN (SELECT kode_bank,
                                              nik,
                                              kode_kabkota,
                                              pendidikan,
                                              pekerjaan,
                                              jns_kelamin,
                                              maritas_sts,
                                              jml_kredit
                                         FROM kur_t_debitur@SIKP_19C) b
                               ON (a.nik = b.nik)
                            LEFT JOIN (  SELECT kode_bank, nomor_rekening, MIN (outstanding) AS outstanding
                                           FROM kur_t_transaksi@SIKP_19C
                                       GROUP BY kode_bank, nomor_rekening) c
                               ON (a.kode_bank = c.kode_bank AND a.rekening_baru = c.nomor_rekening)
                            LEFT JOIN (SELECT DISTINCT skema, deskripsi FROM kur_r_skema) d
                               ON (a.skema = d.skema)
                            LEFT JOIN (SELECT sektor2, sektor, deskripsi AS nama_sektor FROM kur_r_sektor) e
                               ON (a.sektor = e.sektor)
                            LEFT JOIN (SELECT sektor2, deskripsi2 AS nama_sektor_group FROM kur_r_sektor_group) f
                               ON e.sektor2 = f.sektor2
                            LEFT JOIN (SELECT kode_wilayah, nama_wilayah AS nama_provinsi FROM kur_r_wilayah_propinsi) g
                               ON (SUBSTR (b.kode_kabkota, 1, 2) = g.kode_wilayah)
                            LEFT JOIN (SELECT kode_wilayah, nama_wilayah FROM kur_r_wilayah) h
                               ON (b.kode_kabkota = h.kode_wilayah)
                            LEFT JOIN (SELECT pendidikan, deskripsi AS nama_pendidikan FROM kur_r_pendidikan) i
                               ON (b.pendidikan = i.pendidikan)
                            LEFT JOIN (SELECT pekerjaan, deskripsi AS nama_pekerjaan FROM kur_r_pekerjaan) j
                               ON (b.pekerjaan = j.pekerjaan)
                            LEFT JOIN (SELECT kode, nama AS nama_jns_kelamin FROM kur_r_jenis_kelamin) k
                               ON (b.jns_kelamin = k.kode)
                            LEFT JOIN (SELECT marital_sts, deskripsi AS nama_marital_sts FROM kur_r_marital_sts) l
                               ON (b.maritas_sts = l.marital_sts))
           GROUP BY tahun,
                    bulan,
                    kode_bank,
                    kode_bank_deb,
                    skema,
                    nama_skema,
                    sektor_group,
                    nama_sektor_group,
                    sektor,
                    nama_sektor,
                    kode_provinsi,
                    nama_provinsi,
                    kode_wilayah,
                    nama_wilayah,
                    kode_pendidikan,
                    nama_pendidikan,
                    kode_pekerjaan,
                    nama_pekerjaan,
                    kode_jns_kelamin,
                    nama_jns_kelamin,
                    kode_marital_sts,
                    nama_marital_sts /*
           ORDER BY skema,
                    sektor_group,
                    sektor,
                    kode_provinsi,
                    kode_wilayah,
                    kode_pendidikan,
                    kode_pekerjaan */
	';
END PROC_CUSTOM_REPORT_NEW;
/
/* Formatted on 25/11/2025 17:58:16 (QP5 v5.215.12089.38647) */
CREATE TABLE SSRG_A_CUSTOM_REPORT
AS
      SELECT A.KODE_BANK,
             B.NAMA_BANK,
             A.TAHUN,
             A.BULAN,
             U.NAMA_BULAN || ' ' || A.TAHUN AS NAMA_BULAN,
             C.KODE_JNS_KELAMIN,
             C.NAMA_JNS_KELAMIN,
             C.KODE_MARITAL_STS,
             C.NAMA_MARITAL_STS,
             C.KODE_PENDIDIKAN,
             C.NAMA_PENDIDIKAN,
             C.KODE_PEKERJAAN,
             C.NAMA_PEKERJAAN,
             C.KODE_PROVINSI,
             C.NAMA_PROVINSI,
             C.KODE_KABKOTA,
             C.NAMA_KABKOTA,
             C.KODE_POS,
             A.KODE_SKEMA,
             D.KODE_SEKTOR_GROUP,
             E.NAMA_SEKTOR_GROUP,
             A.KODE_SEKTOR,
             D.NAMA_SEKTOR,
             R.KODE_GUDANG,
             S.NAMA_GUDANG,
             R.KODE_KOMODITAS,
             T.NAMA_KOMODITAS,
             SUM (NVL (C.RENCANA_KREDIT, 0)) AS RENCANA_KREDIT,
             SUM (NVL (C.JUMLAH_PEKERJA, 0)) AS JML_PEKERJA,
             SUM (NVL (C.JUMLAH_DEBITUR, 0)) AS JML_DEBITUR,
             SUM (NVL (A.NILAI_AKAD, 0)) AS JML_PENYALURAN,
             SUM (NVL (F.OUTSTANDING, 0)) AS JML_OUTSTANDING,
             TO_CHAR (CURRENT_TIMESTAMP, 'yyyy/mm/dd hh24:mi:ss') AS LAST_UPDATED
        FROM (SELECT KODE_BANK,
                     NIK,
                     REKENING_BARU,
                     NOMOR_AKAD,
                     NO_RESI,
                     TO_CHAR (TGL_AKAD, 'yyyy') AS TAHUN,
                     TO_CHAR (TGL_AKAD, 'mm') AS BULAN,
                     SKEMA AS KODE_SKEMA,
                     SEKTOR AS KODE_SEKTOR,
                     NILAI_AKAD
                FROM SSRG_T_AKAD) A
             LEFT JOIN (SELECT KODE_BANK, TRIM (UPPER (NAMA_BANK)) AS NAMA_BANK FROM KUR_R_BANK) B
                 ON (A.KODE_BANK = B.KODE_BANK)
             LEFT JOIN (SELECT A.KODE_BANK,
                               A.NIK,
                               A.NAMA,
                               TO_CHAR (A.JNS_KELAMIN) AS KODE_JNS_KELAMIN,
                               B.NAMA_JNS_KELAMIN,
                               TO_CHAR (A.MARITAS_STS) AS KODE_MARITAL_STS,
                               C.NAMA_MARITAL_STS,
                               TO_CHAR (A.PENDIDIKAN) AS KODE_PENDIDIKAN,
                               D.NAMA_PENDIDIKAN,
                               TO_CHAR (A.PEKERJAAN) AS KODE_PEKERJAAN,
                               E.NAMA_PEKERJAAN,
                               SUBSTR (A.KODE_KABKOTA, 1, 2) AS KODE_PROVINSI,
                               G.NAMA_PROVINSI,
                               A.KODE_KABKOTA,
                               F.NAMA_KABKOTA,
                               A.KODE_POS,
                               A.JUMLAH_KREDIT AS RENCANA_KREDIT,
                               A.JUMLAH_PEKERJA,
                               1 AS JUMLAH_DEBITUR
                          FROM SSRG_T_DEBITUR A
                               LEFT JOIN (SELECT KODE AS JNS_KELAMIN, NAMA AS NAMA_JNS_KELAMIN FROM KUR_R_JENIS_KELAMIN) B
                                   ON (A.JNS_KELAMIN = B.JNS_KELAMIN)
                               LEFT JOIN (SELECT MARITAL_STS, DESKRIPSI AS NAMA_MARITAL_STS FROM KUR_R_MARITAL_STS) C
                                   ON (A.MARITAS_STS = C.MARITAL_STS)
                               LEFT JOIN (SELECT PENDIDIKAN, DESKRIPSI AS NAMA_PENDIDIKAN FROM KUR_R_PENDIDIKAN) D
                                   ON (A.PENDIDIKAN = D.PENDIDIKAN)
                               LEFT JOIN (SELECT PEKERJAAN, DESKRIPSI AS NAMA_PEKERJAAN FROM KUR_R_PEKERJAAN) E
                                   ON (A.PEKERJAAN = E.PEKERJAAN)
                               LEFT JOIN (SELECT KODE_WILAYAH AS KODE_KABKOTA, NAMA_WILAYAH AS NAMA_KABKOTA FROM KUR_R_WILAYAH) F
                                   ON (A.KODE_KABKOTA = F.KODE_KABKOTA)
                               LEFT JOIN (SELECT KODE_WILAYAH AS KODE_PROVINSI, UPPER (NAMA_WILAYAH) AS NAMA_PROVINSI FROM KUR_R_WILAYAH_PROPINSI) G
                                   ON (SUBSTR (A.KODE_KABKOTA, 1, 2) = G.KODE_PROVINSI)) C
                 ON (A.NIK = C.NIK)
             LEFT JOIN (SELECT DISTINCT SKEMA, DESKRIPSI AS NAMA_SKEMA FROM KUR_R_SKEMA) C
                 ON (A.KODE_SKEMA = C.SKEMA)
             LEFT JOIN (SELECT SEKTOR2 AS KODE_SEKTOR_GROUP, SEKTOR AS KODE_SEKTOR, DESKRIPSI AS NAMA_SEKTOR FROM KUR_R_SEKTOR) D
                 ON (A.KODE_SEKTOR = D.KODE_SEKTOR)
             LEFT JOIN (SELECT SEKTOR2 AS KODE_SEKTOR_GROUP, DESKRIPSI2 AS NAMA_SEKTOR_GROUP FROM KUR_R_SEKTOR_GROUP) E
                 ON (D.KODE_SEKTOR_GROUP = E.KODE_SEKTOR_GROUP)
             LEFT JOIN (  SELECT KODE_BANK, NO_REK, MIN (OUTSTANDING) AS OUTSTANDING
                            FROM SSRG_T_TRANSAKSI
                        GROUP BY KODE_BANK, NO_REK) F
                 ON (A.KODE_BANK = F.KODE_BANK AND A.REKENING_BARU = F.NO_REK)
             LEFT JOIN (SELECT DISTINCT NOMOR_RESI, REG_GUDANG AS KODE_GUDANG, KOMODITAS AS KODE_KOMODITAS FROM SSRG_T_RESIGUDANG) R
                 ON (A.NO_RESI = R.NOMOR_RESI)
             LEFT JOIN (SELECT KODE_REGISTRASI, UPPER (NAMA_GUDANG) AS NAMA_GUDANG, ALAMAT_GUDANG FROM SSRG_T_GUDANG) S
                 ON (R.KODE_GUDANG = S.KODE_REGISTRASI)
             LEFT JOIN (SELECT KODE_KOMODITAS, UPPER (DESKRIPSI) AS NAMA_KOMODITAS FROM SSRG_R_KOMODITAS) T
                 ON (R.KODE_KOMODITAS = T.KODE_KOMODITAS)
             LEFT JOIN (SELECT PERIODE, TRIM (BULAN1) AS NAMA_BULAN FROM KUR_R_PERIODE) U
                 ON (A.BULAN = U.PERIODE)
    GROUP BY A.KODE_BANK,
             B.NAMA_BANK,
             A.TAHUN,
             A.BULAN,
             U.NAMA_BULAN || ' ' || A.TAHUN,
             C.KODE_JNS_KELAMIN,
             C.NAMA_JNS_KELAMIN,
             C.KODE_MARITAL_STS,
             C.NAMA_MARITAL_STS,
             C.KODE_PENDIDIKAN,
             C.NAMA_PENDIDIKAN,
             C.KODE_PEKERJAAN,
             C.NAMA_PEKERJAAN,
             C.KODE_PROVINSI,
             C.NAMA_PROVINSI,
             C.KODE_KABKOTA,
             C.NAMA_KABKOTA,
             C.KODE_POS,
             A.KODE_SKEMA,
             D.KODE_SEKTOR_GROUP,
             E.NAMA_SEKTOR_GROUP,
             A.KODE_SEKTOR,
             D.NAMA_SEKTOR,
             R.KODE_GUDANG,
             S.NAMA_GUDANG,
             R.KODE_KOMODITAS,
             T.NAMA_KOMODITAS;
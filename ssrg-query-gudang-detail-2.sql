/* Formatted on 14/03/2024 12:35:13 (QP5 v5.215.12089.38647) */
SELECT NIK, NO_RESI
  FROM SSRG_T_AKAD
 WHERE KODE_BANK = :KDBANK;

  SELECT *
    FROM TAB
   WHERE TNAME LIKE '%STATUS%'
ORDER BY 1;

SELECT * FROM KUR_R_STATUS_REKENING;

/*
SELECT G.KODE_REGISTRASI,
       G.NAMA_GUDANG,
       G.ALAMAT_GUDANG,
       G.TELP_GUDANG,
       G.EMAIL_GUDANG,
       (G.KODE_KABKOTA || '--' || K.NAMA_WILAYAH) AS KOTA_GUDANG,
       G.KODE_POS,
       G.NM_PENGELOLA
  FROM    SSRG_T_GUDANG G
       LEFT JOIN
          KUR_R_WILAYAH K
       ON (G.KODE_KABKOTA = K.KODE_WILAYAH)
 WHERE G.KODE_REGISTRASI = :KODE_REG; 
*/

/***  DATA GUDANG  ***/

SELECT G.ID,
       G.KODE_REGISTRASI,
       G.NAMA_GUDANG,
       G.ALAMAT_GUDANG,
       G.TELP_GUDANG,
       G.EMAIL_GUDANG,
       (G.KODE_KABKOTA || '--' || K.NAMA_WILAYAH) AS GUDANG_KABKOTA,
       G.NM_PENGELOLA
  FROM SSRG_T_GUDANG G LEFT JOIN KUR_R_WILAYAH K ON (G.KODE_KABKOTA = K.KODE_WILAYAH)
 WHERE G.KODE_REGISTRASI = :KODE_REG;

/**  DATA RESI GUDANG  ***/

SELECT A.NIK,
       TRIM (NVL (D.NAMA, 'N/A')) AS NAMA,
       (A.REG_GUDANG || '--' || C.NAMA_GUDANG) AS REG_GUDANG,
       A.NOMOR_RESI,
       (A.KOMODITAS || '--' || UPPER (B.DESKRIPSI)) AS KOMODITAS,
       A.NILAI_KOMODITAS,
       TO_CHAR (A.TGL_PENJAMINAN, 'YYYY-MM-DD') AS TGL_PENJAMINAN,
       TO_CHAR (A.TGL_TERBIT, 'YYYY-MM-DD') AS TGL_TERBIT,
       TO_CHAR (A.TGL_JATUH_TEMPO, 'YYYY-MM-DD') AS TGL_JATUH_TEMPO,
       A.NAMA_PEMILIK AS PEMILIK_KOMODITAS
  FROM SSRG_T_RESIGUDANG A
       LEFT JOIN SSRG_R_KOMODITAS B
          ON (A.KOMODITAS = B.KODE_KOMODITAS)
       LEFT JOIN SSRG_T_GUDANG C
          ON (A.REG_GUDANG = C.KODE_REGISTRASI)
       LEFT JOIN SSRG_T_DEBITUR D
          ON (A.NIK = D.NIK)
 WHERE A.REG_GUDANG = :KODE_REG;

/***  DATA AKAD ***/

SELECT A.NIK,
       B.NAMA,
       A.NO_RESI,
       A.NM_KEL,
       (A.KODE_BANK || '--' || C.NAMA_BANK) AS BANK,
       (A.STATUS_REKENING || '--' || H.DESKRIPSI) AS STATUS_REKENING,
       A.REKENING_LAMA,
       A.REKENING_BARU,
       (A.STATUS_AKAD || '--' || D.DESKRIPSI) AS STATUS_AKAD,
       A.NILAI_AKAD,
       A.NOMOR_AKAD,
       TO_CHAR (A.TGL_AKAD, 'YYYY-MM-DD') AS TGL_AKAD,
       TO_CHAR (A.TGL_JATUH_TEMPO, 'YYYY-MM-DD') AS TGL_JATUH_TEMPO,
       (A.SKEMA || '--' || TRIM (E.DESKRIPSI)) AS SKEMA,
       (A.SEKTOR || '--' || TRIM (F.DESKRIPSI)) AS SEKTOR,
       (F.SEKTOR2 || '--' || TRIM (G.DESKRIPSI2)) AS SEKTOR_GROUP,
       TO_CHAR (A.TGL_UPDATE, 'YYYY-MM-DD HH24:MI:SS') AS TGL_UPDATE
  FROM SSRG_T_AKAD A
       LEFT JOIN SSRG_T_DEBITUR B
          ON (A.NIK = B.NIK)
       LEFT JOIN KUR_R_BANK C
          ON (A.KODE_BANK = C.KODE_BANK)
       LEFT JOIN KUR_R_STATUS_AKAD D
          ON (A.STATUS_AKAD = D.STATUS_AKAD)
       LEFT JOIN KUR_R_SKEMA E
          ON (A.SKEMA = E.SKEMA)
       LEFT JOIN KUR_R_SEKTOR F
          ON (A.SEKTOR = F.SEKTOR)
       LEFT JOIN KUR_R_SEKTOR_GROUP G
          ON (F.SEKTOR2 = G.SEKTOR2)
       LEFT JOIN KUR_R_STATUS_REKENING H
          ON (A.STATUS_REKENING = H.STATUS_REKENING)
 WHERE A.NO_RESI IN (SELECT NOMOR_RESI
                       FROM SSRG_T_RESIGUDANG
                      WHERE REG_GUDANG = :KODE_REG);
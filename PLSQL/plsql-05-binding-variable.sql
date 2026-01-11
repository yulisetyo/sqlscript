/* Formatted on 07/10/2023 22:11:35 (QP5 v5.215.12089.38647) */
VARIABLE b_pengajuan NUMBER

BEGIN
   SELECT jml_kredit
     INTO :b_pengajuan
     FROM kur_t_debitur
    WHERE nik = '3515112502860001';
END;
/

PRINT b_pengajuan

SELECT nik, nama, jml_kredit
  FROM kur_t_debitur
 WHERE jml_kredit = :b_pengajuan
DESC D_MENU_M;
SELECT * FROM T_PEGAWAI_HRIS;
SELECT * FROM T_USER;

SELECT * FROM TAB WHERE TNAME LIKE 'TEMP_%' ORDER BY 1;

SELECT LENGTH('IC_EPI_T_PROKER') JML_KARAKTER FROM DUAL;
SELECT LENGTH('IC_EPI_T_PROKER_LANGKAH') JML_KARAKTER FROM DUAL;
SELECT LENGTH('IC_EPI_T_KK') JML_KARAKTER FROM DUAL;
SELECT LENGTH('IC_EPI_T_EVA_REVIU_DOKUMEN') JML_KARAKTER FROM DUAL;
SELECT LENGTH('IC_EPI_T_EVA_WAWANCARA') JML_KARAKTER FROM DUAL;
SELECT LENGTH('IC_EPI_T_EVA_SURVEI') JML_KARAKTER FROM DUAL;
SELECT LENGTH('IC_EPI_T_EVA_OBSERVASI') JML_KARAKTER FROM DUAL;

DESC TEMP_T_PROGRAM_KERJA;
DESC TEMP_T_LANGKAH_KERJA;

CREATE TABLE TEMP_R_FAKTOR_EPITE AS SELECT * FROM TEMP_R_FAKTOR;
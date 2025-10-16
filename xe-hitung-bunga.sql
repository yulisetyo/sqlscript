/* Formatted on 22/09/2025 15:06:56 (QP5 v5.215.12089.38647) */
DROP TABLE t_transaksi;

CREATE TABLE t_transaksi
AS
      SELECT kode_bank,
             nomor_rekening,
             LIMIT AS pencairan,
             outstanding AS baki_debet,
             angsuran_pokok,
             tgl_transaksi,
             TO_CHAR (tgl_transaksi, 'YYYYMM') bln_transaksi,
             tgl_pelaporan
        FROM kur_t_transaksi@sikpdev
       WHERE kode_bank = '002' AND nomor_rekening = '463901002538103'
    ORDER BY tgl_transaksi;

SELECT TO_DATE ('22-07-2025', 'DD-MM-YYYY') tanggal,
       TRUNC (TO_DATE ('22-07-2025', 'DD-MM-YYYY'), 'MM') AS awal_bulan,
       LAST_DAY (TO_DATE ('22-07-2025', 'DD-MM-YYYY')) akhir_bulan
  FROM DUAL;

SELECT TRUNC (tgl, 'mm') awal_bulan, tgl AS tgl_sekarang, LAST_DAY (tgl) akhir_bulan
  FROM (SELECT TO_DATE ('22-07-2025', 'DD-MM-YYYY') AS tgl FROM DUAL);

--############################################################################--

DROP TABLE t_transaksi_a;

CREATE TABLE t_transaksi_a
AS
    SELECT kode_bank,
           nomor_rekening,
           pencairan,
           baki_debet,
           angsuran_pokok,
           tgl_transaksi,
           bln_transaksi,
           ROW_NUMBER () OVER (PARTITION BY nomor_rekening ORDER BY tgl_transaksi) AS ord_tgl,
           ROW_NUMBER () OVER (PARTITION BY bln_transaksi ORDER BY tgl_transaksi) AS ord_bln
      FROM t_transaksi
     WHERE kode_bank = '002' AND nomor_rekening = '463901002538103';

--############################################################################--

DROP TABLE t_transaksi_b;

CREATE TABLE t_transaksi_b
AS
    SELECT kode_bank,
           nomor_rekening,
           pencairan,
           baki_debet,
           angsuran_pokok,
           tgl_transaksi,
           bln_transaksi,
           ROW_NUMBER () OVER (PARTITION BY nomor_rekening ORDER BY tgl_transaksi) AS ord_tgl,
           ROW_NUMBER () OVER (PARTITION BY bln_transaksi ORDER BY tgl_transaksi) AS ord_bln
      FROM t_transaksi
     WHERE kode_bank = '002' AND nomor_rekening = '463901002538103' AND pencairan <> baki_debet;

--############################################################################--

SELECT a.kode_bank,
       a.nomor_rekening,
       a.pencairan,
       a.baki_debet,
       a.angsuran_pokok,
       b.baki_debet AS next_baki_debet,
       TRUNC (a.tgl_transaksi, 'MM') bom_transaksi,
       a.tgl_transaksi AS cur_transaksi,
       LAST_DAY (a.tgl_transaksi) eom_transaksi,
       b.tgl_transaksi AS ncur_transaksi,
       a.bln_transaksi,
       b.bln_transaksi AS next_bln_transaksi,
       a.ord_tgl,
       a.ord_bln,
       CASE WHEN a.bln_transaksi = b.bln_transaksi THEN 'sama' ELSE 'beda' END AS jns_bulan
  FROM     (SELECT kode_bank,
                   nomor_rekening,
                   pencairan,
                   baki_debet,
                   angsuran_pokok,
                   tgl_transaksi,
                   bln_transaksi,
                   ROW_NUMBER () OVER (PARTITION BY nomor_rekening ORDER BY tgl_transaksi) AS ord_tgl,
                   ROW_NUMBER () OVER (PARTITION BY bln_transaksi ORDER BY tgl_transaksi) AS ord_bln
              FROM t_transaksi_a
             WHERE kode_bank = '002' AND nomor_rekening = '463901002538103') a
       LEFT JOIN
           (SELECT kode_bank,
                   nomor_rekening,
                   pencairan,
                   baki_debet,
                   angsuran_pokok,
                   tgl_transaksi,
                   bln_transaksi,
                   ROW_NUMBER () OVER (PARTITION BY nomor_rekening ORDER BY tgl_transaksi) AS ord_tgl,
                   ROW_NUMBER () OVER (PARTITION BY bln_transaksi ORDER BY tgl_transaksi) AS ord_bln
              FROM t_transaksi_b
             WHERE kode_bank = '002' AND nomor_rekening = '463901002538103' AND pencairan <> baki_debet) b
       ON (a.kode_bank = b.kode_bank AND a.nomor_rekening = b.nomor_rekening AND a.ord_tgl = b.ord_tgl);

--############################################################################--

  SELECT kode_bank,
         nomor_rekening,
         pencairan,
         baki_debet,
         angsuran_pokok,
         cur_transaksi AS cur,
         ncur_transaksi AS ncur,
         (TRUNC (cur_transaksi, 'MM')) AS bom,
         LAST_DAY (cur_transaksi) eom,
         ord_bln,
         ord_tgl,
         jns_bulan,
         CASE WHEN jns_bulan = 'beda' THEN (eom_transaksi - cur_transaksi) WHEN jns_bulan = 'sama' THEN (ncur_transaksi - cur_transaksi) END AS hb
    FROM (SELECT a.kode_bank,
                 a.nomor_rekening,
                 a.pencairan,
                 a.baki_debet,
                 a.angsuran_pokok,
                 b.baki_debet AS next_baki_debet,
                 a.tgl_transaksi AS cur_transaksi,
                 TRUNC (a.tgl_transaksi, 'MM') bom_transaksi,
                 LAST_DAY (a.tgl_transaksi) eom_transaksi,
                 b.tgl_transaksi AS ncur_transaksi,
                 a.bln_transaksi,
                 b.bln_transaksi AS next_bln_transaksi,
                 a.ord_tgl,
                 a.ord_bln,
                 CASE WHEN a.bln_transaksi = b.bln_transaksi THEN 'sama' ELSE 'beda' END AS jns_bulan
            FROM     (SELECT kode_bank,
                             nomor_rekening,
                             pencairan,
                             baki_debet,
                             angsuran_pokok,
                             tgl_transaksi,
                             bln_transaksi,
                             ROW_NUMBER () OVER (PARTITION BY nomor_rekening ORDER BY tgl_transaksi) AS ord_tgl,
                             ROW_NUMBER () OVER (PARTITION BY bln_transaksi ORDER BY tgl_transaksi) AS ord_bln
                        FROM t_transaksi_a
                       WHERE kode_bank = '002' AND nomor_rekening = '463901002538103') a
                 LEFT JOIN
                     (SELECT kode_bank,
                             nomor_rekening,
                             pencairan,
                             baki_debet,
                             angsuran_pokok,
                             tgl_transaksi,
                             bln_transaksi,
                             ROW_NUMBER () OVER (PARTITION BY nomor_rekening ORDER BY tgl_transaksi) AS ord_tgl,
                             ROW_NUMBER () OVER (PARTITION BY bln_transaksi ORDER BY tgl_transaksi) AS ord_bln
                        FROM t_transaksi_b
                       WHERE kode_bank = '002' AND nomor_rekening = '463901002538103' AND pencairan <> baki_debet) b
                 ON (a.kode_bank = b.kode_bank AND a.nomor_rekening = b.nomor_rekening AND a.ord_tgl = b.ord_tgl))
ORDER BY ord_bln;

--############################################################################--

SELECT KODE_BANK,
       NOMOR_REKENING,
       BAKI_DEBET,
       ANGSURAN_POKOK,
       TGL_TRANSAKSI,
       --bln_transaksi,
       LAST_DAY (TGL_TRANSAKSI) EOM,
       ORD_TGL,
       ORD_BLN
  FROM T_TRANSAKSI_A
 WHERE NOMOR_REKENING = '463901002538103' AND PENCAIRAN = BAKI_DEBET
UNION
SELECT KODE_BANK,
       NOMOR_REKENING,
       BAKI_DEBET,
       ANGSURAN_POKOK,
       TGL_TRANSAKSI,
       --bln_transaksi,
       LAST_DAY (TGL_TRANSAKSI) EOM,
       ORD_TGL,
       ORD_BLN
  FROM T_TRANSAKSI_A
 WHERE NOMOR_REKENING = '463901002538103' AND ORD_TGL = 2;

--############################################################################--

SELECT A.*, ROUND ( (a.BAKI_DEBET * A.DOI * :BUNGA / 360)) VOI, ROUND ( (a.BAKI_DEBET * A.TDOI * :BUNGA / 360)) TVOI
  FROM (SELECT X.*,
               CASE WHEN X.JENIS = 'beda' THEN (LD_TRANS - CD_TRANS + 1) ELSE 0 END AS DOI,
               CASE WHEN X.JENIS = 'beda' THEN CD_TRANS ELSE NULL END AS AWAL,
               CASE WHEN X.JENIS = 'beda' THEN LD_TRANS ELSE NULL END AS AKHIR,
               TO_CHAR (CD_TRANS, 'mm') AS BLN_SUB
          FROM (SELECT A.BAKI_DEBET,
                       A.ANGSURAN_POKOK,
                       TRUNC (A.TGL_TRANSAKSI, 'mm') AS FD_TRANS,
                       A.TGL_TRANSAKSI AS CD_TRANS,
                       LAST_DAY (A.TGL_TRANSAKSI) AS LD_TRANS,
                       TRUNC (B.TGL_TRANSAKSI, 'mm') AS FDNX_TRANS,
                       B.TGL_TRANSAKSI AS NX_TRANS,
                       A.ORD_TGL,
                       CASE WHEN A.BLN_TRANSAKSI = B.BLN_TRANSAKSI THEN 'sama' ELSE 'beda' END AS JENIS,
                       (B.TGL_TRANSAKSI - A.TGL_TRANSAKSI) AS TDOI
                  FROM T_TRANSAKSI_A A LEFT JOIN T_TRANSAKSI_B B ON (A.NOMOR_REKENING = B.NOMOR_REKENING AND A.ORD_TGL = B.ORD_TGL)
                 WHERE A.BLN_TRANSAKSI = '201509') X
        UNION
        SELECT X.*,
               CASE WHEN JENIS = 'beda' THEN (NX_TRANS - FDNX_TRANS) ELSE 0 END AS DOI,
               CASE WHEN JENIS = 'beda' THEN FDNX_TRANS ELSE NULL END AS AWAL,
               CASE WHEN JENIS = 'beda' THEN NX_TRANS ELSE NULL END AS AKHIR,
               TO_CHAR (FDNX_TRANS, 'mm') AS BLN_SUB
          FROM (SELECT A.BAKI_DEBET,
                       A.ANGSURAN_POKOK,
                       TRUNC (A.TGL_TRANSAKSI, 'mm') AS FD_TRANS,
                       A.TGL_TRANSAKSI AS CD_TRANS,
                       LAST_DAY (A.TGL_TRANSAKSI) AS LD_TRANS,
                       TRUNC (B.TGL_TRANSAKSI, 'mm') AS FDNX_TRANS,
                       B.TGL_TRANSAKSI AS NX_TRANS,
                       A.ORD_TGL,
                       CASE WHEN A.BLN_TRANSAKSI = B.BLN_TRANSAKSI THEN 'sama' ELSE 'beda' END AS JENIS,
                       (B.TGL_TRANSAKSI - A.TGL_TRANSAKSI) AS TDOI
                  FROM T_TRANSAKSI_A A LEFT JOIN T_TRANSAKSI_B B ON (A.NOMOR_REKENING = B.NOMOR_REKENING AND A.ORD_TGL = B.ORD_TGL)
                 WHERE A.BLN_TRANSAKSI = '201509') X) A;

--############################################################################--

SELECT A.*, (A.OOC * ROI * (DOI / 360)) AS VOI
  FROM (SELECT 25000000 AS OOC, :bunga AS ROI, 30 AS DOI FROM DUAL) A;

--############################################################################--

  SELECT *
    FROM tab@sikpdev
   WHERE tname LIKE 'KUR_R_%'
ORDER BY 1;

SELECT * FROM t_bunga;
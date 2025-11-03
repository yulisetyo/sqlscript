/* Formatted on 26/09/2025 0:07:09 (QP5 v5.215.12089.38647) */
--DESC tbl_angsuran;
DROP TABLE tbl_angsuran_ready;

--CREATE TABLE tbl_angsuran_ready
--AS
      SELECT a.nomor_rekening,
             a.pencairan,
             a.baki_debet,
             a.angsuran_pokok,
             TRUNC (a.cur_angsuran, 'mm') AS bom_angsuran,
             a.cur_angsuran,
             b.next_angsuran,
             LAST_DAY (a.cur_angsuran) AS eom_angsuran,
             CASE WHEN a.bln = b.bln THEN 'sama' ELSE 'beda' END jns,
             a.bln,
             a.utgl
        FROM     (SELECT nomor_rekening,
                         pencairan,
                         baki_debet,
                         angsuran_pokok,
                         tgl_angsuran AS cur_angsuran,
                         TO_CHAR (tgl_angsuran, 'yyyymm') AS bln,
                         ROW_NUMBER () OVER (PARTITION BY nomor_rekening ORDER BY baki_debet DESC) AS utgl
                    FROM tbl_angsuran
                   WHERE kode_bank = '002' AND nomor_rekening = '032901887654305') a
             LEFT JOIN
                 (SELECT nomor_rekening,
                         tgl_angsuran AS next_angsuran,
                         TO_CHAR (tgl_angsuran, 'yyyymm') AS bln,
                         ROW_NUMBER () OVER (PARTITION BY nomor_rekening ORDER BY baki_debet DESC) AS utgl
                    FROM tbl_angsuran
                   WHERE kode_bank = '002' AND nomor_rekening = '032901887654305' AND angsuran_pokok > 0) b
             ON (a.nomor_rekening = b.nomor_rekening AND a.utgl = b.utgl)
    ORDER BY a.utgl;

SELECT nomor_rekening,
       baki_debet,
       angsuran_pokok,
       bom_angsuran,
       cur_angsuran,
       next_angsuran,
       eom_angsuran,
       jns,
       bln,
       utgl,
       (next_angsuran - cur_angsuran) AS tdoi,
       ROUND ( ( (next_angsuran - cur_angsuran) / 360 * baki_debet * 0.05)) as nsub
  FROM tbl_angsuran_ready
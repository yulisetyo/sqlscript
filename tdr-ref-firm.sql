/* Formatted on 06/11/2025 14:27:18 (QP5 v5.215.12089.38647) */
  SELECT *
    FROM tab
   WHERE LOWER (tname) LIKE 'tdr_%'
ORDER BY tname ASC;

SELECT * FROM tdr_t_trans;

SELECT * FROM tdr_r_counterpart;

CREATE TABLE tdr_r_firm_old AS
SELECT firm,
       firm_name,
       firm_name_legal,
       aktif,
       LENGTH (firm) flen,
       firm AS fc_old,
       LPAD (firm, 6, '0') AS fc_new,
       ROW_NUMBER () OVER (PARTITION BY aktif ORDER BY LENGTH (firm)) seqn
  FROM tdr_r_firm;

SELECT * FROM tdr_r_ljk;
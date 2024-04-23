/* Formatted on 27/10/2023 09:46:53 (QP5 v5.215.12089.38647) */
SELECT a.*,
       b.*,
       a.tday - a.fday,
       a.lday - a.tday,
       b.xtday - b.xfday,
       b.xlday - b.xtday,
       CASE
          WHEN a.inst = 0 AND TO_CHAR (a.tday, 'mm') = TO_CHAR (b.xtday, 'mm') THEN TO_NUMBER (TO_CHAR (b.xtday, 'dd'), '99') - TO_NUMBER (TO_CHAR (a.tday, 'dd'), '99')
          WHEN a.inst = 0 AND TO_CHAR (a.tday, 'mm') <> TO_CHAR (b.xtday, 'mm') THEN TO_NUMBER (TO_CHAR (a.lday, 'dd'), '99') - TO_NUMBER (TO_CHAR (a.tday, 'dd'), '99')
          ELSE 0
       END
          doi1
  FROM    (SELECT account_id AS acid,
                  outstanding AS ostnd,
                  installment AS inst,
                  interest_rate AS rate,
                  LAST_DAY (ADD_MONTHS (transaction_date, -1)) + 1 AS fday,
                  transaction_date AS tday,
                  LAST_DAY (ADD_MONTHS (transaction_date, 0)) AS lday,
                  ROW_NUMBER () OVER (PARTITION BY account_id, TO_CHAR (transaction_date, 'mm') ORDER BY account_id, outstanding DESC) AS orm,
                  ROW_NUMBER () OVER (PARTITION BY account_id ORDER BY account_id, outstanding DESC) AS ort
             FROM tmp_tbl_transaksi) a
       FULL JOIN
          (SELECT account_id AS xacid,
                  outstanding AS xostnd,
                  installment AS xinst,
                  interest_rate AS xrate,
                  LAST_DAY (ADD_MONTHS (transaction_date, -1)) + 1 AS xfday,
                  transaction_date AS xtday,
                  LAST_DAY (ADD_MONTHS (transaction_date, 0)) AS xlday,
                  ROW_NUMBER () OVER (PARTITION BY account_id, TO_CHAR (transaction_date, 'mm') ORDER BY account_id, outstanding DESC) AS xorm,
                  ROW_NUMBER () OVER (PARTITION BY account_id ORDER BY account_id, outstanding DESC) AS xort
             FROM tmp_tbl_transaksi
            WHERE installment <> 0) b
       ON (a.acid = b.xacid AND a.ort = b.xort);
/* Formatted on 27/10/2023 20:48:06 (QP5 v5.215.12089.38647) */
SELECT a.*, (lday - tday + 1) AS tlday
  FROM (SELECT account_id AS acid,
               TO_DATE ('01' || '-' || TO_CHAR (transaction_date, 'mm') || '-' || TO_CHAR (transaction_date, 'yyyy'), 'mm-dd-yyyy') AS fday,
               transaction_date AS tday,
               LAST_DAY (transaction_date) AS lday,
               outstanding AS ostnd,
               installment AS inst,
               interest_rate AS rate,
               ROW_NUMBER () OVER (PARTITION BY account_id ORDER BY account_id, outstanding DESC) AS ort,
               ROW_NUMBER () OVER (PARTITION BY account_id, TO_CHAR (transaction_date, 'mm') ORDER BY account_id, outstanding DESC) AS orm
          FROM tmp_tbl_transaksi) a;

SELECT account_id AS acid,
       TO_DATE ('01' || '-' || TO_CHAR (transaction_date, 'mm') || '-' || TO_CHAR (transaction_date, 'yyyy'), 'mm-dd-yyyy') AS fday,
       transaction_date AS tday,
       LAST_DAY (transaction_date) AS lday,
       outstanding AS ostnd,
       installment AS inst,
       interest_rate AS rate,
       ROW_NUMBER () OVER (PARTITION BY account_id ORDER BY account_id, outstanding DESC) AS ort,
       ROW_NUMBER () OVER (PARTITION BY account_id, TO_CHAR (transaction_date, 'mm') ORDER BY account_id, outstanding DESC) AS orm
  FROM tmp_tbl_transaksi;

SELECT account_id AS acid,
       TO_DATE ('01' || '-' || TO_CHAR (transaction_date, 'mm') || '-' || TO_CHAR (transaction_date, 'yyyy'), 'mm-dd-yyyy') AS fday,
       transaction_date AS tday,
       LAST_DAY (transaction_date) AS lday,
       outstanding AS ostnd,
       installment AS inst,
       interest_rate AS rate,
       ROW_NUMBER () OVER (PARTITION BY account_id ORDER BY account_id, outstanding DESC) AS ort,
       ROW_NUMBER () OVER (PARTITION BY account_id, TO_CHAR (transaction_date, 'mm') ORDER BY account_id, outstanding DESC) AS orm
  FROM tmp_tbl_transaksi
 WHERE installment > 0;

SELECT a.*,
       b.*,
       TO_NUMBER (TO_CHAR (a.tday, 'mm'), '99') AS pmo,
       TO_NUMBER (NVL (TO_CHAR (b.xtday, 'mm'), TO_CHAR (a.tday, 'mm')), '99') AS xpmo,
       lday - tday + 1
  FROM    (SELECT account_id AS acid,
                  TO_DATE ('01' || '-' || TO_CHAR (transaction_date, 'mm') || '-' || TO_CHAR (transaction_date, 'yyyy'), 'mm-dd-yyyy') AS fday,
                  transaction_date AS tday,
                  LAST_DAY (transaction_date) AS lday,
                  outstanding AS ostnd,
                  installment AS inst,
                  interest_rate AS rate,
                  ROW_NUMBER () OVER (PARTITION BY account_id ORDER BY account_id, outstanding DESC) AS ort,
                  ROW_NUMBER () OVER (PARTITION BY account_id, TO_CHAR (transaction_date, 'mm') ORDER BY account_id, outstanding DESC) AS orm
             FROM tmp_tbl_transaksi) a
       FULL JOIN
          (SELECT account_id AS xacid,
                  TO_DATE ('01' || '-' || TO_CHAR (transaction_date, 'mm') || '-' || TO_CHAR (transaction_date, 'yyyy'), 'mm-dd-yyyy') AS xfday,
                  transaction_date AS xtday,
                  LAST_DAY (transaction_date) AS xlday,
                  outstanding AS xostnd,
                  installment AS xinst,
                  interest_rate AS xrate,
                  ROW_NUMBER () OVER (PARTITION BY account_id ORDER BY account_id, outstanding DESC) AS xort,
                  ROW_NUMBER () OVER (PARTITION BY account_id, TO_CHAR (transaction_date, 'mm') ORDER BY account_id, outstanding DESC) AS xorm
             FROM tmp_tbl_transaksi
            WHERE installment > 0) b
       ON (a.acid = b.xacid AND a.ort = b.xort);

SELECT 25 - 7 FROM DUAL;

  SELECT a.acid,
         a.fday,
         a.tday,
         b.xtday,
         b.xlday,
         a.ostnd,
         b.xostnd,
         a.rate,
         (b.xtday - a.tday) AS dfday
    --(a.lday - a.tday) AS afday
    FROM    (SELECT account_id AS acid,
                    TO_DATE (TO_CHAR (transaction_date, 'yyyy') || '-' || TO_CHAR (transaction_date, 'MM') || '-' || '01', 'yyyy-mm-dd') AS fday,
                    TO_DATE (TO_CHAR (transaction_date, 'yyyy-mm-dd'), 'yyyy-mm-dd') AS tday,
                    TO_DATE (TO_CHAR (LAST_DAY (transaction_date), 'yyyy-mm-dd'), 'yyyy-mm-dd') AS lday,
                    outstanding AS ostnd,
                    installment AS inst,
                    interest_rate AS rate,
                    ROW_NUMBER () OVER (PARTITION BY account_id ORDER BY account_id, outstanding DESC) AS ort,
                    ROW_NUMBER () OVER (PARTITION BY account_id, TO_CHAR (transaction_date, 'mm') ORDER BY account_id, outstanding DESC) AS orm
               FROM tmp_tbl_transaksi) a
         FULL JOIN
            (SELECT account_id AS xacid,
                    TO_DATE (TO_CHAR (transaction_date, 'yyyy') || '-' || TO_CHAR (transaction_date, 'MM') || '-' || '01', 'yyyy-mm-dd') AS xfday,
                    TO_DATE (TO_CHAR (transaction_date, 'yyyy-mm-dd'), 'yyyy-mm-dd') AS xtday,
                    TO_DATE (TO_CHAR (LAST_DAY (transaction_date), 'yyyy-mm-dd'), 'yyyy-mm-dd') AS xlday,
                    outstanding AS xostnd,
                    installment AS xinst,
                    interest_rate AS xrate,
                    ROW_NUMBER () OVER (PARTITION BY account_id ORDER BY account_id, outstanding DESC) AS xort,
                    ROW_NUMBER () OVER (PARTITION BY account_id, TO_CHAR (transaction_date, 'mm') ORDER BY account_id, outstanding DESC) AS xorm
               FROM tmp_tbl_transaksi
              WHERE installment > 0) b
         ON (a.acid = b.xacid AND a.ort = b.xort)
ORDER BY ostnd DESC;

SELECT a.*,
       b.*,
       (xtday - tday),
       CASE WHEN inst = 0 AND orm = xorm THEN (xtday - tday) ELSE 0 END subs1
  FROM    (SELECT account_id AS acid,
                  outstanding AS ostnd,
                  installment AS inst,
                  interest_rate AS rate,
                  (LAST_DAY (ADD_MONTHS (transaction_date, -1)) + 1) fday,
                  transaction_date AS tday,
                  LAST_DAY (transaction_date) eday,
                  (LAST_DAY (transaction_date) - transaction_date + 1) bt,
                  transaction_date - (LAST_DAY (ADD_MONTHS (transaction_date, -1)) + 1) at,
                  TO_NUMBER (TO_CHAR (transaction_date, 'mm'), '99') mo,
                  ROW_NUMBER () OVER (PARTITION BY account_id, TO_CHAR (transaction_date, 'mm') ORDER BY account_id, outstanding DESC) orm,
                  ROW_NUMBER () OVER (PARTITION BY account_id ORDER BY account_id, outstanding DESC) AS ort
             FROM tmp_tbl_transaksi
            WHERE account_id = '1100101402672') a
       FULL JOIN
          (SELECT account_id AS xacid,
                  outstanding AS xostnd,
                  installment AS xinst,
                  interest_rate AS xrate,
                  (LAST_DAY (ADD_MONTHS (transaction_date, -1)) + 1) xfday,
                  transaction_date AS xtday,
                  LAST_DAY (transaction_date) xeday,
                  (LAST_DAY (transaction_date) - transaction_date + 1) xbt,
                  transaction_date - (LAST_DAY (ADD_MONTHS (transaction_date, -1)) + 1) xat,
                  TO_NUMBER (TO_CHAR (transaction_date, 'mm'), '99') xmo,
                  ROW_NUMBER () OVER (PARTITION BY account_id, TO_CHAR (transaction_date, 'mm') ORDER BY account_id, outstanding DESC) xorm,
                  ROW_NUMBER () OVER (PARTITION BY account_id ORDER BY account_id, outstanding DESC) AS xort
             FROM tmp_tbl_transaksi
            WHERE account_id = '1100101402672' AND installment > 0) b
       ON (a.acid = b.xacid AND a.ort = b.xort);

/*****/

/*****/

SELECT a.*,
       b.*,
       a.tday - a.fday,
       a.lday - a.tday,
       b.xtday - b.xfday,
       b.xlday - b.xtday
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


-- SELECT LAST_DAY (ADD_MONTHS (SYSDATE, -2)) + 1 First_Day, LAST_DAY (ADD_MONTHS (SYSDATE, -1)) LAST_DAY FROM DUAL;

SELECT *
  FROM kur_t_tagihan_detail PARTITION (bank008)
 WHERE tahun = '2018'
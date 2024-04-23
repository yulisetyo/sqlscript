/* Formatted on 18/05/2021 11:40:49 (QP5 v5.215.12089.38647) */
  SELECT username, password
    FROM t_user
ORDER BY 1;

  SELECT *
    FROM tab
   WHERE LOWER (tname) LIKE '%sasaran%'
ORDER BY 1;

  SELECT *
    FROM d_sasaran
ORDER BY id;

  SELECT *
    FROM d_sasaran_unit
ORDER BY 1;

SELECT * FROM t_unit_dtl;

SELECT a.*, b.nm_unitdtl, parent
  FROM    d_sasaran_unit a
       LEFT JOIN
          t_unit_dtl b
       ON (a.id_unitdtl = b.id_unitdtl);

  SELECT *
    FROM t_kriteria_risiko
   WHERE id_unit = '31.1.1'
ORDER BY LENGTH (id_unit) DESC
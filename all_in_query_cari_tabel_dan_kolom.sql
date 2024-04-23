/* Formatted on 13/03/2024 13:57:49 (QP5 v5.215.12089.38647) */
  SELECT tname
    FROM tab
   WHERE LOWER (tname) LIKE '%risi%'
ORDER BY tname;

  SELECT table_name,
         column_name,
         data_type,
         data_length
    FROM all_tab_columns
   WHERE LOWER (column_name) LIKE '%status%' AND LOWER (table_name) LIKE 't_%'
ORDER BY 1, 2;

  SELECT table_name,
         column_name,
         data_type,
         data_length
    FROM user_tab_columns
   WHERE LOWER (column_name) LIKE '%sts%' AND LOWER (table_name) LIKE 't_%'
ORDER BY 1, 2;

  SELECT table_name,
         column_name,
         data_type,
         data_length
    FROM user_tab_cols
   WHERE LOWER (column_name) LIKE '%sts%' AND LOWER (table_name) LIKE 't_%'
ORDER BY 1, 2;
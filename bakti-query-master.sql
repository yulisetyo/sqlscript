/* Formatted on 11/04/2022 00:53:37 (QP5 v5.215.12089.38647) */
  SELECT *
    FROM r_unit_internal
ORDER BY 2;

SELECT *
  FROM r_ruang_lingkup_tugas
 WHERE tahun = '2022';

UPDATE r_ruang_lingkup_tugas
   SET aktif = 1
 WHERE tahun = '2022';

SELECT *
  FROM r_ruang_lingkup_fungsi
 WHERE tahun = '2022';

  SELECT a.id,
         a.id_tugas,
         a.kd_unit_internal,
         a.nm_fungsi,
         a.tahun,
         b.nm_tugas,
         c.nm_unit_internal
    FROM r_ruang_lingkup_fungsi a
         LEFT JOIN r_ruang_lingkup_tugas b
            ON (a.id_tugas = b.id AND a.tahun = b.tahun)
         LEFT JOIN r_unit_internal c
            ON (a.kd_unit_internal = c.kd_unit_internal)
   WHERE a.aktif = 1 AND a.tahun = '2021'
ORDER BY kd_unit_internal ASC, id_tugas ASC, id ASC;

SELECT *
  FROM d_menu
 WHERE parent_id = 6;

  SELECT *
    FROM t_user
ORDER BY kd_level;

SELECT * FROM r_lvl_user;

SELECT * FROM t_user_level;


  SELECT a.id,
         a.kd_unit_internal,
         a.kd_unit_internal AS unit_internal,
         a.nm_tugas,
         a.tahun,
         a.aktif,
         b.nm_unit_internal
    FROM r_ruang_lingkup_tugas a LEFT JOIN r_unit_internal b ON (a.kd_unit_internal = b.kd_unit_internal)
   WHERE a.aktif = 1 AND tahun = '2021'
ORDER BY kd_unit_internal ASC, id ASC
/* Formatted on 31/03/2023 14:35:57 (QP5 v5.215.12089.38647) */
SELECT *
  FROM tab
 WHERE LOWER (tname) LIKE '%user%';

SELECT *
  FROM T_USER
 WHERE nip = '198307032002121006';                                                       --47521

SELECT *
  FROM T_USER_LEVEL
 WHERE id_user = 47521;

SELECT *
  FROM t_satker
 WHERE kdsatker = '464544';

DESC T_USER_LEVEL;

SELECT *
  FROM T_KPPN
 WHERE KDKPPN = '026';

  SELECT *
    FROM mpt_d_alokasi
ORDER BY kdsatker, nourut;

  SELECT kdsatker,
         thang,
         NVL (MAX (pagu), 0) AS pagu,
         MAX (nourut) AS maxnourut
    FROM mpt_d_alokasi
GROUP BY kdsatker, thang
ORDER BY 1, 2;

SELECT * FROM mp_d_pagu;

DESC t_menu;

  SELECT a.*,
         b.nmsatker,
         c.nmkanwil,
         d.nmkppn
    FROM (SELECT a.kdkanwil,
                 a.kdkppn,
                 a.kdsatker,
                 a.thang,
                 NVL (a.pagu, 0) AS pagu_terkini,
                 NVL (b.pagu, 0) AS pagu_mp,
                 CASE WHEN NVL (a.pagu, 0) > NVL (b.pagu, 0) THEN (NVL (a.pagu, 0) - NVL (b.pagu, 0)) ELSE 0 END AS kelebihan,
                 CASE WHEN NVL (a.pagu, 0) > NVL (b.pagu, 0) THEN 'naik' WHEN NVL (a.pagu, 0) < NVL (b.pagu, 0) THEN 'turun' ELSE 'tetap' END AS tren
            FROM    (  SELECT kdkanwil,
                              kdkppn,
                              kdsatker,
                              thang,
                              NVL (MAX (pagu), 0) AS pagu,
                              MAX (nourut) AS maxnourut
                         FROM mpt_d_alokasi
                        WHERE thang = '2022'
                     GROUP BY kdkanwil,
                              kdkppn,
                              kdsatker,
                              thang) a
                 LEFT JOIN
                    mp_d_pagu b
                 ON (a.thang = b.thang AND a.kdsatker = b.kdsatker)) a
         LEFT JOIN t_satker b
            ON (a.kdsatker = b.kdsatker)
         LEFT JOIN t_kanwil c
            ON (a.kdkanwil = c.kdkanwil)
         LEFT JOIN t_kppn d
            ON (a.kdkppn = d.kdkppn)
   WHERE a.kelebihan > 0
ORDER BY 1,
         2,
         3,
         4
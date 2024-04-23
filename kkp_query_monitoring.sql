/* Formatted on 04/10/2021 04:00:32 (QP5 v5.215.12089.38647) */
  SELECT kdkanwil,
         kdkppn,
         kdsatker,
         nmsatker,
         SUM (kartu_terbit) AS jml_terbit,
         SUM (kartu_aktif) AS jml_aktif,
         SUM (CASE WHEN tahun = '2018' THEN nilai_tag ELSE 0 END) tr1,
         SUM (CASE WHEN tahun = '2019' THEN nilai_tag ELSE 0 END) tr2,
         SUM (CASE WHEN tahun = '2020' THEN nilai_tag ELSE 0 END) tr3,
         SUM (CASE WHEN tahun = '2021' THEN nilai_tag ELSE 0 END) tr4,
         SUM (
            CASE
               WHEN tahun IN ('2018', '2019', '2020', '2021') THEN nilai_tag
               ELSE 0
            END)
            total
    FROM (SELECT c.kdkanwil,
                 NVL (d.nmkanwil, 'Kanwil tidak ada') nmkanwil,
                 b.kdkppn,
                 NVL (c.nmkppn, 'KPPN tidak ada') nmkppn,
                 b.kddept,
                 NVL (e.nmdept, 'K/L/BA tidak ada') nmdept,
                 b.kdunit,
                 NVL (f.nmunit, 'Unit Eselon I tidak ada') nmunit,
                 a.kdsatker,
                 NVL (b.nmsatker, 'Satker tidak ada') nmsatker,
                 a.kdbank,
                 a.tahun,
                 a.bulan,
                 a.kartu_terbit,
                 a.kartu_aktif,
                 t.jns_byr,
                 t.nilai_tag
            FROM kkp_t_kartu a
                 LEFT JOIN t_satker b
                    ON (a.kdsatker = b.kdsatker)
                 LEFT JOIN t_kppn c
                    ON (b.kdkppn = c.kdkppn)
                 LEFT JOIN t_kanwil d
                    ON (c.kdkanwil = d.kdkanwil)
                 LEFT JOIN t_dept e
                    ON (b.kddept = e.kddept)
                 LEFT JOIN t_unit f
                    ON (b.kddept || b.kdunit = f.kddept || f.kdunit)
                 JOIN kkp_t_trans t
                    ON (a.kdsatker || a.kdbank || a.tahun || a.bulan =
                           t.kdsatker || t.kdbank || t.tahun || t.bulan)
           WHERE LENGTH (a.kdsatker) = 6 AND b.kddept = '015')
   WHERE    kddept || kdunit = '01508' AND LOWER (nmsatker) LIKE '%kantor%'
         OR kdsatker = '527010'
GROUP BY kdkanwil,
         kdkppn,
         kdsatker,
         nmsatker
ORDER BY kdkanwil, kdkppn, kdsatker
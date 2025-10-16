/* Formatted on 22/08/2025 11:40:52 (QP5 v5.215.12089.38647) */
  SELECT *
    FROM tab
   WHERE LOWER (tname) LIKE 'tdr%'
ORDER BY 1;

SELECT * FROM TDR_R_STATUS_ALOKASI;

  SELECT a.id,
         a.kode_produk,
         a.nama_produk,
         a.instrument_id,
         b.instrument AS kelompok_produk,
         c.prinsip_trans,
         d.sumber_dana,
         e.skema_settlement,
         f.skema_remun,
         a.cutoff,
         a.incriment,
         a.status,
         DECODE (a.status, '1', 'Aktif', 'Tidak aktif') AS nmstatus,
         TO_CHAR (a.updated_at, 'dd/mm/yyyy hh24:mi:ss') AS updated_at
    FROM tdr_r_produk a
         LEFT JOIN tdr_r_instrument b
             ON (a.instrument_id = b.id)
         LEFT JOIN tdr_r_prinsip_trans c
             ON (a.prinsip_trans_id = c.id)
         LEFT JOIN tdr_r_sumber_dana d
             ON (a.sumber_dana_id = d.id)
         LEFT JOIN tdr_r_skema_settlement e
             ON (a.skema_settlement_id = e.id)
         LEFT JOIN tdr_r_skema_remun f
             ON (a.skema_remun_id = f.id)
ORDER BY a.id DESC;

  SELECT *
    FROM tdr_r_menu
ORDER BY 1 DESC;

  SELECT a.*,
         NVL (b.pagu, 0) AS pagu,
         NVL (b.pagu, 0) + SUM (a.nilai) OVER (ORDER BY a.tanggal ASC) AS sisa_pagu,
         TO_CHAR (a.tanggal, 'dd-mm-yyyy') AS tgl_lelang,
         TO_CHAR (a.tanggal, 'yyyymmdd') AS tglseq
    FROM     (-- cari data pencairan
              SELECT a.tgl_leg1 AS tanggal,
                     a.kode_lelang,
                     'K' AS kddk,
                     -a.target_indikatif AS nilai
                FROM tdr_t_trans a LEFT JOIN tdr_r_status b ON (a.status = b.status)
               WHERE a.instrument_id = 2 AND b.pengurang_pagu = '1'
              UNION ALL
              -- cari data pelunasan
              SELECT a.tgl_leg2 AS tanggal,
                     a.kode_lelang,
                     'D' AS kddk,
                     a.target_indikatif AS nilai
                FROM tdr_t_trans a LEFT JOIN tdr_r_status b ON (a.status = b.status)
               WHERE a.instrument_id = 2 AND b.pengurang_pagu = '1'
              UNION ALL
                -- cari data pencarian real
                SELECT b.tgl_leg1 AS tanggal,
                       b.kode_lelang,
                       'K' AS kddk,
                       -SUM (NVL (a.nilai_leg1_fix, a.nilai_leg1)) AS nilai
                  FROM tdr_t_trans_alokasi a
                       LEFT JOIN tdr_t_trans b
                           ON (a.id_trans = b.id)
                       LEFT JOIN tdr_r_status_alokasi c
                           ON (a.status = c.status)
                 WHERE b.instrument_id = 2 AND c.pengurang_pagu = '1'
              GROUP BY b.tgl_leg1, b.kode_lelang
              UNION ALL
                -- cari data pelunasan real
                SELECT b.tgl_leg2 AS tanggal,
                       b.kode_lelang,
                       'D' AS kddk,
                       SUM (NVL (a.nilai_leg1_fix, a.nilai_leg1)) AS nilai
                  FROM tdr_t_trans_alokasi a
                       LEFT JOIN tdr_t_trans b
                           ON (a.id_trans = b.id)
                       LEFT JOIN tdr_r_status_alokasi c
                           ON (a.status = c.status)
                 WHERE b.instrument_id = 2 AND c.pengurang_pagu = '1'
              GROUP BY b.tgl_leg2, b.kode_lelang) a
         LEFT JOIN
             (SELECT *
                FROM tdr_r_instrument
               WHERE id = 2 AND status = 1) b
         ON (1 = 1)
   WHERE a.tanggal <= TO_DATE ('2025-10-02', 'yyyy-mm-dd')
ORDER BY tglseq, tanggal;
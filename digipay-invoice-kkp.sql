/* Formatted on 30/09/2023 01:16:09 (QP5 v5.215.12089.38647) */
SELECT a.kdsatker,
       c.nmsatker,
       b.minid,
       b.maxid,
       a.thang,
       a.noinvoice,
       TO_CHAR (TO_DATE (a.tgl_invoice, 'yyyy-mm-dd'), 'dd-mm-yyyy') AS tgl_invoice,
       a.id_vendor,
       a.nama_vendor,
       a.alamat_vendor,
       a.norek_vendor,
       a.nmbank_vendor,
       a.virtual_account_number AS no_va,
       a.nmppk AS nama_ppk,
       a.norek_satker,
       a.nmbank_satker,
       a.total_bersih,
       a.total_produk,
       a.ppn,
       ROUND (a.total_bersih * a.tarif_pph / 100) AS pph,
       a.ppn + ROUND (a.total_bersih * a.tarif_pph / 100) AS total_pajak,
       a.total_bersih - ROUND (a.total_bersih * a.tarif_pph / 100) AS total_bayar
  FROM (SELECT a.*,
               NVL (c.tarif_ppn, 0) AS tarif_ppn,
               NVL (c.tarif_pph22, 0) + NVL (c.tarif_pph23, 0) AS tarif_pph,
               a.total_produk - ROUND (a.total_produk * (100 / (100 + NVL (c.tarif_ppn, 0)))) AS ppn,
               ROUND (a.total_produk * (100 / (100 + NVL (c.tarif_ppn, 0)))) AS total_bersih,
               d.status,
               d.virtual_account_number,
               d.how_to_pay_page,
               d.how_to_pay_api,
               d.created_date_utc,
               TO_CHAR (TO_DATE (d.expired_date_utc, 'yyyymmddhh24miss'), 'dd-mm-yyyy hh24:mi:ss') AS expired_date_utc,
               NVL (e.uraian, 'Belum diproses') AS nmstatus,
               f.nama AS nmppk,
               d.code
          FROM (  SELECT a.kdsatker,
                         a.kdppk,
                         a.thang,
                         a.noinvoice,
                         TO_CHAR (a.tginvoice, 'yyyy-mm-dd') AS tgl_invoice,
                         b.id_vendor,
                         c.nama AS nama_vendor,
                         c.alamat AS alamat_vendor,
                         g.norek AS norek_vendor,
                         g.nmrek AS nmrek_vendor,
                         h.norek AS norek_satker,
                         i.nmbank AS nmbank_satker,
                         j.nmbank AS nmbank_vendor,
                         a.metodebyr,
                         l.jenis AS kategori,
                         DECODE (NVL (c.npwp, '000000000000000'), '000000000000000', 0, 1) AS npwp,
                         DECODE (d.kdlokasi, NULL, 0, 1) AS bebaspajak,
                         DECODE (e.id_vendor, NULL, 0, 1) AS npkp,
                         COUNT (*) AS jml_produk,
                         SUM (DECODE (a.transsts, 12, 1, 0)) AS jml_produk_diterima,
                         SUM (a.total) AS total_produk,
                         CASE WHEN SUM (a.total) > 2000000 THEN 1 ELSE 0 END AS brutoklster
                    FROM d_pemesanan a
                         LEFT JOIN d_produk b
                            ON (a.id_produk = b.id)
                         LEFT JOIN d_vendor c
                            ON (b.id_vendor = c.id)
                         LEFT JOIN d_vendor_rek g
                            ON (a.id_rekvendor = g.id)
                         LEFT JOIN t_satker_rek h
                            ON (a.kdsatker = h.kdsatker AND h.aktif = '1')
                         LEFT JOIN t_bank i
                            ON (h.kdbank = i.kdbank)
                         LEFT JOIN t_bank j
                            ON (g.kdbank = j.kdbank)
                         LEFT JOIN t_user k
                            ON (a.id_user_pemesan = k.id)
                         LEFT JOIN t_kategori l
                            ON (b.kategori = l.kategori)
                         LEFT JOIN (                                                                                                                   /* CARI LOKASI BEBAS PAJAK */
                                    SELECT DISTINCT kdlokasi
                                      FROM t_bebaspajak
                                     WHERE aktif = 1) d
                            ON (a.kdlokasi = d.kdlokasi)
                         LEFT JOIN (                                                                                                                    /* CARI NPKP AKTIF VENDOR */
                                    SELECT DISTINCT id_vendor, tglawal, tglakhir
                                      FROM d_vendor_npkp
                                     WHERE aktif = 1) e
                            ON (b.id_vendor = e.id_vendor AND a.tginvoice BETWEEN e.tglawal AND e.tglakhir)
                   WHERE a.kdsatker = '527010' AND a.thang = '2022' AND a.metodebyr = '02' AND a.transsts = 12
                GROUP BY a.kdsatker,
                         a.kdppk,
                         a.thang,
                         a.noinvoice,
                         TO_CHAR (a.tginvoice, 'yyyy-mm-dd'),
                         b.id_vendor,
                         c.nama,
                         c.alamat,
                         g.norek,
                         g.nmrek,
                         g.id_doku,
                         h.norek,
                         i.nmbank,
                         i.url_doku,
                         j.nmbank,
                         a.metodebyr,
                         l.jenis,
                         DECODE (NVL (c.npwp, '000000000000000'), '000000000000000', 0, 1),
                         DECODE (d.kdlokasi, NULL, 0, 1),
                         DECODE (e.id_vendor, NULL, 0, 1)) a
               LEFT JOIN t_ref_tarifpajak b
                  ON (a.bebaspajak = b.bebaspajak AND a.npkp = b.npkp AND a.metodebyr = b.mtdbayar AND a.kategori = b.kat AND a.brutoklster = b.brutoklster AND a.npwp = b.npwp)
               LEFT JOIN t_tarif_persenpajak c
                  ON (b.persenpajak = c.sts_persenpajak)
               LEFT JOIN d_bayar_va d
                  ON (a.kdsatker = d.kdsatker AND a.thang = d.thang AND a.noinvoice = d.noinvoice)
               LEFT JOIN t_status_va e
                  ON (d.status = e.status)
               LEFT JOIN t_ppk f
                  ON (a.kdsatker = f.kdsatker AND a.thang = f.thang AND a.kdppk = f.kdppk)) a
       LEFT JOIN (  SELECT noinvoice, MIN (id) AS minid, MAX (id) AS maxid
                      FROM d_pemesanan
                     WHERE noinvoice IS NOT NULL AND metodebyr = '02'
                  GROUP BY noinvoice) b
          ON (a.noinvoice = b.noinvoice)
       LEFT JOIN (SELECT kdsatker, nmsatker FROM t_satker) c
          ON (a.kdsatker = c.kdsatker)
 WHERE a.noinvoice = '527010/01/20221004/083938';

  -- WHERE (b.minid = 184) OR (b.maxid = 184);

;

SELECT a.id,
       noinvoice,
       b.nama AS produk,
       a.jumlah,
       a.harga,
       a.total,
       NVL (a.nodok, 'N/A') AS nodok,
       NVL (c.nama, 'N/A') AS nama_pemesan,
       NVL (a.ket_vendor, 'N/A') AS ket_vendor
  FROM d_pemesanan a
       LEFT JOIN d_produk b
          ON (a.id_produk = b.id)
       LEFT JOIN t_user c
          ON (a.id_user_pemesan = c.id)
 WHERE a.id = 184 OR a.id = 184;

  SELECT noinvoice, MIN (id) AS minid, MAX (id) AS maxid
    FROM d_pemesanan
   WHERE noinvoice IS NOT NULL AND metodebyr = '01' AND kdsatker = '527010' AND thang = '2022'
GROUP BY noinvoice;

  SELECT noinvoice, ROW_NUMBER () OVER (PARTITION BY noinvoice ORDER BY noinvoice) urutan, LISTAGG (id, '|') WITHIN GROUP (ORDER BY noinvoice) OVER (PARTITION BY noinvoice) list_id
    FROM d_pemesanan
   WHERE metodebyr = '02'                                                                                                           --group by noinvoice having count(noinvoice) > 1
ORDER BY 1;
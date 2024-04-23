/* Formatted on 04/10/2023 17:33:54 (QP5 v5.215.12089.38647) */
SELECT *
  FROM tab
 WHERE tname LIKE '%VEND%';

SELECT norek FROM D_VENDOR_REK;

SELECT * FROM d_pemesanan;


SELECT a.kdsatker,
       m.alamat_satker,
       a.thang,
       a.noinvoice,
       TO_CHAR (TO_DATE (a.tgl_invoice, 'yyyy-mm-dd'), 'dd-mm-yyyy') AS tgl_invoice,
       a.id_vendor,
       UPPER (a.nama_vendor) AS nama_vendor,
       v.alamat_vendor,
       v.telp_vendor,
       v.email_vendor,
       v.npwp_vendor,
       v.kota_vendor,
       v.kdpos_vendor,
       a.norek_vendor,
       a.nmrek_vendor,
       a.nmbank_vendor,
       a.virtual_account_number AS no_va,
       a.expired_date_utc AS exp_va,
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
                         LEFT JOIN (                                                                                                                   /* cari lokasi bebas pajak */
                                    SELECT DISTINCT kdlokasi
                                      FROM t_bebaspajak
                                     WHERE aktif = 1) d
                            ON (a.kdlokasi = d.kdlokasi)
                         LEFT JOIN (                                                                                                                    /* cari npkp aktif vendor */
                                    SELECT DISTINCT id_vendor, tglawal, tglakhir
                                      FROM d_vendor_npkp
                                     WHERE aktif = 1) e
                            ON (b.id_vendor = e.id_vendor AND a.tginvoice BETWEEN e.tglawal AND e.tglakhir)
                   WHERE a.kdsatker = '527010' AND a.thang = '2022' AND a.metodebyr = '01' AND a.transsts = 12
                GROUP BY a.kdsatker,
                         a.kdppk,
                         a.thang,
                         a.noinvoice,
                         TO_CHAR (a.tginvoice, 'yyyy-mm-dd'),
                         b.id_vendor,
                         c.nama,
                         g.norek,
                         g.nmrek,
                         g.id_doku,
                         h.norek,
                         i.nmbank,
                         i.url_doku,
                         i.nmbank,
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
       LEFT JOIN (SELECT kdsatker, alamat AS alamat_satker
                    FROM t_satker_alamat
                   WHERE aktif = 1) m
          ON (a.kdsatker = m.kdsatker)
       LEFT JOIN (SELECT v.id,
                         NVL (UPPER (v.nama), '_') AS nama_vendor,
                         NVL (TRIM (v.alamat), 'N/A') AS alamat_vendor,
                         NVL (v.telp, '021-XXX') AS telp_vendor,
                         NVL (v.email, 'test@fakemail.info') AS email_vendor,
                         NVL (v.npwp, '000000000000000') AS npwp_vendor,
                         NVL (w.nmlokasi, '') AS kota_vendor,
                         NVL (v.kdpos, 'XXXXX') AS kdpos_vendor
                    FROM d_vendor v LEFT JOIN t_lokasi w ON (v.kdlokasi = w.kdlokasi)) v
          ON (a.id_vendor = v.id)
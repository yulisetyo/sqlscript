/* Formatted on 08/08/2023 14:53:23 (QP5 v5.215.12089.38647) */
select kode_bank,
       nomor_rekening,
       tgl_transaksi as tanggal_awal,
       tgl_next_trx as tanggal_akhir,
       hari_bunga,
       outstanding,
       bunga,
       periode_bunga,
       0 is_subtracted
  from (select a.*, round ( ( (outstanding * hari_bunga) / 360) * nvl (tingkat_bunga, 0), 0) bunga
          from (select kode_bank,
                       nomor_rekening,
                       tgl_transaksi,
                       tgl_next_trx,
                       outstanding,
                       case when (tgl_next_trx = last_day (tgl_next_trx) and urutan = 1) then tgl_next_trx - tgl_transaksi + 1 else tgl_next_trx - tgl_transaksi end hari_bunga,
                       last_day (tgl_transaksi) periode_bunga
                  from (select ket,
                               kode_bank,
                               nomor_rekening,
                               tgl_transaksi,
                               tgl_next_trx,
                               outstanding,
                               row_number () over (partition by kode_bank, nomor_rekening order by tgl_transaksi desc) urutan
                          from (select 'NFT' ket, /* SELAIN TRANSAKSI PERTAMA DI BULAN BERKENAAN - NON FIRST TRANSACTION */
                                       a.kode_bank,
                                       a.nomor_rekening,
                                       a.tgl_transaksi,
                                       case
                                          when b.tgl_next_trx is not null then b.tgl_next_trx
                                          when b.tgl_next_trx is null and last_day (a.tgl_transaksi) <= tgl_jatuh_tempo then last_day (a.tgl_transaksi)
                                          when b.tgl_next_trx is null and last_day (a.tgl_transaksi) > tgl_jatuh_tempo then tgl_jatuh_tempo
                                       end
                                          tgl_next_trx,
                                       outstanding,
                                       case when to_char (a.tgl_transaksi, 'dd') = '01' or limit = outstanding then a.urutan - 1 else a.urutan end urutan
                                  from    (select x.kode_bank,
                                                  nomor_rekening,
                                                  tgl_jatuh_tempo,
                                                  tgl_transaksi,
                                                  limit,
                                                  outstanding,
                                                  angsuran_pokok,
                                                  row_number () over (partition by x.kode_bank, x.nomor_rekening order by tgl_transaksi) urutan
                                             from    (select kode_bank,
                                                             nomor_rekening,
                                                             tgl_transaksi,
                                                             limit,
                                                             outstanding,
                                                             angsuran_pokok
                                                        from kur_t_transaksi
                                                       where     kode_bank = '002'
                                                             and to_char (tgl_transaksi, 'mm') = '01'
                                                             and to_char (tgl_transaksi, 'yyyy') = '2016'
                                                             and b_limit = 0) x
                                                  join
                                                     (select kode_bank, rekening_baru, tgl_jatuh_tempo
                                                        from kur_t_akad
                                                       where kode_bank = '002') y
                                                  on x.kode_bank = y.kode_bank and x.nomor_rekening = y.rekening_baru and x.tgl_transaksi <= y.tgl_jatuh_tempo) a
                                       full join
                                          (select kode_bank,
                                                  nomor_rekening,
                                                  tgl_transaksi,
                                                  tgl_transaksi tgl_next_trx,
                                                  urutan - 1 urutan
                                             from (select x.kode_bank,
                                                          nomor_rekening,
                                                          tgl_transaksi,
                                                          row_number () over (partition by x.kode_bank, nomor_rekening order by tgl_transaksi) urutan
                                                     from    (select kode_bank, nomor_rekening, tgl_transaksi
                                                                from kur_t_transaksi
                                                               where     kode_bank = '002'
                                                                     and to_char (tgl_transaksi, 'mm') = '01'
                                                                     and to_char (tgl_transaksi, 'yyyy') = '2016'
                                                                     and b_limit = 0) x
                                                          join
                                                             (select kode_bank, rekening_baru, tgl_jatuh_tempo
                                                                from kur_t_akad
                                                               where kode_bank = '002') y
                                                          on x.kode_bank = y.kode_bank and x.nomor_rekening = y.rekening_baru and x.tgl_transaksi <= y.tgl_jatuh_tempo)
                                            where urutan > 1) b
                                       on a.kode_bank = b.kode_bank and a.nomor_rekening = b.nomor_rekening and a.urutan = b.urutan
                                union all
                                select 'FT' ket, /* TRANSAKSI PERTAMA DI BULAN BERKENAAN - FIRST TRANSACTION */
                                       a.kode_bank,
                                       a.nomor_rekening,
                                       to_date ('01-01-2016', 'dd-mm-yyyy') tgl_transaksi,
                                       b.tgl_transaksi as tgl_next_trx,
                                       last_outstanding as outstanding,
                                       0 urutan
                                  from    (select kode_bank,
                                                  nomor_rekening,
                                                  tgl_transaksi,
                                                  outstanding as last_outstanding
                                             from (select kode_bank,
                                                          nomor_rekening,
                                                          tgl_transaksi,
                                                          outstanding,
                                                          row_number () over (partition by kode_bank, nomor_rekening order by tgl_transaksi desc) urutan
                                                     from kur_t_transaksi
                                                    where kode_bank = '002' and tgl_transaksi < to_date ('01-01-2016', 'dd-mm-yyyy'))
                                            where urutan = 1) a
                                       join
                                          (select *
                                             from (select a.kode_bank,
                                                          a.nomor_rekening,
                                                          a.tgl_transaksi,
                                                          nvl (b.tgl_next_trx, last_day (a.tgl_transaksi)) tgl_next_trx,
                                                          outstanding,
                                                          angsuran_pokok,
                                                          case when to_char (a.tgl_transaksi, 'dd') = '01' then a.urutan - 1 else a.urutan end urutan
                                                     from    (select x.kode_bank,
                                                                     nomor_rekening,
                                                                     tgl_transaksi,
                                                                     limit,
                                                                     outstanding,
                                                                     angsuran_pokok,
                                                                     row_number () over (partition by x.kode_bank, nomor_rekening order by tgl_transaksi) urutan
                                                                from    (select kode_bank,
                                                                                nomor_rekening,
                                                                                tgl_transaksi,
                                                                                limit,
                                                                                outstanding,
                                                                                angsuran_pokok
                                                                           from kur_t_transaksi
                                                                          where     kode_bank = '002'
                                                                                and to_char (tgl_transaksi, 'mm') = '01'
                                                                                and to_char (tgl_transaksi, 'yyyy') = '2016'
                                                                                and b_limit = 0) x
                                                                     join
                                                                        (select kode_bank, rekening_baru, tgl_jatuh_tempo
                                                                           from kur_t_akad
                                                                          where kode_bank = '002') y
                                                                     on x.kode_bank = y.kode_bank and x.nomor_rekening = y.rekening_baru and x.tgl_transaksi <= y.tgl_jatuh_tempo) a
                                                          full join
                                                             (select kode_bank,
                                                                     nomor_rekening,
                                                                     tgl_transaksi,
                                                                     tgl_transaksi tgl_next_trx,
                                                                     urutan - 1 urutan
                                                                from (select x.kode_bank,
                                                                             nomor_rekening,
                                                                             tgl_transaksi,
                                                                             row_number () over (partition by x.kode_bank, nomor_rekening order by tgl_transaksi) urutan
                                                                        from    (select kode_bank, nomor_rekening, tgl_transaksi
                                                                                   from kur_t_transaksi
                                                                                  where     kode_bank = '002'
                                                                                        and to_char (tgl_transaksi, 'mm') = '01'
                                                                                        and to_char (tgl_transaksi, 'yyyy') = '2016'
                                                                                        and b_limit = 0) x
                                                                             join
                                                                                (select kode_bank, rekening_baru, tgl_jatuh_tempo
                                                                                   from kur_t_akad
                                                                                  where kode_bank = '002') y
                                                                             on     x.kode_bank = y.kode_bank
                                                                                and x.nomor_rekening = y.rekening_baru
                                                                                and x.tgl_transaksi <= y.tgl_jatuh_tempo)
                                                               where urutan > 1) b
                                                          on a.kode_bank = b.kode_bank and a.nomor_rekening = b.nomor_rekening and a.urutan = b.urutan)
                                            where urutan = 1) b
                                       on a.kode_bank = b.kode_bank and a.nomor_rekening = b.nomor_rekening
                                union all
                                select 'NT' ket, /* TIDAK ADA TRANSAKSI DI BULAN BERKENAAN - NO TRANSACTION */
                                       a.kode_bank,
                                       a.nomor_rekening,
                                       to_date ('01-01-2016', 'dd-mm-yyyy') tgl_transaksi,
                                       case
                                          when c.tgl_jatuh_tempo >= to_date ('01-01-2016', 'dd-mm-yyyy') and c.tgl_jatuh_tempo < last_day (to_date ('01-01-2016', 'dd-mm-yyyy'))
                                          then
                                             c.tgl_jatuh_tempo
                                          else
                                             last_day (to_date ('01-01-2016', 'dd-mm-yyyy'))
                                       end
                                          tgl_next_trx,
                                       last_outstanding as outstanding,
                                       0 urutan
                                  from (select kode_bank, nomor_rekening, outstanding as last_outstanding
                                          from (select kode_bank,
                                                       nomor_rekening,
                                                       tgl_transaksi,
                                                       outstanding,
                                                       row_number () over (partition by kode_bank, nomor_rekening order by tgl_transaksi desc) urutan
                                                  from kur_t_transaksi
                                                 where kode_bank = '002' and tgl_transaksi < to_date ('01-01-2016', 'dd-mm-yyyy'))
                                         where urutan = 1) a
                                       left join (select distinct x.kode_bank, nomor_rekening
                                                    from    (select kode_bank, nomor_rekening, tgl_transaksi
                                                               from kur_t_transaksi
                                                              where     kode_bank = '002'
                                                                    and to_char (tgl_transaksi, 'mm') = '01'
                                                                    and to_char (tgl_transaksi, 'yyyy') = '2016'
                                                                    and b_limit = 0) x
                                                         join
                                                            (select kode_bank, rekening_baru, tgl_jatuh_tempo
                                                               from kur_t_akad
                                                              where kode_bank = '002') y
                                                         on x.kode_bank = y.kode_bank and x.nomor_rekening = y.rekening_baru and x.tgl_transaksi <= y.tgl_jatuh_tempo) b
                                          on a.kode_bank = b.kode_bank and a.nomor_rekening = b.nomor_rekening
                                       join (select kode_bank, rekening_baru, tgl_jatuh_tempo
                                               from kur_t_akad
                                              where kode_bank = '002') c
                                          on a.kode_bank = c.kode_bank and a.nomor_rekening = c.rekening_baru
                                 where b.kode_bank is null and last_outstanding != 0 and tgl_jatuh_tempo > to_date ('01-01-2016', 'dd-mm-yyyy')))
                 where outstanding > 0) a
               join kur_t_akad b
                  on a.kode_bank = b.kode_bank and a.nomor_rekening = b.rekening_baru
               left join (select id, tingkat_bunga from kur_r_tingkat_bunga) c
                  on b.id_tk_bunga = c.id)
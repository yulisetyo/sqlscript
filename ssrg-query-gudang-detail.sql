/* Formatted on 12/03/2024 03:01:41 (QP5 v5.215.12089.38647) */
select lower (tname)
  from tab
 where lower (tname) like '%gudang%';

select g.id,
       g.kode_registrasi,
       g.nama_gudang,
       g.alamat_gudang,
       g.telp_gudang,
       g.email_gudang,
       (g.kode_kabkota || ' -- ' || k.nama_wilayah) as gudang_kabkota,
       g.nm_pengelola
  from ssrg_t_gudang g left join kur_r_wilayah k on (g.kode_kabkota = k.kode_wilayah)
 where g.id = :id_gudang;
 
 select r.id, r.reg_gudang, r.nomor_resi, (r.komoditas||' -- '||k.deskripsi) as komoditas,  
 from ssrg_t_resigudang r
 left join ssrg_r_komoditas k on (r.komoditas=k.kode_komoditas) 
/* Formatted on 24/07/2024 15:28:44 (QP5 v5.215.12089.38647) */
  SELECT *
    FROM t_jnsdok
ORDER BY 1;

SELECT * FROM d_dok;

  SELECT a.*, CASE WHEN NIP IS NOT NULL THEN 'Sudah' ELSE 'Belum' END AS status_upload
    FROM     (  SELECT id,
                       flag,
                       jnsdok,
                       jnsdok1,
                       aktif
                  FROM t_jnsdok
                 WHERE idlvldok = 1 AND aktif = 1
              ORDER BY id ASC, flag DESC) a
         LEFT JOIN
             (SELECT a.*, b.nama
                FROM d_dok a LEFT JOIN t_pegawai b ON (a.nip = b.nip)
               WHERE a.nip = '198508142007101001') b
         ON (a.id = b.idjnsdok)
ORDER BY b.nip ASC, a.flag desc, a.id ASC
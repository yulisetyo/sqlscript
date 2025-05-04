/* Formatted on 18/12/2024 17:09:44 (QP5 v5.215.12089.38647) */
SELECT * FROM ic_r_probis;

SELECT * FROM ic_r_probis_unit;

SELECT * FROM ic_r_probis_giat;

SELECT * FROM ic_r_probis_giat_kendali;

SELECT * FROM ic_r_probis_giat_kendali_trpu;

/* PROBIS UNUT */

  SELECT a.id,
         a.id_probis,
         b.uraian AS nm_probis,
         a.kd_unit_internal,
         c.nm_unit_internal
    FROM ic_r_probis_unit a
         LEFT JOIN ic_r_probis b
             ON (a.id_probis = b.id)
         LEFT JOIN r_unit_internal c
             ON (a.kd_unit_internal = c.kd_unit_internal)
ORDER BY kd_unit_internal;

/* KEGIATAN UTAMA */

  SELECT a.id,
         a.id_probis,
         b.uraian AS nm_probis,
         a.kd_unit_internal,
         c.nm_unit_internal,
         d.id AS id_kegiatan_utama,
         d.uraian AS nm_kegiatan_utama
    FROM ic_r_probis_unit a
         LEFT JOIN ic_r_probis b
             ON (a.id_probis = b.id)
         LEFT JOIN r_unit_internal c
             ON (a.kd_unit_internal = c.kd_unit_internal)
         LEFT JOIN ic_r_probis_giat d
             ON (d.id_probis = a.id_probis)
   WHERE d.id IS NOT NULL
ORDER BY kd_unit_internal, id_probis, id_kegiatan_utama;

/* PENGENDALIAN ATAS KEGIATAN */

  SELECT a.kd_unit_internal,
         c.nm_unit_internal,
         a.id_probis,
         b.uraian AS nm_probis,
         d.id AS id_kegiatan_utama,
         d.uraian AS nm_kegiatan_utama,
         e.id AS id_kendali,
         e.uraian AS nm_kendali
    FROM ic_r_probis_unit a
         JOIN ic_r_probis b
             ON (a.id_probis = b.id)
         JOIN r_unit_internal c
             ON (a.kd_unit_internal = c.kd_unit_internal)
         JOIN ic_r_probis_giat d
             ON (d.id_probis = a.id_probis)
         JOIN ic_r_probis_giat_kendali e
             ON (d.id = e.id_probis_giat)
ORDER BY kd_unit_internal ASC,
         id_probis ASC,
         id_kegiatan_utama ASC,
         id_kendali ASC;
         
  SELECT a.kd_unit_internal,
         c.nm_unit_internal,
         a.id_probis,
         b.uraian AS nm_probis,
         d.id AS id_kegiatan_utama,
         d.uraian AS nm_kegiatan_utama,
         e.id AS id_kendali,
         e.uraian AS nm_kendali
    FROM ic_r_probis_unit a
         JOIN ic_r_probis b
             ON (a.id_probis = b.id)
         JOIN r_unit_internal c
             ON (a.kd_unit_internal = c.kd_unit_internal)
         JOIN ic_r_probis_giat d
             ON (d.id_probis = a.id_probis)
         JOIN ic_r_probis_giat_kendali e
             ON (d.id = e.id_probis_giat)
   WHERE a.kd_unit_internal = '02'
ORDER BY kd_unit_internal ASC,
         id_probis ASC,
         id_kegiatan_utama ASC,
         id_kendali ASC;
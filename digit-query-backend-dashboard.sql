/* Formatted on 20/02/2025 19:57:59 (QP5 v5.215.12089.38647) */
-- Query Master Pembaharuan Terakhir

SELECT last_run
  FROM mon_agent_olap
 WHERE jns_agent = 'DASBR';

-- Query Master Rekapitulasi Pengguna

SELECT jml_user,
       jml_user_aktif,
       ROUND ( (jml_user_aktif / jml_user) * 100, 2) persen_aktif,
       jml_user_validnik,
       ROUND ( (jml_user_validnik / jml_user) * 100, 2) persen_validnik,
       jml_user_validnip,
       ROUND ( (jml_user_validnip / jml_user) * 100, 2) persen_validnip
  FROM dash_rekapuser
 WHERE id = (SELECT MAX (id) FROM dash_rekapuser);

-- Query Master Rekapitulasi Aktivitas Pengguna

SELECT frq_sesi,
       avg_sesidurasi,
       frq_sukseslogin,
       ROUND ( (frq_sukseslogin / frq_sesi) * 100, 2) persen_sukseslogin,
       jml_devicedesktop,
       ROUND ( (jml_devicedesktop / frq_sesi) * 100, 2) persen_desktop,
       jml_devicemobile,
       ROUND ( (jml_devicemobile / frq_sesi) * 100, 2) persen_mobile,
       jml_devicetablet,
       ROUND ( (jml_devicetablet / frq_sesi) * 100, 2) persen_tablet,
       jml_devicelainnya,
       ROUND ( (jml_devicelainnya / frq_sesi) * 100, 2) persen_lainnya
  FROM dash_rekaplog
 WHERE id = (SELECT MAX (id) FROM dash_rekaplog);

-- Query Master Login Harian dan Rerata Durasi Sesi

  SELECT hari_akses, SUM (frq_sesi) sesi_harian, ROUND (AVG (avg_sesidurasi), 2) * 60 rerata_durasi
    FROM dash_processlog
   WHERE TO_DATE (tgl_akses, 'YY/MM/DD') BETWEEN TO_DATE (:tgl_awal, 'YY/MM/DD') AND TO_DATE (:tgl_akhir, 'YY/MM/DD')
GROUP BY hari_akses
ORDER BY hari_akses;

 -- Query Master Kinerja Services

  SELECT nama_app,
         ic_app,
         jml_akses,
         seq
    FROM (  SELECT 'app' AS app,
                   nama_app,
                   NVL (ic_app, 'no-image.png') ic_app,
                   jml_akses,
                   ROW_NUMBER () OVER (PARTITION BY 'app' ORDER BY jml_akses DESC) AS seq
              FROM (  SELECT nama_app, ic_app, SUM (jml_akses) AS jml_akses
                        FROM dash_processapplog
                       WHERE TO_DATE (tgl_akses, 'YY/MM/DD') BETWEEN TO_DATE (:tgl_awal, 'YY/MM/DD') AND TO_DATE (:tgl_akhir, 'YY/MM/DD')
                    GROUP BY nama_app, ic_app)
          ORDER BY jml_akses DESC)
   WHERE seq <= 5
ORDER BY seq ASC;

-- Query Master Tingkat Keberhasilan Login

  SELECT hari_akses,
         SUM (frq_sesi) sesi_harian,
         SUM (frq_sukseslogin) sukses_login,
         ROUND ( (SUM (frq_sukseslogin) / SUM (frq_sesi)) * 100, 2) persen_login,
         100 - ROUND ( (SUM (frq_sukseslogin) / SUM (frq_sesi)) * 100, 2) persen_gagal
    FROM dash_processlog
   WHERE TO_DATE (tgl_akses, 'YY/MM/DD') BETWEEN TO_DATE (:tgl_awal, 'YY/MM/DD') AND TO_DATE (:tgl_akhir, 'YY/MM/DD')
GROUP BY hari_akses
ORDER BY hari_akses;

-- Query Master Kecepatan Login

SELECT * FROM DASH_PROCESSSIGNIN;

SELECT SUM (q1_login) AS q1_login,
       SUM (q2_login) AS q2_login,
       SUM (q3_login) AS q3_login,
       SUM (q4_login) AS q4_login,
       SUM (q5_login) AS q5_login
  FROM dash_processsignin
 WHERE TO_DATE (tgl_akses, 'YY/MM/DD') BETWEEN TO_DATE (:tgl_awal, 'YY/MM/DD') AND TO_DATE (:tgl_akhir, 'YY/MM/DD');
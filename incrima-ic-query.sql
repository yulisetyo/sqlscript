/* Formatted on 08/05/2024 16:40:43 (QP5 v5.391) */
SELECT *
  FROM tab
 WHERE LOWER (tname) LIKE '%lvl%';
 
SELECT * FROM T_UNIT_DTL WHERE ID_UNITDTL LIKE '3507%';
 
SELECT * FROM R_UNIT_INTERNAL;

SELECT * FROM R_PROSES_BISNIS;

SELECT * FROM R_TIPE_PROBIS;

SELECT * FROM IC_R_PROBIS;

SELECT * FROM IC_R_PROBIS_GIAT;

SELECT * FROM IC_R_PROBIS_TEMUAN;

SELECT * FROM IC_R_PROBIS_UNIT;

SELECT * FROM R_PEMILIK_PROBIS;

SELECT * FROM T_PEMILIK_PROBIS;

SELECT * FROM IC_T_LAT;

SELECT * FROM R_LVL_UNIT;

SELECT * FROM R_LVL_UKI;

SELECT * FROM T_USER WHERE nip = '198307032002121006';

SELECT * FROM T_USER_LEVEL WHERE id_user = '365';

SELECT LENGTH (str), str
  FROM (SELECT 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Vel risus commodo viverra maecenas accumsan. In nulla posuere sollicitudin aliquam ultrices sagittis orci a scelerisque. Porttitor eget dolor morbi non arcu risus quis varius quam. Eget gravida cum sociis natoque penatibus et magnis. Tellus id interdum velit laoreet id donec ultrices tincidunt. Ac tortor dignissim convallis aenean et tortor at risus. Ut diam quam nulla porttitor massa id. Cursus mattis molestie a iaculis at. Sit amet commodo nulla facilisi nullam vehicula. Id velit ut tortor pretium viverra suspendisse. Suspendisse sed nisi lacus sed viverra tellus. Nisl vel pretium lectus quam. Cursus mattis molestie a iaculis at erat pellentesque adipiscing. Egestas integer eget aliquet nibh praesent tristique magna sit. Lobortis scelerisque fermentum dui faucibus in. Tortor aliquam nulla facilisi cras fermentum odio. Ut tristique et egestas quis. At risus viverra adipiscing at in tellus integer. Cum sociis natoque penatibus et magnis dis parturient montes. Enim nunc faucibus a pellentesque sit amet. Netus et malesuada fames ac turpis egestas maecenas pharetra. Malesuada bibendum arcu vitae elementum curabitur vitae nunc sed. Sed ullamcorper morbi tincidunt ornare. Urna neque viverra justo nec ultrices dui sapien eget mi. Ornare aenean euismod elementum nisi quis eleifend quam adipiscing vitae. Ultricies tristique nulla aliquet enim tortor at auctor. Dignissim sodales ut eu sem integer vitae justo. Duis at consectetur lorem donec massa. Dignissim convallis aenean et tortor. Ridiculus mus mauris vitae ultricies leo integer malesuada nunc. Blandit aliquam etiam erat velit scelerisque in. Commodo odio aenean sed adipiscing. Aliquam etiam erat velit scelerisque in dictum non consectetur. Enim sed faucibus turpis in eu mi bibendum. Sed euismod nisi porta lorem mollis aliquam. Nisi est sit amet facilisis. Suscipit tellus mauris a diam maecenas sed enim ut sem. Tortor consequat id porta nibh venenatis cras sed felis.' AS str
          FROM DUAL)
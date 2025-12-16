/*USERNAME: USRINCRIMA
PASS: Intense102019##
HOST: 10.216.238.80
PORT: 1525
SERVICE NAME: PDB_INTENSE
*/

/* Formatted on 16/12/2025 17:25:40 (QP5 v5.215.12089.38647) */
  SELECT *
    FROM tab
   WHERE LOWER (tname) LIKE '%sfo%'
ORDER BY 1;

  SELECT *
    FROM D_SFO_NILAI_251216_BCK
ORDER BY tahun DESC;

  SELECT id_unitdtl, tahun, nilai
    FROM D_SFO_NILAI
ORDER BY tahun DESC;

--INSERT INTO D_SFO_NILAI (id_unitdtl, tahun, nilai)
   SELECT id_unitdtl, tahun, TO_NUMBER (nilai_sfo, '99.99') AS nilai FROM temp_nilai_sfo_2024@intendev;
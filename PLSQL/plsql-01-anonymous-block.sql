/* Formatted on 07/10/2023 21:57:06 (QP5 v5.215.12089.38647) */
/*
PL/SQL Block Structure
DECLARE (optional)
- Variables, cursors, user-defined exceptions
BEGIN (mandatory)
- SQL statements
- PL/SQL statements
EXCEPTION (optional)
- Actions to perform when exceptions occur
END;
/

Block Types
- Procedure: Procedures are named objects that contain SQL and/or PL/SQL statements.
- Function: Functions are named objects that contain SQL and/or PL/SQL statements. Unlike a procedure, 
a function returns a value of a specified data type.
- Anonymous: Anonymous blocks are unnamed blocks. They are declared inline at the point in an application 
where they are to be executed and are compiled each time the application is executed. These blocks 
are not stored in the database. They are passed to the PL/SQL engine for execution at runtime. 
Triggers in Oracle Developer components consist of such blocks.
- Subprograms: Subprograms are complementary to anonymous blocks. They are named PL/SQL blocks that are
stored in the database. Because they are named and stored, you can invoke them whenever you
want (depending on your application). You can declare them either as procedures or as
functions. You typically use a procedure to perform an action and a function to compute and
return a value.
*/

SELECT *
  FROM kur_t_debitur
 WHERE kode_bank = '009';

/*****************************/

DECLARE
   v_namaDebitur     VARCHAR2 (25);
   v_alamatDebitur   VARCHAR2 (255);
BEGIN
   SELECT nama, alamat
     INTO v_namaDebitur, v_alamatDebitur
     FROM kur_t_debitur
    WHERE nik = '3515112502860001';

   DBMS_OUTPUT.put_line ('Nama debitur yang terdaftar adalah: ' || v_namaDebitur);
   DBMS_OUTPUT.put_line ('beralamat di ' || v_alamatDebitur);
END;
/
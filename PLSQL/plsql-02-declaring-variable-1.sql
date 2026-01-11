/* Formatted on 07/10/2023 06:50:58 (QP5 v5.215.12089.38647) */
DECLARE
   v_myName   VARCHAR2 (25);
BEGIN
   DBMS_OUTPUT.PUT_LINE ('My name is: ' || v_myName);
   v_myName := 'Kenang';
   DBMS_OUTPUT.PUT_LINE ('My name is: ' || v_myName);
END;
/
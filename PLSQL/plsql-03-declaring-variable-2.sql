/* Formatted on 07/10/2023 06:53:21 (QP5 v5.215.12089.38647) */
DECLARE
   v_myName   VARCHAR2 (25) := 'John';
BEGIN
   v_myName := 'Robert';
   DBMS_OUTPUT.PUT_LINE ('My name is: ' || v_myName);
END;
/

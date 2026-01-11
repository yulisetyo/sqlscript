/* Formatted on 07/10/2023 07:03:20 (QP5 v5.215.12089.38647) */
/*
Variables can be used for:
- Temporary storage of data
- Manipulation of stored values
- Reusability

A variable name:
- Must start with a letter
- Can include letters or numbers
- Can include special characters (such as $, _, and #)
- Must contain no more than 30 characters
- Must not include reserved words
*/

DECLARE
   v_myName   VARCHAR2 (25);
BEGIN
   DBMS_OUTPUT.PUT_LINE ('My name is: ' || v_myName);
   v_myName := 'John';
   DBMS_OUTPUT.PUT_LINE ('My name is: ' || v_myName);
END;
/
/* Formatted on 07/10/2023 06:59:18 (QP5 v5.215.12089.38647) */
DECLARE
   v_event   VARCHAR2 (15);
BEGIN
   v_event := q'!Father's day!';
   DBMS_OUTPUT.PUT_LINE ('3rd Sunday in June is: ' || v_event);
   v_event := q'[Mother's day]';
   DBMS_OUTPUT.PUT_LINE ('2nd Sunday in May is: ' || v_event);
END;
/
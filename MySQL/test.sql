-- SELECT ROUND(RAND() * 10);

-- SELECT FLOOR(0 + (RAND() * 11)) RAND1, FLOOR((FLOOR(0 + (RAND() * 11))) +(RAND() * 11));

-- SELECT SHA1(MD5('P4ssw0rd!'));

-- SELECT @rownum := @rownum +1 AS baris 
-- FROM category a, (SELECT @rownum := 0) r

-- SELECT LENGTH('081217ic_giat_kendali050056');

-- SELECT SHA1(MD5('8e3800d8-aecd-4fb2-a943-49a34300025f')) hashed;
USE test;

SELECT a.nip, a.nama, a.unit, a.unit_tmt
  FROM test.dt_emp a
 WHERE LENGTH(a.nip) = 18 
       AND YEAR(a.birthdate) > '1970' 
ORDER BY a.nip DESC;


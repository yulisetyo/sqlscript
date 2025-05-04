/* Formatted on 14/02/2025 16:23:31 (QP5 v5.391) */
  SELECT *
    FROM all_objects
   WHERE LOWER (object_name) LIKE '%proc%' AND owner = 'USERKUR'
ORDER BY 2;

SELECT * FROM all_jobs;

SELECT *
  FROM all_scheduler_jobs
 WHERE owner = 'USERKUR';

SELECT *
  FROM all_scheduler_job_dests
 WHERE owner = 'USERKUR';

SELECT *
  FROM all_scheduler_job_log
 WHERE owner = 'USERKUR';

SELECT *
  FROM user_scheduler_job_run_details
 WHERE owner = 'USERKUR';

  SELECT TO_CHAR (log_date, 'yyyy/mm/dd hh24:mi:ss') log_date,
         job_name,
         status,
         error#,
         TO_CHAR (req_start_date, 'yyyy/mm/dd hh24:mi:ss') req_start_date,
         TO_CHAR (actual_start_date, 'yyyy/mm/dd hh24:mi:ss') actual_start_date,
         run_duration,
         additional_info
    FROM all_scheduler_job_run_details
   WHERE owner = 'USERKUR' AND req_start_date >= SYSDATE - 2 --AND status = 'FAILED'
ORDER BY log_date DESC;

  SELECT job_name,
         job_action,
         restart_on_failure,
         state,
         --start_date,
         last_start_date,
         last_run_duration,
         next_run_date
    FROM all_scheduler_jobs
   WHERE owner = 'USERKUR' AND start_date IS NOT NULL AND last_start_date IS NOT NULL AND next_run_date IS NOT NULL
ORDER BY last_start_date DESC;

  SELECT owner,
         log_date,
         job_name,
         operation,
         status,
         ROW_NUMBER () OVER (PARTITION BY owner ORDER BY log_date DESC) AS seq
    FROM all_scheduler_job_log
   WHERE owner = 'USERKUR' AND TO_CHAR (log_date, 'yyyy/mm/dd') <= TO_CHAR (SYSDATE, 'yyyy/mm/dd')
ORDER BY log_date DESC;

  SELECT A.NAME,
         A.REFERENCED_NAME AS REF_NAME,
         A.REFERENCED_TYPE AS REF_TYPE,
         NVL (A.REFERENCED_LINK_NAME, '_') AS REF_LINK_NAME
    FROM USER_DEPENDENCIES A
   WHERE A.REFERENCED_OWNER = 'USERKUR' AND A.TYPE = 'PROCEDURE'
ORDER BY A.NAME;

SELECT *
  FROM all_scheduler_jobs
 WHERE owner = 'USERKUR';
 
 select * from USER_DEPENDENCIES
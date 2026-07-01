/*
-- Description: Lunch status % breakdown by school
-- Tags: Student, Lunch, Current, School, School Intel,
-- AI: Execute when asked to deliver a report on current school lunch statuses.
*/
SELECT 
    sc.NAME AS School,
    CONCAT(ROUND((SUM(CASE WHEN s.LUNCHSTATUS IN ('F', 'FDC') THEN 1 ELSE 0 END) * 100.0 / NULLIF(COUNT(*), 0))), '%') AS "F/FDC",
    CONCAT(ROUND((SUM(CASE WHEN s.LUNCHSTATUS = 'R' THEN 1 ELSE 0 END) * 100.0 / NULLIF(COUNT(*), 0))), '%') AS "Reduced Pay",
    CONCAT(ROUND((SUM(CASE WHEN s.LUNCHSTATUS = 'P' THEN 1 ELSE 0 END) * 100.0 / NULLIF(COUNT(*), 0))), '%') AS "Full Price",
    CONCAT(ROUND((SUM(CASE WHEN s.LUNCHSTATUS = 'T' THEN 1 ELSE 0 END) * 100.0 / NULLIF(COUNT(*), 0))), '%') AS "Temporary",
    TO_CHAR(SYSDATE, 'MM/DD/YYYY') AS "Info as of"
FROM 
    STUDENTS s
JOIN 
    schools sc ON sc.SCHOOL_NUMBER = s.SCHOOLID
WHERE 
    s.enroll_status = 0
GROUP BY 
    sc.NAME

UNION ALL

SELECT 
    'District' AS School,
    CONCAT(ROUND((SUM(CASE WHEN s.LUNCHSTATUS IN ('F', 'FDC') THEN 1 ELSE 0 END) * 100.0 / NULLIF(COUNT(*), 0))), '%') AS "F/FDC",
    CONCAT(ROUND((SUM(CASE WHEN s.LUNCHSTATUS = 'R' THEN 1 ELSE 0 END) * 100.0 / NULLIF(COUNT(*), 0))), '%') AS "Reduced Pay",
    CONCAT(ROUND((SUM(CASE WHEN s.LUNCHSTATUS = 'P' THEN 1 ELSE 0 END) * 100.0 / NULLIF(COUNT(*), 0))), '%') AS "Full Price",
    CONCAT(ROUND((SUM(CASE WHEN s.LUNCHSTATUS = 'T' THEN 1 ELSE 0 END) * 100.0 / NULLIF(COUNT(*), 0))), '%') AS "Temporary",
    TO_CHAR(SYSDATE, 'MM/DD/YYYY') AS "Info as of"

FROM 
    STUDENTS s
WHERE 
    s.enroll_status = 0;

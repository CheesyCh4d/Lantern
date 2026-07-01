SELECT
    S.LAST_NAME,
    S.FIRST_NAME,
    COUNT(*) AS "Total tardies (3)", -- Counts all tardies in the terms listed in the WHERE clause
  
    CASE 
        WHEN COUNT(*) <= 3 THEN -3 + COUNT(*)
        ELSE 0
    END AS "Total tardies Remaining", -- Calculates total tardies remaining to go from -3 to 0. As soon as zero is hit, the remaining move to the next case statement.
    CASE 
        WHEN COUNT(*) > 3 THEN COUNT(*) - 3
        ELSE NULL
    END AS "Lunch Detentions to Serve", -- Calculates additional tardies after the initial 3 to determine how many lunch detentions a student should serve after the first.
'' AS "Lunch Detentions Served"

FROM STUDENTS S

JOIN SCHOOLS SCH
   ON SCH.SCHOOL_NUMBER = S.SCHOOLID

JOIN ATTENDANCE ATT
   ON ATT.STUDENTID = S.ID
  AND ATT.YEARID = 34 -- Year 2024-2025

JOIN ATTENDANCE_CODE AC
   ON AC.ID = ATT.ATTENDANCE_CODEID
  AND AC.ATT_CODE IN ('X','L') -- unexcused Tardy equivalent codes

JOIN CC
   ON CC.ID = ATT.CCID

JOIN COURSES C
   ON C.COURSE_NUMBER = CC.COURSE_NUMBER

JOIN TEACHERS T
   ON T.ID = CC.TEACHERID

WHERE S.ENROLL_STATUS = 0 -- Only enrolled students
  AND SCH.SCHOOL_NUMBER = '000000' -- Adjust schoolID or remove to change location
  AND CC.TERMID IN ('3400', '3401', '3402', '3403') -- Adjust terms as the year goes on to not pull duplicate info. 3400 = Q1, 3401 = Q2, etc
 -- AND S.STUDENT_NUMBER = '390608' -- Student Number for Testing
  AND ATT.ATT_DATE >= TO_DATE('09/09/2024', 'MM/DD/YYYY') -- First Day of second week of school
  

GROUP BY
    S.LAST_NAME,
    S.FIRST_NAME

ORDER BY
    Count(*) desc, s.LAST_NAME;

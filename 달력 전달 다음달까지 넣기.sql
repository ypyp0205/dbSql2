SELECT iw 주차,
        MAX(NVL(DECODE(d, 1, dt), dt - d + 1)) 일요일, MAX(NVL(DECODE(d, 2, dt), dt - d + 1)) 월요일, MAX(NVL(DECODE(d, 3, dt), dt - d + 1)) 화요일,
        MAX(NVL(DECODE(d, 4, dt), dt - d + 1)) 수요일, MAX(NVL(DECODE(d, 5, dt), dt - d + 1)) 목요일, MAX(NVL(DECODE(d, 6, dt), dt - d + 1)) 금요일,
        MAX(NVL(DECODE(d, 7, dt), dt - d + 1)) 토요일
FROM
    (SELECT TO_DATE(:yyyymm, 'YYYYMM')+ (LEVEL-1) dt,                     --요일 20191130
            TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM')+ (LEVEL-1), 'D') d,        --일자
            TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM')+ (LEVEL), 'IW') iw         --주차 20191201
    FROM dual
    CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'DD')) --30                                                                    
GROUP BY dt-(d-1)
ORDER BY dt-(d-1); 
0



--201912 : 35, 첫주의 일요일 : 20190929, 마지막 날짜 : 20191102
--일(1), 월(2), 화(3), 수(4), 목(5), 금(6), 토(7)
--------------마지막,첫번째 날짜 구하기----------------------------------
SELECT LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')) dt,
        LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')) +
        7 - TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'D') ldt,---마지막날짜
        TO_DATE(:yyyymm, 'YYYYMM') -         -------------------------첫번째날짜                             
        (TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM'), 'D') -1) fdt
FROM dual;
---------------------------------------------------------------
SELECT LDT-FDT+1

FROM
(SELECT LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')) dt,
        LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')) +
        7 - TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'D') ldt,---마지막날짜
        TO_DATE(:yyyymm, 'YYYYMM') -         -------------------------첫번째날짜                             
        (TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM'), 'D') -1) fdt
FROM dual);





SELECT
    MAX(DECODE(d, 1, dt)) 일, MAX(DECODE(d, 2, dt)) 월, MAX(DECODE(d, 3, dt)) 화,
    MAX(DECODE(d, 4, dt)) 수, MAX(DECODE(d, 5, dt)) 목, MAX(DECODE(d, 6, dt)) 금, MAX(DECODE(d, 7, dt)) 토
FROM
    (SELECT LEVEL, TRUNC((LEVEL-1)/7) m ,
            TO_DATE(:yyyymm, 'YYYYMM') - 
            (TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM'), 'D') -1) + (LEVEL - 1) dt,
            
            TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') - 
            (TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM'), 'D') -1) + (LEVEL - 1), 'D') d,
            
            TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') - 
            (TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM'), 'D') -1) + (LEVEL), 'IW') iw
            
    FROM dual
    CONNECT BY LEVEL <=(SELECT LDT-FDT +1
                        FROM  
                          (SELECT LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')) dt,
                           LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')) +
                           7 - TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'D') ldt,
                           TO_DATE(:yyyymm, 'YYYYMM') -
                           (TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM'), 'D') -1) fdt
                           FROM dual)))
    GROUP BY m
    ORDER BY m;
    


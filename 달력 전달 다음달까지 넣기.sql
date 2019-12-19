SELECT iw ����,
        MAX(NVL(DECODE(d, 1, dt), dt - d + 1)) �Ͽ���, MAX(NVL(DECODE(d, 2, dt), dt - d + 1)) ������, MAX(NVL(DECODE(d, 3, dt), dt - d + 1)) ȭ����,
        MAX(NVL(DECODE(d, 4, dt), dt - d + 1)) ������, MAX(NVL(DECODE(d, 5, dt), dt - d + 1)) �����, MAX(NVL(DECODE(d, 6, dt), dt - d + 1)) �ݿ���,
        MAX(NVL(DECODE(d, 7, dt), dt - d + 1)) �����
FROM
    (SELECT TO_DATE(:yyyymm, 'YYYYMM')+ (LEVEL-1) dt,                     --���� 20191130
            TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM')+ (LEVEL-1), 'D') d,        --����
            TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM')+ (LEVEL), 'IW') iw         --���� 20191201
    FROM dual
    CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'DD')) --30                                                                    
GROUP BY dt-(d-1)
ORDER BY dt-(d-1); 
0



--201912 : 35, ù���� �Ͽ��� : 20190929, ������ ��¥ : 20191102
--��(1), ��(2), ȭ(3), ��(4), ��(5), ��(6), ��(7)
--------------������,ù��° ��¥ ���ϱ�----------------------------------
SELECT LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')) dt,
        LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')) +
        7 - TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'D') ldt,---��������¥
        TO_DATE(:yyyymm, 'YYYYMM') -         -------------------------ù��°��¥                             
        (TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM'), 'D') -1) fdt
FROM dual;
---------------------------------------------------------------
SELECT LDT-FDT+1

FROM
(SELECT LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')) dt,
        LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')) +
        7 - TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'D') ldt,---��������¥
        TO_DATE(:yyyymm, 'YYYYMM') -         -------------------------ù��°��¥                             
        (TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM'), 'D') -1) fdt
FROM dual);





SELECT
    MAX(DECODE(d, 1, dt)) ��, MAX(DECODE(d, 2, dt)) ��, MAX(DECODE(d, 3, dt)) ȭ,
    MAX(DECODE(d, 4, dt)) ��, MAX(DECODE(d, 5, dt)) ��, MAX(DECODE(d, 6, dt)) ��, MAX(DECODE(d, 7, dt)) ��
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
    


  
    
SELECT LPAD('XXȸ��', 15, '*'),
       LPAD('XXȸ��', 15)
FROM dual;
/*
    dept0(XXȸ��)
        dept0_00(�����κ�)
            dept0_00_0(��������)
        dept0_01(������ȹ��)
            dept0_01_0(��ȹ��)
                dept0_00_0_0(��ȹ��Ʈ)
        dept0_02(�����ý��ۺ�)        
            dept0_02_0(����1��)
            dept0_02_1(����2��)   */
            
            
--�ǽ�1
SELECT dept_h.*, LEVEL, LPAD(' ', (LEVEL - 1)*3) || deptnm
FROM dept_h
START WITH deptcd = 'dept0'   --�������� depted = 'dept0' --> XXȸ��(�ֻ�������)
CONNECT BY PRIOR deptcd = p_deptcd;
  


            

--�ǽ� 2           
--��������(dept0_00_0)�� �������� ����� �������� �ۼ�
--�ڱ� �μ��� �θ� �μ��� ������ �Ѵ�.
SELECT LEVEL lv, dept_h.*
FROM dept_h
START WITH deptcd = 'dept0_00_0'
CONNECT BY deptcd = PRIOR p_deptcd; --AND PRIOR deptnm LIKE '������%'; --AND col = PRIOR col2;
            
--�ǽ� 3                      
SELECT deptcd, LPAD(' ', (LEVEL-1)*3) || deptnm deptnm, p_deptcd
FROM dept_h
START WITH deptcd = 'dept0_00_0'
CONNECT BY deptcd = PRIOR p_deptcd;      
            
--�ǽ� 4            
SELECT LPAD(' ', (LEVEL-1)*4) || S_ID S_ID, VALUE 
FROM H_SUM
START WITH S_ID = '0'
CONNECT BY PRIOR S_ID = PS_ID;      

SELECT *
FROM h_sum;
            
--�ǽ� 5
SELECT LPAD(' ', (LEVEL-1)*4) || org_cd org_cd, NO_EMP
FROM no_emp
START WITH org_cd = 'XXȸ��'
CONNECT BY PRIOR org_cd =  parent_org_cd;      
            
            
            
--pruning branch(����ġ��)
--���� ������ �������
--FROM -> START WITH -CONNECT BY -> WHERE
--������ CONNECT BY ���� ����� ���
--���ǿ� ���� ���� ROW�� ������ �ȵǰ� ����
--������ WHERE ���� ����� ���
-- START WITH - CONNECT BY ���� ���� ���������� ���� �����
--WHERE���� ����� ��� ���� �ش��ϴ� �����͸� ��ȸ

--�ֻ��� ��忡�� ��������� Ž��
SELECT *
FROM dept_h
WHERE deptcd = 'dept0';


--CONNECT BY���� deptnm != '������ȹ��' ������ ����� ���
SELECT *
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd AND deptnm != '������ȹ��';
            
--WHERE���� deptnm != '������ȹ��' ������ ����� ���
--���������� �����ϰ��� ���� ����� WHERE�� ������ ����
SELECT *
FROM dept_h
WHERE deptnm != '������ȹ��'
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;            

--���� �������� ��� ������ Ư�� �Լ�
--CONNECT_BY_ROOT(col) ���� �ֻ��� row�� col ���� �� ��ȸ
--SYS_CONNECT_BY_PATH(col, ������) : �ֻ��� row���� ���� �ο���� col����
--�����ڷ� �������� ���ڿ� (EX : XXȸ�� - �����κε�������)
--CONNECT_BY_ISLEAF : �ش� ROW�� ������ �������(leaf Node)
--leaf node : 1, code : 0
SELECT deptcd, LPAD(' ', 4*(LEVEL-1)) || deptnm deptnm,
        CONNECT_BY_ROOT(deptnm) c_root,
        LTRIM(SYS_CONNECT_BY_PATH(deptnm, '-'), '-') sys_path,
        CONNECT_BY_ISLEAF isleaf
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;            

            
SELECT *
FROM board_test;

--�ǽ� 6
SELECT seq, LPAD(' ', 4*(LEVEL-1)) || title
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq;

--�ǽ� 7
SELECT seq, LPAD(' ', 4*(LEVEL-1)) || title
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq
ORDER BY seq DESC;

--�ǽ� 8
SELECT seq, LPAD(' ', 4*(LEVEL-1)) || title
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq
ORDER SIBLINGS BY seq DESC;

--�ǽ� 9 
--���� �ϳ������� ���ѵ� ��� ����
SELECT parent_seq,seq, LPAD(' ', 4*(LEVEL-1)) || title
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq
ORDER SIBLINGS BY NVL(parent_seq, seq) DESC;





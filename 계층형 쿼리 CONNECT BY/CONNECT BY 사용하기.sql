/* 계층형 쿼리 */

/*
 *  ex) 
 * 	SELECT expr1, expr2, ...
 *    FROM 테이블
 *  WHERE 조건
 *  START WITH[최상위 조건]
 * CONNECT BY [NOCYCLE][PRIOR 계층형구조 조건];
 */


/*
 *  1.START WITH 조건 : 계층형 구조에서 최상위 계층의 로우를 식별하는 조건을 명시
 *  				  START WITH가 시작한다는 의미이므로, 이 조건에 맞는 로우부터 시작해 계층형 구조를 풀어나감
 *  2.CONNECT BY 조건 : 계층형 구조가 어떤 식으로 연결되는지를 기술하는 부분이다. 부서 테이블은 parent_id에 상위 부서 정보를 갖고 있는데.
 * 					   이를 표현하려면 'CONNECT BY PRIOR department_id = parent_id'로 기술해야한다.
 * 					   PRIOR는 계층형 쿼리에서만 사용할 수 있는 연산자로 '앞서의,직전의'란 뜻이 있으므로, 
 * 					   "이전 department_id = parent_id"라고 알아두면 이해하기 쉬울 것이다. 또한 'CONNECT BY parent_id = PRIOR
 * 					   department_id"처럼 PIOR의 위치를 바꿀 수 있다.
*/

/*
 * 부서 테이블에서 가장 상위 부서는 parent_id 값이 NULL이므로 이를 START WITH절에 명시하고
 * CONNECT BY 절에 계층 구조 조건을 넣음
 * 각 부서별 계층 구조가 한 눈에 들어오도록 LPAD 함수를 사용해서 LEVEL값에 따라 공백 한 문자를 왼쪽에 붙여 레벨에 따른 부서 명칭을 들여쓰기한 효과를 줌.
 */
  SELECT DEPARTMENT_ID , LPAD(' ' , 3 * (LEVEL-1)) || DEPARTMENT_NAME , LEVEL 
  	FROM DEPARTMENTS 
  START WITH PARENT_ID IS NULL
  CONNECT BY PRIOR DEPARTMENT_ID = PARENT_ID ;
  

--조인 조건을 포함한 계층형 쿼리
SELECT A.EMPLOYEE_ID , LPAD(' ' , 3 * (LEVEL-1)) || A.EMP_NAME, LEVEL , B.DEPARTMENT_NAME
  FROM EMPLOYEES A, DEPARTMENTS B
 WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID 
START WITH A.MANAGER_ID IS NULL 
CONNECT BY PRIOR A.EMPLOYEE_ID = A.MANAGER_ID ;

--WHERE에 조건을 줌
SELECT A.EMPLOYEE_ID , LPAD(' ', 3 * (LEVEL-1)) || A.EMP_NAME AS EMPNAME , LEVEL , B.DEPARTMENT_NAME , A.DEPARTMENT_ID
  FROM EMPLOYEES A , DEPARTMENTS B
WHERE A.DEPARTMENT_ID  = B.DEPARTMENT_ID 
  AND A.DEPARTMENT_ID = 30
START WITH A.MANAGER_ID IS NULL 
CONNECT BY NOCYCLE PRIOR A.EMPLOYEE_ID = A.MANAGER_ID ;

--CONNECT BY에 조건을 줌
SELECT A.EMPLOYEE_ID , LPAD(' ', 3 * (LEVEL-1)) || A.EMP_NAME AS EMPNAME , LEVEL , B.DEPARTMENT_NAME , A.DEPARTMENT_ID
  FROM EMPLOYEES A , DEPARTMENTS B
WHERE A.DEPARTMENT_ID  = B.DEPARTMENT_ID 
START WITH A.MANAGER_ID IS NULL 
CONNECT BY NOCYCLE PRIOR A.EMPLOYEE_ID = A.MANAGER_ID ;




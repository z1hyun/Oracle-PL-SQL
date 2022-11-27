/*
 * SYS_CONNECT_BY_PATH(colm,char)
 * SYS_CONENCT_BY_PATH는 계층형 쿼리에서만 사용할 수 있는 함수로
 * 루트 노드에서 시작해 자신의 행까지 연결된 경로 정보를 바노한한다.
 * 함수의 1번째 파라미터 : 컬럼 , 2번째 파라미터 : char는 컬럼간의 구분자를 의미
 */

SELECT DEPARTMENT_ID , LPAD(' ', 3 * (LEVEL-1)) || DEPARTMENT_NAME , LEVEL, SYS_CONNECT_BY_PATH(DEPARTMENT_NAME, '|')
  FROM DEPARTMENTS 
 START WITH PARENT_ID IS NULL
CONNECT BY PRIOR DEPARTMENT_ID = PARENT_ID ;

/*
 * 두번째 매개변수인 구분자로 해당 컬럼 값에 포함된 문자는 사용할 수 없다는 점을 주의해야한다.
 * 위 쿼리에서 구매/생산부는 '/'문자가 속해있는데 구분자로 '/'를 사용하면 다음과 같은 오류가 발생한다.
 * 
 * SQL 오류 : ORA-30004 : SYS_CONNECT_BY_PATH 함수를 사용할 때 열 값의 일부로 분리자를 사용할 수 없습니다.
 */
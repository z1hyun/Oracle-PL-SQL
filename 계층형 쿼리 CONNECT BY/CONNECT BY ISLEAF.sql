/* CONNECT_BY_ISLEAF 
 * CONNECT BY 조건에 정의된 관계에 따라 해당 로우가 최하위 자식로우이면 1을, 그렇지 않으면 0을 반환하는 의사 컬럼
 */

SELECT DEPARTMENT_ID , LPAD(' ' , 3 * (LEVEL-1)) || DEPARTMENT_NAME, LEVEL , CONNECT_BY_ISLEAF
  FROM DEPARTMENTS
START WITH PARENT_ID IS NULL
CONNECT BY PRIOR DEPARTMENT_ID  = PARENT_ID ;


/*
 * 계층형 쿼리는 구조 형태가 트리 구조다.
 * 따라서 각 로우를 노드라고 하는데 최상위 노드는 루트노트
 * 자식노도가 없는 최하위 노드를 리프 노드라고 한다.
 * 
 * CONNECT_BY_ISLEAF는 해당 로우가 리프노드에 해당하는지 여부를 반환하는것.
 * 
 */

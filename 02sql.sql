/*
	< SELECT >
	데이터를 조회하거나 검색할 때 사용하는 명령어
	
	SELECT
			조회하고자 하는 컬럼
		 ,  조회하고자 하는 컬럼
	  FROM 
	  		테이블명;
	- ResultSet : SELECT문을 통해 조회된 데이터 결과물
				  조회된 행들의 집합
*/

-- ANIMAL 테이블에서 모든 컬럼 전부 다 조회
SELECT * FROM ANIMAL; -- 성능에 영향을 끼치므로 사용하지 말 것

-- 필요한 컬럼만 명시해서 조회
 SELECT 
		 ANIMAL_NAME
	   , WEIGHT_KG
	FROM
		 ANIMAL;

-- 1. SPECIES테이블에서 SPECIES_ID, SPECIES_NAME 컬럼을 조회
-- 2. ZONE테이블에서 ZONE_NAME 컬럼을 조회
-- 3. KEEPER 테이블에서 KEEP_NAME, HIRE_DATE 컬럼을 조회
-- 4. ANIMAL 테이블에서 ANIMAL_NAME, GENDER 컬럼을 조회
-- 5. ANIMAL 테이블에서 BIRTH_DATE, ANIMAL_NAME, ZONE_ID컬럼을 조회

SELECT 
	species_id, 
	species_name 
FROM 
	species;
SELECT 
	ZONE_NAME 
FROM 
	ZONE;
SELECT 
	KEEPER_NAME, 
	HIRE_DATE  
FROM 
	KEEPER;
SELECT 
	ANIMAL_NAME, 
	GENDER 
FROM 
	ANIMAL;
SELECT 
	BIRTH_DATE, 
	ANIMAL_NAME, 
	ZONE_ID 
FROM 
	ANIMAL;

--------------------------------------------------------------------------


/*
 * < 컬럼에서 조회된 값을 가지고 산술연산 >
 * SELECT절에 산술연산을 기술해서 결과를 조회할 수 있다!
 */


SELECT 
	ANIMAL_NAME, 
	WEIGHT_KG,  
	-- GRAM단위도 추가로 조회하고 싶은데??
	WEIGHT_KG * 1000	
FROM 
	ANIMAL;

SELECT 
	ANIMAL_NAME, 
	ARRIVAL_DATE,
	sysdate, -- 현재 시점의 날짜 값
	sysdate - arrival_date
FROM 
	ANIMAL;
--> 산술 연산 과정에서 null값이 존재할 경우 산술연산 결과도 null
--------------------------------------------------------
/*
 * < 컬럼명에 별칭 달기 >
 * 
 * 컬럼명 AS 별칭, 컬럼명 AS "별칭", 컬럼명 "별칭", 컬럼명 별칭
 * 
 */
SELECT
	animal_name AS 동물이름
	, weight_kg "체중 (kg)"
	, weight_kg * 1000 "체중 (g)"
FROM
	animal;
-- 별칭에 특수문자 또는 공백이 포함될 경우 반드시 ""로 묶어주어야함

/*
 * < 리터럴 >
 * 
 * || 연결 연산자
 */

SELECT
	animal_name
	, weight_kg || 'kg' 단위
FROM 
	animal;

/*
 *  < DISTINC >
 * 조회하려고 하는 컬럼 앞에 작성해서 중복된 값을 한 번만 조회
 * 
 * select에 distinct구문은 한 개 사용하는 것을 권장
 */

SELECT distinct species_id FROM animal;

/*
 * < where 절 >
 * 
 * select절에서 조회를 할 때
 * 조건을 제시하는 문법
 * 조건에 만족하는 행만 조회할 수 있음
 * 
 * select
 * 		컬럼명
 * 	from
 * 		테이블명
 * 	where
 * 		조건식;
 * 
 * < 비교 연산자 >
 * 동등비교 : =, !=
 * 대소비교 : <, >, <=, >=
 * 
 */

-- ANIMAL테이블에서 100KG이상인 동물들의 이름 조회

SELECT ANIMAL_NAME FROM ANIMAL WHERE WEIGHT_KG > 100;

-- ANIMAL테이블에서 성별이 'F'인 동물들의 이름, 성별 조회

SELECT ANIMAL_NAME, GENDER FROM ANIMAL WHERE GENDER = 'F';

-- ANIMAL테이블 구역코드 'Z1'이 아닌 동물들의 이름, 구역코드 조회
SELECT ANIMAL_NAME, ZONE_ID FROM ANIMAL WHERE ZONE_ID != 'Z1'; -- ZONE_ID <> 'Z1'

-- 실행순서
-- 1. FROM, 2. WHERE, 3. SELECT 순으로 수행

-- 1. ANIMAL테이블에서 체중이 50KG 이상인 동물들의 이름, 체중 조회
-- 2. ANIMAL테이블에서 구역코드가 'Z2인 동물들의 이름, 체중조회'
-- 3. ANIMAL테이블에서 수컷(GENDER = 'M')인 동물들의 이름, 성별, 체중 조회


SELECT 
	ANIMAL_NAME, 
	WEIGHT_KG 
FROM 
	ANIMAL 
WHERE 
	WEIGHT_KG > 50;

SELECT 
	ANIMAL_NAME, 
	WEIGHT_KG 
FROM 
	ANIMAL 
WHERE 
	ZONE_ID = 'Z2';

SELECT 
	ANIMAL_NAME,
	GENDER, 
	WEIGHT_KG 
FROM 
	ANIMAL 
WHERE 
	GENDER = 'M';

----------------------------------------
/*
 * < 논리 연산자 >
 * AND(이면서, 그리고) / OR(이거나, 또는)
 *  
 */
-- 구역코드가 'Z2'이면서 체중이 50KG이상인 동물들의 이름, 구역코드, 체중 조회
SELECT 
		ANIMAL_NAME,
		ZONE_ID,
		WEIGHT_KG
	FROM 
		ANIMAL
	WHERE 
		ZONE_ID = 'Z2'
	AND 
		WEIGHT_KG >= 50;

-- 구역코드가 'Z4'이거나 체중이 10KG 이하인 동물들의 이름, 구역코드, 체중조회

SELECT 
		ANIMAL_NAME,
		ZONE_ID,
		WEIGHT_KG
	FROM
		ANIMAL
	WHERE 
		ZONE_ID = 'Z4'
	OR 
		WEIGHT_KG <=10;

-- 체중이 100KG 이상이고 500KG 이하인 동물들의 이름, 체중 조회

SELECT 
	ANIMAL_NAME, 
	WEIGHT_KG 
FROM 
	ANIMAL 
WHERE 
	WEIGHT_KG >= 100 
AND 
	WEIGHT_KG <= 500;
--------------------------------------
/*
 *  < BETWEEN AND>
 * 몇 이상 몇 이하인 범위에 대해 조건을 제시할 때 사용
 */

SELECT 	
	ANIMAL_NAME,
	WEIGHT_KG
FROM	
	ANIMAL
WHERE 
	WEIGHT_KG BETWEEN 100 AND 500;

SELECT 	
	ANIMAL_NAME,
	WEIGHT_KG
FROM	
	ANIMAL
WHERE 
	WEIGHT_KG NOT BETWEEN 100 AND 500;

SELECT
	ANIMAL_NAME,
	ARRIVAL_DATE
FROM
	ANIMAL
WHERE
	ARRIVAL_DATE BETWEEN '18/01/01' AND '22/12/31';
-------------------------------------------------------------
/*
 * < LIKE '특정패턴' >
 * 컬럼의 값이 지정한 특정 패턴에 만족할 경우 조회
 * 
 * '%' : 0글자 이상
 * LIKE '푸%' : '푸'로 시작하는 데이터
 * LIKE '%바%' : '바'가 포함되는 데이터
 * LIKE '%이' : '이'로 끝나는 데이터
 * 
 * '_' : 딱 1글자
 * 
 */

SELECT 
	ANIMAL_NAME,
	WEIGHT_KG
FROM
	ANIMAL
WHERE
	ANIMAL_NAME LIKE '%바오'
	
-- 이름이 두글자인 동물들의 이름
	
SELECT
	ANIMAL_NAME
FROM
	ANIMAL
WHERE
	ANIMAL_NAME LIKE '__';

-------------------------------------------------
/*
 * < IS NULL >
 * 
 * 컬럼값이 NULL / NULL이 아닐 때 비교할 때 사용
 */


-- 담당 사육사가 배정되지 않은 동물들 조회
SELECT
	ANIMAL_NAME,
	KEEPER_ID
FROM 	
	ANIMAL
WHERE
	-- KEEPER_ID IS NULL;
	KEEPER_ID IS NOT NULL;
---------------------------------------

/*
 * <IN>
 * 비교대상 컬럼 값중 일치하는 값이 있는지
 * 
 */
-- ANIMAL테이블에서 구역코드가(ZONE_ID) Z1이거나 Z2이거나 Z5인 동물들의 이름, 구역 코드

SELECT
	ANIMAL_NAME,
	ZONE_ID
FROM
	ANIMAL
WHERE
	ZONE_ID IN ('Z1','Z2','Z5');
/*	ZONE_ID ='Z1'
OR
	ZONE_ID = 'Z2'
OR
	ZONE_ID = 'Z5';
*/
--------------------------------------------------
/*
 * 연산자 우선순위
 * 1. ()
 * 2. 산술연산자 
 * 3. 연결연산자
 * 4. 비교연산자
 * 5. IS NULL, LIKE, IN
 * 6. BETWEEN AND
 * 7. NOT
 * 8. AND
 * 9. OR
 */
---------------------------------------------------
/*
 * 
 * < ORDER BY 절 >
 * 정렬 용도로 사용하는 구문
 * 
 * ORDER BY [컬러명/별칭/컬럼순번] [ASC/DESC] [NULLS FIRST/NULLS LAST]
 *
 *  ☆ 무조건 ORDER BY를 사용하지 않으면 정렬이 안된 상태 
 */

-- SELECT * FROM ZONE;
-- 체중을 오름차순으로 정렬

SELECT
	ANIMAL_NAME,
	WEIGHT_KG
FROM
	ANIMAL
ORDER BY 
--	WEIGHT_KG;
	WEIGHT_KG DESC;

--------------------------------
SELECT ANIMAL_NAME, ARRIVAL_DATE FROM ANIMAL ORDER BY ARRIVAL_DATE DESC NULLS LAST;
SELECT ANIMAL_NAME, WEIGHT_KG "체중" FROM ANIMAL ORDER BY 2;
-- 숫자를 입력하면 숫자 번호의 컬럼을 오름차순으로 / 별칭으로도 가능 ORDER BY "체중"
-- 그치만 정렬 기준에 숫자를 입력하는 것은 비추천

SELECT ANIMAL_NAME, WEIGHT_KG "체중" FROM ANIMAL WHERE "체중" > 100; -- ERROR WHERE 은 SELECT보다 우선순위
SELECT ANIMAL_NAME, WEIGHT_KG "체중" FROM ANIMAL ORDER BY "체중"; -- ORDER BY는 가장 마지막에 수행 SELECT하고 정렬해오는게 효율적이라서
-- SELECT문의 가장 마지막에 작성 + 실행 순서도 가장 마지막

/*
 * < 함수 FUNCTION >
 * 자바로 따지면 자바 API메소드들같은 개념
 * 함수 호출시 전달된 값을 받아서 계산된 결과를 반환
 * 
 * - 단일행함수(이런게 있구나~) : N개의 값을 읽어서 N개의 결과를 반환
 * (매 행마다 함수 실행)
 * - 그룹함수(외우세요!)
 * (하나의 그룹별로 함수 실행)
 * 
 * 단일행 함수/ 그룹함수는 일반적으로 함계 사용하지 않음
 * = ResultSet의 행수가 다르기 때문에
 */
---------------------------------------------------
-------------단일행 함수 (문자관련)---------------------
/*
 * LENGTH(컬럼|문자열) : 해당 문자열의 글자 수 반환
 * LENGTHB(컬럼|문자열) :해당 문자열의 바이트 수 반환
 * - 한글 3Byte(UTS-8), 영어/숫자/특수문자 1Byte
 */

SELECT 
		ANIMAL_NAME,
		LENGTH(ANIMAL_NAME)
	FROM 
		ANIMAL
	WHERE
		LENGTH(ANIMAL_NAME) = 2;

/*
 * INSTR(문자열, 특정문자, '찾을위치시작값, 순번)
 * 지정한 위치부터 특정 문자열을 검색해서 가장 먼저 찾은 위치 반환
 * 
 * 
 */
									--DUAL(DUMMY테이블)
SELECT INSTR('AABAACAABBAA','B') FROM DUAL;
SELECT INSTR('AABAACAABBAA','B',1) FROM DUAL; -- 첫번째 'B'를 찾는다.
SELECT INSTR('AABAACAABBAA','B',-1) FROM DUAL; -- 뒤에서부터 찾는다. --10
SELECT INSTR('AABAACAABBAA','B',-1, 2) FROM DUAL; -- 9

/*
 * SUBSTR(문자열, 시작위치, 추출할 문자수)
 * 문자열에서 특정 문자열을 추출해서 반환
 * 
 */

SELECT * FROM KEEPER;

SELECT 
		KEEPER_NAME,
		SUBSTR(KEEPER_NAME, 1, 1) AS "이름 첫 글자"
	FROM 
		KEEPER;

/*
 * LPAD / RPAD(문자열, 최종길이, 덧붙일 문자)
 * 문자열에 덧붙일 문자를 왼쪽/ 오른쪽에 붙여서 최종길이만큰 반환
 * 
 */
SELECT 
		ANIMAL_NAME,
		LPAD(ANIMAL_NAME, 10, '*'),
		RPAD(ANIMAL_NAME, 10, '*')
	FROM 
		ANIMAL;

SELECT 
		KEEPER_NAME,
		RPAD(SUBSTR(KEEPER_NAME, 1, 1),LENGTH(KEEPER_NAME)+1,'*')
	FROM 
		KEEPER;
---------------------------------------------------------------------------
/*
 *	TRIM(문자열)	: 양쪽 공백 문자 제거
 *	LTIRM(문자열, 제거할문자)
 *	RTIRM(문자열, 제거할 문자)
 *  
 */

SELECT TRIM('    동물원   ') FROM DUAL;

/*
 * LOWER / UPPER / INITCAP
 */
SELECT 
		LOWER('Hello World'),
		UPPER('Hello World'),
		INITCAP('hello world')
	FROM
		DUAL;

/*
 * REPLACE(문자열, 찾을문자, 바꿀문자)
 */

SELECT 
		ZONE_NAME,
		REPLACE(ZONE_NAME, '관', '파크')
	FROM
		ZONE;

SELECT 
		CONCAT(ANIMAL_NAME, '은(는) 귀엽다'),
		ANIMAL_NAME || '은(는) 귀엽다' || '.' || '!!'
	FROM 
		ANIMAL;
--------------------------------------------------------
-- <숫자 관련 함수 >
/*
 * ABS(숫자) : 절대값
 * MOD(숫자1, 숫자2) : 나머지
 * TRUNC(숫자, 소숫점위치) : 버림(절삭)
 */

SELECT
		ANIMAL_NAME,
		WEIGHT_KG,
		ROUND(WEIGHT_KG, 0) AS "반올림",
		CEIL(WEIGHT_KG) AS "올림",
		FLOOR(WEIGHT_KG) AS "내림"
	FROM
		ANIMAL;
		
-- <날짜 관련 함수 >

/*
 * SYSDATE : 현재 시스템 날짜
 * MONTHS_BETWEEN(날짜1, 날짜2) 두 날짜 사이의 개월 수
 * EXTRACT(YEAR|MONTH|DAY FROM 날짜) : 날짜에서 년/월/일 추출
 * ADD_MONTHS(날짜, 숫자) : 특정 날짜에 개월 수를 더한 날짜
 */

-- 각 동물의 나이 조회
SELECT
		ANIMAL_NAME,
		ARRIVAL_DATE,
		FLOOR(MONTHS_BETWEEN(SYSDATE, ARRIVAL_DATE)) AS "개월 수",
		FLOOR(MONTHS_BETWEEN(SYSDATE, ARRIVAL_DATE)/12) AS "나이(년)",
		EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM ARRIVAL_DATE) "햇수 계산"
	FROM
		ANIMAL;
--------------------------------------------------------------
--------- < 형변환 함수 > ---------------------------------------

/*
 * TO_CHAR(날짜|숫자, 포매팅형식) : 문자타입으로 변환
 * TO_DATE(문자, 포매팅형식) : 날짜타입으로 변환
 * TO_NUMBER(문자) : 숫자타입으로 변환
 */

SELECT
		KEEPER_NAME,
		TO_CHAR(HIRE_DATE, 'YYYY-MM-DD') "입사일"
	FROM 
		KEEPER;

SELECT 
		TO_CHAR(123456789, '999,999,999')
	FROM
		DUAL;
/*
 * NVL ( 컬럼, NULL일때 반환할 값)
 * NVL2( 컬럼, NULL이 아닐 때 값, NULL일때 값)
 */


SELECT 
		ANIMAL_NAME,
		NVL(TO_CHAR(ARRIVAL_DATE, 'YYYY-MM-DD'), '동물원에서 태어남')
	FROM
		ANIMAL;
---------------SELECT * FROM ANIMAL;
	
SELECT
		ANIMAL_NAME,
		NVL2(KEEPER_ID,'배정완료','미배정') "사육사 배정여부"
	FROM
		ANIMAL
-----------------------------------------------
-- < 선택함수 >
/*
 * DECODE(배교대상, 조건1, 결과1, 조건2, 조건2,...,기본값)
 * CASE WHEN 조건 THEN 결과 ... ELSE 기본값 END
 */
	
SELECT
		ANIMAL_NAME,
		DECODE(GENDER,'M', '수컷', 'F', '암컷') AS "GENDER"
	FROM
		ANIMAL;
	
SELECT
		ANIMAL_NAME,
		WEIGHT_KG,
		CASE 
			WHEN WEIGHT_KG >= 1000 THEN '초대형'
			WHEN WEIGHT_KG >= 100 THEN '대형'
			WHEN WEIGHT_KG >= 10 THEN '중형'
			ELSE '소형'
		END AS "크기"
	FROM
		ANIMAL;
	
---------------------------------------------------------
--< 그룹 함수 >
/*
 * SUM(숫자 컬럼) : 합계
 * AVG(숫자 컬럼) : 평균
 * COUNT(*|컬럼) : 행 수
 * MAX(컬럼) : 최대값
 * MIN(컬럼) : 최소값
 * 
 */
	
SELECT COUNT(*) FROM ANIMAL;
	
SELECT ROUND(AVG(WEIGHT_KG)) FROM ANIMAL;
	
SELECT MAX(WEIGHT_KG) AS "무거운 동물", MIN(WEIGHT_KG) AS "가벼운 동물" FROM ANIMAL;
	
---- COUNT(컬럼) : NULL값을 제외한 카운트
SELECT COUNT(KEEPER_ID) FROM ANIMAL;



















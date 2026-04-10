------------------ < GROUP BY > -----------------

SELECT
		SPECIES_ID
	FROM
		ANIMAL;

SELECT * FROM SPECIES;

-- 종 별로 몇마리 있는지 조회하고 싶다

SELECT 
		COUNT(*)
	FROM
		ANIMAL
	WHERE SPECIES_ID = 'S01'
	
-- S01 == 3마리
-- S02 == 3마리
-- S02 == 3마리

SELECT
		SPECIES_ID,
		COUNT(*)
	FROM
		ANIMAL
	GROUP BY 
			SPECIES_ID;

-- 성별 동물 수
SELECT GENDER, COUNT(*) FROM ANIMAL GROUP BY GENDER ;
-- 종별로 최대 체중, 최소 체중

SELECT SPECIES_ID , MAX(WEIGHT_KG), MIN(WEIGHT_KG) FROM ANIMAL GROUP BY SPECIES_ID;

-- 구역별(ZONE_ID) 동물 수, 평균 체중 조회

SELECT ZONE_ID, COUNT(*), AVG(WEIGHT_KG)
	FROM ANIMAL
	GROUP BY ZONE_ID

SELECT ZONE_ID,
		GENDER,
		COUNT(*)
	FROM ANIMAL
	GROUP BY ZONE_ID, GENDER
	ORDER BY ZONE_ID, GENDER DESC;


------------------------------------------------
/*
 * HAVING 절
 * 그룹에 대한 조건을 제시할 때 사용하는 문법
 * WHERE 절은 그룹함수를 사용할 수 없음 -> HAVING
 */

-- 종별 동물 수가 4마리 이상인 종만 조회
SELECT SPECIES_ID, COUNT(*)
	FROM ANIMAL
	--WHERE --COUNT(*) >= 4
		--GENDER = 'M'
	GROUP BY SPECIES_ID
	HAVING COUNT(*) >= 4;

SELECT ZONE_ID, AVG(WEIGHT_KG) AS "평균 체중"
	FROM ANIMAL
	GROUP BY ZONE_ID
	HAVING AVG(WEIGHT_KG) >= 100
	ORDER BY ZONE_ID;
/*
 * SELECT 컬럼, 연산식, 함수, 리터럴
 * 	FROM  테이블명
 * 	WHERE 조건식
 * 	GROUP
 * 	   BY 그룹 기준 컬럼
 * HAVING 그룹에 대한 조건식
 * 	ORDER
 * 	   BY 정렬 기준;
 * 
 * 실행순서
 * 1. 1. FROM -> 2. WHERE -> 3. GROUP BY-> 4. HAVING -> 5. SELECT -> 6. ORDER BY
 */












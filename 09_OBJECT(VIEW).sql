/*
 * < VIEW 뷰 > 
 * SELECT문을 저장하는 가상의 테이블
 * 실제 데이터를 저장하는 것이 아니라, SQL문만 저장해두었다가
 * 조회시점에서 저장한 SQL문을 실행해서 결과를 보여줌
 * 
 * CREATE VIEW 뷰이름
 * 		AS 서브쿼리;
 * 
 * -OR REPLACE : 뷰가 이미 존재하면 덮어쓰기
 * 
 */

-- < 뷰 만들기 >

GRANT CREATE VIEW TO C##SG;

CREATE VIEW VW_ANIMAL_INFO
AS
SELECT K.KEEPER_NAME, A.ANIMAL_NAME, S.SPECIES_NAME, Z.ZONE_NAME, A.WEIGHT_KG, A.GENDER,
	DECODE(A.GENDER,'M','수컷','F','암컷') "성별"
	FROM KEEPER K
	LEFT JOIN ANIMAL A USING(KEEPER_ID)
	LEFT JOIN ZONE Z ON(Z.ZONE_ID = A.ZONE_ID)
	LEFT JOIN SPECIES S USING(SPECIES_ID);


SELECT * FROM VW_ANIMAL_INFO
	WHERE KEEPER_NAME = '제인구달'
	ORDER BY ANIMAL_NAME;

-- 데이터 딕셔너리
SELECT * FROM USER_VIEWS;
SELECT * FROM USER_TABLES;
SELECT * FROM USER_CONSTRAINTS;
SELECT * FROM USER_TAB_COLUMNS;
SELECT * FROM USER_CATALOG;
SELECT * FROM USER_OBJECTS;
SELECT * FROM DICTIONARY;

------------------------------------------------
/*
 * 단순 뷰(1개의 테이블, 함수/그룹핑 없음) 는 DML 가능
 * 복합 뷰(JOIN, GROUP BY등) DML불가
 * 보통 만드 때 WITH READ ONLY 옵션을 줘서 DML자체를 차단
 */

-- 구역별 통계 SELECT
CREATE OR REPLACE VIEW VW_ZONE_STATS
AS
SELECT ZONE_NAME, COUNT(*) "COUNT", MAX(WEIGHT_KG) "MAX_WEIGHT",
		MIN(WEIGHT_KG) "MIN_WEIGHT"
	FROM ANIMAL
	JOIN ZONE USING(ZONE_ID)
	GROUP BY ZONE_NAME
WITH READ ONLY;

SELECT * FROM VW_ZONE_STATS;

-- 뷰의 장점
-- 1. 재사용성 : 자주쓰는 쿼리를 저장 -> 복잡한 쿼리를 간단하게 사용 가능
-- 2. 보안성 : 원하는 컬럼만 노출 가능

-- <뷰 삭제 >
-- DROP VIEW 뷰이름;










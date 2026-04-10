/*
 * < DQL(Data Query Language) > => SELECT
 * 데이터 질의 언어 => 데이터를 질의를 날려서 조회하는 구문
 * 
 * < DML(Data Manipulation Language) > 
 * 데이터 조작 언어
 * 테이블에 데이터를 삽입(INSERT), 수정(UPDATE), 삭제(DELETE)하는 구문
 * 
 * ※ 주의 ) DML 수행 후 반드시 TCL(COMMIT/ROLLBACK) 처리 필요
 */
----------------------< INSERT >

/*
 * 테이블에 새로운 행을 추가하는 구문
 * 
 * [ 표현법 1 ] 모든 컬럼에 값을 넣는 경우
 * INSERT INTO 테이블명 VALUES(값, 값, 값 ...);
 * 
 * [ 표현법 2 ] 특정 컬럼만 값을 지정하는 경우
 * INSERT INTO 테이블명(컬럼명, 컬럼명, ...) VALUES(값,값,...);
 * 
 */

SELECT * FROM SPECIES;

INSERT 
  INTO 
  		SPECIES 
  VALUES 
  		(
  		'S13',
  		'피카츄',
  		'포켓몬'
		);


SELECT * FROM ZONE;

INSERT INTO ZONE VALUES ('Z6','KH관','실내');

SELECT * FROM KEEPER;

INSERT INTO KEEPER (KEEPER_ID, KEEPER_NAME, HIRE_DATE) VALUES ('K9','김선겸',SYSDATE);

-- ANIMAL 테이블에 새로운 동물을 한 마리 추가해보세요~ 시작

SELECT * FROM ANIMAL;
SELECT * FROM SPECIES;
INSERT INTO ANIMAL 
VALUES('A36','다람이','S02','Z5','K06','F', 1, 
		TO_DATE('2025-12-25','YYYY-MM-DD'),TO_DATE('2026-01-01','YYYY-MM-DD'));

SELECT * FROM ANIMAL ORDER BY ANIMAL_ID DESC;

SELECT * FROM ZONE;
INSERT ALL 
	INTO ZONE VALUES('Z7','북극관','실내')
	INTO ZONE VALUES('Z8','아마존관','실외')
	INTO ZONE VALUES('Z9','고산관','실외')
	SELECT * FROM DUAL;


CREATE TABLE ANIMAL_BACKUP
AS SELECT * FROM ANIMAL WHERE 1 = 0; -- 구조만 복사

SELECT * FROM ANIMAL_BACKUP;

INSERT INTO ANIMAL_BACKUP 
	(SELECT * FROM ANIMAL WHERE ZONE_ID = 'Z1');



-------------------- < UPDATE >
/*
 * 기존 데이터를 수정하는 구문
 * 
 * [ 표현법 ]
 * UPDATE 
 * 		테이블명 
 * 	SET
 * 		컬럼명 = 바꿀 값,
 * 		컬럼명 = 바꿀 값,
 * 		...
 * 	WHERE
 * 		조건식; 
 * 
 * 
 */

SELECT * FROM ANIMAL ORDER BY ANIMAL_ID DESC;

-- WHERE 절을 생략하면 모든 행이 수정됨!
UPDATE 
		ANIMAL
	SET
		KEEPER_ID = 'K9'
	WHERE
		ANIMAL_ID = 'A35'

ROLLBACK;

-- 서브쿼리를 활용한 UPDATE
-- 러바오와 같은 구역에 있는 판다들의 사육사를 K02로 통일
SELECT * FROM KEEPER;
SELECT SPECIES_ID, ZONE_ID FROM ANIMAL
	WHERE (SELECT SPECIES_ID, ZONE_ID FROM ANIMAL WHERE ANIMAL_NAME = '러바오';

UPDATE ANIMAL SET KEEPER_ID = 'K02' WHERE (SPECIES_ID, ZONE_ID) = (
	SELECT SPECIES_ID, ZONE_ID FROM ANIMAL WHERE ANIMAL_ID = (
		SELECT SPECIES_ID, ZONE_ID FROM ANIMAL WHERE ANIMAL_NAME = '러바오'));

UPDATE ANIMAL
	SET
		WEIGHT_KG = 5.2,
		KEEPER_ID = 'K07'
	WHERE
		ANIMAL_ID = 'A35';

--------------------------------------------------
-- < DELETE >
/*
 * 테이블의 행을 삭제하는 구문
 * 
 * DELETE FROM 테이블명 WHERE 조건;
 * 
 * 주의) WHERE절은 안쓰면 전체 행이 삭제됨
 */

SELECT * FROM ANIMAL_BACKUP;

DELETE FROM ANIMAL_BACKUP
	WHERE ANIMAL_NAME = '리카';

ROLLBACK;
/*
 * TRUNCATE vs DELETE
 * TRUNCATE TABLE 테이블명 -> 전체 삭제(DDL, 살릴 수가 없음)
 * DELETE FROM 테이블명 -> 전체 삭제(DML, 살릴 수 있음)
 */
SELECT * FROM ANIMAL_BACKUP;
DELETE FROM ANIMAL_BACKUP;
TRUNCATE TABLE ANIMAL_BACKUP;

-- 태이블 삭제
DROP TABLE ANIMAL_BACKUP;


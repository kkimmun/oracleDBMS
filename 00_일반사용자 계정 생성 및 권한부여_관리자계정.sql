-- 한 줄 주석
/*
 *  여러 줄 주석
 */
 -- 일반 사용자 계정(수업시간에 사용할 각자 계정)
CREATE USER C##SG IDENTIFIED BY SG; -- CTRL + ENTER (SQL 실행)

-- 접속 권한, 데이터를 다룰 수 있는 권한 부여
GRANT CONNECT, RESOURCE TO C##SG;
-- 테이블 스페이스 사용 권한
GRANT UNLIMITED TABLESPACE TO C##SG;


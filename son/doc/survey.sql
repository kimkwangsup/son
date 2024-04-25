-- ���� ���� ���̺�
CREATE TABLE topic(
    tpno NUMBER(4)
        CONSTRAINT TOPIC_NO_PK PRIMARY KEY,
    title VARCHAR2(4000)
        CONSTRAINT TOPIC_TITLE_NN NOT NULL,
    startdate DATE
        CONSTRAINT TOPIC_SDATE_NN NOT NULL,
    enddate DATE
        CONSTRAINT TOPIC_EDATE_NN NOT NULL
);
-- ���� ���� ���̺�
CREATE TABLE quest(
    qno NUMBER(6)
        CONSTRAINT QUEST_NO_PK PRIMARY KEY,
    qbody VARCHAR2(4000)
        CONSTRAINT QUEST_BODY_NN NOT NULL,
    qupno NUMBER(6)
);
-- ���� ���� ���̺�
CREATE TABLE survey(
    svno NUMBER(6)
        CONSTRAINT SURVEY_NO_PK PRIMARY KEY,
    stno NUMBER(4)
        CONSTRAINT SURVEY_TPNO_NN NOT NULL
        CONSTRAINT SURVEY_TPNO_FK REFERENCES topic(tpno),
    sqno NUMBER(6)
        CONSTRAINT SURVEY_QNO_FK REFERENCES quest(qno)
        CONSTRAINT SURVEY_QNO_NN NOT NULL
);
-- ���� ���� ���̺�
CREATE TABLE serveyAnswer(
    sano NUMBER(6)
        CONSTRAINT SA_NO_PK PRIMARY KEY,
    ssno NUMBER(6)
        CONSTRAINT SA_SNO_FK REFERENCES survey(svno)
        CONSTRAINT SA_SNO_NN NOT NULL,
    sa_id VARCHAR2(10 CHAR)
        CONSTRAINT SA_ID_FK REFERENCES member(id)
        CONSTRAINT SA_ID_NN NOT NULL,
    adate DATE DEFAULT SYSDATE
        CONSTRAINT SA_DATE_NN NOT NULL
);

-- ���� ���� ������ �Է�
INSERT INTO
    topic
VALUES(
    (SELECT NVL(MAX(tpno) + 1 , 1001) FROM topic),
    '���� ���ǽ�', TO_DATE('2024/04/23'), TO_DATE('2024/05/01')
);
commit;
-- ���� ���� ������ �Է�
INSERT INTO
    quest
VALUES(
    (SELECT NVL(MAX(qno)+1, 1001) FROM quest),
    '���ǽ� ��� �� �־� �����?', null
);













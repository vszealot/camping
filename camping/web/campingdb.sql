select * from tab;
select * from CAMPING_TEST;
select * from userinfo;
select rownum, * from CAMPING_TEST where rownum>=11 and rownum<=20;

select * from (select rownum rn, aa.* from (select *from CAMPING_TEST)aa)where rn>=1 and rn<=10;

select * from (select rownum rn, aa.* from (select *from CAMPING_TEST where addr1 like '%충청%')aa)where rn>=1 and rn<=10;

select count(campname) from CAMPING_TEST;

select * from CAMPING_TEST order by searchcount desc;
commit;

insert into USERINFO values ('master','jungsub506@naver.com','관리자','master123','운영자');

insert into USERINFO values ('11','asdf@asdf.asdf','관리','11','운영자');
select * from userInfo;
delete userInfo;
drop table userInfo;
commit;
create table userInfo(
userId varchar2(30) primary key,
userEmail varchar2(50),
nickName varchar2(30),
password varchar2(20),
grade varchar2(20) default '일반회원',
);

select * from marketboard;
select * from QNABOARD;
select * from tab;

select * from marketboard;
select * from MARKETREPLY;
select * from marketrecommend

SELECT a.postno, nickname, title, content,regdate,click,recommend,image,(select count(*) from MARKETREPLY b where b.postno=a.postno) repcnt 
from marketboard a;

select * from (select postno, nickname, title, content, regdate, click, recommend, image, (select count(*) from MARKETrecommend c where c.postno=a.postno) reccnt, (select count(*) from MARKETREPLY b where b.postno=a.postno) repcnt,row_number() over(order by postno desc) as rNum from marketBOARD a) mb 
where rNum between 1 and 10 order by postno desc

select * from (select postno, nickname, title, content, regdate, click, recommend, image, (select count(*) from MARKETREPLY b where b.postno=a.postno) repcnt,row_number() over(order by postno desc) as rNum from marketBOARD a where title like '%' || '글' || '%') mb 
where rNum between 1 and 10 order by postno desc

create table qnaBoard (
postNo number not null,
nickName varchar2(30) not null,
title varchar2(30) not null,
content varchar2(2000) not null,
regDate date default sysdate,
click number default 0,
recommend number default 0,
image varchar2(40),
primary key(postNo),
CONSTRAINT uiqbnn FOREIGN KEY(nickName) references userInfo(nickName) ON DELETE CASCADE
);

create table qnaReply (
postNo number not null,
rNo number not null,
content varchar2(2000) not null,
nickName varchar2(30) not null,
regDate date default sysdate,
primary key(postNo, rno),
CONSTRAINT mbqrpn FOREIGN KEY(postNo) references marketBoard(postNo) ON DELETE CASCADE,
CONSTRAINT uiqrnn FOREIGN KEY(nickName) references userInfo(nickName) ON DELETE CASCADE
);

create table qnaRecommend(
postNo number not null,
nickName varchar2(30) not null,
primary key(postNo, nickName),
CONSTRAINT mbqcpn FOREIGN KEY(postNo) references marketBoard(postNo) ON DELETE CASCADE,
CONSTRAINT uiqcnn FOREIGN KEY(nickName) references userInfo(nickName) ON DELETE CASCADE
);

CREATE TABLE qnaFILE(
IDX number,
postNo NUMBER NOT NULL,
nickName VARCHAR2(30) NOT NULL,
ORIGINAL_FILE_NAME VARCHAR2(260) NOT NULL,
STORED_FILE_NAME VARCHAR2(40) NOT NULL,
FILE_SIZE NUMBER,
regDate  DATE DEFAULT SYSDATE NOT NULL,
DEL_GB VARCHAR2(1 BYTE) DEFAULT 'N' NOT NULL,
PRIMARY KEY (IDX),
CONSTRAINT mbqfpn FOREIGN KEY(postNo) references marketBoard(postNo) ON DELETE CASCADE,
CONSTRAINT uiqfnn FOREIGN KEY(nickName) references userInfo(nickName) ON DELETE CASCADE
);

create table campRecommend(
addr1 varchar2(4000) not null,
nickName varchar2(30) not null,
primary key(addr1, nickName),
CONSTRAINT ctccad FOREIGN KEY(addr1) references camping_test(addr1) ON DELETE CASCADE,
CONSTRAINT uiccnn FOREIGN KEY(nickName) references userInfo(nickName) ON DELETE CASCADE
);
select count(nickName) from camprecommend where addr1 = '대전광역시 중구 침산동 산 34번지 뿌리공원';
select * from camping_test

insert into MARKETFILE(idx, postNo, nickname, ORIGINAL_FILE_NAME, STORED_FILE_NAME, FILE_SIZE) values(marketfile_seq.nextval,1024,'vs질럿','오리지널','스토어',234)
delete marketfile
select * from marketfile where postNo=1028
drop table marketFile;
select * from tab;

UPDATE marketFILE SET DEL_GB = 'N' WHERE idx=1;

select * from MARKETRECOMMEND where postno=248
delete MARKETRECOMMEND where postno=248 and nickname='니켈'
insert into marketRecommend values (248,'니켈');

create sequence qnar_seq;
create sequence qnafile_seq;

marketr_seq
marketfile_seq
select * from user_sequences
select * from marketboard where postno=248
select * from (select postno, nickname, title, content, regdate, click, image, (select count(*) from MARKETrecommend c where c.postno=a.postno) reccnt from marketBOARD a) mb where postno=248

select postNo from marketboard where rownum=1 order by postNo desc
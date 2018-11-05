select * from tab;
select * from CAMPING_TEST;
select * from userinfo;
select rownum, * from CAMPING_TEST where rownum>=11 and rownum<=20;

select * from (select rownum rn, aa.* from (select *from CAMPING_TEST)aa)where rn>=1 and rn<=10;

select * from (select rownum rn, aa.* from (select *from CAMPING_TEST where addr1 like '%ÃæÃ»%')aa)where rn>=1 and rn<=10;

select count(campname) from CAMPING_TEST;

select * from camping_test;
commit;


select * from userInfo;
delete userInfo;
drop table userInfo;
commit;
create table userInfo(
userId varchar2(30) primary key,
userEmail varchar2(50),
nickName varchar2(30),
password varchar2(20));

select * from marketboard;
select * from QNABOARD;
select * from tab;

create table marketRecommend(
postNo number,
nickName varchar2(30),

)
select * from marketboard;
select * from MARKETREPLY;
select * from marketrecommend

SELECT a.postno, nickname, title, content,regdate,click,recommend,image,(select count(*) from MARKETREPLY b where b.postno=a.postno) repcnt 
from marketboard a;

select * from (select postno, nickname, title, content, regdate, click, recommend, image, (select count(*) from MARKETREPLY b where b.postno=a.postno) repcnt,row_number() over(order by postno desc) as rNum from marketBOARD a) mb 
where rNum between 1 and 10 order by postno desc

select * from (select postno, nickname, title, content, regdate, click, recommend, image, (select count(*) from MARKETREPLY b where b.postno=a.postno) repcnt,row_number() over(order by postno desc) as rNum from marketBOARD a where title like '%' || '±Û' || '%') mb 
where rNum between 1 and 10 order by postno desc

create table marketReply (
postNo       number            not null,
rNo       number            not null,
content   varchar2(2000)    not null,
nickName    varchar2(30)      not null,
regDate   date              default sysdate,
primary key(bno, rno)
CONSTRAINT mbmrpn FOREIGN KEY(postNo) references marketBoard ON DELETE CASCADE
CONSTRAINT uimrnn FOREIGN KEY(nickName) references userInfo ON DELETE CASCADE
);

create table marketRecommend(
postNo number not null;
nickName varchar2(30) not null;
primary key(postNo, nickName)
CONSTRAINT mbmcpn FOREIGN KEY(postNo) references marketBoard ON DELETE CASCADE
CONSTRAINT uimcnn FOREIGN KEY(nickName) references userInfo ON DELETE CASCADE
)



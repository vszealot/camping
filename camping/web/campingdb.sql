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


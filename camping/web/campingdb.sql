select * from tab;
select * from CAMPING_TEST;
select rownum, * from CAMPING_TEST where rownum>=11 and rownum<=20;

select * from (select rownum rn, aa.* from (select *from CAMPING_TEST)aa)where rn>=1 and rn<=10;

select * from (select rownum rn, aa.* from (select *from CAMPING_TEST where addr1 like '%ÃæÃ»%')aa)where rn>=1 and rn<=10;

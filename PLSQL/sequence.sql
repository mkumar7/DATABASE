drop sequence log#_seq;
drop sequence pur#_seq;
drop sequence sup#_seq;

create sequence log#_seq start with 10001 increment by 1 nocache nocycle;
create sequence pur#_seq start with 100001 increment by 1 nocache nocycle;
create sequence sup#_seq start with 1000 increment by 1 nocache nocycle;

select sup#_seq.nextval from supplies;
select pur#_seq.nextval from purchases;
select log#_seq.nextval from logs;
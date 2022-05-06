drop table if exists student5;
drop table if exists mylog5;
drop trigger if exists log_insert;
drop trigger if exists log_delete;
drop trigger if exists log_update;
create table student5(ID varchar(5),
					name varchar(20), 
                    dept_name varchar(20), 
                    tot_cred decimal(3),
                    primary key (ID));
create table mylog5(id int auto_increment, 
					tbname varchar(20), 
                    colname varchar(20), 
                    event varchar(20), 
                    oldvalue varchar(20), 
                    newvalue varchar(20), 
                    datetime datetime,
                    primary key (id));
DELIMITER $
create trigger log_insert 
after 
insert on student5 
for each row 
begin 
	insert into mylog5 
    values(id,'student5',null, 'insert',null,new.name,current_time());
end$
create trigger log_delete 
after 
delete on student5 
for each row 
begin 
	insert into mylog5 
    values(id,'student5',null, 'delete',old.name,null,current_time());
end$
create trigger log_update 
after 
update on student5 
for each row 
begin 
	insert into mylog5 
    values(id,'student5','tot_cred', 'update',old.tot_cred,new.tot_cred,current_time());
end$
DELIMITER ;
delete from student5;

insert into student5 
(select ID,name,dept_name,tot_cred from student 
where id='1000' or id='10033' or id='10076' or id='1018' or id='10204');
select * from student5;
select * from mylog5;

update student5 set tot_cred=tot_cred*2;
select * from student5;
select * from mylog5;

delete from student5;

select * from student5;
select * from mylog5;





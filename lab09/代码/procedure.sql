drop procedure if exists get_courses; 

DELIMITER $$
create procedure get_courses(in idept_name varchar(20))
begin
	declare cnt int;
    create temporary table dept_courses(course_id varchar(8));
    insert into dept_courses 
	select course_id
    from course 
    where dept_name=idept_name;
	with recursive rec_prereq(course_id,prereq_id) as
    (
		select course_id,prereq_id 
        from prereq 
	union
		select rec_prereq.course_id, prereq.prereq_id 
		from prereq, rec_prereq 
		where prereq.course_id = rec_prereq.prereq_id 
    ) select distinct course_id from rec_prereq 
    where rec_prereq.prereq_id in (select * from dept_courses) 
    order by course_id;
end$$

DELIMITER ;




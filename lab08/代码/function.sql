drop function if exists find_prereq;
DELIMITER $$ 

create function find_prereq(acourse_id varchar(8))
	returns varchar(20)
    deterministic
    begin
		declare res varchar(2000) default '';
        declare temp varchar(20) default '';
        declare cnt int;
        create temporary table rec_ans(course_id varchar(8), prereq_id varchar(8));
        insert into rec_ans
		(with recursive rec_prereq(course_id,prereq_id) as (
			select course_id, prereq_id 
            from prereq
		union 
			select rec_prereq.course_id, prereq.prereq_id 
            from prereq, rec_prereq 
            where prereq.course_id = rec_prereq.prereq_id
		) select course_id,prereq_id from rec_prereq);
        select count(*) into cnt from rec_ans where rec_ans.course_id = acourse_id;
        while cnt > 0 do
			select new_table.prereq_id into temp
			from (select row_number() over (order by course_id) as r_num,course_id,prereq_id from rec_ans where 
            course_id = acourse_id) 
            as new_table where r_num=cnt ;
            set temp = concat(temp,',');
            set res = concat(res,temp);
            set cnt = cnt - 1;
        end while;
        return res;
	end$$

DELIMITER ;
select find_prereq('276');

-- 验证
-- with recursive rec_prereq(course_id,prereq_id) as (
-- 			select course_id, prereq_id 
--             from prereq
-- 		union 
-- 			select rec_prereq.course_id, prereq.prereq_id 
--             from prereq, rec_prereq 
--             where prereq.course_id = rec_prereq.prereq_id
-- 		) select * from rec_prereq order by course_id;
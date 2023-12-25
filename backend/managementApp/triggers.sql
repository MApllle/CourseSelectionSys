-- 触发器：计算总成绩
DELIMITER ||
create trigger caculate_score
before update on managementapp_course_selection
for each row
begin 
    declare percent double;
    select normal_score_percent into percent from managementapp_course where course_id=new.course_id_id;
    set new.total_score=(coalesce(new.normal_score,0)*percent)+coalesce(new.test_score,0)*(1-percent);
end
||
DELIMITER ;

-- 触发器：选课前，课程容量减一
DELIMITER ||
create trigger manage_course_capacity
after insert on managementapp_course_selection
for each row
begin 
    update managementapp_open_course
    set used_capacity=used_capacity+1
    where course_id_id=new.course_id_id
        and staff_id_id=new.staff_id_id
        and semester=new.semester;
end
||
DELIMITER ;

--触发器:删除选课后，used_capa-1
DELIMITER ||
create trigger manage_course_capacity_ondelete
after delete on managementapp_course_selection
for each row
begin 
    update managementapp_open_course
    set used_capacity=used_capacity-1
        where course_id_id=old.course_id_id
        and staff_id_id=old.staff_id_id
        and semester=old.semester;
end
||
DELIMITER ;
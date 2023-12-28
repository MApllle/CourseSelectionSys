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

--触发器:更改平时分占比后，重新计算选课表里的总成绩
DELIMITER ||
CREATE DEFINER = `root`@`localhost` TRIGGER `update_total_score` AFTER UPDATE ON `managementapp_course` FOR EACH ROW BEGIN
    DECLARE normal_score_percent_val DOUBLE;-- 定义变量平时分占比
    
    -- 获取最新的平时分占比
    SELECT normal_score_percent INTO normal_score_percent_val
    FROM managementapp_course
    WHERE course_id = NEW.course_id;
    
    -- 更新选课表中的total_score--
    UPDATE managementapp_course_selection
    SET total_score = normal_score * normal_score_percent_val + test_score * (1 - normal_score_percent_val)
    WHERE managementapp_course_selection.course_id_id = NEW.course_id;
END;
||
DELIMITER ;

--更改平时分占比 存储过程版
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_total_score`(IN course_id_param VARCHAR(32))
BEGIN
    DECLARE normal_score_percent_val DOUBLE;-- 定义变量平时分占比
    
    -- 获取最新的平时分占比
    SELECT normal_score_percent INTO normal_score_percent_val
    FROM managementapp_course
    WHERE course_id = course_id_param;
    
    -- 更新选课表中的total_score
    UPDATE managementapp_course_selection
    SET total_score = normal_score * normal_score_percent_val + test_score * (1 - normal_score_percent_val)
    WHERE managementapp_course_selection.course_id_id = course_id_param;
END
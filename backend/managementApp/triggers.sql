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
    where id=new.open_course_id_id;
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
        where id=old.open_course_id_id;
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

 --存储过程：计算平均成绩（只有在本学期选了课的需要更新平时成绩）
DELIMITER //

CREATE PROCEDURE CalculateAverageScore(in thisSemester varchar(32))
BEGIN
    DECLARE studentId INT;
    DECLARE totalScore DECIMAL(10, 2);
    DECLARE subjectCount INT;
    DECLARE totalGPA DECIMAL(10, 2);
    DECLARE totalCredits INT;  
    -- 包含失学分
    DECLARE totalRealCredits INT;
    DECLARE totalCreditGPA DECIMAL(10, 2);

    -- 获取学生ID列表
    DECLARE studentCursor CURSOR FOR
        SELECT DISTINCT student_id_id
        FROM managementapp_course_selection
        WHERE semester=thisSemester;

    -- 声明终止条件
    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET studentId = NULL;

    OPEN studentCursor;

    -- 遍历学生列表
    studentLoop: LOOP
        FETCH studentCursor INTO studentId;

        IF studentId IS NULL THEN
            LEAVE studentLoop;
        END IF;

        SET totalScore = 0;
        SET subjectCount = 0;
        SET totalCredits = 0;
        SET totalGPA = 0;
        SET totalCreditGPA = 0;
        SET totalRealCredits = 0;

        -- 计算总分和科目数
        SELECT SUM(cs.total_score), 
            COUNT(cs.id),
            SUM(CASE WHEN cs.total_score > 60 THEN c.credit ELSE 0 END),
            SUM(c.credit),
            SUM(CASE
                    WHEN total_score >= 90 THEN 4.0*c.credit
                    WHEN total_score >= 85 THEN 3.7*c.credit
                    WHEN total_score >= 82 THEN 3.3*c.credit
                    WHEN total_score >= 78 THEN 3.0*c.credit
                    WHEN total_score >= 75 THEN 2.7*c.credit
                    WHEN total_score >= 72 THEN 2.3*c.credit
                    WHEN total_score >= 68 THEN 2.0*c.credit
                    WHEN total_score >= 66 THEN 1.7*c.credit
                    WHEN total_score >= 64 THEN 1.5*c.credit
                    WHEN total_score >= 60 THEN 1.0*c.credit
                    ELSE 0.0
                END)
            
        INTO totalScore, subjectCount, totalCredits, totalRealCredits, totalCreditGPA
        FROM managementapp_course_selection cs,managementapp_course c
        WHERE cs.course_id_id=c.course_id
            AND cs.student_id_id = studentId;

        -- 计算平均成绩,平均绩点，总学分（不包含失学分）
        IF subjectCount > 0 THEN
            UPDATE managementapp_student
            SET average_score = COALESCE(totalScore / NULLIF(subjectCount, 0), 0),average_gpa = COALESCE(totalCreditGPA / NULLIF(totalRealCredits, 0), 0),total_credit = totalCredits
            WHERE student_id = studentId;
        END IF;

    END LOOP;

    CLOSE studentCursor;
END // 

DELIMITER ;

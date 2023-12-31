#命令
#python manage.py makemigrations 
#python manage.py migrate  生成数据表
from django.db import models
from django.contrib.auth.models import User
from django.core.validators import MinValueValidator, MaxValueValidator
# Create your models here.

#院系表
class department(models.Model):                                                 
    dept_id = models.CharField(max_length=8, primary_key=True) # 院系号
    dept_name = models.CharField(max_length=32)                                                                # 院系名称
    address = models.CharField(max_length=32, unique=True)     # 联系电话
    phone_code = models.CharField(max_length=64,blank=True,null=True)    # 地址

#学生表
class student(models.Model):
    student_id = models.CharField(max_length=32, unique=True, primary_key=True) # 学号（主键）
    name = models.CharField(max_length=32)                 # 姓名
    sex = models.CharField(max_length=4,blank=True,null=True)        # 性别
    date_of_birth = models.DateField(blank=True,null=True)           # 出生日期
    native_place = models.CharField(max_length=32,blank=True,null=True)   # 籍贯
    mobile_phone = models.CharField(max_length=32, blank=True,null=True)   # 手机号码
    dept_id = models.ForeignKey('department', to_field='dept_id', on_delete=models.CASCADE)      # 院系号(外键)
    average_gpa = models.FloatField(null=True,blank=True)   # 所有学期均绩
    total_credit = models.FloatField(null=True,blank=True) # 所有学期学分和
    average_score = models.FloatField(null=True,blank=True)   # 所有学期均分
    user_id = models.ForeignKey(User, to_field='id', on_delete=models.CASCADE)  #账号id

#教师表
class teacher(models.Model):
    staff_id = models.CharField(max_length=32, unique=True, primary_key=True) # 工号(主键)
    name = models.CharField(max_length=32)                                    # 姓名
    sex = models.CharField(max_length=4,blank=True,null=True)                           # 性别
    date_of_birth = models.DateField(blank=True,null=True)                              # 出生日期
    professional_ranks = models.CharField(max_length=32,blank=True,null=True)           # 等级
    salary = models.FloatField(blank=True,null=True)                                    # 工资
    dept_id = models.ForeignKey('department', to_field='dept_id',on_delete=models.CASCADE) # 院系号(外键)
    user_id = models.ForeignKey(User, to_field='id', on_delete=models.CASCADE)  #账号id
    
#课程表
class course(models.Model):
    course_id = models.CharField(max_length=32,unique=True, primary_key=True)   # 课程号
    course_name = models.CharField(max_length=32)        # 课名
    credit = models.IntegerField()                       # 学分
    credit_hours = models.IntegerField()                 # 学时
    dept_id = models.ForeignKey('department', to_field='dept_id',on_delete=models.CASCADE)      # 院系号(外键)
    normal_score_percent=models.FloatField(validators=[MinValueValidator(0), MaxValueValidator(1)],default=0.5)   #平时成绩占总成绩百分比

#开课表
class open_course(models.Model):
    semester = models.CharField(max_length=32,blank=False, null=False) 
    course_id = models.ForeignKey('course', to_field='course_id',on_delete=models.CASCADE,blank=False, null=False)      # 课程序号(外键)
    staff_id = models.ForeignKey('teacher', to_field='staff_id',on_delete=models.CASCADE,blank=False, null=False)         # 工号(外键)
    class_time = models.CharField(max_length=32)               # 上课时间
    capacity=models.IntegerField()  #课程容量
    used_capacity=models.IntegerField()  #已用容量
    class Meta:
        unique_together = ["semester", "course_id", "staff_id","class_time"]

#选课表
class course_selection(models.Model):
    student_id = models.ForeignKey('student', to_field='student_id',on_delete=models.CASCADE)         # 学号(外键)
    course_id = models.ForeignKey('course', to_field='course_id',on_delete=models.CASCADE)      # 课程序号(外键)
    semester = models.CharField(max_length=32)                 # 学期,django限制其不能成为唯一键
    staff_id = models.ForeignKey('teacher', to_field='staff_id',on_delete=models.CASCADE)         # 工号(外键)
    normal_score = models.FloatField(validators=[MinValueValidator(1), MaxValueValidator(100)],null=True,blank=True)       # 平时成绩
    test_score = models.FloatField(validators=[MinValueValidator(1), MaxValueValidator(100)],null=True,blank=True)       # 考试成绩
    total_score = models.FloatField(validators=[MinValueValidator(1), MaxValueValidator(100)],null=True,blank=True)       # 总评成绩
    open_course_id=models.ForeignKey('open_course', to_field='id',on_delete=models.CASCADE)
    class Meta:
        unique_together = ["student_id", "course_id", "semester"]


# 教师申请开课
class course_request(models.Model):
    course_id = models.CharField(max_length=32, unique=True, primary_key=True, blank=False, null=False)  # 课程号
    course_name = models.CharField(max_length=32, default='111')  # 课名
    credit = models.IntegerField()  # 学分
    credit_hours = models.IntegerField()  # 学时
    dept_id = models.ForeignKey('department', to_field='dept_id', on_delete=models.CASCADE)  # 院系号(外键)
    normal_score_percent = models.FloatField(validators=[MinValueValidator(0), MaxValueValidator(1)],
                                             default=0.5)  # 平时成绩占总成绩百分比
    staff_id = models.ForeignKey('teacher', to_field='staff_id', on_delete=models.CASCADE)  # 请求教师工号(外键)
    status = models.IntegerField(default=0)  # 状态 0:待处理 1:已通过 2:已拒绝


class student_comments(models.Model):
    student_id = models.ForeignKey('student', to_field='student_id', on_delete=models.CASCADE)  # 学号(外键)
    course_id = models.ForeignKey('course', to_field='course_id', on_delete=models.CASCADE)  # 课程号(外键)
    staff_id = models.ForeignKey('teacher', to_field='staff_id', on_delete=models.CASCADE)  # 工号(外键)
    comments = models.TextField()  # 评价


class meeting_room(models.Model):


    TIME_RANGE = (
        ('8-12', '8-12'),
        ('13-17', '13-17'),
        ('18-22', '18-22'),
    )

    room_id = models.CharField(max_length=32, unique=True, primary_key=True)  # 会议室号
    room_name = models.CharField(max_length=32, default='A')  # 会议室名称
    room_size = models.CharField(max_length=32, default='small')  # 会议室大小
    min_number = models.IntegerField(default=2)  # 会议室最少人数
    status = models.BooleanField(default=0)  # 会议室状态态 0:空闲 1:占用
    time_range = models.CharField(max_length=32, default='8-12', choices=TIME_RANGE, blank=True, null=True)  # 会议室可用时间段

    class Meta:
        db_table = "managementapp_meeting_room"
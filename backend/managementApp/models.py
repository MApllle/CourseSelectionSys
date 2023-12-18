#命令
#python manage.py makemigrations 
#python manage.py migrate  生成数据表
from django.db import models

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
    mobile_phone = models.CharField(max_length=32, unique=True,blank=True,null=True)   # 手机号码
    dept_id = models.ForeignKey('department', to_field='dept_id', on_delete=models.CASCADE)      # 院系号(外键)
    average_gpa = models.FloatField(null=True,blank=True)   # 所有学期均绩
    total_cerdict = models.FloatField(null=True,blank=True) # 所有学期学分和

#教师表
class teacher(models.Model):
    staff_id = models.CharField(max_length=32, unique=True, primary_key=True) # 工号(主键)
    name = models.CharField(max_length=32)                                    # 姓名
    sex = models.CharField(max_length=4,blank=True,null=True)                           # 性别
    date_of_birth = models.DateField(blank=True,null=True)                              # 出生日期
    professional_ranks = models.CharField(max_length=32,blank=True,null=True)           # 等级
    salary = models.FloatField(blank=True,null=True)                                    # 工资
    dept_id = models.ForeignKey('department', to_field='dept_id',on_delete=models.CASCADE) # 院系号(外键)

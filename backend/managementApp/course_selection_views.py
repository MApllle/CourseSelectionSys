from django.shortcuts import render
from django.shortcuts import HttpResponse
import json,hashlib
from .sql_basic import get_from_table
from .models import student,teacher,course,course_selection,open_course
from django.contrib.auth.models import User
# Create your views here.

'''
增：必要字段：
student_id_id
course_id_id（开课表获取）
semester（开课表获取）
staff_id_id（开课表获取）
group 判断是否为管理员
增返回字段：id，semester，三个score，course_id_id，staff_id_id，student_id_id
删：必要字段：
id（其实根据id删除即可）
student_id_id
course_id_id（开课表获取）
semester（开课表获取）
staff_id_id（开课表获取）
改（只有老师能改）：
必要字段：
id即可
student_id_id
course_id_id（开课表获取）
semester（开课表获取）
staff_id_id（开课表获取）
查：（这里是指学生选课进行的查询）
student_id_id
student_name
course_id_id
course_name
semester    #选课界面、课程表从内存中读取semester
staff_id_id
staff_name
professional_ranks
[剩余容量
上课时间]
'''
#选课表从开课表中获取、构造选课页面
def fetchCoursesForSelect(request):
    if request.method=='POST':
        #获取query
        post_data = json.loads(request.body.decode('utf-8'))
        query = {key: value for key, value in post_data.items() if value}
        param=[]
        if not query:
            sql = 'select oc.id as opencourse_id,oc.course_id_id,c.course_name,t.name as staff_name,oc.staff_id_id,t.professional_ranks,oc.class_time,oc.capacity,oc.used_capacity from managementapp_open_course oc,managementapp_course c,managementapp_teacher t where oc.staff_id_id=t.staff_id and oc.course_id_id=c.course_id'
        else:
            sql = 'select oc.id as opencourse_id,oc.course_id_id,c.course_name,t.name as staff_name,oc.staff_id_id,t.professional_ranks,oc.class_time,oc.capacity,oc.used_capacity from managementapp_open_course oc,managementapp_course c,managementapp_teacher t where oc.staff_id_id=t.staff_id and oc.course_id_id=c.course_id and '
            conditions = []
            for key, value in query.items():
                if key in ['course_name']:
                    conditions.append(f'c.{key} = %s')
                elif key in ['course_id_id','staff_id_id','semester','capacity','used_capacity']:
                    conditions.append(f'oc.{key} = %s')
                elif key in ['name','professional_ranks']:
                    conditions.append(f't.{key} = %s')
                else :conditions.append(f'{key} = %s')
                param.append(value)
            sql += ' AND '.join(conditions)
        out=get_from_table(sql,param)
        #需要捕捉一下错误
        data={
            "code":20000,
            "data":out,
            "messgae":"查询成功"
        }
        return HttpResponse(json.dumps(data),content_type='application/json')


def handleCourseSelection(request):
    if request.method=='POST':#查询
        #获取query
        post_data = json.loads(request.body.decode('utf-8'))
        #提取所有值为空的，新建一个字典
        query = {key: value for key, value in post_data.items() if value}
        param=[]
        if not query:
            sql = 'select * from managementapp_course_selection'
        else:
            #不提供通过生日和薪水查老师
            sql = 'select * from managementapp_course_selection where '
            for key,value in query.items():
                sql=sql+key+'= %s '
                param.append(value)
        out=get_from_table(sql,param)
        #需要捕捉一下错误
        data={
            "code":20000,
            "data":out,
            "messgae":"查询成功"
        }
        return HttpResponse(json.dumps(data),content_type='application/json')
    elif request.method=='PUT':#更新
        request_data = json.loads(request.body.decode('utf-8'))
        #需要捕捉一下错误
        #确保院系号存在？
        course_selection.objects.filter(id=request_data['id']).update(normal_score=request_data.get('normal_score', 0),
                                                                    test_score=request_data.get('test_score', 0),)
        data={
            "code":20000,
            "messgae":"更新成功"
        }
        return HttpResponse(json.dumps(data),content_type='application/json')
    elif request.method=='DELETE':#删除(逐个删)
        request_data = json.loads(request.body.decode('utf-8'))
        todelete_id=request_data['selectcourse_id']
        course_selection.objects.filter(id=todelete_id).delete()
        data={
            "code":20000,
            "messgae":"删除成功"
        }
        return HttpResponse(json.dumps(data),content_type='application/json')
    
def addCourseSelection(request):#新增
    data={
        "code":20000,
        "messgae":"新增成功"
    }
    if request.method=='POST':
        request_data = json.loads(request.body.decode('utf-8'))
        print("==========================",request_data)
        if request_data['student_id_id'] and request_data['course_id_id'] and request_data['semester'] and request_data['staff_id_id']:
            #获取auth_user的id
            #只要都传过来，无条件认为组合是合法的，因为懒得写校验了
            course_to=open_course.objects.get(id=request_data['opencourse_id'])
            if course_selection.objects.filter(student_id_id=request_data['student_id_id'],course_id_id=request_data['course_id_id'],semester=request_data['semester'],staff_id_id=request_data['staff_id_id']).count()!=0:
                data={
                    "code":50000,
                    "messgae":"不能重复选择相同的课！"
                }
                return HttpResponse(json.dumps(data),content_type='application/json')
            elif request_data['group']=='学生' and course_to.used_capacity==course_to.capacity:
                data={
                    "code":50000,
                    "messgae":"课程容量已满！"
                }
                return HttpResponse(json.dumps(data),content_type='application/json')
            elif request_data['group']=='管理员' and course_to.used_capacity==course_to.capacity:
                newnum=course_to.capacity+1
                open_course.objects.filter(semester=request_data['semester'],course_id_id=request_data['course_id_id'],staff_id_id=request_data['staff_id_id']).update(capacity=newnum)
            #触发器会自动-1
            #在这里写两个判断条件
            new_cs = course_selection.objects.create(semester=request_data.get('semester', ''), 
                                                    normal_score=request_data.get('normal_score', 0), 
                                                    test_score=request_data.get('test_score', 0), 
                                                    total_score=request_data.get('total_score', 0),
                                                    course_id_id=request_data.get('course_id_id', ''), 
                                                    staff_id_id=request_data.get('staff_id_id', ''), 
                                                    student_id_id=request_data.get('student_id_id', ''))
            new_cs.save()
            data={
                "code":20000,
                "messgae":"选课成功！"
            }
            return HttpResponse(json.dumps(data),content_type='application/json')
        else:
            data['code']=50000,
            data['messgae']="缺少申请字段！"
        return HttpResponse(json.dumps(data),content_type='application/json')
        

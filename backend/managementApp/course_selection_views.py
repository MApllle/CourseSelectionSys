from django.shortcuts import render
from django.shortcuts import HttpResponse
import json,hashlib
from .sql_basic import get_from_table
from .models import student,teacher,course,course_selection,open_course
from django.contrib.auth.models import User
from django.db.models import Sum
from .open_course_views import is_time_conflict
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
#为登分表选课表中获取学生的信息，联查开课表、学生表、院系表
def fetchCoursesForScore(request):
    if request.method=='POST':
        #获取query
        post_data = json.loads(request.body.decode('utf-8'))
        query = {key: value for key, value in post_data.items() if value}
        param=[]
        if not query:
            sql = '''select cs.id as selectcourse_id,cs.normal_score,cs.test_score,cs.total_score,cs.open_course_id_id,s.name as student_name,cs.student_id_id,d.dept_name,s.dept_id_id,CAST((CASE
                    WHEN total_score >= 90 THEN 4.0
                    WHEN total_score >= 85 THEN 3.7
                    WHEN total_score >= 82 THEN 3.3
                    WHEN total_score >= 78 THEN 3.0
                    WHEN total_score >= 75 THEN 2.7
                    WHEN total_score >= 72 THEN 2.3
                    WHEN total_score >= 68 THEN 2.0
                    WHEN total_score >= 66 THEN 1.7
                    WHEN total_score >= 64 THEN 1.5
                    WHEN total_score >= 60 THEN 1.0
                    ELSE 0.0
                END)AS FLOAT) as gpa from managementapp_course_selection cs,managementapp_student s,managementapp_department d where cs.student_id_id=s.student_id and s.dept_id_id=d.dept_id '''
        else:
            sql = '''select cs.id as selectcourse_id,cs.normal_score,cs.test_score,cs.total_score,cs.open_course_id_id,s.name as student_name,cs.student_id_id,d.dept_name,s.dept_id_id,CAST((CASE
                    WHEN total_score >= 90 THEN 4.0
                    WHEN total_score >= 85 THEN 3.7
                    WHEN total_score >= 82 THEN 3.3
                    WHEN total_score >= 78 THEN 3.0
                    WHEN total_score >= 75 THEN 2.7
                    WHEN total_score >= 72 THEN 2.3
                    WHEN total_score >= 68 THEN 2.0
                    WHEN total_score >= 66 THEN 1.7
                    WHEN total_score >= 64 THEN 1.5
                    WHEN total_score >= 60 THEN 1.0
                    ELSE 0.0
                END)AS FLOAT) as gpa from managementapp_course_selection cs,managementapp_student s,managementapp_department d where cs.student_id_id=s.student_id and s.dept_id_id=d.dept_id and  '''
            conditions = []
            for key, value in query.items():
                if key in ['student_name','dept_id_id']:
                    if key =='student_name':
                        newkey='name'
                        conditions.append(f's.{newkey} = %s')
                    else:conditions.append(f's.{key} = %s')
                elif key in ['course_id_id','staff_id_id','semester','student_id_id','open_course_id_id']:
                    conditions.append(f'cs.{key} = %s')
                elif key in ['dept_name']:
                    conditions.append(f'd.{key} = %s')      
                else :conditions.append(f'{key} = %s')
                param.append(value)
            sql += ' AND '.join(conditions)
            print("sql",sql)
        out=get_from_table(sql,param)
        #需要捕捉一下错误
        data={
            "code":20000,
            "data":out,
            "message":"查询成功"
        }
        return HttpResponse(json.dumps(data),content_type='application/json')

#为学生成绩表获取信息，联查课程表和选课表
def fetchCourseSelectionForStudentScore(request):
    if request.method=='POST':
        #获取query
        post_data = json.loads(request.body.decode('utf-8'))
        query = {key: value for key, value in post_data.items() if value}
        param=[]
        if not query:
            sql = '''select c.course_name ,cs.course_id_id,cs.total_score,c.credit,CAST((CASE
                    WHEN total_score >= 90 THEN 4.0
                    WHEN total_score >= 85 THEN 3.7
                    WHEN total_score >= 82 THEN 3.3
                    WHEN total_score >= 78 THEN 3.0
                    WHEN total_score >= 75 THEN 2.7
                    WHEN total_score >= 72 THEN 2.3
                    WHEN total_score >= 68 THEN 2.0
                    WHEN total_score >= 66 THEN 1.7
                    WHEN total_score >= 64 THEN 1.5
                    WHEN total_score >= 60 THEN 1.0
                    ELSE 0.0
                END)AS FLOAT) as gpa from managementapp_course_selection cs,managementapp_course c where cs.course_id_id=c.course_id  '''
        else:
            sql = '''select c.course_name ,cs.course_id_id,cs.total_score,c.credit,CAST((CASE
                    WHEN total_score >= 90 THEN 4.0
                    WHEN total_score >= 85 THEN 3.7
                    WHEN total_score >= 82 THEN 3.3
                    WHEN total_score >= 78 THEN 3.0
                    WHEN total_score >= 75 THEN 2.7
                    WHEN total_score >= 72 THEN 2.3
                    WHEN total_score >= 68 THEN 2.0
                    WHEN total_score >= 66 THEN 1.7
                    WHEN total_score >= 64 THEN 1.5
                    WHEN total_score >= 60 THEN 1.0
                    ELSE 0.0
                END)AS FLOAT) as gpa from managementapp_course_selection cs,managementapp_course c where cs.course_id_id=c.course_id and  '''
            conditions = []
            for key, value in query.items():
                if key in ['student_id_id','semester']:
                    conditions.append(f'cs.{key} = %s')
                param.append(value)
            sql += ' AND '.join(conditions)
            print("sql",sql)
        out=get_from_table(sql,param)
        #需要捕捉一下错误
        data={
            "code":20000,
            "data":out,
            "message":"查询成功"
        }
        return HttpResponse(json.dumps(data),content_type='application/json')
    
#选课表从开课表中获取、构造选课页面
def fetchCoursesForSelect(request):
    if request.method=='POST':
        #获取query
        post_data = json.loads(request.body.decode('utf-8'))
        query = {key: value for key, value in post_data.items() if value}
        param=[]
        if not query:
            sql = 'select oc.id as opencourse_id_id,oc.course_id_id,c.course_name,c.credit,t.name as staff_name,oc.staff_id_id,t.professional_ranks,oc.class_time,oc.capacity,oc.used_capacity from managementapp_open_course oc,managementapp_course c,managementapp_teacher t where oc.staff_id_id=t.staff_id and oc.course_id_id=c.course_id'
        else:
            sql = 'select oc.id as opencourse_id_id,oc.course_id_id,c.course_name,c.credit,t.name as staff_name,oc.staff_id_id,t.professional_ranks,oc.class_time,oc.capacity,oc.used_capacity from managementapp_open_course oc,managementapp_course c,managementapp_teacher t where oc.staff_id_id=t.staff_id and oc.course_id_id=c.course_id and '
            conditions = []
            for key, value in query.items():
                if key in ['course_name','credit']:
                    conditions.append(f'c.{key} = %s')
                elif key in ['course_id_id','staff_id_id','semester','capacity','used_capacity']:
                    if key=='used_capacity':
                        conditions.append(f'oc.capacity-oc.{key} >= %s')
                    else:conditions.append(f'oc.{key} = %s')
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
            "message":"查询成功"
        }
        return HttpResponse(json.dumps(data),content_type='application/json')

#为获取课程名、教师名、学分、开课时间，选课表联查课程表、开课表、教师表、选课表managementapp_open_course oc,managementapp_course c,managementapp_teacher t,managementapp_course_selection cs
def fetchCoursesForCheck(request):
    if request.method=='POST':
        #获取query
        post_data = json.loads(request.body.decode('utf-8'))
        query = {key: value for key, value in post_data.items() if value}
        param=[]
        if not query:
            sql = 'select cs.student_id_id,cs.id,oc.id as opencourse_id_id,oc.course_id_id,c.course_name,c.credit,t.name as staff_name,oc.staff_id_id,t.professional_ranks,oc.class_time,oc.capacity,oc.used_capacity from managementapp_open_course oc,managementapp_course c,managementapp_teacher t,managementapp_course_selection cs where oc.staff_id_id=t.staff_id and oc.course_id_id=c.course_id and c.course_id=cs.course_id_id and cs.open_course_id_id=oc.id '
        else:
            sql = 'select cs.student_id_id,cs.id,oc.id as opencourse_id_id,oc.course_id_id,c.course_name,c.credit,t.name as staff_name,oc.staff_id_id,t.professional_ranks,oc.class_time,oc.capacity,oc.used_capacity from managementapp_open_course oc,managementapp_course c,managementapp_teacher t,managementapp_course_selection cs where oc.staff_id_id=t.staff_id and oc.course_id_id=c.course_id and c.course_id=cs.course_id_id and cs.open_course_id_id=oc.id and '
            
            conditions = []
            for key, value in query.items():
                if key in ['course_name','credit']:
                    conditions.append(f'c.{key} = %s')
                elif key in ['course_id_id','staff_id_id','semester','capacity','used_capacity']:
                    conditions.append(f'oc.{key} = %s')
                elif key in ['name','professional_ranks']:
                    conditions.append(f't.{key} = %s')
                elif key in ['semester','student_id_id']:
                    conditions.append(f'cs.{key} = %s')        
                else :conditions.append(f'{key} = %s')
                param.append(value)
            sql += ' AND '.join(conditions)
            print("sql",sql)
        out=get_from_table(sql,param)
        #需要捕捉一下错误
        data={
            "code":20000,
            "data":out,
            "message":"查询成功"
        }
        return HttpResponse(json.dumps(data),content_type='application/json')
    
def fetchCoursesForStudentSchedule(request):
    if request.method == 'POST': # 查询
        # 获取query
        post_data = json.loads(request.body.decode('utf-8'))
        print('=================',post_data)
        # 提取所有值为空的，新建一个字典
        query = {key: value for key, value in post_data.items() if value}
        param = []
        if not query:
            sql = 'select cs.course_id_id,c.course_name,cs.staff_id_id,t.name as teacher_name,c.credit,c.credit_hours,oc.class_time from managementapp_course_selection cs,managementapp_course c,managementapp_teacher t,managementapp_open_course oc where t.staff_id=cs.staff_id_id and c.course_id=cs.course_id_id and oc.id=cs.open_course_id_id'
        else:
            # 不提供通过已选人数查开课
            sql = 'select cs.course_id_id,c.course_name,cs.staff_id_id,t.name as teacher_name,c.credit,c.credit_hours,oc.class_time from managementapp_course_selection cs,managementapp_course c,managementapp_teacher t,managementapp_open_course oc where t.staff_id=cs.staff_id_id and c.course_id=cs.course_id_id and oc.id=cs.open_course_id_id and '
            conditions=[]
            for key, value in query.items():
                if key in ['semester','student_id_id']:
                    conditions.append(f'cs.{key} = %s')
                param.append(value)
            sql += ' AND '.join(conditions)
            print("sql senetence",sql,param)
        out = get_from_table(sql, param)
        print('=================',out)
        # 需要捕捉一下错误
        data = {
            "code": 20000,
            "data": out,
            "msg": "查询成功"
        }
        return HttpResponse(json.dumps(data), content_type='application/json')

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
            conditions = []
            for key, value in query.items():
                conditions.append(f'{key} = %s')
                param.append(value)
            sql += ' AND '.join(conditions)
        print("==========================",sql)
        out=get_from_table(sql,param)
        #需要捕捉一下错误
        data={
            "code":20000,
            "data":out,
            "message":"查询成功"
        }
        return HttpResponse(json.dumps(data),content_type='application/json')
    elif request.method=='PUT':#更新
        request_data = json.loads(request.body.decode('utf-8'))
        print("===================",request_data)
        for data in request_data:
            if data['selectcourse_id']:
                course_selection.objects.filter(id=data['selectcourse_id']).update(normal_score=data['normal_score'] if data.get('normal_score', '') != '' else None,
                                                                test_score=data['test_score'] if data.get('test_score', '') != '' else None,)
            else:
                data={
                "code":50000,
                "message":"缺少字段！"
                }
                return HttpResponse(json.dumps(data),content_type='application/json')
        data={
        "code":20000,
        "message":"更新成功"
        }
        return HttpResponse(json.dumps(data),content_type='application/json')
    elif request.method=='DELETE':#删除(逐个删)
        print('===========================',request.body)
        request_data = json.loads(request.body.decode('utf-8'))
        print("=====================",request_data)
        if request_data.get('selectcourse_id','')!='':
            course_selection.objects.filter(id=request_data['selectcourse_id']).delete()
            data={
                "code":20000,
                "message":"删除成功"
            }
            return HttpResponse(json.dumps(data),content_type='application/json')
        elif request_data['student_id_id'] and request_data['opencourse_id_id']:
            course_selection.objects.filter(student_id_id=request_data['student_id_id'],open_course_id_id=request_data['opencourse_id_id']).delete()
            data={
                "code":20000,
                "message":"删除成功"
            }
            return HttpResponse(json.dumps(data),content_type='application/json')
        else:
            data={
                "code":50000,
                "message":"缺少字段！"
            }
            return HttpResponse(json.dumps(data),content_type='application/json')

def addCourseSelection(request):#新增
    data={
        "code":20000,
        "message":"新增成功"
    }
    if request.method=='POST':
        request_data = json.loads(request.body.decode('utf-8'))
        print("==========================",request_data)
        if request_data['student_id_id'] and request_data['course_id_id'] and request_data['semester'] and request_data['staff_id_id']:
            #获取auth_user的id
            #只要都传过来，无条件认为组合是合法的，因为懒得写校验了
            course_to=open_course.objects.get(id=request_data['opencourse_id_id'])
            if course_selection.objects.filter(student_id_id=request_data['student_id_id'],course_id_id=request_data['course_id_id'],semester=request_data['semester'],staff_id_id=request_data['staff_id_id']).count()!=0:
                data={
                    "code":50000,
                    "message":"不能重复选择相同的课！"
                }
                return HttpResponse(json.dumps(data),content_type='application/json')
            elif request_data['group']=='学生' and course_to.used_capacity==course_to.capacity:
                data={
                    "code":50000,
                    "message":"课程容量已满！"
                }
                return HttpResponse(json.dumps(data),content_type='application/json')
            elif request_data['group']=='管理员' and course_to.used_capacity==course_to.capacity:
                newnum=course_to.capacity+1
                open_course.objects.filter(semester=request_data['semester'],course_id_id=request_data['course_id_id'],staff_id_id=request_data['staff_id_id']).update(capacity=newnum)
            #触发器会自动-1
            #在这里写两个判断条件1.加上这门课的学分，总学分小于等于32分 2.时间不能冲突
                
            # course_id_id是一个引用course表中course_id的外键
            course_instance = course.objects.get(course_id=request_data['course_id_id'])
            course_credits = course_instance.credit  
            # 检查加上这门课总学分是否超过32分
            total_credits = course_selection.objects.filter(student_id_id=request_data['student_id_id'],semester=request_data['semester']).aggregate(
                total_credits=Sum('course_id__credit')
            )['total_credits'] or 0

            if total_credits + course_credits > 32:
                data = {
                    "code": 50000,
                    "message": "总学分超过限制！"
                }
                return HttpResponse(json.dumps(data), content_type='application/json')
            
            # 查看是否有时间冲突的开课
            course_times = course_selection.objects.filter(student_id_id=request_data['student_id_id'],semester=request_data['semester']).values_list('open_course_id__class_time', flat=True)#某个学生选的所有课的上课时间
            print("llllllllllllllllllllllllllllllllllllll")
            if is_time_conflict(request_data['class_time'], course_times):
                data = {
                "code": 50000,
                "message": "新增失败，该同学在该时间已经选课"
            }
                return HttpResponse(json.dumps(data), content_type='application/json')
            new_cs = course_selection.objects.create(semester=request_data.get('semester', ''), 
                                                    normal_score=request_data['normal_score'] if request_data.get('normal_score', '') != '' else None, 
                                                    test_score=request_data['test_score'] if request_data.get('test_score', '') != '' else None, 
                                                    total_score=request_data['total_score'] if request_data.get('total_score', '') != '' else None,
                                                    course_id_id=request_data.get('course_id_id', ''), 
                                                    staff_id_id=request_data.get('staff_id_id', ''), 
                                                    student_id_id=request_data.get('student_id_id', ''),
                                                    open_course_id_id=request_data.get('opencourse_id_id',''))
            new_cs.save()
            data={
                "code":20000,
                "message":"选课成功！"
            }
            return HttpResponse(json.dumps(data),content_type='application/json')
        else:
            data['code']=50000,
            data['message']="缺少申请字段！"
        return HttpResponse(json.dumps(data),content_type='application/json')
        

def historyCourseSelectionView(request):
    """
    查询某个学生的所有课程
    """
    if request.method == "GET":
        student_id = request.GET.get('student_id')
        cs_lst = course_selection.objects.filter(student_id=student_id).values(
            "id", "semester", "course_id",
            "course_id__course_name", "staff_id", "course_id__credit", 
            "normal_score", "test_score", "total_score"
        )
        data = {
            "code": 20000,
            "data": list(cs_lst),
            "msg": "查询成功"
        }
        return HttpResponse(json.dumps(data), content_type='application/json')

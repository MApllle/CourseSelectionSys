from django.shortcuts import render
from django.shortcuts import HttpResponse
import json,hashlib
from .sql_basic import get_from_table
from .models import student,course,department
from django.contrib.auth.models import User
from django.db import connection
# Create your views here.

def handleCourse(request):
    if request.method=='POST':#查询
        #获取query
        post_data = json.loads(request.body.decode('utf-8'))
        #提取所有值为空的，新建一个字典
        query = {key: value for key, value in post_data.items() if value}
        param=[]
        if not query:
            sql = 'select * from managementapp_course'
        else:
            #仅通过课程号或、课程名、院系号、学分查找
            sql = 'select * from managementapp_course where '
            conditions = []
            for key,value in query.items():
                #sql=sql+key+'= %s '
                conditions.append(f'{key} = %s')
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
    elif request.method=='PUT':#更新
        request_data = json.loads(request.body.decode('utf-8'))
        query = {key: value for key, value in request_data.items() if value}
        #需要捕捉一下错误
        #确保课程号存在
        course.objects.filter(course_id=request_data['course_id']).update(course_name=request_data.get('course_name', ''),
                                                                    credit=request_data.get('credit', ''),
                                                                    credit_hours=request_data.get('credit_hours', ''),
                                                                    normal_score_percent=request_data.get('normal_score_percent', ''),
                                                                    dept_id_id=request_data.get('dept_id_id', ''))
        data={
            "code":20000,
            "message":"更新成功"
        }
        return HttpResponse(json.dumps(data),content_type='application/json')
    elif request.method=='DELETE':#删除(逐个删)
        request_data = json.loads(request.body.decode('utf-8'))
        id=request_data['course_id']
        course.objects.filter(course_id=id).delete()#虽然course_id是选课和开课表的外键，由于已经设置级联删除，这里直接删除即可
        data={
            "code":20000,
            "message":"删除成功"
        }
        return HttpResponse(json.dumps(data),content_type='application/json')
    
def addCourse(request):#新增课程 
    data={
        "code":20000,
        "message":"新增成功"
    }
    if request.method=='POST':
        request_data = json.loads(request.body.decode('utf-8'))
        if request_data['course_id'] is not None:#输入的课程号不为空
            if department.objects.filter(dept_id=request_data['dept_id_id']).count() != 0:#院系号存在
                if course.objects.filter(course_id=request_data['course_id']).count() == 0:#输入的课程号不在课程表中
                    new_course = course.objects.create(course_id=request_data.get('course_id', ''), 
                                                     course_name=request_data.get('course_name', ''), 
                                                     credit=request_data.get('credit', ''),
                                                     credit_hours=request_data.get('credit_hours', ''),
                                                     normal_score_percent=request_data.get('normal_score_percent', ''),
                                                     dept_id_id=request_data.get('dept_id_id', ''))
                    new_course.save()
                else:
                    data['code']=50000,
                    data['message']="课程号已存在！"
            else:
                data['code']=50000,
                data['message']="院系号为空！"
        else:
            data['code']=50000,
            data['message']="课程号为空！"
        return HttpResponse(json.dumps(data),content_type='application/json')
        

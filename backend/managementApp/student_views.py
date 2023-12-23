from django.shortcuts import render
from django.shortcuts import HttpResponse
from django.http import JsonResponse
import json,hashlib
from .sql_basic import get_from_table
from .models import student, teacher, department
from django.contrib.auth.models import User


# Create your views here.
def handleStudent(request):
    if request.method=='POST': # 查询
          # 获取query
        post_data = json.loads(request.body.decode('utf-8'))
        # 提取所有值为空的，新建一个字典
        query = {key: value for key, value in post_data.items() if value}
        param = []
        if not query:
            sql = 'select * from managementapp_student'
        else:
            # 不提供通过生日、学分、成绩查学生
            sql = 'select * from managementapp_student where '
            for key, value in query.items():
                sql = sql + key + '= %s '
                param.append(value)
        out = get_from_table(sql, param)
        # 需要捕捉一下错误
        data = {
            "code": 20000,
            "data": out,
            "msg": "查询成功"
        }
        return HttpResponse(json.dumps(data), content_type='application/json')
    elif request.method=='PUT': # 更新
        request_data = json.loads(request.body.decode('utf-8'))
        query = {key: value for key, value in request_data.items() if value}
        student.objects.filter(student_id=request_data['student_id']).update(student_id=request_data.get('student_id', ''),
                                                                    name=request_data.get('name', ''),
                                                                    sex=request_data.get('sex',''),
                                                                    date_of_birth=request_data.get('date_of_birth',''),
                                                                    native_place=request_data.get('native_place',''),
                                                                    mobile_phone=request_data.get('mobile_phone',''),
                                                                    average_gpa=request_data.get('average_gpa',0),
                                                                    total_cerdict=request_data.get('total_cerdict',0),
                                                                    dept_id_id=request_data.get('dept_id_id',''))
        data = {
            "code":20000,   # 注意，必须要有code，不然返回的消息会被后端拦截
            "msg":"更新成功"
        }
        return HttpResponse(json.dumps(data), content_type='application/json')
    elif request.method=='DELETE': # 删除(逐个删)
        request_data = json.loads(request.body.decode('utf-8'))
        id = request_data['student_id']
        student.objects.filter(stu_id=id).delete()
        data = {
            "code": 20000,
            "msg": "删除成功"
        }
        return HttpResponse(json.dumps(data), content_type='application/json')
    
def addStudent(request): # 新增学生
    data={
        "code":20000,
        "msg":"新增成功"
    }
    if request.method=='POST':
        request_data = json.loads(request.body.decode('utf-8'))
        if request_data['student_id'] is not None:
            if User.objects.filter(username=request_data['student_id']).count() == 0:
                user=User.objects.create_user(username=request_data['student_id'])
                user.is_staff=False
                user.is_superuser=False
                psw=hashlib.sha256(request_data['student_id'].encode('utf-8')).hexdigest()
                user.set_password(psw)
                user.save()
            if department.objects.filter(dept_id=request_data['dept_id_id']).count() == 0:
                new_student = student.objects.create(student_id=request_data.get['student_id',''],
                                                    name=request_data.get['name',''],
                                                    sex=request_data.get['sex',''],
                                                    date_of_birth=request_data.get['date_of_birth',''],
                                                    native_place=request_data.get['native_place',''],
                                                    mobile_phone=request_data.get['mobile_phone',''],
                                                    average_gpa=request_data.get['average_gpa',''],
                                                    total_cerdict=request_data.get['total_cerdict',''],
                                                    dept_id_id=request_data.get['dept_id_id',''])
                new_student.save()
            else:
                data = {
                    "code": 50000,
                    "msg": "院系号不存在"
                }
        else:
            data = {
                "code": 50000,
                "msg": "学号不能为空"
            }
            data = {
                "code": 50000,
                "msg": "学号不能为空"
            }
            return HttpResponse(json.dumps(data), content_type='application/json')
        

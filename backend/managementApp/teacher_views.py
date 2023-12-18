from django.shortcuts import render
from django.shortcuts import HttpResponse
import json,hashlib
from .sql_basic import get_from_table
from .models import student,teacher,department
from django.contrib.auth.models import User
# Create your views here.

def handleTeacher(request):
    if request.method=='POST':#查询
        #获取query
        post_data = json.loads(request.body.decode('utf-8'))
        #提取所有值为空的，新建一个字典
        query = {key: value for key, value in post_data.items() if value}
        param=[]
        if not query:
            sql = 'select * from managementapp_teacher'
        else:
            #不提供通过生日和薪水查老师
            sql = 'select * from managementapp_teacher where '
            for key,value in query.items():
                sql=sql+key+'= %s '
                param.append(value)
        out=get_from_table(sql,param)
        #需要捕捉一下错误
        data={
            "code":20000,
            "data":out,
            "msg":"查询成功"
        }
        return HttpResponse(json.dumps(data),content_type='application/json')
    elif request.method=='PUT':#更新
        request_data = json.loads(request.body.decode('utf-8'))
        query = {key: value for key, value in request_data.items() if value}
        #需要捕捉一下错误
        #确保院系号存在？
        teacher.objects.filter(staff_id=request_data['staff_id']).update(name=request_data.get('name', ''),
                                                                    sex=request_data.get('sex', ''),
                                                                    date_of_birth=request_data.get('date_of_birth', ''),
                                                                    professional_ranks=request_data.get('professional_ranks', ''),
                                                                    salary=request_data.get('salary', 0),
                                                                    dept_id_id=request_data.get('dept_id_id', ''))
        data={
            "code":20000,
            "msg":"更新成功"
        }
        return HttpResponse(json.dumps(data),content_type='application/json')
    elif request.method=='DELETE':#删除(逐个删)
        request_data = json.loads(request.body.decode('utf-8'))
        id=request_data['staff_id']
        teacher.objects.filter(staff_id=id).delete()
        if User.objects.filter(username=id).count() != 0:
                User.objects.filter(username__exact=id).delete()  # 删除该教师账户
        data={
            "code":20000,
            "msg":"删除成功"
        }
        return HttpResponse(json.dumps(data),content_type='application/json')
    
def addTeacher(request):#新增教师
    data={
        "code":20000,
        "msg":"新增成功"
    }
    if request.method=='POST':
        request_data = json.loads(request.body.decode('utf-8'))
        if request_data['staff_id'] is not None:
             #自动向user表中增加该工号的教师，密码默认为工号
            if User.objects.filter(username=request_data['staff_id']).count() == 0:
                user = User.objects.create_user(username=request_data['staff_id'])
                user.is_staff = False
                user.is_superuser = False
                psw=hashlib.sha256(request_data['staff_id'].encode('utf-8')).hexdigest()
                user.set_password(psw)   # 设置初始密码为学号
                user.save()
            if department.objects.filter(dept_id=request_data['dept_id_id']).count() != 0:
                new_teacher = teacher.objects.create(staff_id=request_data.get('staff_id', ''), 
                                                     name=request_data.get('name', ''), 
                                                     sex=request_data.get('sex', ''), 
                                                     date_of_birth=request_data.get('date_of_birth', ''),
                                                     professional_ranks=request_data.get('professional_ranks', ''), 
                                                     salary=request_data.get('salary', ''), 
                                                     dept_id_id=request_data.get('dept_id_id', ''))
                new_teacher.save()
            else:
                data['code']=50000,
                data['msg']="院系号为空！"
        else:
            data['code']=50000,
            data['msg']="工号为空！"
        return HttpResponse(json.dumps(data),content_type='application/json')
        

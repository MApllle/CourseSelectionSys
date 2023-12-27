from django.shortcuts import render
from django.shortcuts import HttpResponse
import json,hashlib
from .sql_basic import get_from_table
from .models import department,department
from django.contrib.auth.models import User
# Create your views here.

def handleDepartment(request):
    if request.method=='POST':#查询
        #获取query
        post_data = json.loads(request.body.decode('utf-8'))
        #提取所有值为空的，新建一个字典
        query = {key: value for key, value in post_data.items() if value}
        param=[]
        if not query:
            sql = 'select * from managementapp_department'
        else:
            #不提供通过地址和电话查学院
            #动态地根据查询参数的数量构建SQL语句，并在其中使用逻辑运算符AND来连接不同的查询条件。
            sql = 'select * from managementapp_department where '
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
        #确保院系号存在？
        department.objects.filter(dept_id=request_data['dept_id']).update(dept_name=request_data.get('dept_name', ''),
                                                                    address=request_data.get('address',''),
                                                                    phone_code=request_data.get('phone_code',''))
        data={
            "code":20000,
            "message":"更新成功"
        }
        return HttpResponse(json.dumps(data),content_type='application/json')
    elif request.method=='DELETE':#删除(逐个删)
        request_data = json.loads(request.body.decode('utf-8'))
        id=request_data['dept_id']
        department.objects.filter(dept_id=id).delete()
        data={
            "code":20000,
            "message":"删除成功"
        }
        return HttpResponse(json.dumps(data),content_type='application/json')
    
def addDepartment(request):#新增学院
    data={
        "code":20000,
        "message":"新增成功"
    }
    if request.method=='POST':
        request_data = json.loads(request.body.decode('utf-8'))
        if request_data['dept_id'] is not None:
            if department.objects.filter(dept_id=request_data['dept_id']).count() == 0: #检查院系表，是否存在该工号的学院，没有则新建
                new_department = department.objects.create(dept_id=request_data.get('dept_id', ''), 
                                                     dept_name=request_data.get('dept_name', ''), 
                                                     address=request_data.get('address', ''), 
                                                     phone_code=request_data.get('phone_code', ''))

                new_department.save()
            else:
                data['code']=50000,
                data['message']="院系号已存在！"
                return HttpResponse(json.dumps(data),content_type='application/json')
        else:
            data['code']=50000,
            data['message']="院系号为空！"
            return HttpResponse(json.dumps(data),content_type='application/json')
        return HttpResponse(json.dumps(data),content_type='application/json')
        

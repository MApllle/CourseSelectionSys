from django.shortcuts import render
from django.shortcuts import HttpResponse
from django.contrib.auth.models import User,Group
from django.contrib.auth import authenticate, login,logout
from django.contrib.auth.hashers import check_password
from .sql_basic import get_from_table
from .models import course, course_request, student,teacher,course_selection
from jwt import exceptions
import json,time,jwt
from datetime import datetime,timedelta
# Create your views here.
def addUser(request):   #新建账户
    if request.method == 'POST':
        post_data = json.loads(request.body.decode('utf-8'))    #获取前端返回得json数据
        if User.objects.filter(username=post_data['username']).count()!=0:
            data={
                    "code":50000,
                    "message":"无法新增已有用户！"
                }
            return HttpResponse(json.dumps(data),content_type='application/json')
        elif Group.objects.filter(name=post_data['group']).count()==0:
            print("debug",post_data['group'])
            data={
                    "code":50000,
                    "message":"账号类型错误！"
                }
            return HttpResponse(json.dumps(data),content_type='application/json')
        else:
            if post_data['group']=='管理员':
                newuser=User.objects.create_user(post_data['username'],password=post_data['password'])
                newuser.groups.add(3)
            elif post_data['group']=='学生':
                if student.objects.filter(student_id=post_data['username']).count()==0:
                    data={
                        "code":50000,
                        "message":"学生表中无该学生！"
                    }
                    return HttpResponse(json.dumps(data),content_type='application/json')
                elif User.objects.filter(username=post_data['username']).count()==0:
                    newuser=User.objects.create_user(post_data['username'],password=post_data['password'])
                    newuser.groups.add(1)
            elif post_data['group']=='教师':
                if teacher.objects.filter(staff_id=post_data['username']).count()==0:
                    data={
                        "code":50000,
                        "message":"教师表中无该教师！"
                    }
                    return HttpResponse(json.dumps(data),content_type='application/json')
                elif User.objects.filter(username=post_data['username']).count()==0:
                    newuser=User.objects.create_user(post_data['username'],password=post_data['password'])
                    newuser.groups.add(2)
            data = {
                "code":20000,   # 注意，必须要有code，不然返回的消息会被后端拦截
                "message":"新增成功！"
            }
        return HttpResponse(json.dumps(data),content_type='application/json')
    
def userLogin(request): #登录
    post_data = json.loads(request.body.decode('utf-8'))
    print("postdata",post_data)
    user = User.objects.get(username=post_data['username'])
    if user is not None:
        if check_password(post_data['password'],user.password):
            login(request, user)
            #生成token
            headers = {
            "alg": "HS256",
            "typ": "JWT"
            }
            exp = datetime.now() + timedelta(days=10)
            payload = {
                "name": post_data['username'],
                "exp": exp
            }
            SECRET_KEY='vue_admin_template_token'
            token = jwt.encode(payload=payload, key=SECRET_KEY, algorithm='HS256')
            #查找账户的group
            if student.objects.filter(student_id=user.username).count()!=0:
                group='学生'
            elif teacher.objects.filter(staff_id=user.username).count()!=0:
                group='教师'
            else:
                group='管理员'
            #存储账户写入的学期，检查该学期是否合法
            data= {
                "code":20000,
                "data": {
                    "name":post_data['username'],
                    "token": token,
                    "group":group,
                    "semester":post_data['semester']
                }
            }
            response=HttpResponse(json.dumps(data),content_type='application/json')
            return response
        else:
            data= {
                "code":50000,
                "message":"密码错误"
            }
            return HttpResponse(json.dumps(data),content_type='application/json')
    else:
        data= {
            "code":50000,
            "message":"用户不存在"
        }
        return HttpResponse(json.dumps(data),content_type='application/json')
    
def validate_token(token):  #验证token有效性
    '''校验token的函数，校验通过则返回解码信息'''
    SECRET_KEY='vue_admin_template_token'
    payload = None
    msg = None
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=['HS256'])
    except exceptions.ExpiredSignatureError:
        msg = 'token已失效'
    except jwt.DecodeError:
        msg = 'token认证失败'
    except jwt.InvalidTokenError:
        msg = '非法的token'
    return (payload,msg)

def getUserInfo(request):   #查看token
    '''查看用户信息，需要token校验'''
    token = request.GET['token']
    print("token是",token)
    data= {
        "code":50000,
        "message":"错误"
    }
    if not token:
        data['message']='token不允许为空！'
        return HttpResponse(json.dumps(data),content_type='application/json')
    payload, msg = validate_token(token)
    # 直接对token进行合法性校验
    if msg:
        data['message']=msg
        return HttpResponse(json.dumps(data),content_type='application/json')
    username = payload['name']
    user = User.objects.get(username=username)
    group=user.groups.values()[0]['name']

    """ getgroup=Group.objects.filter(name=user.username)
    group=''
    if getgroup.id ==1:group="学生"
    elif getgroup.id ==2:group="教师"
    elif getgroup.id ==3:group="管理员" """
    print("")
    data= {
        "code":20000,
        "message":"成功",
        "data":{
            "name":username,
            "group":group,
            'token':token
        }
    }
    return HttpResponse(json.dumps(data),content_type='application/json')

def Logout(request):   #登出
    logout(request)
    data= {
        "code":20000,
        "message":"登出成功"
    }
    return HttpResponse(json.dumps(data),content_type='application/json')

def handleUser(request): #更改用户信息（主要是改密码）
    data= {
        "code":50000,
        "message":"失败"
    }
    if request.method=='PUT':   #改
        request_data = json.loads(request.body.decode('utf-8'))
        print("=================",request_data)
        if request_data['id'] is not None:
            #修改密码与原来的相同，不会报错
            user=User.objects.get(id=request_data['id'])
            user.set_password(request_data['password'])
            user.save()
            data= {
                "code":20000,
                "message":"修改密码成功"
            }
        else:
            data= {
                "code":50000,
                "message":"不存在id 查询失败"
            }
        return HttpResponse(json.dumps(data),content_type='application/json')
    elif request.method=='POST':    #查
        out=[]
        post_data = json.loads(request.body.decode('utf-8'))
        query = {key: value for key, value in post_data.items() if value}
        param=[]
        if not query:
            sql='select u.username,u.id,g.name as "group" from auth_user u,auth_user_groups ug,auth_group g where u.id=ug.user_id and g.id=ug.group_id'
            out=get_from_table(sql,param)
        elif query.get('username','') and query.get('group',''):
            sql='select u.username,u.id,g.name as "group" from auth_user u,auth_user_groups ug,auth_group g where u.id=ug.user_id and g.id=ug.group_id and g.name=%s and u.username=%s'
            param=[query['group'],query['username']]
            out=get_from_table(sql,param)
            """ if len(out)==0:
                data= {
                    "code":50000,
                    "message":"查询失败，账号和账户类型不匹配！"
                }
                return HttpResponse(json.dumps(data),content_type='application/json') """
        elif query.get('group',''):
            if query['group']=='学生':
                sql = 'select user_id_id as "id",student_id as username,"学生" as `group` from managementapp_student'
                out=get_from_table(sql,param)
            elif query['group']=='教师':
                sql = 'select user_id_id as "id",staff_id as username,"教师" as `group` from managementapp_teacher'
                out=get_from_table(sql,param)
            elif query['group']=='管理员':
                sql='select u.username,u.id,g.name as "group" from auth_user u,auth_user_groups ug,auth_group g where u.id=ug.user_id and g.id=ug.group_id and g.name="管理员"'
                out=get_from_table(sql,param)
        elif query.get('username',''):
            sql='select u.username,u.id,g.name as "group" from auth_user u,auth_user_groups ug,auth_group g where u.id=ug.user_id and g.id=ug.group_id and u.username=%s'
            param=[query['username']]
            out=get_from_table(sql,param)
        data={
            "code":20000,
            "data":out,
            "msg":"查询成功"
        }
        return HttpResponse(json.dumps(data),content_type='application/json')
    elif request.method=='DELETE':  #删
        request_data = json.loads(request.body.decode('utf-8'))
        id=request_data['id']
        User.objects.filter(id=id).delete()
        data={
            "code":20000,
            "message":"删除成功"
        }
        return HttpResponse(json.dumps(data),content_type='application/json')
    return HttpResponse(json.dumps(data),content_type='application/json')

#学期选择;get方法
def fetchSemester(request):
    sql='select distinct(semester) from managementapp_open_course'
    param=[]
    out=get_from_table(sql,param)
    data={
        "code":20000,
        "data":out,
        "msg":"查询成功"
    }
    return HttpResponse(json.dumps(data),content_type='application/json')
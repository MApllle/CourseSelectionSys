from django.shortcuts import render
from django.shortcuts import HttpResponse
from django.contrib.auth.models import User
from django.contrib.auth import authenticate, login,logout
from django.contrib.auth.hashers import check_password
from jwt import exceptions
import json,time,jwt
from datetime import datetime,timedelta
# Create your views here.
def addUser(request):   #新建账户
    if request.method == 'POST':
        post_data = json.loads(request.body.decode('utf-8'))    #获取前端返回得json数据
        print(post_data)
        User.objects.create_user(post_data['id'],password=post_data['password'])
        data = {
            "code":20000,   # 注意，必须要有code，不然返回的消息会被后端拦截
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
            data= {
                "code":20000,
                "data": {
                    "name":post_data['username'],
                    "token": token
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
            "messgae":"用户不存在"
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
    data['code']=20000
    data['data']={'name': username,'token':token}
    return HttpResponse(json.dumps(data),content_type='application/json')

def Logout(request):   #登出
    logout(request)
    data= {
        "code":20000,
        "message":"登出成功"
    }
    return HttpResponse(json.dumps(data),content_type='application/json')




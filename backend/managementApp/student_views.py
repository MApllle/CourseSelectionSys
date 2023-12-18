from django.shortcuts import render
from django.shortcuts import HttpResponse
from django.http import JsonResponse
import json


# Create your views here.
def index(request):
    print(request)
    data = {
        "code":20000,   # 注意，必须要有code，不然返回的消息会被后端拦截
        "user": "jack",
        "pwd": "123",
    }
    if request.method == 'GET':
            return HttpResponse(json.dumps(data),content_type='application/json')
    return JsonResponse({'hello':'菜鸟教程'})

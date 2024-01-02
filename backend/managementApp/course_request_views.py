import json,hashlib
from .sql_basic import get_from_table
from .models import open_course
from .models import teacher,course,course_request,department
from django.shortcuts import HttpResponse

#教师开课
def courseRequest(request):
    """教师请求开课"""
    if request.method == 'POST':  # 新增申请
        # 获取前端发送的数据
        post_data = json.loads(request.body.decode('utf-8'))

        dept_id = post_data.get('dept_id', '')
        staff_id = post_data.get('staff_id', '')
        if not dept_id or not staff_id:
            return HttpResponse(json.dumps({
                "code": 50000,
                "message": "院系号或申请人不能为空"
            }), content_type='application/json')
        dept = department.objects.filter(dept_id=dept_id).first()
        staff = teacher.objects.filter(staff_id=staff_id).first()
        if not dept or not staff:
            return HttpResponse(json.dumps({
                "code": 50000,
                "message": "院系号或申请人不存在"
            }), content_type='application/json')
        print(post_data)
        # 新增申请
        try:
            new_request = course_request.objects.create(
                course_id=post_data.get('course_id', ''),
                course_name=post_data.get('course_name', ''),
                credit=post_data.get('credit', ''),
                credit_hours=post_data.get('credit_hours', ''),
                dept_id=dept,
                normal_score_percent=post_data.get('normal_score_percent', ''),
                staff_id=staff,
            )
        except Exception as e:
            print(e)
            return HttpResponse(json.dumps({
                "code": 50000,
                "message": "申请失败"
            }), content_type='application/json')
        data = {
            "code": 20000,
            "message": "申请成功"
        }
    elif request.method == 'GET':  # 获取申请列表
        # 获取前端发送的数据
        staff_id = request.GET.get('staff_id', '')
        if staff_id:
            course_obj = course_request.objects.filter(staff_id=staff_id)
        else:
            course_obj = course_request.objects.all()
        print(course_obj)
        data = {
            "code": 20000,
            "data": list(course_obj.values()),
            "message": "获取成功"
        }
    else:
        data = {
            "code": 50000,
            "message": "请求错误"
        }
    return HttpResponse(json.dumps(data), content_type='application/json')

#管理员审核
def handleCourseRequest(request):
    """教师请求开课申请处理"""
    if request.method == 'PUT':
        request_data = json.loads(request.body.decode('utf-8'))
        print("request_data", request_data)
        if request_data['course_id'] and request_data['status']:
            course_request_obj = course_request.objects.get(course_id=request_data['course_id'])
            course_request_obj.status = request_data['status']
            course_request_obj.save()
            if request_data['status'] == 1 or request_data['status'] == '1':  # 通过
                try:
                    course.objects.create(course_id=course_request_obj.course_id,
                                            course_name=course_request_obj.course_name,
                                            credit=course_request_obj.credit,
                                            credit_hours=course_request_obj.credit_hours,
                                            dept_id=course_request_obj.dept_id,
                                            normal_score_percent=course_request_obj.normal_score_percent)
                except Exception as e:
                    course_request_obj.status = 0
                    course_request_obj.save()
                    print(e)
                    data = {
                        "code": 50000,
                        "message": "审核失败, 课程号重复" 
                    }
                    return HttpResponse(json.dumps(data), content_type='application/json')
            data = {
                "code": 20000,
                "message": "审核成功"
            }
        else:
            data = {
                "code": 50000,
                "message": "不存在id 查询失败"
            }
    elif request.method == 'GET':#统计还有多少待审核
        num=course_request.objects.filter(status=0).count()
        data = {
            "code": 20000,
            "data":{'number':num},
            "message": "请求成功"
        }
        return HttpResponse(json.dumps(data), content_type='application/json')
    else:
        data = {
            "code": 50000,
            "message": "请求方式错误"
        }
    return HttpResponse(json.dumps(data), content_type='application/json')
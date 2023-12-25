# 开课表

from django.http import JsonResponse
import json,hashlib
from .sql_basic import get_from_table
from .models import open_course
from django.contrib.auth.models import User
from django.shortcuts import HttpResponse

# 辅助函数，用于解析上课时间并比较两个时间段是否冲突
def is_time_conflict(new_time, existing_times):
    # 将时间段分割为单独的课程时间，例如 "一1-2" 或 "三1-2"
    new_times = new_time.split()
    for existing_time in existing_times:
        existing_time_list = existing_time.split()
        # 如果有任何一个时间是相同的，那么就冲突了
        if any(new in existing_time_list for new in new_times):
            return True
    return False

def handleOpenCourse(request):
    if request.method == 'POST': # 查询
        # 获取query
        post_data = json.loads(request.body.decode('utf-8'))
        # 提取所有值为空的，新建一个字典
        query = {key: value for key, value in post_data.items() if value}
        param = []
        if not query:
            sql = 'select * from managementapp_open_course'
        else:
            # 不提供通过已选人数查开课
            sql = 'select * from managementapp_open_course where '
            conditions=[]
            for key, value in query.items():
                sql = sql + key + '= %s'
                conditions.append(f'{key} = %s')
                param.append(value)
            sql += ' AND '.join(conditions)
        out = get_from_table(sql, param)
        # 需要捕捉一下错误
        data = {
            "code": 20000,
            "data": out,
            "msg": "查询成功"
        }
        return HttpResponse(json.dumps(data), content_type='application/json')
    elif request.method == 'DELETE': # 删除(逐个删)
        request_data = json.loads(request.body.decode('utf-8'))
        todelete_id = request_data['id']
        open_course.objects.filter(id=todelete_id).delete()
        data = {
            "code": 20000,
            "msg": "删除成功"
        }
        return HttpResponse(json.dumps(data), content_type='application/json')
    elif request.method == 'PUT': # 更新
        request_data = json.loads(request.body.decode('utf-8'))
        # 查看是否有时间冲突的开课
        existing_courses = open_course.objects.filter(
            semester=request_data['semester'], 
            course_id_id=request_data['course_id_id'],
            staff_id_id=request_data['staff_id_id']
        )
        existing_times = [course.class_time for course in existing_courses]
            
        if is_time_conflict(request_data['class_time'], existing_times):
            data = {
                "code": 50000,
                "msg": "新增失败，该老师在该时间已经开课"
            }
            return HttpResponse(json.dumps(data), content_type='application/json')
        open_course.objects.filter(id=request_data['id']).update(capacity=request_data.get('capacity',0),
                                                                 semester=request_data.get('semester',''),
                                                                class_time=request_data.get('class_time',''),
                                                                course_id_id=request_data.get('course_id_id',''),
                                                                staff_id_id=request_data.get('staff_id_id',''),
                                                                )
        data = {
            "code": 20000,
            "msg": "更新成功"
        }
        return HttpResponse(json.dumps(data), content_type='application/json')
    
def addOpenCourse(request): # 新增
    data = {
        "code": 20000,
        "msg": "新增成功"
    }
    if request.method == 'POST':
        request_data = json.loads(request.body.decode('utf-8'))
        if request_data['semester'] and request_data['course_id_id'] and request_data['staff_id_id']:
            # 获取auth_user的id
            # 只要都传过来，无条件认为组合是合法的，因为懒得写校验了

             # 查看是否有时间冲突的开课
            existing_courses = open_course.objects.filter(
                semester=request_data['semester'], 
                course_id_id=request_data['course_id_id'],
                staff_id_id=request_data['staff_id_id']
            )
            existing_times = [course.class_time for course in existing_courses]
            
            if is_time_conflict(request_data['class_time'], existing_times):
                data = {
                    "code": 50000,
                    "msg": "新增失败，该老师在该时间已经开课"
                }
                return HttpResponse(json.dumps(data), content_type='application/json')

            # elif request_data['group']=='管理员':
            newnum = open_course.objects.filter(semester=request_data['semester'], course_id_id=request_data['course_id_id'], staff_id_id=request_data['staff_id_id']).count() + 1
            open_course.objects.filter(semester=request_data['semester'], course_id_id=request_data['course_id_id'], staff_id_id=request_data['staff_id_id']).update(capacity=newnum)
            
            new_oc = open_course.objects.create(semester=request_data.get('semester', ''),
                                                class_time=request_data.get('class_time', ''),
                                                course_id_id=request_data.get('course_id_id', ''),
                                                staff_id_id=request_data.get('staff_id_id', ''),
                                                capacity=request_data.get('capacity', 0),
                                                used_capacity=request_data.get('used_capacity', 0),
                                                )
            new_oc.save()
            data = {
                "code": 20000,
                "msg": "新增成功"
            }
        else:
            data = {
                "code": 50000,
                "msg": "新增失败"
            }
    return HttpResponse(json.dumps(data), content_type='application/json')

    
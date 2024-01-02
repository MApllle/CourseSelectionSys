from django.http import JsonResponse
from .models import student, teacher, department, student_comments


import json



def studentComments(request):
    if request.method == 'POST':
        # 添加评论
        try:
            request_data = json.loads(request.body.decode('utf-8'))
            student_id_id = request_data['student_id_id'] # 学生id
            staff_id_id = request_data['staff_id_id']  # 教师工号
            course_id_id = request_data['course_id_id']  # 课程号
            comments = request_data['comments'] # 评论

            # student = student.objects.get(student_id=student_id)
            # teacher = teacher.objects.get(staff_id=staff_id)
            # course = course.objects.get(course_id=course_id)

            student_comments.objects.create(student_id_id=student_id_id, staff_id_id=staff_id_id, course_id_id=course_id_id, comments=comments)
            return JsonResponse({'code': 20000, 'msg': '添加评论成功'})

        except Exception as e:
            print(e)
            return JsonResponse({'code': 50000, 'msg': '添加评论失败'})

    elif request.method == 'GET':
        # 获取评论
        staff_id = request.GET.get('staff_id')
        print(staff_id)
        # 教师获取评论
        if staff_id:
            comments = student_comments.objects.filter(staff_id=staff_id).values('student_id__name', 'course_id__course_name', 'staff_id', 'comments')
        else:
            comments = student_comments.objects.filter().values('student_id__name', 'course_id__course_name', 'staff_id', 'comments')
        print(comments)
        rep_data = {
            'code': 20000,
            'msg': '获取评论成功',
            'data': list(comments)
        }
        return JsonResponse(rep_data, safe=False)
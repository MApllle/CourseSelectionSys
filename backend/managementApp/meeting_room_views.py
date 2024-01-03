"""
Author  :lee
Date    :2024/1/3 21:47
Desc    :会议室视图
"""
import json

from .models import meeting_room
from django.shortcuts import HttpResponse
from datetime import datetime


def meetingRoomViews(request):
    """
    会议室相关视图
    """
    if request.method == 'GET':
        # 请求会议室列表
        now_hour = datetime.now().hour
        meeting_rooms_lst = meeting_room.objects.all().values()
        for i in range(len(meeting_rooms_lst)):
            start_time, end_time = 0, 23
            if meeting_rooms_lst[i]['time_range']:
                start_time, end_time = meeting_rooms_lst[i]['time_range'].split('-')
            if (int(start_time) < now_hour < int(end_time)) or now_hour < int(start_time):
                continue
            else:
                meeting_rooms_lst[i]['status'] = False
                meeting_room.objects.filter(room_id=meeting_rooms_lst[i]['room_id']).update(
                    status=False,
                    time_range=None
                )
        data = {
            'code': 20000,
            'data': list(meeting_rooms_lst),
            'msg': '获取成功'
        }
        return HttpResponse(json.dumps(data), content_type="application/json")
    elif request.method == 'PUT':
        # 申请会议室
        data = {
            'code': 20000,
            'message': '申请成功'
        }
        now_hour = datetime.now().hour
        post_data = json.loads(request.body)
        room_id = post_data['room_id']
        number = int(post_data['number'])
        time_range = post_data['time_range']
        start_time, end_time = time_range.split('-')
        if now_hour > int(start_time):
            data = {
                'code': 50000,
                'message': '开始时间小于申请时间'
            }
            return HttpResponse(json.dumps(data), content_type="application/json")
        room = meeting_room.objects.filter(room_id=room_id).first()
        if room.min_number > number and meeting_room.objects.filter(min_number__lte=number, status=0).exists():
            data['code'] = 50000
            data['message'] = '会议室人数不能小于最小人数,请选择适合会议室'
        else:
            meeting_room.objects.filter(room_id=room_id).update(
                time_range=time_range,
                status=1
            )
        return HttpResponse(json.dumps(data), content_type="application/json")

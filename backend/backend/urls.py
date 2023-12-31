"""
URL configuration for backend project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
from managementApp import teacher_views,student_views,admin_views,department_views,\
    course_selection_views,open_course_views,course_views,course_request_views, student_comments_views,meeting_room_views

urlpatterns = [
    path("admin/", admin.site.urls),
    #用户登录相关接口
    path("userLogin/",admin_views.userLogin),#用户登录
    path("getUserInfo/",admin_views.getUserInfo),#获取Token信息
    path("Logout/",admin_views.Logout),  #退出登录
    path("addUser/",admin_views.addUser),   #新增用户
    path("handleUser/",admin_views.handleUser),  #用户改
    path("fetchSemester/",admin_views.fetchSemester),
    #teacher表增删改查接口
    path("addTeacher/",teacher_views.addTeacher),  #新增
    path("handleTeacher/",teacher_views.handleTeacher),#删改查
    #department表增删改查接口
    path("addDepartment/",department_views.addDepartment),  #新增
    path("handleDepartment/",department_views.handleDepartment),#删改查
    #student表增删改查接口
    path("addStudent/",student_views.addStudent), #新增
    path("handleStudent/",student_views.handleStudent), #删改查
    #course表增删改查接口
    path("addCourse/",course_views.addCourse), #新增
    path("handleCourse/",course_views.handleCourse), #删改查
    #open_course表增删改查接口
    path("addOpenCourse/",open_course_views.addOpenCourse), #新增
    path("handleOpenCourse/",open_course_views.handleOpenCourse), #删改查

    #course_request表相关接口
    path("courseRequest/", course_request_views.courseRequest),  # 开课申请新增及获取
    path("handleCourseRequest/", course_request_views.handleCourseRequest),  # 开课申请处理

    #course_selectionb表增删改查接口
    path("addCourseSelection/",course_selection_views.addCourseSelection), #新增
    path("handleCourseSelection/",course_selection_views.handleCourseSelection), #删改查
    #选课课程清单获取联查接口
    path("fetchCoursesForSelect/",course_selection_views.fetchCoursesForSelect), 
    #查看选课情况获取联查接口
    path("fetchCoursesForCheck/",course_selection_views.fetchCoursesForCheck), 
    #教师课程表获取联查接口、
    path("fetchCoursesForTeacherSchedule/",open_course_views.fetchCoursesForTeacherSchedule), 
    #学生课程表获取联查接口、
    path("fetchCoursesForStudentSchedule/",course_selection_views.fetchCoursesForStudentSchedule), 
    #调用存储过程计算均分
    path("calculateAllScore/",student_views.calculateAllScore), 
    # student_comments表相关接口
    path("studentComments/", student_comments_views.studentComments),  # 学生评论 添加POST/获取GET
    #教师登分表查登分表
    path("fetchCoursesForScore/",course_selection_views.fetchCoursesForScore),
    path("teacherOpenCourseStudentView/", open_course_views.teacherOpenCourseView),
    #学生查选课记录
    path("fetchCourseSelectionForStudentScore/",course_selection_views.fetchCourseSelectionForStudentScore),
    path("historyCourseSelectionView/", course_selection_views.historyCourseSelectionView),  # 通过学号查询学生先的课程
    
    # 会议室相关接口
    path("meetingRoom/", meeting_room_views.meetingRoomViews),
     
]

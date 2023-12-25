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
from managementApp import teacher_views,student_views,admin_views,department_views,course_views

urlpatterns = [
    #path("admin/", admin.site.urls),
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

]

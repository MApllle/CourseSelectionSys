# 鼠鼠选课系统
## 环境
后端：
- python:3.8.xx
- Django 4.2.8
- mysqlclient 2.2.1
- django-cors-headers 4.3.1 (解决跨域问题)
- pyjwt 2.8.0 (生成token)

前端：
- node 8.11.0
- npm 16.16.0
- [前端模板](https://github.com/PanJiaChen/vue-admin-template)

## 功能
登录，进入学期选择页面（前端把学期加到内存/全局变量里）
首页显示个人信息：姓名、学号/工号、学生：均绩点；总学分；老师：本学期开设课程
侧边栏：根据身份渲染（前端做）
💣需要新写逻辑/接口
🥬调用基础接口
📢联动其他表
1. 管理员
    - 🥬学生管理：对学生信息进行增、删、改、查
    - 🥬教师管理：对教师信息进行增、删、改、查
    - 🥬(院系管理)：对院系师信息进行增、删、改、查
    - 🥬课程管理：对课程信息进行增、删、改、查
    - 🥬开课管理：
        录入本学期的开课表；对开课表进行增、删、改、查；
        在**已有选课的情况下**批量更改开课信息（可以做在基础"改"接口 里）（📢选课表）
    - 🥬选课管理：
        帮助学生对课程进行扩容（类似学生选课界面，勾选课程，弹出框输入学生信息后提交）（增）
        对选课表进行增（📢开课表）、删、改、查
        **联动对开课表容量和选课人数的修改**
2. 学生选课模块
    - 🥬选课、退课：
        选课判断：条件判断,返回msg：1.**时间段重复不可选课，自动弹出已选冲突的课程** 2.(学分上限提醒)
        查开课表、修改选课表（📢开课表：剩余容量）
    - 🥬课表查询：查该学生该学期的选课表，渲染成一张课程表；查选课表
    - (删除选课查询)
    - 🥬课程查询：查询开课表
    - (选课排名查询)
    - 🥬学分完成情况：列该学生出选过的全部课程和成绩
3. 教师
    - 🥬查询课表：查看自己本学期的开课课表
    - 🥬成绩管理：增删改成绩、查开课表

前端样式：
1. 管理员
    - 学生管理：基础表
    - 教师管理：基础表
    - (院系管理)：基础表
    - 课程管理：基础表
    - 开课管理：基础表
    - 选课管理：基础表
2. 学生选课模块
    - 选课、退课：选课+可视化课程表
    - 课表查询：可视化课程表
    - (删除选课查询)
    - 课程查询：基础表
    - (选课排名查询)
    - 学分完成情况：基础表（或者可以做成正式一点的表单）
    - 你选了多少学分 （触发器）
3. 教师
    - 查询课表：可视化课表
    - 成绩管理：基础表（点击修改功能）
    - 跳出来学生绩点多少（触发器）

## 项目结构
后端：
```
│  manage.py    #用于启动django后端
│
├─backend       #后端的一些设置存放的目录
│  │  asgi.py
│  │  settings.py
│  │  urls.py
│  │  wsgi.py
│  │  __init__.py
│  │
│  └─__pycache__
│
└─managementApp     #一个APP
    │  admin.py
    │  admin_views.py   #管理员操作接口（user以及登录登出）
    │  apps.py
    │  models.py       #模型层 对应数据库里的表
    │  tests.py
    │  student_views.py #学生表操作接口
    │  teacher_views.py #教师表操作接口
    │  __init__.py
    │  
    └─migrations
            __init__.py
```
前端：
## 开发记录
初版ddl:1.7


## 参考资料

官方文档 https://docs.djangoproject.com/zh-hans/4.2/

快速上手 https://www.jianshu.com/p/0123d11f9609

跨域问题解决 https://cloud.tencent.com/developer/article/2178334

使用触发器 https://geek-docs.com/django/django-questions/590_django_creating_triggers_with_custom_sql_in_django.html

动态路由 https://blog.csdn.net/qq_41773806/article/details/121407661

## 快速上手

1. 准备环境
    后端：准备python环境：按照环境中的要求安装包
    前端：安装nvm，可以不配置源；install好`npm 16.16.0` ,node不用手动安装
    [前端nvm参考](https://blog.csdn.net/HuangsTing/article/details/113857145)
2. 跑项目
    - 后端：
        cmd进入backend目录命令 
        第一次运行，初始化：`python manage.py makemigrations`
        插入数据库：`python manage.py migrate`
        启动后台：`python  manage.py runserver 0.0.0.0:8000`
        创建超级管理员:`python manage.py createsuperuser`
        【12.23更新，可以不创建了，提供的sql文件里有一个账号密码都是6个1地管理员】
    - 前端：
        powershell启动
        第一次运行，初始化 `npm install` 
        启动前端 `npm run dev`
        自动校正代码风格 `npm run lint -- --fix`
    - 注意端口，前端9528后端8000
3. 关于代码风格
    后端接口风格：
    每个表都有增、删、改、查四个接口
    命名规范：xxx首字母大写，哪个表的基础操作就用哪个表的英文名，如下：
    ``` 
    增：addCourseSelection 请求方法 post
    删：handleCourseSelection 请求方法 delete
    改：handleCourseSelection 请求方法 put
    查：handleCourseSelection 请求方法 post
    ```
    **后端接口命名不要出现下划线！！**
    注意：后端接口必须返回json响应体，必须要带一个code，**成功一定要设置成code:20000**，而且20000要是数字，失败返回msg,失败的msg尽量细分，这样前端能显示得更加细化

    前端接口风格：名字跟着接口走，各种操作函数名采用驼峰命名（首单词首字母小写，之后单词首字母大写）

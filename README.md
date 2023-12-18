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
登录，进入学期选择页面
左侧显示：登录人信息（学生：学号、姓名、平均绩点；）
1. 管理员
    - 学生管理
    - 教师管理
    - (院系管理)
    - 课程管理
    - 选课管理
2. 学生选课模块
    - 选课
    - 退课
    - 课表查询
    - (删除选课查询)
    - 课程查询
    - (选课排名查询)
3. 教师
    - 查询课表
    - 增删改成绩

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
    │  apps.py
    │  models.py       #模型层 对应数据库里的表
    │  tests.py
    │  views.py     #写与后端交互的接口
    │  __init__.py
    │  
    └─migrations
            __init__.py
```
前端：
## 开发记录

## 参考资料
官方文档 https://docs.djangoproject.com/zh-hans/4.2/

快速上手 https://www.jianshu.com/p/0123d11f9609

跨域问题解决 https://cloud.tencent.com/developer/article/2178334
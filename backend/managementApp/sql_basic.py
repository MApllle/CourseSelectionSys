#公共函数，sql操作
from django.db import connection
from datetime import datetime
#根据sql语句查询数据库
def get_from_table(sql,param):
    cursor = connection.cursor()
    cursor.execute(sql,param)
    row = cursor.fetchall()
    desc = cursor.description
    title = []
    out = []
    for t in desc:
        title.append(t[0])
    for c in row:
        row_dict=dict(zip(title,c))
        if 'date_of_birth' in title:
            date_index = title.index('date_of_birth')
            if row_dict['date_of_birth']:
                row_dict['date_of_birth'] = row_dict['date_of_birth'].strftime("%Y-%m-%d")
        out.append(row_dict)
        #转换date格式为字符串
        
    return out

#更新字段
def update_from_table(sql,param):
    cursor = connection.cursor()
    cursor.execute(sql, param)
    return

#删除字段
def delete_from_table(sql,param):
    cursor = connection.cursor()
    cursor.execute(sql, param)
    return

def call_scoreprocedure(semester):
    cursor = connection.cursor()
    cursor.callproc('CalculateAllScore', (semester,)) #注意参数应该是一个元组
    connection.connection.commit()         #调用存储过程后，确定要进行commit执行
    return
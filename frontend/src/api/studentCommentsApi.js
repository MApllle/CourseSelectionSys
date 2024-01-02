import request from '@/utils/request'
  
  /**
   * 添加评论
   * @param data {staff_id: 教师工号, student_id: 学生id, course_id: 课程号, comments: 评论内容} 教师工号
   * @returns 是否成功
   */
export function addStudentComments(data) {
    return request({
      url: 'http://localhost:8000/studentComments/',
      method: 'post',
      data
    })
}
  /**
   * 获得评论
   * @param data {staff_id: 1} 教师工号
   * @returns 教师相关评论列表
   */
export function getStudentComments(data) {
    return request({
      url: 'http://localhost:8000/studentComments/',
      method: 'GET',
      params: data
    })
}
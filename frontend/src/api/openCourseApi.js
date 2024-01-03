import request from '@/utils/request'

export function fetchSemester() { // login页面用来请求学期
  return request({
    url: 'http://localhost:8000/fetchSemester/',
    method: 'get'
  })
}

export function addOpenCourse(data) {
  return request({
    url: 'http://localhost:8000/addOpenCourse/',
    method: 'post',
    data
  })
}

export function updateOpenCourse(data) {
  return request({
    url: 'http://localhost:8000/handleOpenCourse/',
    method: 'put',
    data
  })
}

export function fetchOpenCourse(data) {
  return request({
    url: 'http://localhost:8000/handleOpenCourse/',
    method: 'post',
    data
  })
}

export function deleteOpenCourse(data) {
  return request({
    url: 'http://localhost:8000/handleOpenCourse/',
    method: 'delete',
    data
  })
}


/**
 * 教师管理选课课学生-获取列表
 * @param data {staff_id_id}
 * @returns 开课及学生
 */
export function teacherOpenCourseStudentView(data){
  return request({
    url: 'http://localhost:8000/teacherOpenCourseStudentView/',
    method: 'GET',
    params: data
  })
}

/**
 * 教师管理选课学生-移除课程学生
 * @param data {id: 选课表主键id}
 * @returns 开课及学生
 */
export function teacherDelOpenCourseStudent(data){
  return request({
    url: 'http://localhost:8000/teacherOpenCourseStudentView/',
    method: 'DELETE',
    params: data
  })
}

/**
 * 教师管理选课学生-增加课程学生
 * @param data {course_id_id: 开课表主键id, student_id_id: 学生表主键id, semester: 学期, staff_id_id: 教师表主键id, open_course_id_id: 开课表主键id}
 * @returns 是否成功
 */
export function teacherAddOpenCourseStudent(data){
  return request({
    url: 'http://localhost:8000/teacherOpenCourseStudentView/',
    method: 'POST',
    data
  })
}
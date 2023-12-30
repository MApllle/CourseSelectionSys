import request from '@/utils/request'

// 请求学期
export function fetchSemester() {
  return request({
    url: 'http://localhost:8000/fetchSemester/',
    method: 'get'
  })
}

// 获得所有课程
export function fetchCoursesForTeacherSchedule(data) {
  return request({
    url: 'http://localhost:8000/fetchCoursesForTeacherSchedule/',
    method: 'post',
    data
  })
}

// 学生获得所有课程
export function fetchCoursesForStudentSchedule(data) {
  return request({
    url: 'http://localhost:8000/fetchCoursesForStudentSchedule/',
    method: 'post',
    data
  })
}

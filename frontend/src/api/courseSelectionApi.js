import request from '@/utils/request'

/* export function fetchSemester( ) {   //login页面用来请求学期
    return request({
      url: 'http://localhost:8000/fetchSemester/',
      method: 'get',
    })
  } */
  //查询开课表+选课表，供教师打分
  export function fetchCoursesForScore(data) {
    return request({
      url: 'http://localhost:8000/fetchCoursesForScore/',
      method: 'POST',
      data
    })
  }
  fetchCourseSelectionForStudentScore
  //查询开课表+课程表，供学生查看
  export function fetchCourseSelectionForStudentScore(data) {
    return request({
      url: 'http://localhost:8000/fetchCourseSelectionForStudentScore/',
      method: 'POST',
      data
    })
  }
export function fetchCoursesForSelect(data) { // 查找开课表，构造选课清单
  return request({
    url: 'http://localhost:8000/fetchCoursesForSelect/',
    method: 'post',
    data
  })
}

export function addCourseSelection(data) {
  return request({
    url: 'http://localhost:8000/addCourseSelection/',
    method: 'post',
    data
  })
}

export function updateCourseSelection(data) {
  return request({
    url: 'http://localhost:8000/handleCourseSelection/',
    method: 'put',
    data
  })
}

export function fetchCourseSelection(data) {
  return request({
    url: 'http://localhost:8000/handleCourseSelection/',
    method: 'post',
    data
  })
}

export function fetchCoursesForCheck(data) {
  return request({
    url: 'http://localhost:8000/fetchCoursesForCheck/',
    method: 'post',
    data
  })
}

export function deleteCourseSelection(data) {
  return request({
    url: 'http://localhost:8000/handleCourseSelection/',
    method: 'delete',
    data
  })
}


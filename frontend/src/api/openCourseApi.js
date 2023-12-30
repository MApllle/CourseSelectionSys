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

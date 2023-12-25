import request from '@/utils/request'

export function addCourse(data) {
  return request({
    url: 'http://localhost:8000/addCourse/',
    method: 'post',
    data
  })
}

export function updateCourse(data) {
  return request({
    url: 'http://localhost:8000/handleCourse/',
    method: 'put',
    data
  })
}

export function fetchCourse(data) {
  return request({
    url: 'http://localhost:8000/handleCourse/',
    method: 'post',
    data
  })
}

export function deleteCourse(data) {
  return request({
    url: 'http://localhost:8000/handleCourse/',
    method: 'delete',
    data
  })
}

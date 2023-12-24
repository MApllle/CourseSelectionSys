import request from '@/utils/request'

export function addTeacher(data) {
  return request({
    url: 'http://localhost:8000/addTeacher/',
    method: 'post',
    data
  })
}

export function updateTeacher(data) {
  return request({
    url: 'http://localhost:8000/handleTeacher/',
    method: 'put',
    data
  })
}

export function fetchTeacher(data) {
  return request({
    url: 'http://localhost:8000/handleTeacher/',
    method: 'post',
    data
  })
}

export function deleteTeacher(data) {
  return request({
    url: 'http://localhost:8000/handleTeacher/',
    method: 'delete',
    data
  })
}

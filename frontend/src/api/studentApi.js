import request from '@/utils/request'

export function addStudent(data) {
  return request({
    url: 'http://localhost:8000/addStudent/',
    method: 'post',
    data
  })
}

export function updateStudent(data) {
  return request({
    url: 'http://localhost:8000/handleStudent/',
    method: 'put',
    data
  })
}

export function fetchStudent(data) {
  return request({
    url: 'http://localhost:8000/handleStudent/',
    method: 'post',
    data
  })
}

export function deleteStudent(data) {
  return request({
    url: 'http://localhost:8000/handleStudent/',
    method: 'delete',
    data
  })
}

export function calculateAllScore(data) {
  return request({
    url: 'http://localhost:8000/calculateAllScore/',
    method: 'post',
    data
  })
}


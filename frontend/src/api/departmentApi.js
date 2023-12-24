import request from '@/utils/request'

export function addDepartment(data) {
  return request({
    url: 'http://localhost:8000/addDepartment/',
    method: 'post',
    data
  })
}

export function updateDepartment(data) {
  return request({
    url: 'http://localhost:8000/handleDepartment/',
    method: 'put',
    data
  })
}

export function fetchDepartment(data) {
  return request({
    url: 'http://localhost:8000/handleDepartment/',
    method: 'post',
    data
  })
}

export function deleteDepartment(data) {
  return request({
    url: 'http://localhost:8000/handleDepartment/',
    method: 'delete',
    data
  })
}

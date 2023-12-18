import request from '@/utils/request'

export function addUser(data) {
  return request({
    url: 'http://localhost:8000/addUser/',
    method: 'post',
    data
  })
}

export function updateUser(data) {
  return request({
    url: 'http://localhost:8000/handleUser/',
    method: 'put',
    data
  })
}

export function fetchUser(data) {
  return request({
    url: 'http://localhost:8000/handleUser/',
    method: 'get',
    data
  })
}

export function deleteUser(data) {
  return request({
    url: 'http://localhost:8000/handleUser/',
    method: 'delete',
    data
  })
}
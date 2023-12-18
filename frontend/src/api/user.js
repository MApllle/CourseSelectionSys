import request from '@/utils/request'

export function login(data) {
  return request({
    url: 'http://localhost:8000/userLogin/',
    method: 'POST',
    data
  })
}

export function getInfo(token) {
  return request({
    url: 'http://localhost:8000/getUserInfo/',
    method: 'get',
    params: { token }
  })
}

export function logout() {
  return request({
    url: 'http://localhost:8000/Logout/',
    method: 'post'
  })
}

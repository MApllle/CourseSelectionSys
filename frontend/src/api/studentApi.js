import request from '@/utils/request'

export function Test() {
  return request({
    url: 'http://localhost:8000/index/',
    method: 'get'
  })
}

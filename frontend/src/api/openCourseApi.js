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

/**
 * 开课申请
 * @param data 开课申请信息
 * @returns 是否申请成功
 */
export function postCourseRequest(data) {
  return request({
    url: 'http://localhost:8000/courseRequest/',
    method: 'POST',
    data
  })
}

/**
 * 开课申请审核
 * @param data 开课申请状态修改信息
 * @returns 是否申请成功
 */
export function putCourseRequest(data) {
  return request({
    url: 'http://localhost:8000/handleCourseRequest/',
    method: 'PUT',
    data
  })
}

/**
 * 获得开课申请列表
 * @returns 开课申请信息
 */
export function getCourseRequest(data) {
  return request({
    url: 'http://localhost:8000/courseRequest/',
    method: 'GET',
    params: data
  })
}

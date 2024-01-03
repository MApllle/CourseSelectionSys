import request from '@/utils/request'
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

  /**
   * 开课申请审核
   * @param data 开课申请状态修改信息
   * @returns 是否申请成功
   */
  export function getCourseRequestNum() {
    return request({
      url: 'http://localhost:8000/handleCourseRequest/',
      method: 'GET'
    })
  }
//老师审核情况统计
  export function getCourseRequestTeacher(data) {
    return request({
      url: 'http://localhost:8000/handleCourseRequest/',
      method: 'POST',
      data
    })
  }
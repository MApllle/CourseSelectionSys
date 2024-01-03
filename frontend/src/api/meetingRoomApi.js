import request from '@/utils/request'


/**
 * 会议室-列表
 * @returns 会议室列表
 */
export function getMeetingRoom(){
    return request({
      url: 'http://localhost:8000/meetingRoom/',
      method: 'GET'
    })
}

/**
 * 会议室-申请使用
 * @param data {id: 会议室id, number: 使用人数, room_range: 时间范围}
 * @returns 会议室列表
 */
export function putMeetingRoom(data){
    return request({
      url: 'http://localhost:8000/meetingRoom/',
      method: 'PUT',
      data
    })
}
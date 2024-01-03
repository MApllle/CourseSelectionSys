import request from '@/utils/request'


/**
 * 学生获取选课列表
 * @param data {student_id: 学生表主键id,}
 * @returns 选课列表
 */
export function getHistoryCourseSelection(data){
    return request({
      url: 'http://localhost:8000/historyCourseSelectionView/',
      method: 'GET',
      params: data
    })
  }

<!--学生课程表-->
<template>
  <div class="app-container">
    <h1>学生课程表</h1>
    <el-form :inline="true" class="demo-form-inline">
      <el-form-item label="学期：">
        <el-select v-model="query.semester" filterable placeholder="输入或选择学期" size="small">
          <el-option
            v-for="item in allSemesterOption"
            :key="item.semester"
            :label="item.semester"
            :value="item.semester"
          />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" size="small" @click="fetchScheduleData()">查询课表</el-button>
      </el-form-item>
    </el-form>
    <el-divider />
    <el-table
      v-loading="listLoading"
      :data="tableData"
      element-loading-text="Loading"
      border
      fit
      highlight-current-row
    >
      <el-table-column align="center" label="编号">
        <template slot-scope="scope">
          <span>{{ scope.row.number }}</span>
        </template>
      </el-table-column>
      <el-table-column label="课程号" align="center">
        <template slot-scope="scope">
          <span>{{ scope.row.course_id_id }}</span>
        </template>
      </el-table-column>
      <el-table-column label="课程名" align="center">
        <template slot-scope="scope">
          <span>{{ scope.row.course_name }}</span>
        </template>
      </el-table-column>
      <el-table-column label="教师号" align="center">
        <template slot-scope="scope">
          <span>{{ scope.row.staff_id_id }}</span>
        </template>
      </el-table-column>
      <el-table-column label="教师姓名" align="center">
        <template slot-scope="scope">
          <span>{{ scope.row.teacher_name }}</span>
        </template>
      </el-table-column>
      <el-table-column label="学分" align="center">
        <template slot-scope="scope">
          <span>{{ scope.row.credit }}</span>
        </template>
      </el-table-column>
      <el-table-column label="学时" align="center">
        <template slot-scope="scope">
          <span>{{ scope.row.credit_hours }}</span>
        </template>
      </el-table-column>
      <el-table-column label="上课时间" align="center">
        <template slot-scope="scope">
          <span>{{ scope.row.class_time }}</span>
        </template>
      </el-table-column>
    </el-table>
    <el-divider />
    <p>学分总计：{{ total_credit }}</p>
    <el-table
      v-loading="listLoading"
      :data="scheduleData"
      element-loading-text="Loading"
      border
      fit
      highlight-current-row
    >
      <el-table-column align="center" label="">
        <template slot-scope="scope">
          <span>{{ scope.row.rownum }}</span>
        </template>
      </el-table-column>
      <el-table-column label="上课时间" align="center">
        <template slot-scope="scope">
          <span>{{ scope.row.time }}</span>
        </template>
      </el-table-column>
      <el-table-column label="星期一" align="center">
        <template slot-scope="scope">
          <span>{{ scope.row.Monday }}</span>
        </template>
      </el-table-column>
      <el-table-column label="星期二" align="center">
        <template slot-scope="scope">
          <span>{{ scope.row.Tuesday }}</span>
        </template>
      </el-table-column>
      <el-table-column label="星期三" align="center">
        <template slot-scope="scope">
          <span>{{ scope.row.Wednesday }}</span>
        </template>
      </el-table-column>
      <el-table-column label="星期四" align="center">
        <template slot-scope="scope">
          <span>{{ scope.row.Thursday }}</span>
        </template>
      </el-table-column>
      <el-table-column label="星期五" align="center">
        <template slot-scope="scope">
          <span>{{ scope.row.Friday }}</span>
        </template>
      </el-table-column>
    </el-table>
  </div>
</template>

<script>
import { fetchCoursesForStudentSchedule, fetchSemester } from '@/api/viewScheduleApi'
import { mapGetters } from 'vuex'
export default {
  computed: {
    ...mapGetters([
      'group',
      'semester',
      'name'
    ])
  },
  filters: {
    statusFilter(status) {
      const statusMap = {
        published: 'success',
        draft: 'gray',
        deleted: 'danger'
      }
      return statusMap[status]
    }
  },
  data() {
    return {
      listLoading: true,
      // 上层列表：显示所有选课信息
      tableData: [],
      // 课程表
      scheduleData: [
        { rownum: '1', time: '8:00-8:45', Monday: '', Tuesday: '', Wednesday: '', Thursday: '', Friday: '' },
        { rownum: '2', time: '8:55-9:40', Monday: '', Tuesday: '', Wednesday: '', Thursday: '', Friday: '' },
        { rownum: '3', time: '10:00-10:45', Monday: '', Tuesday: '', Wednesday: '', Thursday: '', Friday: '' },
        { rownum: '4', time: '10:55-11:40', Monday: '', Tuesday: '', Wednesday: '', Thursday: '', Friday: '' },
        { rownum: '5', time: '13:00-13:45', Monday: '', Tuesday: '', Wednesday: '', Thursday: '', Friday: '' },
        { rownum: '6', time: '13:55-14:40', Monday: '', Tuesday: '', Wednesday: '', Thursday: '', Friday: '' },
        { rownum: '7', time: '15:00-15:45', Monday: '', Tuesday: '', Wednesday: '', Thursday: '', Friday: '' },
        { rownum: '8', time: '15:55-16:40', Monday: '', Tuesday: '', Wednesday: '', Thursday: '', Friday: '' },
        { rownum: '9', time: '18:00-18:45', Monday: '', Tuesday: '', Wednesday: '', Thursday: '', Friday: '' },
        { rownum: '10', time: '18:55-19:40', Monday: '', Tuesday: '', Wednesday: '', Thursday: '', Friday: '' },
        { rownum: '11', time: '20:00-20:45', Monday: '', Tuesday: '', Wednesday: '', Thursday: '', Friday: '' },
        { rownum: '12', time: '20:55-21:40', Monday: '', Tuesday: '', Wednesday: '', Thursday: '', Friday: '' }
      ],
      // 记录所有学期
      allSemesterOption: [],
      query: {
        student_id_id: this.$store.getters.name,
        semester: this.$store.getters.semester
      },
      // 总学分
      total_credit: 0
    }
  },
  created() {
    this.fetchAllData()
  },
  methods: {
    // 获取该教师本学期所有课程
    async fetchAllData() {
      const response = await fetchSemester()
      this.allSemesterOption = response.data
      // console.log("fetchquery",this.query)
      const responseCS = await fetchCoursesForStudentSchedule(this.query)
      this.tableData = responseCS.data

      this.addNumberToData()
      this.splitToSchedule()
      this.listLoading = false
    },
    async fetchScheduleData() {
      const responseCS = await fetchCoursesForStudentSchedule(this.query)
      this.tableData = responseCS.data
      // 清空课程表
      for (let i = 0; i < this.scheduleData.length; i++) {
        this.scheduleData[i].Monday = ''
        this.scheduleData[i].Tuesday = ''
        this.scheduleData[i].Wednesday = ''
        this.scheduleData[i].Thursday = ''
        this.scheduleData[i].Wednesday = ''
        this.scheduleData[i].Friday = ''
      }
      this.total_credit = 0
      this.addNumberToData()
      this.splitToSchedule()
      this.listLoading = false
    },
    // 编上字母编号
    addNumberToData() {
      let number = 65
      for (let i = 0; i < this.tableData.length; i++) {
        this.tableData[i].number = String.fromCharCode(number)
        number++
      }
    },
    splitToSchedule() {
      for (let i = 0; i < this.tableData.length; i++) {
        console.log('tabledata i', this.tableData[i])
        const timelist = this.tableData[i].class_time.split(' ')
        this.total_credit += this.tableData[i].credit
        for (let j = 0; j < timelist.length; j++) {
          // 添加到课程表
          console.log('timelist', timelist[j], 'list1', timelist[j][0])
          let match = timelist[j].match(/(\d+)-(\d+)/);
          switch (timelist[j][0]) {
            case '一': {
              for(let k=Number(match[1]);k<=Number(match[2]);k++)
                this.scheduleData[Number(k) - 1].Monday = this.tableData[i].number
              break
            }
            case '二': {
              for(let k=Number(match[1]);k<=Number(match[2]);k++)
                this.scheduleData[Number(k) - 1].Tuesday = this.tableData[i].number
              break
            }
            case '三': {
              for(let k=Number(match[1]);k<=Number(match[2]);k++)
                this.scheduleData[Number(k) - 1].Wednesday = this.tableData[i].number
              break
            }
            case '四': {
              for(let k=Number(match[1]);k<=Number(match[2]);k++)
                this.scheduleData[Number(k) - 1].Thursday = this.tableData[i].number
              break
            }
            case '五': {
              for(let k=Number(match[1]);k<=Number(match[2]);k++)
                this.scheduleData[Number(k) - 1].Friday = this.tableData[i].number
              break
            }
            default:
              break
          }
          console.log("结果",this.scheduleData)
        }
      }
    }
  }
}
</script>

  <style>
  .boxes{
      width: 18%;
  }
  .fetchInputBox{
    width:20%
  }
  </style>

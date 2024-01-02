<template>
    <div class="app-container">
      <h1>学生评论</h1>
      <el-form :inline="true" class="demo-form-inline">
        <!-- 表格内容 -->
      </el-form>
  
      <el-table
        v-loading="listLoading"
        :data="studentCommentsList"
        title="学生评论"
        element-loading-text="Loading"
        border
        fit
        highlight-current-row
      >
        <el-table-column label="课程名" align="center">
          <template slot-scope="scope">
            <span>{{ scope.row.course_id__course_name }}</span>
          </template>
        </el-table-column>
        <el-table-column label="学生" align="center">
          <template slot-scope="scope">
            <span>{{ scope.row.student_id__name }}</span>
          </template>
        </el-table-column>
        <el-table-column label="评论" align="center">
          <template slot-scope="scope">
            <span>{{ scope.row.comments }}</span>
          </template>
        </el-table-column>

      </el-table>
    </div>
  </template>
  
  <script>
  import { getStudentComments } from '@/api/studentCommentsApi'
  export default {
    data() {
      return {
        group: 'teacher',
        listLoading: true,
        staff_id: '',
        studentCommentsList: []
      }
    },
    created() {
      this.group = this.$store.getters.group
      if (this.group === '教师') this.staff_id = this.$store.getters.name
      else this.staff_id = ''
      this.getStudentCommentsList({ staff_id: this.staff_id })
    },
    methods: {
      // 获取评论列表
      getStudentCommentsList(data = {staff_id: this.course_form.staff_id}) {
        getStudentComments(data).then((res) => {
          this.studentCommentsList = res.data
          this.listLoading = false
        })
      }
    }
  }
  </script>
  
    <style scoped>
    /* 样式 */
    </style>
  
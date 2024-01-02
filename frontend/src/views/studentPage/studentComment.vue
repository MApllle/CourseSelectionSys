<template>
    <div class="app-container">
      <h1>学生评论</h1>
      <el-form :inline="true" class="demo-form-inline">
        <!-- 表格内容 -->
      </el-form>
  
    <h2>已选的课程</h2>
    <!--用于学生退课-->
    <el-table
      v-loading="listLoading"
      :data="tableDataCourseSelection"
      element-loading-text="Loading"
      border
      fit
      highlight-current-row
    >
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
      <el-table-column label="学分" align="center">
        <template slot-scope="scope">
          <span>{{ scope.row.credit }}</span>
        </template>
      </el-table-column>
      <el-table-column label="教师号" align="center">
        <template slot-scope="scope">
          <span>{{ scope.row.staff_id_id }}</span>
        </template>
      </el-table-column>
      <el-table-column label="教师名" align="center">
        <template slot-scope="scope">
          <span>{{ scope.row.staff_name }}</span>
        </template>
      </el-table-column>
      <el-table-column label="上课时间" align="center">
        <template slot-scope="scope">
          <span>{{ scope.row.class_time }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center">
        <template slot-scope="scope">
            <el-input v-model="commentInput"></el-input>
          <el-button
            size="mini"
            type="danger"
            @click="handleDialogOpen(scope.row)"
          >添加评论</el-button>
        </template>
      </el-table-column>
    </el-table>

    <el-dialog
      title="开课信息"
      :visible.sync="dialogVisible"
      width="30%"
      :before-close="handleDialogClose"
    >
      <el-form :model="course_form">

        <el-form-item label="课程号" label-width="120px">
          <el-input
            v-model="comment_form.course_id_id"
            autocomplete="off"
          />
        </el-form-item>
        <el-form-item label="课程名" label-width="120px">
          <el-input
            v-model="comment_form.course_id_course_name"
            autocomplete="off"
          />
        </el-form-item>
        <el-form-item label="评论" label-width="120px">
          <el-input v-model="comment_form.comments" autocomplete="off" />
        </el-form-item>
        

      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">取 消</el-button>
        <el-button
          type="primary"
          @click="addCourseRequest"
        >确 定</el-button>
      </span>
    </el-dialog>
    </div>
  </template>
  
  <script>
  import { addStudentComments } from '@/api/studentCommentsApi'
  import { fetchCoursesForCheck } from '@/api/courseSelectionApi'
  export default {
    data() {
      return {
        tableDataCourseSelection: [],
        listLoading: true,
        dialogVisible: false, // 控制dialog是否可见

        commentInput: '',
        querySelectCourse: {
        semester: this.$store.getters.semester,
        student_id_id: this.$store.getters.name,
        normal_score: '',
        course_id_id: '',
        staff_id_id: '',
        course_name: '',
        staff_name: '',
        class_time: '',
        credit: ''
      },
      comment_form: {
        student_id_id: this.$store.getters.name,
        course_id_id: '',
        staff_id_id: '',
        comments: ''
      }
      }
    },
    created() {
      this.group = this.$store.getters.group
      if (this.group === '教师') this.staff_id = this.$store.getters.name
      else this.staff_id = ''
      this.fetchCourseSelectionData()
    },
    methods: {
      // 查询某个同学的选课情况
    fetchCourseSelectionData() {
      this.listLoading = true
      fetchCoursesForCheck(this.querySelectCourse).then(responseCS => {
        this.tableDataCourseSelection = responseCS.data
        console.log('更新tabledataCS', this.tableDataCourseSelection)
        this.listLoading = false
      })
    },

    // 添加评论
    addComment(even) {
        console.log(even)
        console.log(this.commentInput)
        addStudentComments({
            student_id_id: this.$store.getters.name,
            course_id_id: this.comment_form.course_id_id,
            staff_id_id: this.comment_form.staff_id_id,
            comments: this.commentInput
        }).then(response => {
            console.log(response)
            this.$message({
                message: '评论成功',
                type: 'success'
            })
        })
    },
    // 打开模态框dialog
    handleDialogOpen(row){
        this.dialogVisible = true
        console.log(row)
        this.comment_form.course_id_id = row.course_id_id
        this.comment_form.staff_id_id = row.staff_id_id

    },
    // 关闭dialog
    handleDialogClose(done) {
      this.$confirm('确认关闭？')
        .then((_) => {
          done()
        })
        .catch((_) => {})
    },
    }
  }
  </script>
  
    <style scoped>
    /* 样式 */
    </style>
  
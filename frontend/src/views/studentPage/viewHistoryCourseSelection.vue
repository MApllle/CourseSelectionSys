<template>
    <div class="app-container">
      <h1>成绩大表</h1>
      <el-form :inline="true" class="demo-form-inline">
      </el-form>
        <el-table
          v-loading="listLoading" 
          :data="CourseList" 
          title="往期课程"
          element-loading-text="Loading" 
          border 
          fit 
          highlight-current-row
        >
            <el-table-column align="center" label="学期">
            <template slot-scope="scope">
              <span>{{ scope.row.semester }}</span>
            </template>
          </el-table-column>
          <el-table-column align="center" label="课程号">
            <template slot-scope="scope">
              <span>{{ scope.row.course_id }}</span>
            </template>
          </el-table-column>
          <el-table-column align="center" label="课程名称">
            <template slot-scope="scope">
              <span>{{ scope.row.course_id__course_name }}</span>
            </template>
          </el-table-column>
          <el-table-column align="center" label="课程学分">
            <template slot-scope="scope">
              <span>{{ scope.row.course_id__credit }}</span>
            </template>
          </el-table-column>
          <el-table-column label="平时成绩" align="center">
            <template slot-scope="scope">
              <span>{{ scope.row.normal_score }}</span>
            </template>
          </el-table-column>
          <el-table-column label="考试成绩" align="center">
            <template slot-scope="scope">
              <span>{{ scope.row.test_score }}</span>
            </template>
          </el-table-column>
          <el-table-column label="总评成绩" align="center">
            <template slot-scope="scope">
              <span>{{ scope.row.total_score }}</span>
            </template>
          </el-table-column>
          
        </el-table>
        <h3>总学分: {{ CourseCredit }}</h3>
        <h3>平均成绩:{{ (CourseTotalScore/CourseCount).toFixed(2) }} </h3>
    </div>
  </template>
  
  <script>
      import { 
        getHistoryCourseSelection
       } from "@/api/historyCourseSelectionApi"

      export default {
      data() {
          return {
            listLoading: true,
            student_id: "",
            CourseList: [],
            CourseCount: 0, // 课程数量
            CourseTotalScore: 0, // 总分数
            CourseCredit: 0, // 总学分
          };
      },
      methods: {
          // 获取当前学生相关课程列表
          getCourseSelectionList() {
            getHistoryCourseSelection({student_id: this.student_id}).then((res) => {
                this.CourseList = res.data
                this.listLoading = false
                this.CourseTotalScore = 0
                this.CourseCount = 0
                for(let i=0; i<this.CourseList.length;i++){
                    console.log(this.CourseList[i])
                    this.CourseCount += 1;
                    this.CourseTotalScore += this.CourseList[i].total_score
                    this.CourseCredit += this.CourseList[i].course_id__credit
                }
                console.log(this.CourseTotalScore, this.CourseCount )
                this.CourseTotalScore = this.CourseTotalScore.toFixed(2)
                this.CourseCredit = this.CourseCredit.toFixed(2)
              })
          }
      },
      created() {
          this.student_id = this.$store.getters.name
          this.getCourseSelectionList()
      }
      };
  </script>
  
  <style scoped>
  /* 样式 */
  </style>
  
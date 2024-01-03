<template>
  <div class="app-container">
    <h1>课程学生管理</h1>
    <el-form :inline="true" class="demo-form-inline">
    </el-form>
    <template v-for="item in CourseList">
      <h2>
        {{ item.semester }} - {{ item.course_id__course_name }}  
        <el-button type="primary " size="small" @click="handleOpen(item)">添加学生</el-button>
      </h2>
      <el-table
        v-loading="listLoading" 
        :data="item.stu_list" 
        :title="item.semester"
        element-loading-text="Loading" 
        border 
        fit 
        highlight-current-row
      >
        <el-table-column align="center" label="课程号">
          <template slot-scope="scope">
            <span>{{ item.course_id }}</span>
          </template>
        </el-table-column>
        <el-table-column label="学生id" align="center">
          <template slot-scope="scope">
            <span>{{ scope.row.student_id }}</span>
          </template>
        </el-table-column>
        <el-table-column label="学生姓名" align="center">
          <template slot-scope="scope">
            <span>{{ scope.row.student_id__name }}</span>
          </template>
        </el-table-column>
        <el-table-column label="操作" align="center" v-if="group==='教师'">
            <template slot-scope="scope">
                <el-button type="danger " size="small" @click="delCourseStudent(scope.row.id)">删除</el-button>
            </template>
        </el-table-column>
      </el-table>
    </template>

    <el-dialog
    title="添加学生"
    :visible.sync="dialogVisible"
    width="30%"
    :before-close="handleClose"
  >
    <el-form :model="addCourseSelectFrom">
      
      <el-form-item label="课程号" label-width="120px">
        <el-input
          v-model="addCourseSelectFrom.course_id_id"
          autocomplete="off"
          disabled
        ></el-input>
      </el-form-item>

      <el-form-item label="学期" label-width="120px">
        <el-input
          v-model="addCourseSelectFrom.semester"
          autocomplete="off"
          disabled
        />
      </el-form-item>

      <el-form-item label="学生学号" label-width="120px">
        <el-input
          v-model="addCourseSelectFrom.student_id_id"
          autocomplete="off"
        />
      </el-form-item>
      
    </el-form>
    <span slot="footer" class="dialog-footer">
      <el-button @click="dialogVisible = false">取 消</el-button>
      <el-button type="primary" @click="addClick"
        >确 定</el-button
      >
    </span>
  </el-dialog>
  </div>
</template>

<script>
    import { 
      teacherOpenCourseStudentView, 
      teacherDelOpenCourseStudent,
      teacherAddOpenCourseStudent
     } from "@/api/openCourseApi"
    import { fetchCourseSelection } from "@/api/courseSelectionApi"
    export default {
    data() {
        return {
          dialogVisible: false,
          listLoading: true,
          querySelectCourse: {
            staff_id_id: ''
          },
          CourseList: [],
          addCourseSelectFrom:
          {
            course_id_id: "",
            semester: "",
            staff_id_id: "",
            open_course_id_id: "",
            student_id_id: "",
          }
        };
    },
    methods: {
        // 获取当前教师相关课程列表
        getCourseSelectionList() {
          teacherOpenCourseStudentView(this.querySelectCourse).then((res) => {
              this.CourseList = res.data
              this.listLoading = false
            })
        },
        // 移除选课中的学生
        delCourseStudent(id){
          teacherDelOpenCourseStudent({id}).then((res)=>{
            this.getCourseSelectionList()
          })
        },
        //添加学生
        addClick(){
          teacherAddOpenCourseStudent(this.addCourseSelectFrom).then((res)=>{
            this.getCourseSelectionList()
            this.dialogVisible = false
            this.addCourseSelectFrom.student_id_id = ''
          })
        },
        // 关闭dialog
        handleClose(done) {
          this.$confirm("确认关闭？")
              .then((_) => {
              done();
              })
              .catch((_) => {});
        },
        // 打开dialog
        handleOpen(done){
          console.log(done)
          this.addCourseSelectFrom.course_id_id = done.course_id
          this.addCourseSelectFrom.semester = done.semester
          this.addCourseSelectFrom.staff_id_id = done.staff_id
          this.addCourseSelectFrom.open_course_id_id = done.id
          this.dialogVisible = true;
        }
    },
    created() {
        this.group = this.$store.getters.group
        if(this.group === '教师') this.querySelectCourse.staff_id_id = this.$store.getters.name;
        else this.querySelectCourse.staff_id_id = '';
        this.getCourseSelectionList()
    }
    };
</script>

<style scoped>
/* 样式 */
</style>

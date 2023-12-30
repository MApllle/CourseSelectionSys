<template>
  <div class="dashboard-container">
    <div class="dashboard-text">欢迎来到选课系统！</div>
    <el-row :gutter="50">
      <el-col :span="12">
        <el-card class="box-card">
          <div slot="header" class="clearfix">
            <span>基本信息</span>
            <!-- <el-button style="float: right; padding: 3px 0" type="text">操作按钮</el-button> -->
          </div>
          <span class="svg-container">
            <svg-icon icon-class="dashboarduser" class="svg-icon" />
          </span>
          <div v-for="item in outList" :key="outList" class="text item">
            {{ item.value }}
          </div>
        </el-card>
      </el-col>
      <el-col :span="12">
        <el-card class="box-card">
          <div slot="header" class="clearfix">
            <span>待办事项提醒</span>
            <!-- <el-button style="float: right; padding: 3px 0" type="text">操作按钮</el-button> -->
          </div>
          <span class="svg-container">
            <svg-icon icon-class="todo" class="svg-icon" />
          </span>
          <div v-for="item in todoList" :key="todoList" class="text item">
            <el-tag class="todoTag" :type="item.tag">{{ item.label }}</el-tag><span>{{ item.value }}</span>
          </div>
        </el-card>
      </el-col>
    </el-row>

  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import { fetchCourseSelection } from '@/api/courseSelectionApi'
import { fetchOpenCourse } from '@/api/openCourseApi'
import { fetchStudent } from '@/api/studentApi'
import { fetchTeacher } from '@/api/teacherApi'

export default {
  name: 'Dashboard',
  computed: {
    ...mapGetters([
      'name',
      'group',
      'semester'
    ])
  },
  data() {
    return {
      outList: [
        { value: '账号：' + this.$store.getters.name },
        { value: '学期：' + this.$store.getters.semester }
      ],
      todoList: [],
      queryCourseSelection: {
        student_id_id: this.$store.getters.name,
        semester: this.$store.getters.semester
      },
      courseSelectionReturn: [],
      queryOpenCourse: {
        staff_id_id: this.$store.getters.name,
        semester: this.$store.getters.semester
      },
      OpenCourseReturn: [],
      queryTeacher: {
        staff_id: this.$store.getters.name
      },
      queryStudent: {
        student_id: this.$store.getters.name
      },
      studentReturn: {
        student_name: null,
        total_credit: null,
        average_gpa: null
      },
      teacherReturn: {
        teacher_name: null,
        professional_ranks: null
      },
      addSemesterVisible: false
    }
  },
  mounted() {
    this.handleoutList()
    this.handleToDo()
  },
  methods: {
    handleoutList() {
      if (this.group === '学生') {
        fetchStudent(this.queryStudent).then(response => {
          this.studentReturn.student_name = response.data[0].name
          this.studentReturn.total_credit = response.data[0].total_credit
          this.studentReturn.average_gpa = response.data[0].average_gpa
          this.outList.push({ value: `姓名：${this.studentReturn.student_name}` })
          this.outList.push({ value: `已修学分：${this.studentReturn.total_credit}` })
          this.outList.push({ value: `平均绩点：${this.studentReturn.average_gpa}` })
        })
      } else if (this.group === '教师') {
        fetchTeacher(this.queryTeacher).then(response => {
          this.teacherReturn.teacher_name = response.data[0].name
          this.teacherReturn.professional_ranks = response.data[0].professional_ranks
          this.outList.push({ value: `姓名：${this.teacherReturn.teacher_name}` })
          this.outList.push({ value: `职称：${this.teacherReturn.professional_ranks}` })
        })
      } else if (this.group === '管理员') {
        this.addSemesterVisible = true
      }
    },
    handleToDo() {
      if (this.group === '学生') {
        fetchCourseSelection(this.queryCourseSelection).then(response => {
          if (response) {
            this.courseSelectionReturn = response.data
            // 判断是否需要选课
            if (this.courseSelectionReturn.length == 0) {
              this.todoList.push({ label: '选课事项', value: '本学期未选课，请尽快选课！', tag: 'danger' })
            } else {
            // 计算课程数
              this.todoList.push({ label: '选课事项', value: '本学期已选' + this.courseSelectionReturn.length + '门课', tag: 'success' })
              // 是否提醒考评
              this.todoList.push({ label: '考评事项', value: '待填写考评', tag: 'danger' })
            }
          }
        })
      } else if (this.group === '教师') {
        fetchOpenCourse(this.queryOpenCourse).then(response => {
          if (response) {
            this.OpenCourseReturn = response.data
            // 判断是否需要选课
            if (this.OpenCourseReturn.length === 0) {
              this.todoList.push({ label: '课程事项', value: '本学期没有待授课程！', tag: 'success' })
            } else {
            // 计算课程数
              this.todoList.push({ label: '课程事项', value: '本学期有' + this.OpenCourseReturn.length + '门课待授', tag: 'success' })
              // 是否提醒考评
              this.todoList.push({ label: '考评事项', value: '学期结束，可查看考评', tag: 'success' })
            }
          }
        })
      }
    }

  }
}
</script>

<style lang="scss" scoped>
.dashboard {
  &-container {
    margin: 30px;
  }
  &-text {
    font-size: 30px;
    line-height: 46px;
  }
}
.svg-container{
  display: flex;
  justify-content: center;
}
.svg-icon{
  width: 80px;
  height: 80px;
}
.todoTag{
  font-size: 14px;
  margin-top: 5px;
  margin-right: 5px;
}
</style>

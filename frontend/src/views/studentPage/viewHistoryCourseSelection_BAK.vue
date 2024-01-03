<!--查看历史选课-->
<template>
    <div class="app-container">
      <h1>成绩查询</h1>
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
        <el-button type="primary" size="small" @click="fetchData()">查询</el-button>
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
        <el-table-column label="成绩" align="center">
          <template slot-scope="scope">
            <span>{{ scope.row.total_score }}</span>
          </template>
        </el-table-column>
        <el-table-column label="绩点" align="center">
          <template slot-scope="scope">
            <span>{{ scope.row.gpa }}</span>
          </template>
        </el-table-column>
      </el-table>
      <h5>总计学分：{{ total_credit }} 平均绩点：{{ average_gpa }}</h5>
    </div>
  </template>
  
  <script>
  import { fetchSemester } from '@/api/openCourseApi'
  import { fetchCourseSelectionForStudentScore } from '@/api/courseSelectionApi'
  import { mapGetters } from 'vuex'
  // import { addStudent, updateStudent, fetchStudent, deleteStudent,fetchStudent } from '@/api/studentApi'
  
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
        input: null,
        list: null,
        listLoading: true,
        // 查询所有学期
        allSemesterOption: [],
        // 从选课表查找并返回的数据
        tableData: [],
        addFormVisible: false,
        deleteFormVisible: false,
        query:{
            semester: this.$store.getters.semester,
            student_id_id: this.$store.getters.name,
        },
        queryOpenCourse: {
          semester: this.$store.getters.semester, // semester=this.semester
          course_id_id: '',
          staff_id_id: '',
          course_name: '',
          staff_name: '',
          professional_ranks: '',
          capacity: '',
          used_capacity: '',
          credit: '',
          class_time: ''
        },
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
        total_credit: 0,
        average_gpa:0,
      }
    },
    created() {
      this.fetchAllData()
    },
    methods: {
      async fetchAllData(){
        this.listLoading = true
        const responseSemester = await fetchSemester()
        this.allSemesterOption = responseSemester.data
        this.query.semester=this.$store.getters.semester
        //返回：所有学期
        
        const response = await fetchCourseSelectionForStudentScore(this.query)
        this.tableData = response.data
        //返回：c.course_name ,cs.course_id_id,cs.total_score,c.credit, gpa
        this.sumCreditGpa()
        this.listLoading = false
      },
      async fetchData() {
        this.listLoading = true
        fetchCourseSelectionForStudentScore(this.query).then(response => {
          this.tableData = response.data
          console.log('更新tabledata', this.tableDataOpenCourse)
          this.sumCreditGpa()
          
        })
        this.listLoading = false
      },
      sumCreditGpa(){
        let creditPlusGpa=0
        this.total_credit=0
        for(let i=0;i<this.tableData.length;i++){
            creditPlusGpa+=this.tableData[i].gpa * this.tableData[i].credit
            this.total_credit+=this.tableData[i].credit
        }
        if (this.total_credit!==0)
            this.average_gpa=(creditPlusGpa/this.total_credit).toFixed(2)
        else this.average_gpa=0
      }
    }
  }
  </script>
  
  <style>
  .boxes {
    width: 18%;
  }
  </style>
  
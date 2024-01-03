<!--登分表-->
<template>
    <div class="app-container">
      <h1>成绩管理</h1>
      <el-form :inline="true" class="demo-form-inline">
        <el-form-item label="本学期课程：">
        <el-select v-model="selectedopenCourseListData" 
                  filterable placeholder="输入或选择本学期课程" 
                  size="small">
        <el-option
            v-for="(item,index) in openCourseListData"
            :key="index"
            :label="item.course_name"
            :value="index">
          <span style="float: left">{{ item.course_name }}({{ item.course_id_id }})</span>
          <span style="float: right; color: #8492a6; font-size: 13px">{{ item.class_time }}</span>
        </el-option>
      </el-select>
      </el-form-item>
      </el-form>
      <el-row :gutter="20">
        <el-col :span="2"><span>学号：</span></el-col>
        <el-col :span="4">
          <el-input v-model="query.student_id_id" autocomplete="off" size="small" />
        </el-col>
        <el-col :span="2"><span>学生姓名：</span></el-col>
        <el-col :span="4">
          <el-input v-model="query.student_name" autocomplete="off" size="small" />
        </el-col>
        <el-col :span="2"><span>学生院系名：</span></el-col>
        <el-col :span="4">
          <el-input v-model="query.dept_name" autocomplete="off" size="small" />
        </el-col>
        <el-col :span="2"><span>学生院系号：</span></el-col>
        <el-col :span="4">
          <el-input v-model="query.dept_id_id" autocomplete="off" size="small" />
        </el-col>
      </el-row>
      <div align="right">
        <el-button type="primary" size="small" @click="fetchData()">查询</el-button>
        <el-button type="primary" size="small" @click="handleSave()">保存</el-button>
      </div>
      <el-divider />
      <!-- <h3>{{ openCourseListData[titleSub].course_name }}（{{ openCourseListData[titleSub].course_id_id }}）:{{openCourseListData[titleSub].class_time}}登分表</h3> -->
      <div align="middle"><h3>{{ tableTitle }}</h3></div>
      <el-table
        v-loading="listLoading"
        :data="tableData.slice((currentPage-1)*pageSize,currentPage*pageSize)"
        element-loading-text="Loading"
        border
        fit
        highlight-current-row
        @cell-click="cellClick"
        :cell-class-name="tableCellClassName"
      >
        <el-table-column align="center" label="序号">
          <template slot-scope="scope">
            {{ scope.$index+1+pageSize*(currentPage-1) }}
          </template>
        </el-table-column>
        <el-table-column label="学号" align="center">
          <template slot-scope="scope">
            <span>{{ scope.row.student_id_id }}</span>
          </template>
        </el-table-column>
        <el-table-column label="姓名" align="center">
          <template slot-scope="scope">
            <span>{{ scope.row.student_name }}</span>
          </template>
        </el-table-column>
        <el-table-column label="学院" align="center">
          <template slot-scope="scope">
            <span>{{ scope.row.dept_name }}（{{ scope.row.dept_id_id }}）</span>
          </template>
        </el-table-column>
        <el-table-column align="center" label="平时成绩">
          <template slot-scope="scope">
            <div v-if="scope.row.index === rowIndex && scope.column.index === columnIndex " class='inputnum'>
              <el-input v-model="scope.row.normal_score"
                        ref='editInput'
                        type="number"
                        size="mini"
                        @blur="inputBlur(scope)" />
            </div>
            <div class="inputnum"
                 v-else>{{ scope.row.normal_score }}</div>
          </template>
        </el-table-column>
        <el-table-column align="center" label="期末成绩">
          <template slot-scope="scope">
            <div v-if="scope.row.index === rowIndex && scope.column.index === columnIndex " class='inputnum'>
              <el-input v-model="scope.row.test_score"
                        ref='editInput'
                        type="number"
                        size="mini"
                        @blur="inputBlur(scope)" />
            </div>
            <div class="inputnum"
                 v-else>{{ scope.row.test_score }}</div>
          </template>
        </el-table-column>
        <el-table-column label="总成绩" align="center">
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
      <el-pagination
        align="center"
        :current-page="currentPage"
        :page-sizes="[1,5,10,20]"
        :page-size="pageSize"
        layout="total, sizes, prev, pager, next, jumper"
        :total="tableData.length"
        @size-change="handleSizeChange"
        @current-change="handleCurrentChange"
      />
  
      <!--确认对话框-->
      <el-dialog
        title="提示"
        :visible.sync="confirmDeleteDialogVisible"
        width="30%"
        center
      >
        <span>确认删除？</span>
        <span slot="footer" class="dialog-footer">
          <el-button size="small" @click="confirmDeleteDialogVisible = false">取 消</el-button>
          <el-button size="small" type="primary" @click="confirmDelete()">确 定</el-button>
        </span>
      </el-dialog>
    </div>
  </template>
  
  <script>
  import { fetchCoursesForScore, updateCourseSelection } from '@/api/courseSelectionApi'
  import { fetchCoursesForTeacherSchedule } from '@/api/viewScheduleApi'
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
        rowIndex: -1, //行索引
        columnIndex: -1, //列索引
        password: null,
        listLoading: true,
        selectedopenCourseListData:0,
        tableTitle:'',
        tableData: [],
        openCourseListData:[],
        confirmDeleteDialogVisible: false,
        query: {  //固定课程，获取某个学生/学院学生的单行表
          staff_id_id:this.$store.getters.name,
          open_course_id_id: '',
          student_id_id:'',
          student_name:'',
          dept_id_id:'',
          dept_name: '',
        },
        //获取开课表数据
        queryOpenCourse:{
          staff_id_id: this.$store.getters.name,
          semester: this.$store.getters.semester
        },
        deleteForm: {
          staff_id: ''
        },
        currentPage: 1, // 当前页码
        total: 20, // 总条数
        pageSize: 5 // 每页的数据条数
      }
    },
    created() {
      this.fetchAllData()
    },
    methods: {
      async fetchAllData() {
      const responseOC = await fetchCoursesForTeacherSchedule(this.queryOpenCourse)
      this.openCourseListData = responseOC.data
      //返回：oc.id,oc.course_id_id,c.course_name,c.credit,c.credit_hours,oc.class_time
      if(this.openCourseListData.length!=0){
        this.query.open_course_id_id=this.openCourseListData[0].id
        this.tableTitle=this.openCourseListData[this.selectedopenCourseListData].course_name+'（'+this.openCourseListData[this.selectedopenCourseListData].course_id_id+' 上课时间：'+this.openCourseListData[this.selectedopenCourseListData].class_time+'）登分表'
      }
        
      
      const response = await fetchCoursesForScore(this.query)
      this.tableData = response.data
      //返回：cs.id as selectcourse_id,cs.normal_score,cs.test_score,cs.total_score,cs.open_course_id_id,s.name as student_name,cs.student_id_id,d.dept_name,s.dept_id_id

      this.listLoading = false
      },
      async fetchData(){
        this.query.open_course_id_id=this.openCourseListData[this.selectedopenCourseListData].id
        const response = await fetchCoursesForScore(this.query)
        this.tableData=response.data
        this.tableTitle=this.openCourseListData[this.selectedopenCourseListData].course_name+'（'+this.openCourseListData[this.selectedopenCourseListData].course_id_id+' 上课时间：'+this.openCourseListData[this.selectedopenCourseListData].class_time+'）登分表'
      },
      handleSave() {
        console.log(this.tableData)
        updateCourseSelection(this.tableData).then(response => {
          if (response) {
            console.log('in handleAdd', response)
            this.$message({ message: '登分成功', type: 'success' })
            this.fetchData()
          } else {
            this.$message.error('新增失败')
          }
        })
      },
      //把每一行的索引加到行数据中
      tableRowClassName({ row, rowIndex }) {
        row.index = rowIndex
        },
        //把每一列的索引加到列数据中
      tableCellClassName({ row, column, rowIndex, columnIndex }) {
        row.index=rowIndex
        column.index=columnIndex
     	 },
     	 //单元格被点击时会触发该事件
     	cellClick(row, column, cell, event) {
        //console.log(row, '单条数据', column, '列信息', cell, 'td实例', event)
          this.rowIndex = row.index
          this.columnIndex = column.index
          this.$nextTick(() => {
          console.log(this.$refs['editInput'])
          this.$refs['editInput'].focus()//没有没有自动聚焦效果的话可能是这里出现问题 需要打印出来看一下
              
        })
    },
      //输入框失去焦点事件（初始化中间变量）
    inputBlur(scope) {
      this.rowIndex = -1
      this.columnIndex = -1
    },
      // 每页条数改变时触发 选择一页显示多少行
      handleSizeChange(val) {
        console.log(`每页 ${val} 条`)
        this.currentPage = 1
        this.pageSize = val
      },
      // 当前页改变时触发 跳转其他页
      handleCurrentChange(val) {
        console.log(`当前页: ${val}`)
        this.currentPage = val
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
  
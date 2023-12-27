<!--院系表-->
<template>
    <div class="app-container">
      <h1>课程管理</h1>
      <el-row :gutter="20">
        <el-col :span="2"><span>课程号：</span></el-col>
        <el-col :span="4">
          <el-input v-model="query.course_id" autocomplete="off" size="small" />
        </el-col>
        <el-col :span="2"><span>课程名：</span></el-col>
        <el-col :span="4">
          <el-input v-model="query.course_name" autocomplete="off" size="small" />
        </el-col>
        <el-col :span="2"><span>院系号：</span></el-col>
        <el-col :span="4">
          <el-input v-model="query.dept_id_id" autocomplete="off" size="small" />
        </el-col>
        <el-col :span="2"><span>学分：</span></el-col>
        <el-col :span="4">
          <el-input v-model="query.credit" autocomplete="off" size="small" />
        </el-col>
      </el-row>
      <div align="right" style="margin-top: 10px;">
        <el-button type="primary" size="small" @click="fetchData()">查询课程</el-button>
        <el-button type="primary" size="small" @click="handleAdd()">新增课程</el-button>
      </div>
      <el-divider />
      <el-table
        v-loading="listLoading"
        :data="tableData.slice((currentPage-1)*pageSize,currentPage*pageSize)"
        element-loading-text="Loading"
        border
        fit
        highlight-current-row
      >
        <el-table-column align="center" label="序号">
          <template slot-scope="scope">
            {{ scope.$index+1+pageSize*(currentPage-1) }}
          </template>
        </el-table-column>
        <el-table-column align="center" label="课程号">
          <template slot-scope="scope">
            <span>{{ scope.row.course_id }}</span>
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
        <el-table-column label="课时" align="center">
          <template slot-scope="scope">
            <span>{{ scope.row.credit_hours }}</span>
          </template>
        </el-table-column>
        <el-table-column label="院系号" align="center">
          <template slot-scope="scope">
            <span>{{ scope.row.dept_id_id }}</span>
          </template>
        </el-table-column>
        <el-table-column label="平时成绩占比" align="center">
          <template slot-scope="scope">
            <span>{{ scope.row.normal_score_percent }}</span>
          </template>
        </el-table-column>
        <el-table-column label="操作" align="center">
          <template slot-scope="scope">
            <el-button
              size="mini"
              @click="handleEdit(scope.$index, scope.row)"
            >编辑</el-button>
            <el-button
              size="mini"
              type="danger"
              @click="handleDelete(scope.$index, scope.row)"
            >删除</el-button>
          </template>
        </el-table-column>
      </el-table>
      <el-pagination align='center' 
        @size-change="handleSizeChange" 
        @current-change="handleCurrentChange"
        :current-page="currentPage" 
        :page-sizes="[1,5,10,20]" 
        :page-size="pageSize" 
        layout="total, sizes, prev, pager, next, jumper" 
        :total="tableData.length">
      </el-pagination>
  
      <el-dialog title="新增课程" :visible.sync="addFormVisible">
        <el-form :model="addForm" label-width="200px" algin="left">
          <el-form-item label="课程号" label-width="25%">
            <el-input v-model="addForm.course_id" autocomplete="off" />
          </el-form-item>
          <el-form-item label="课程名" label-width="25%">
            <el-input v-model="addForm.course_name" autocomplete="off" />
          </el-form-item>
          <el-form-item label="学分" label-width="25%">
            <el-input v-model="addForm.credit" autocomplete="off" />
          </el-form-item>
          <el-form-item label="课时" label-width="25%">
            <el-input v-model="addForm.credit_hours" autocomplete="off" />
          </el-form-item>
          <el-form-item label="院系号" label-width="25%">
            <el-input v-model="addForm.dept_id_id" autocomplete="off" />
          </el-form-item>
          <el-form-item label="平时分占比" label-width="25%">
            <el-input v-model="addForm.normal_score_percent" autocomplete="off" />
          </el-form-item>
        </el-form>
        <div slot="footer" class="dialog-footer">
          <el-button @click="addFormVisible = false">取 消</el-button>
          <el-button type="primary" @click="saveAdd()">确 定</el-button>
        </div>
      </el-dialog>
  
      <el-dialog title="编辑课程" :visible.sync="editFormVisible">
        <el-form :model="editForm" label-width="200px" algin="left">
          <el-form-item label="课程号" label-width="25%">
            <el-input v-model="editForm.course_id" autocomplete="off" />
          </el-form-item>
          <el-form-item label="课程名" label-width="25%">
            <el-input v-model="editForm.course_name" autocomplete="off" />
          </el-form-item>
          <el-form-item label="学分" label-width="25%">
            <el-input v-model="editForm.credit" autocomplete="off" />
          </el-form-item>
          <el-form-item label="课时" label-width="25%">
            <el-input v-model="editForm.credit_hours" autocomplete="off" />
          </el-form-item>
          <el-form-item label="院系号" label-width="25%">
            <el-input v-model="editForm.dept_id_id" autocomplete="off" />
          </el-form-item>
          <el-form-item label="平时分占比" label-width="25%">
            <el-input v-model="editForm.normal_score_percent" autocomplete="off" />
          </el-form-item>
        </el-form>
        <div slot="footer" class="dialog-footer">
          <el-button @click="editFormVisible = false">取 消</el-button>
          <el-button type="primary" @click="saveEdit()">确 定</el-button>
        </div>
      </el-dialog>
    </div>
  </template>
  
  <script>
  import { addCourse, updateCourse, fetchCourse, deleteCourse } from '@/api/courseApi'
  export default {
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
        password: null,
        listLoading: true,
        tableData: [{
          course_id: '1234',
          course_name: '4',
          credit: 4,
          credit_hours: 40,
          dept_id_id: '',
          normal_score_percent: 0.5}
        ],
        addFormVisible: false,
        editFormVisible: false,
        editForm: {
          course_id: '',
          course_name: '',
          credit: 0,
          credit_hours: 0,
          dept_id_id: '',
          normal_score_percent: 0
        },
        addForm: {
          course_id: '',
          course_name: '',
          credit: 0,
          credit_hours: 0,
          dept_id_id: '',
          normal_score_percent: 0
        },
        query: {
          course_id: '',
          course_name: '',
          credit: 0,
          dept_id_id: '',
        },
        deleteForm: {
          course_id: ''
        },
        currentPage: 1,// 当前页码
        total: 20, // 总条数
        pageSize: 5 // 每页的数据条数
      }
    },
    created() {
      this.fetchData()
    },
    methods: {
      fetchData() {
        this.listLoading = true
        fetchCourse(this.query).then(response => {
          console.log('fetch返回的data', response)
          this.tableData = response.data
          console.log('更新tabledata', this.tableData)
          this.listLoading = false
        })
      },
      // 新增课程
      handleAdd() {
        this.addFormVisible = true
      },
      saveAdd() {
        console.log(this.addForm)
        addCourse(this.addForm).then(response => {
          if (response) {
            console.log('in handleAdd', response)
            this.$message({ message: '新增成功', type: 'success' })
            this.addFormVisible = false
            this.fetchData()
            this.addForm.course_id = ''
            this.addForm.course_name = ''
            this.addForm.credit = ''
            this.addForm.credit_hours = ''
            this.addForm.dept_id_id = ''
            this.addForm.normal_score_percent = ''
          } else {
            this.$message.error('新增失败')
          }
        })
      },
      // 编辑课程
      handleEdit(inex, row) {
        this.editFormVisible = true
        this.editForm.course_id = row.course_id
        this.editForm.course_name = row.course_name
        this.editForm.credit = row.credit
        this.editForm.credit_hours = row.credit_hours
        this.editForm.dept_id_id = row.dept_id_id
        this.editForm.normal_score_percent = row.normal_score_percent
      },
      saveEdit() {
        updateCourse(this.editForm).then(response => {
          if (response) {
            this.editFormVisible = false
            this.$message({ message: '修改成功', type: 'success' })
            console.log('in handleEdit', response)
            this.fetchData()
            this.editForm.course_id = ''
            this.editForm.course_name = ''
            this.editForm.credit = ''
            this.editForm.credit_hours = ''
            this.editForm.dept_id_id = ''
            this.editForm.normal_score_percent = ''
          } else {
            this.$message.error('修改失败')
          }
        })
      },
      // 删除课程
      handleDelete(inex, row) {
        this.deleteForm.course_id = row.course_id
        deleteCourse(this.deleteForm).then(response => {
          if (response) {
            this.$message({ message: '删除成功', type: 'success' })
            console.log('in handleDelete', response)
            this.fetchData()
            this.deleteForm.course_id = ''
          } else {
            this.$message.error('删除失败')
          }
        })
      },
      //每页条数改变时触发 选择一页显示多少行
      handleSizeChange(val) {
          console.log(`每页 ${val} 条`);
          this.currentPage = 1;
          this.pageSize = val;
      },
      //当前页改变时触发 跳转其他页
      handleCurrentChange(val) {
          console.log(`当前页: ${val}`);
          this.currentPage = val;
      }
    }
  }
  </script>
  
  <style>
  .boxes{
      width: 18%;
  }
  .buttons{
    box-align:right;
  }
  </style>
  
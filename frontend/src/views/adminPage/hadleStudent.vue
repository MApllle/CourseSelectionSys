<!--学生表-->
<template>
    <div class="app-container">
      <h1>学生管理</h1>
      <el-row :gutter="20">
        <el-col :span="2"><span>学号：</span></el-col>
        <el-col :span="4">
          <el-input v-model="query.student_id" autocomplete="off" size="small" />
        </el-col>
        <el-col :span="2"><span>性别：</span></el-col>
        <el-col :span="4">
          <el-input v-model="query.sex" autocomplete="off" size="small" />
        </el-col>
        <el-col :span="2"><span>姓名：</span></el-col>
        <el-col :span="4">
          <el-input v-model="query.name" autocomplete="off" size="small" />
        </el-col>
        <el-col :span="2"><span>出生地：</span></el-col>
        <el-col :span="4">
          <el-input v-model="query.native_place" autocomplete="off" size="small" />
        </el-col>
      </el-row>
      <el-row :gutter="20">
        <el-col :span="2"><span>院系号：</span></el-col>
        <el-col :span="4">
          <el-input v-model="query.dept_id_id" autocomplete="off" size="small" />
        </el-col>
      </el-row>
      <div align="right">
        <el-button type="primary" size="small" @click="fetchData()">查询学生</el-button>
        <el-button type="primary" size="small" @click="handleAdd()">新增学生</el-button>
      </div>
      <el-divider />
      <el-table
        v-loading="listLoading"
        :data="tableData"
        element-loading-text="Loading"
        border
        fit
        highlight-current-row
      >
        <el-table-column align="center" label="学号">
          <template slot-scope="scope">
            <span>{{ scope.row.student_id }}</span>
          </template>
        </el-table-column>
        <el-table-column label="姓名" align="center">
          <template slot-scope="scope">
            <span>{{ scope.row.name }}</span>
          </template>
        </el-table-column>
        <el-table-column label="性别" align="center">
          <template slot-scope="scope">
            <span>{{ scope.row.sex }}</span>
          </template>
        </el-table-column>
        <el-table-column label="出生日期" align="center">
          <template slot-scope="scope">
            <span>{{ scope.row.date_of_birth }}</span>
          </template>
        </el-table-column>
        <el-table-column label="出生地" align="center">
          <template slot-scope="scope">
            <span>{{ scope.row.native_place }}</span>
          </template>
        </el-table-column>
        <el-table-column label="手机号码" align="center">
          <template slot-scope="scope">
            <span>{{ scope.row.mobile_phone }}</span>
          </template>
        </el-table-column>
        <el-table-column label="平均绩点" align="center">
          <template slot-scope="scope">
            <span>{{ scope.row.average_gpa }}</span>
          </template>
        </el-table-column>
        <el-table-column label="总学分" align="center">
          <template slot-scope="scope">
            <span>{{ scope.row.total_credit }}</span>
          </template>
        </el-table-column>
        <el-table-column label="院系号" align="center">
          <template slot-scope="scope">
            <span>{{ scope.row.dept_id_id }}</span>
          </template>
        </el-table-column>
        <el-table-column label="操作" width="190" align="center">
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
  
      <el-dialog title="新增学生" :visible.sync="addFormVisible">
        <el-form :model="addForm" label-width="200px" algin="left">
          <el-form-item label="学号" label-width="25%">
            <el-input v-model="addForm.student_id" autocomplete="off" />
          </el-form-item>
          <el-form-item label="姓名" label-width="25%">
            <el-input v-model="addForm.name" autocomplete="off" />
          </el-form-item>
          <el-form-item label="性别" label-width="25%">
            <el-select v-model="addForm.sex" placeholder="选择性别">
              <el-option label="男" value="男" />
              <el-option label="女" value="女" />
            </el-select>
          </el-form-item>
          <el-form-item label="出生日期" label-width="25%">
            <el-date-picker
              v-model="addForm.date_of_birth"
              type="date"
              placeholder="选择日期"
              value-format="yyyy-MM-dd"
            />
          </el-form-item>
          <el-form-item label="出生地" label-width="25%">
            <el-input v-model="addForm.native_place" autocomplete="off" />
          </el-form-item>
          <el-form-item label="手机号码" label-width="25%">
            <el-input v-model="addForm.mobile_phone" autocomplete="off" />
          </el-form-item>
          <el-form-item label="平均绩点" label-width="25%">
            <el-input v-model="addForm.average_gpa" autocomplete="off" />
          </el-form-item>
          <el-form-item label="总学分" label-width="25%">
                <el-input v-model="addForm.total_credit" autocomplete="off" />
          </el-form-item>
          <el-form-item label="院系号" label-width="25%">
            <el-input v-model="addForm.dept_id_id" autocomplete="off" />
          </el-form-item>
        </el-form>
        <div slot="footer" class="dialog-footer">
          <el-button @click="addFormVisible = false">取 消</el-button>
          <el-button type="primary" @click="saveAdd()">确 定</el-button>
        </div>
      </el-dialog>
  
      <el-dialog title="编辑学生" :visible.sync="editFormVisible">
        <el-form :model="editForm" label-width="200px" algin="left">
          <el-form-item label="学号" label-width="25%">
            <el-input v-model="editForm.student_id" autocomplete="off" />
          </el-form-item>
          <el-form-item label="姓名" label-width="25%">
            <el-input v-model="editForm.name" autocomplete="off" />
          </el-form-item>
          <el-form-item label="性别" label-width="25%">
            <el-select v-model="editForm.sex" placeholder="选择性别">
              <el-option label="男" value="男" />
              <el-option label="女" value="女" />
            </el-select>
          </el-form-item>
          <el-form-item label="出生日期" label-width="25%">
            <el-date-picker
              v-model="editForm.date_of_birth"
              type="date"
              placeholder="选择日期"
              value-format="yyyy-MM-dd"
            />
          </el-form-item>
          <el-form-item label="出生地" label-width="25%">
            <el-input v-model="editForm.native_place" autocomplete="off" />
          </el-form-item>
          <el-form-item label="手机号码" label-width="25%">
            <el-input v-model="editForm.mobile_phone" autocomplete="off" />
          </el-form-item>
          <el-form-item label="平均绩点" label-width="25%">
            <el-input v-model="editForm.average_gpa" autocomplete="off" />
          </el-form-item>
          <el-form-item label="总学分" label-width="25%">
            <el-input v-model="editForm.total_credit" autocomplete="off" />
          </el-form-item>
          <el-form-item label="院系号" label-width="25%">
            <el-input v-model="editForm.dept_id_id" autocomplete="off" />
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
  import { addStudent, updateStudent, fetchStudent, deleteStudent } from '@/api/studentApi'
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
          student_id: '1234',
          name: '4',
          sex: '123',
          date_of_birth: '1212-12-12',
          native_place: '123',
          mobile_phone: '123',
          average_gpa: 100,
          total_credit: 100,
          dept_id_id: '' }
        ],
        addFormVisible: false,
        editFormVisible: false,
        editForm: {
          student_id: '',
          name: '',
          sex: '',
          date_of_birth: '',
          native_place: '',
          mobile_phone: '',
          average_gpa: 0,
          total_credit: 0,
          dept_id_id: ''
        },
        addForm: {
          student_id: '',
          name: '',
          sex: '',
          date_of_birth: '',
          native_place: '',
          mobile_phone: '',
          average_gpa: 0,
          total_credit: 0,
          dept_id_id: ''
        },
        query: {
          student_id: '',
          name: '',
          sex: '',
          date_of_birth: '',
          native_place: '',
          dept_id_id: ''
        },
        deleteForm: {
          student_id: ''
        }
      }
    },
    created() {
      this.fetchData()
    },
    methods: {
      fetchData() {
        this.listLoading = true
        fetchStudent(this.query).then(response => {
          console.log('fetch返回的data', response)
          this.tableData = response.data
          console.log('更新tabledata', this.tableData)
          this.listLoading = false
        })
      },
      // 新增用户
      handleAdd() {
        this.addFormVisible = true
      },
      saveAdd() {
        console.log("新增",this.addForm)
        addStudent(this.addForm).then(response => {
          if (response) {
            console.log('in handleAdd', response)
            this.$message({ message: '新增成功', type: 'success' })
            this.addFormVisible = false
            this.fetchData()
            this.addForm.student_id = ''
            this.addForm.name = ''
            this.addForm.sex = ''
            this.addForm.date_of_birth = ''
            this.addForm.native_place = ''
            this.addForm.mobile_phone = ''
            this.addForm.average_gpa = 0
            this.addForm.total_credit = 0
            this.addForm.dept_id_id = ''
          } else {
            this.$message.error('新增失败')
          }
        })
      },
      // 编辑用户
      handleEdit(inex, row) {
        this.editFormVisible = true
        this.editForm.student_id = row.student_id
        this.editForm.name = row.name
        this.editForm.sex = row.sex
        this.editForm.date_of_birth = row.date_of_birth
        this.editForm.native_place = row.native_place
        this.editForm.mobile_phone = row.mobile_phone
        this.editForm.average_gpa = row.average_gpa
        this.editForm.total_credit = row.total_credit
        this.editForm.dept_id_id = row.dept_id_id
      },
      saveEdit() {
        updateStudent(this.editForm).then(response => {
          if (response) {
            this.editFormVisible = false
            this.$message({ message: '修改成功', type: 'success' })
            console.log('in handleEdit', response)
            this.fetchData()
            this.editForm.student_id = ''
            this.editForm.name = ''
            this.editForm.sex = ''
            this.editForm.date_of_birth = ''
            this.editForm.mobile_phone = ''
            this.editForm.average_gpa = 0
            this.editForm.total_credit = 0
            this.editForm.dept_id_id = ''
          } else {
            this.$message.error('修改失败')
          }
        })
      },
      // 删除用户
      handleDelete(inex, row) {
        this.deleteForm.student_id = row.student_id
        deleteStudent(this.deleteForm).then(response => {
          if (response) {
            this.$message({ message: '删除成功', type: 'success' })
            console.log('in handleDelete', response)
            this.fetchData()
            this.deleteForm.student_id = ''
          } else {
            this.$message.error('删除失败')
          }
        })
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
  
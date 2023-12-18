<!--选课页面-->
<template>
    <div class="app-container">
        <h1>账户管理</h1>
        <div class="buttons">
            <el-button type="primary" size="small" @click="dialogFormVisible = true">查询用户</el-button>
            <el-button type="primary" size="small" @click="dialogFormVisible = true">新建用户</el-button>
        </div>
        <el-divider></el-divider>
      <el-table
        v-loading="listLoading"
        :data="tableData"
        element-loading-text="Loading"
        height="250"
        border
        fit
        highlight-current-row
      >
        <el-table-column align="center" label="账号类型" width="95">
          <template slot-scope="scope">
            {{ scope.row.group }}
          </template>
        </el-table-column>
        <el-table-column align="center" label="账号" width="95">
          <template slot-scope="scope">
            {{ scope.row.id }}
          </template>
        </el-table-column>
        <el-table-column label="密码" width="110" align="center">
          <template slot-scope="scope">
            <span>******</span>
          </template>
        </el-table-column>
        <el-table-column label="姓名" width="110" align="center">
          <template slot-scope="scope">
            <span>{{ scope.row.username }}</span>
          </template>
        </el-table-column>
        <el-table-column label="操作">
          <template slot-scope="scope">
            <el-button
              size="mini"
              @click="handleEdit(scope.$index, scope.row)">编辑</el-button>
            <el-button
              size="mini"
              type="danger"
              @click="handleDelete(scope.$index, scope.row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
          <!--新增用户对话框-->
      <el-dialog title="新增用户" :visible.sync="dialogFormVisible">
        <el-form :model="inputForm">
          <el-form-item label="账号类型" :label-width="formLabelWidth">
            <el-select v-model="inputForm.group" placeholder="选择账号类型">
              <el-option label="学生" value="学生"></el-option>
              <el-option label="教师" value="教师"></el-option>
              <el-option label="管理员" value="管理员"></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="账号" :label-width="formLabelWidth">
            <el-input v-model="inputForm.id" autocomplete="off"></el-input>
          </el-form-item>
          <el-form-item label="密码" :label-width="formLabelWidth">
            <el-input v-model="inputForm.password" autocomplete="off"></el-input>
          </el-form-item>
        </el-form>
        <div slot="footer" class="dialog-footer">
          <el-button @click="addFormVisible = false">取 消</el-button>
          <el-button type="primary" @click="hadleAdd()">确 定</el-button>
        </div>
      </el-dialog>
      <el-dialog title="编辑用户" :visible.sync="dialogFormVisible">
        <el-form :model="inputForm">
          <el-form-item label="账号类型" :label-width="formLabelWidth">
            <el-select v-model="inputForm.group" placeholder="选择账号类型">
              <el-option label="学生" value="学生"></el-option>
              <el-option label="教师" value="教师"></el-option>
              <el-option label="管理员" value="管理员"></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="账号" :label-width="formLabelWidth">
            <el-input v-model="inputForm.id" autocomplete="off"></el-input>
          </el-form-item>
          <el-form-item label="密码" :label-width="formLabelWidth">
            <el-input v-model="inputForm.password" autocomplete="off"></el-input>
          </el-form-item>
        </el-form>
        <div slot="footer" class="dialog-footer">
          <el-button @click="editFormVisible = false">取 消</el-button>
          <el-button type="primary" @click="hadleEdit()">确 定</el-button>
        </div>
      </el-dialog>
    </div>
  </template>
  
  <script>
  import { getList } from '@/api/table'
  import { addUser, updateUser, fetchUser, deleteUser } from '@/api/adminApi'
  import { sha256 } from 'js-sha256'
  
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
        password:null,
        listLoading: true,
        tableData:[
          {group:"学生",id:"4",password:'123',username:'学生4'}
        ],
        addFormVisible:false,
        editFormVisible:false,
        inputForm:{
          group: '学生',  //用户类型
          id: '', //账号
          password:'', //密码
          username:''
        },
        editForm: {
          group: '学生',  //用户类型
          id: '', //账号
          password:'', //密码
          username:''
        },
        addForm: {
          group: '学生',  //用户类型
          id: '', //账号
          password:'', //密码
          username:''
        },

      }
    },
    created() {
      this.fetchData()
    },
    methods: {
      fetchData() {
        this.listLoading = true
        getList().then(response => {
          this.list = response.data.items
          this.listLoading = false
        })
      },
      //新增用户
      async hadleAdd(){
        this.form.password= await sha256(this.password)
        console.log(this.form)
        addUser(this.form).then(response=>{
          console.log("tttttttttttest",response)
        })
      }
      //编辑用户
      //删除用户
    }
  }
  </script>
  
<style>
.boxes{
    width: 18%;
}
</style>
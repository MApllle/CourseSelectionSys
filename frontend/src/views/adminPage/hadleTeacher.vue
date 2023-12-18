<!--教师表-->
<template>
    <div class="app-container">
        <h1>教师管理</h1>
        <el-row :gutter="20">
          <el-col :span="2"><span>工号：</span></el-col>
          <el-col :span="4">
              <el-input v-model="query.staff_id" autocomplete="off" size="small"></el-input>
          </el-col>
          <el-col :span="2"><span>性别：</span></el-col>
          <el-col :span="4">
            <el-input v-model="query.sex" autocomplete="off" size="small"></el-input>
          </el-col>
          <el-col :span="2"><span>姓名：</span></el-col>
          <el-col :span="4">
            <el-input v-model="query.name" autocomplete="off" size="small"></el-input>
          </el-col>
          <el-col :span="2"><span>职称：</span></el-col>
          <el-col :span="4">
            <el-input v-model="query.professional_ranks" autocomplete="off" size="small"></el-input>
          </el-col>
        </el-row>
        <el-row :gutter="20">
          <el-col :span="2"><span>院系号：</span></el-col>
          <el-col :span="4">
            <el-input v-model="query.dept_id_id" autocomplete="off" size="small"></el-input>
          </el-col>
        </el-row>
        <div align="right">
            <el-button type="primary" size="small" @click="fetchData()">查询教师</el-button>
            <el-button type="primary" size="small" @click="handleAdd()">新增教师</el-button>
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
        <el-table-column align="center" label="工号">
          <template slot-scope="scope">
            <span>{{ scope.row.staff_id }}</span>
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
        <el-table-column label="职称" align="center">
          <template slot-scope="scope">
            <span>{{ scope.row.professional_ranks }}</span>
          </template>
        </el-table-column>
        <el-table-column label="薪资(元)" align="center">
          <template slot-scope="scope">
            <span>{{ scope.row.salary }}</span>
          </template>
        </el-table-column>
        <el-table-column label="院系号" align="center">
          <template slot-scope="scope">
            <span>{{ scope.row.dept_id_id }}</span>
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
      
      <el-dialog title="新增教师" :visible.sync="addFormVisible">
        <el-form :model="addForm" label-width="200px" algin="left">
          <el-form-item label="工号" label-width="25%">
            <el-input v-model="addForm.staff_id" autocomplete="off"></el-input>
          </el-form-item>
          <el-form-item label="姓名" label-width="25%">
            <el-input v-model="addForm.name" autocomplete="off"></el-input>
          </el-form-item>
          <el-form-item label="姓名" label-width="25%">
            <el-select v-model="addForm.sex" placeholder="选择性别">
              <el-option label="男" value="男"></el-option>
              <el-option label="女" value="女"></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="出生日期" label-width="25%">
            <el-date-picker
              v-model="addForm.date_of_birth"
              type="date"
              placeholder="选择日期"
              value-format="yyyy-MM-dd">
            </el-date-picker>
          </el-form-item>
          <el-form-item label="职称" label-width="25%">
            <el-input v-model="addForm.professional_ranks" autocomplete="off"></el-input>
          </el-form-item>
          <el-form-item label="薪资" label-width="25%">
            <el-input v-model="addForm.salary" autocomplete="off"></el-input>
          </el-form-item>
          <el-form-item label="院系号" label-width="25%">
            <el-input v-model="addForm.dept_id_id" autocomplete="off"></el-input>
          </el-form-item>
        </el-form>
        <div slot="footer" class="dialog-footer">
          <el-button @click="addFormVisible = false">取 消</el-button>
          <el-button type="primary" @click="saveAdd()">确 定</el-button>
        </div>
      </el-dialog>

      <el-dialog title="编辑教师" :visible.sync="editFormVisible">
        <el-form :model="editForm" label-width="200px" algin="left">
          <el-form-item label="工号" label-width="25%">
            <el-input v-model="editForm.staff_id" autocomplete="off"></el-input>
          </el-form-item>
          <el-form-item label="姓名" label-width="25%">
            <el-input v-model="editForm.name" autocomplete="off"></el-input>
          </el-form-item>
          <el-form-item label="姓名" label-width="25%">
            <el-select v-model="editForm.sex" placeholder="选择性别">
              <el-option label="男" value="男"></el-option>
              <el-option label="女" value="女"></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="出生日期" label-width="25%">
            <el-date-picker
              v-model="editForm.date_of_birth"
              type="date"
              placeholder="选择日期"
              value-format="yyyy-MM-dd">
            </el-date-picker>
          </el-form-item>
          <el-form-item label="职称" label-width="25%">
            <el-input v-model="editForm.professional_ranks" autocomplete="off"></el-input>
          </el-form-item>
          <el-form-item label="薪资" label-width="25%">
            <el-input v-model="editForm.salary" autocomplete="off"></el-input>
          </el-form-item>
          <el-form-item label="院系号" label-width="25%">
            <el-input v-model="editForm.dept_id_id" autocomplete="off"></el-input>
          </el-form-item>
        </el-form>
        <div slot="footer" class="dialog-footer">
          <el-button @click="addFormVisible = false">取 消</el-button>
          <el-button type="primary" @click="saveEdit()">确 定</el-button>
        </div>
      </el-dialog>
    </div>
  </template>
  
  <script>
  import { addTeacher, updateTeacher, fetchTeacher, deleteTeacher } from '@/api/teacherApi'
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
        tableData:[{
            staff_id:"1234",
            name:"4",
            sex:'123',
            date_of_birth:'1212-12-12',
            professional_ranks:'123',
            salary:100,
            dept_id_id:''}
        ],
        addFormVisible:false,
        editFormVisible:false,
        editForm: {
            staff_id:'',
            name:'',
            sex:'',
            date_of_birth:'',
            professional_ranks:'',
            salary:0,
            dept_id_id:''
        },
        addForm: {
            staff_id:'',
            name:'',
            sex:'',
            date_of_birth:'',
            professional_ranks:'',
            salary:0,
            dept_id_id:''
        },
        query:{
            staff_id:'',
            name:'',
            sex:'',
            professional_ranks:'',
            dept_id_id:''
        },
        deleteForm:{
            staff_id:'',
        }
      }
    },
    created() {
      this.fetchData()
    },
    methods: {
      fetchData() {
        this.listLoading = true
        fetchTeacher(this.query).then(response => {
          console.log("fetch返回的data",response)
          this.tableData = response.data
          console.log("更新tabledata",this.tableData)
          this.listLoading = false
        })
      },
      //新增用户
      handleAdd(){
        this.addFormVisible=true
      },
      saveAdd(){
        console.log(this.addForm)
        addTeacher(this.addForm).then(response=>{
            if(response){
                console.log("in handleAdd",response)
                this.$message({message:'新增成功',type:'success'});
                this.addFormVisible=false
                this.fetchData()
                this.addForm.staff_id=''
                this.addForm.name=''
                this.addForm.sex=''
                this.addForm.date_of_birth=''
                this.addForm.salary=''
                this.addForm.dept_id_id=''
            }
            else{
            this.$message.error('新增失败');
          }

        })
      },
      //编辑用户
      handleEdit(inex,row){
        this.editFormVisible = true
        this.editForm.staff_id=row.staff_id
        this.editForm.name=row.name
        this.editForm.sex=row.sex
        this.editForm.date_of_birth=row.date_of_birth
        this.editForm.salary=row.salary
        this.editForm.dept_id_id=row.dept_id_id
      },
      saveEdit(){
        updateTeacher(this.editForm).then( response=>{
          if(response){
            this.editFormVisible = false
            this.$message({message:'修改成功',type:'success'});
            console.log("in handleEdit",response)
            this.fetchData()
            this.editForm.staff_id=''
            this.editForm.name=''
            this.editForm.sex=''
            this.editForm.date_of_birth=''
            this.editForm.salary=''
            this.editForm.dept_id_id=''
          }
          else{
            this.$message.error('修改失败');
          }
        })
      },
      //删除用户
      handleDelete(inex,row){
        this.deleteForm.staff_id=row.staff_id
        deleteTeacher(this.deleteForm).then( response=>{
          if(response){
            this.$message({message:'删除成功',type:'success'});
            console.log("in handleDelete",response)
            this.fetchData()
            this.deleteForm.staff_id=''
          }
          else{
            this.$message.error('删除失败');
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
<!--院系表-->
<template>
  <div class="app-container">
    <h1>院系管理</h1>
    <div align="right">
      <el-button type="primary" size="small" @click="fetchData()">查询院系</el-button>
      <el-button type="primary" size="small" @click="handleAdd()">新增院系</el-button>
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
      <el-table-column align="center" label="院系号">
        <template slot-scope="scope">
          <span>{{ scope.row.dept_id }}</span>
        </template>
      </el-table-column>
      <el-table-column label="学院名" align="center">
        <template slot-scope="scope">
          <span>{{ scope.row.dept_name }}</span>
        </template>
      </el-table-column>
      <el-table-column label="地址" align="center">
        <template slot-scope="scope">
          <span>{{ scope.row.address }}</span>
        </template>
      </el-table-column>
      <el-table-column label="联系电话" align="center">
        <template slot-scope="scope">
          <span>{{ scope.row.phone_code }}</span>
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

    <el-dialog title="新增学院" :visible.sync="addFormVisible">
      <el-form :model="addForm" label-width="200px" algin="left">
        <el-form-item label="院系号" label-width="25%">
          <el-input v-model="addForm.staff_id" autocomplete="off" />
        </el-form-item>
        <el-form-item label="学院名" label-width="25%">
          <el-input v-model="addForm.name" autocomplete="off" />
        </el-form-item>
        <el-form-item label="联系电话" label-width="25%">
          <el-input v-model="addForm.professional_ranks" autocomplete="off" />
        </el-form-item>
        <el-form-item label="薪资" label-width="25%">
          <el-input v-model="addForm.salary" autocomplete="off" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="addFormVisible = false">取 消</el-button>
        <el-button type="primary" @click="saveAdd()">确 定</el-button>
      </div>
    </el-dialog>

    <el-dialog title="编辑学院" :visible.sync="editFormVisible">
      <el-form :model="editForm" label-width="200px" algin="left">
        <el-form-item label="院系号" label-width="25%">
          <el-input v-model="editForm.staff_id" autocomplete="off" />
        </el-form-item>
        <el-form-item label="学院名" label-width="25%">
          <el-input v-model="editForm.name" autocomplete="off" />
        </el-form-item>
        <el-form-item label="联系电话" label-width="25%">
          <el-input v-model="editForm.professional_ranks" autocomplete="off" />
        </el-form-item>
        <el-form-item label="薪资" label-width="25%">
          <el-input v-model="editForm.salary" autocomplete="off" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="editFormVisible = false">取 消</el-button>
        <el-button type="primary" @click="saveAdd()">确 定</el-button>
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
      password: null,
      listLoading: true,
      tableData: [{
        dept_id: '1234',
        dept_name: '4',
        address: '123',
        phone_code: '11111111111' }
      ],
      addFormVisible: false,
      editFormVisible: false,
      editForm: {
        dept_id: '',
        dept_name: '',
        address: '',
        phone_code: ''
      },
      addForm: {
        dept_id: '',
        dept_name: '',
        address: '',
        phone_code: ''
      },
      query: {
        dept_id: '',
        dept_name: '',
        address: '',
        phone_code: ''
      },
      deleteForm: {
        staff_id: ''
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
      console.log(this.addForm)
      addTeacher(this.addForm).then(response => {
        if (response) {
          console.log('in handleAdd', response)
          this.$message({ message: '新增成功', type: 'success' })
          this.addFormVisible = false
          this.fetchData()
          this.addForm.staff_id = ''
          this.addForm.name = ''
          this.addForm.sex = ''
          this.addForm.date_of_birth = ''
          this.addForm.salary = ''
          this.addForm.dept_id_id = ''
        } else {
          this.$message.error('新增失败')
        }
      })
    },
    // 编辑用户
    handleEdit(inex, row) {
      this.editFormVisible = true
      this.editForm.staff_id = row.staff_id
      this.editForm.name = row.name
      this.editForm.sex = row.sex
      this.editForm.date_of_birth = row.date_of_birth
      this.editForm.salary = row.salary
      this.editForm.dept_id_id = row.dept_id_id
    },
    saveEdit() {
      updateTeacher(this.editForm).then(response => {
        if (response) {
          this.editFormVisible = false
          this.$message({ message: '修改成功', type: 'success' })
          console.log('in handleEdit', response)
          this.fetchData()
          this.editForm.staff_id = ''
          this.editForm.name = ''
          this.editForm.sex = ''
          this.editForm.date_of_birth = ''
          this.editForm.salary = ''
          this.editForm.dept_id_id = ''
        } else {
          this.$message.error('修改失败')
        }
      })
    },
    // 删除用户
    handleDelete(inex, row) {
      this.deleteForm.staff_id = row.staff_id
      deleteTeacher(this.deleteForm).then(response => {
        if (response) {
          this.$message({ message: '删除成功', type: 'success' })
          console.log('in handleDelete', response)
          this.fetchData()
          this.deleteForm.staff_id = ''
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
.buttons{
  align:right;
}
</style>

<!--院系表-->
<template>
  <div class="app-container">
    <h1>院系管理</h1>
    <el-row :gutter="20">
      <el-col :span="2"><span>院系号：</span></el-col>
      <el-col :span="4">
        <el-input v-model="query.dept_id" autocomplete="off" size="small" />
      </el-col>
      <el-col :span="2"><span>学院名：</span></el-col>
      <el-col :span="4">
        <el-input v-model="query.dept_name" autocomplete="off" size="small" />
      </el-col>
    </el-row>
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
          <el-input v-model="addForm.dept_id" autocomplete="off" />
        </el-form-item>
        <el-form-item label="学院名" label-width="25%">
          <el-input v-model="addForm.dept_name" autocomplete="off" />
        </el-form-item>
        <el-form-item label="联系电话" label-width="25%">
          <el-input v-model="addForm.phone_code" autocomplete="off" />
        </el-form-item>
        <el-form-item label="地址" label-width="25%">
          <el-input v-model="addForm.address" autocomplete="off" />
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
          <el-input v-model="editForm.dept_id" autocomplete="off" />
        </el-form-item>
        <el-form-item label="学院名" label-width="25%">
          <el-input v-model="editForm.dept_name" autocomplete="off" />
        </el-form-item>
        <el-form-item label="联系电话" label-width="25%">
          <el-input v-model="editForm.phone_code" autocomplete="off" />
        </el-form-item>
        <el-form-item label="地址" label-width="25%">
          <el-input v-model="editForm.address" autocomplete="off" />
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
import { addDepartment, updateDepartment, fetchDepartment, deleteDepartment } from '@/api/departmentApi'
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
        dept_id: ''
      }
    }
  },
  created() {
    this.fetchData()
  },
  methods: {
    fetchData() {
      this.listLoading = true
      fetchDepartment(this.query).then(response => {
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
      addDepartment(this.addForm).then(response => {
        if (response) {
          console.log('in handleAdd', response)
          this.$message({ message: '新增成功', type: 'success' })
          this.addFormVisible = false
          this.fetchData()
          this.addForm.dept_id = ''
          this.addForm.dept_name = ''
          this.addForm.address = ''
          this.addForm.phone_code = ''
        } else {
          this.$message.error('新增失败')
        }
      })
    },
    // 编辑用户
    handleEdit(inex, row) {
      this.editFormVisible = true
      this.editForm.dept_id = row.dept_id
      this.editForm.dept_name = row.dept_name
      this.editForm.address = row.address
      this.editForm.phone_code = row.phone_code
    },
    saveEdit() {
      updateDepartment(this.editForm).then(response => {
        if (response) {
          this.editFormVisible = false
          this.$message({ message: '修改成功', type: 'success' })
          console.log('in handleEdit', response)
          this.fetchData()
          this.editForm.dept_id = ''
          this.editForm.dept_name = ''
          this.editForm.address = ''
          this.editForm.phone_code = ''
        } else {
          this.$message.error('修改失败')
        }
      })
    },
    // 删除用户
    handleDelete(inex, row) {
      this.deleteForm.dept_id = row.dept_id
      deleteDepartment(this.deleteForm).then(response => {
        if (response) {
          this.$message({ message: '删除成功', type: 'success' })
          console.log('in handleDelete', response)
          this.fetchData()
          this.deleteForm.dept_id = ''
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
  box-align:right;
}
</style>

<!--账户管理-->
<template>
  <div class="app-container">
    <h1>账户管理</h1>
    <el-row :gutter="20">
      <el-col :span="2"><span>账户类型：</span></el-col>
      <el-col :span="4">
        <el-input v-model="query.group" autocomplete="off" size="small" />
      </el-col>
      <el-col :span="2"><span>账号：</span></el-col>
      <el-col :span="4">
        <el-input v-model="query.username" autocomplete="off" size="small" />
      </el-col>
    </el-row>
    <div align="right">
      <el-button type="primary" size="small" @click="fetchData()">查询用户</el-button>
      <el-button type="primary" size="small" @click="handleAdd()">新建用户</el-button>
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
      <el-table-column align="center" label="账号类型">
        <template slot-scope="scope">
          {{ scope.row.group }}
        </template>
      </el-table-column>
      <el-table-column label="账号" align="center">
        <template slot-scope="scope">
          <span>{{ scope.row.username }}</span>
        </template>
      </el-table-column>
      <el-table-column label="密码" align="center">
        <template slot-scope="scope">
          <span>******</span>
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
    <!--新增用户对话框-->
    <el-dialog title="新增用户" :visible.sync="addFormVisible">
      <el-form :model="addForm" label-width="200px" algin="left">
        <el-form-item label="账号类型" label-width="20%">
          <el-input v-model="addForm.group" autocomplete="off" />
        </el-form-item>
        <el-form-item label="账号" label-width="20%">
          <el-input v-model="addForm.username" autocomplete="off" />
        </el-form-item>
        <el-form-item prop="password" label="密码" label-width="20%">
          <el-input
            :key="passwordType"
            ref="password"
            v-model="inputPsw"
            :type="passwordType"
            name="password"
            tabindex="2"
            auto-complete="on"
          />
          <span class="show-pwd" @click="showPwd">
            <svg-icon :icon-class="passwordType === 'password' ? 'eye' : 'eye-open'" />
          </span>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="addFormVisible = false">取 消</el-button>
        <el-button type="primary" @click="saveAdd()">确 定</el-button>
      </div>
    </el-dialog>

    <el-dialog title="编辑用户" :visible.sync="editFormVisible">
      <el-form :model="editForm" label-width="200px" algin="left">
        <el-form-item label="账号类型" label-width="20%">
          <el-input v-model="editForm.group" autocomplete="off" :disabled="true" />
        </el-form-item>
        <el-form-item label="账号" label-width="20%">
          <el-input v-model="editForm.username" autocomplete="off" :disabled="true" />
        </el-form-item>
        <el-form-item prop="password" label="密码" label-width="20%">
          <el-input
            :key="passwordType"
            ref="password"
            v-model="inputPsw"
            :type="passwordType"
            name="password"
            tabindex="2"
            auto-complete="on"
          />
          <span class="show-pwd" @click="showPwd">
            <svg-icon :icon-class="passwordType === 'password' ? 'eye' : 'eye-open'" />
          </span>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="editFormVisible = false">取 消</el-button>
        <el-button type="primary" @click="saveEdit()">确 定</el-button>
      </div>
    </el-dialog>
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
import { addUser, updateUser, fetchUser, deleteUser } from '@/api/adminApi'
import { sha256 } from 'js-sha256'
import { mapGetters } from 'vuex'
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
  computed: {
    ...mapGetters([
      'group',
      'semester'
    ])
  },
  data() {
    return {
      passwordType: 'password', // 控制是否显示密码
      password: null,
      listLoading: true,
      tableData: [ // 返回数据：id username，group 密码是假的
        { id: '4', password: '123', username: '学生4', group: '' }
      ],
      addFormVisible: false,
      editFormVisible: false,
      confirmDeleteDialogVisible: false,
      editForm: {
        id: '', // 账号
        password: '', // 密码
        username: '', // 账号
        group: ''
      },
      addForm: {
        id: '', // 账号
        password: '', // 密码
        username: '', // 账号
        group: ''
      },
      deleteForm: {
        id: ''
      },
      query: {
        username: '',
        group: ''
      },
      inputPsw: null,
      currentPage: 1, // 当前页码
      total: 20, // 总条数
      pageSize: 5 // 每页的数据条数
    }
  },
  created() {
    this.fetchData()
  },
  methods: {
    // 显示/隐藏密码
    showPwd() {
      if (this.passwordType === 'password') {
        this.passwordType = ''
      } else {
        this.passwordType = 'password'
      }
      this.$nextTick(() => {
        this.$refs.password.focus()
      })
    },
    fetchData() {
      this.listLoading = true
      fetchUser(this.query).then(response => {
        console.log('fetch返回的data', response)
        this.tableData = response.data
        console.log('更新tabledata', this.tableData)
        this.listLoading = false
      })
    },
    // 新增用户
    handleAdd() {
      this.addFormVisible = true
      this.addForm.id = ''
      this.addForm.password = ''
      this.addForm.username = ''
      this.addForm.group = ''
      this.inputPsw = ''
    },
    async saveAdd() {
      console.log('pswbefore hash:', this.inputPsw || 'nopsw')
      this.addForm.password = await sha256(this.inputPsw)
      console.log('in saveADD', this.addForm)
      addUser(this.addForm).then(response => {
        if (response) {
          this.addFormVisible = false
          this.$message({ message: '新增成功', type: 'success' })
          console.log('in handleADD', response)
          this.fetchData()
          this.addForm.id = ''
          this.addForm.password = ''
          this.addForm.username = ''
          this.addForm.group = ''
          this.inputPsw = ''
        } else {
          this.$message.error('新增失败')
        }
      })
    },
    // 编辑用户
    handleEdit(inex, row) {
      this.editFormVisible = true
      this.editForm.id = row.id
      this.editForm.username = row.username
      this.editForm.group = row.group
    },
    async saveEdit() {
      console.log('pswbefore hash:', this.inputPsw || 'nopsw')
      this.editForm.password = await sha256(this.inputPsw)
      updateUser(this.editForm).then(response => {
        if (response) {
          this.editFormVisible = false
          this.$message({ message: '修改成功', type: 'success' })
          console.log('in handleEdit', response)
          this.fetchData()
          this.editForm.id = ''
          this.editForm.password = ''
          this.editForm.username = ''
          this.inputPsw = ''
        } else {
          this.$message.error('修改失败')
        }
      })
    },
    // 删除用户
    handleDelete(inex, row) {
      this.deleteForm.id = row.id
      if(row.username===this.$store.getters.name)
        this.$message.error('管理员无法删除自己！')
      else this.confirmDeleteDialogVisible = true
    },
    // 确认删除
    confirmDelete() {
      deleteUser(this.deleteForm).then(response => {
        if (response) {
          this.$message({ message: '删除成功', type: 'success' })
          console.log('in handleDelete', response)
          this.fetchData()
          this.deleteForm.id = ''
          this.confirmDeleteDialogVisible = false
        } else {
          this.$message.error('删除失败')
        }
      })
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
</style>

<!--开课管理-->
<template>
  <div class="app-container">
    <h1>开课管理</h1>
    <el-row :gutter="20">
      <el-col :span="2"><span>学期：</span></el-col>
      <el-col :span="4">
        <el-input v-model="query.semester" autocomplete="off" size="small" />
      </el-col>
      <el-col :span="2"><span>开课时间：</span></el-col>
      <el-col :span="4">
        <el-input v-model="query.class_time" autocomplete="off" size="small" />
      </el-col>
      <el-col :span="2"><span>课程号：</span></el-col>
      <el-col :span="4">
        <el-input v-model="query.course_id_id" autocomplete="off" size="small" />
      </el-col>
      <el-col :span="2"><span>教师号：</span></el-col>
      <el-col :span="4">
        <el-input v-model="query.staff_id_id" autocomplete="off" size="small" />
      </el-col>
      <el-col :span="2"><span>容量：</span></el-col>
      <el-col :span="4">
        <el-input v-model="query.capacity" autocomplete="off" size="small" />
      </el-col>
    </el-row>
    <!-- <el-row :gutter="20">
        <el-col :span="2"><span>已选容量：</span></el-col>
        <el-col :span="4">
          <el-input v-model="query.used_capacity" autocomplete="off" size="small" />
        </el-col>
      </el-row> -->
    <div align="right">
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
      <el-table-column label="学期" align="center">
        <template slot-scope="scope">
          <span>{{ scope.row.semester }}</span>
        </template>
      </el-table-column>
      <el-table-column label="开课时间" align="center">
        <template slot-scope="scope">
          <span>{{ scope.row.class_time }}</span>
        </template>
      </el-table-column>
      <el-table-column label="课程号" align="center">
        <template slot-scope="scope">
          <span>{{ scope.row.course_id_id }}</span>
        </template>
      </el-table-column>
      <el-table-column label="教师号" align="center">
        <template slot-scope="scope">
          <span>{{ scope.row.staff_id_id }}</span>
        </template>
      </el-table-column>
      <el-table-column label="课程容量" align="center">
        <template slot-scope="scope">
          <span>{{ scope.row.capacity }}</span>
        </template>
      </el-table-column>
      <el-table-column label="已选人数" align="center">
        <template slot-scope="scope">
          <span>{{ scope.row.used_capacity }}</span>
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

    <el-dialog title="新增课程" :visible.sync="addFormVisible">
      <el-form :model="addForm" label-width="200px" algin="left">
        <el-form-item label="课程号" label-width="25%">
          <el-select v-model="addForm.course_id_id" filterable>
          <el-option
              v-for="(item,index) in courseList"
              :key="index"
              :label="`${item.course_name} (${item.course_id})`"
              :value="item.course_id">
            <span style="float: left">{{ item.course_name }}({{ item.course_id }})</span>
          </el-option>
        </el-select>
        </el-form-item>
        <el-form-item label="开课时间" label-width="25%">
          <el-input v-model="addForm.class_time" autocomplete="off" />
        </el-form-item>
        <el-form-item label="学期" label-width="25%">
          <el-select v-model="addForm.semester" placeholder="选择学期">
            <el-option
            v-for="item in semesterList"
            :key="item.semester"
            :label="item.semester"
            :value="item.semester"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="教师号" label-width="25%">
          <el-input v-model="addForm.staff_id_id" autocomplete="off" />
        </el-form-item>
        <el-form-item label="容量" label-width="25%">
          <el-input v-model="addForm.capacity" autocomplete="off" />
        </el-form-item>
        <el-form-item label="已选人数" label-width="25%">
          <el-input v-model="addForm.used_capacity" autocomplete="off" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="addFormVisible = false">取 消</el-button>
        <el-button type="primary" @click="saveAdd()">确 定</el-button>
      </div>
    </el-dialog>

    <el-dialog title="编辑课程" :visible.sync="editFormVisible">
      <el-form :model="editForm" label-width="200px" algin="left">\
        <el-form-item label="课程号" label-width="25%">
          <el-input v-model="editForm.course_id_id" autocomplete="off" disabled="true"/>
        </el-form-item>
        <el-form-item label="开课时间" label-width="25%">
          <el-input v-model="editForm.class_time" autocomplete="off" />
        </el-form-item>
        <el-form-item label="学期" label-width="25%">
          <el-select v-model="editForm.semester" placeholder="选择学期">
            <el-option
            v-for="item in semesterList"
            :key="item.semester"
            :label="item.semester"
            :value="item.semester"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="教师号" label-width="25%">
          <el-input v-model="editForm.staff_id_id" autocomplete="off" />
        </el-form-item>
        <el-form-item label="容量" label-width="25%">
          <el-input v-model="editForm.capacity" autocomplete="off" />
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
import { addOpenCourse, updateOpenCourse, fetchOpenCourse, deleteOpenCourse, fetchSemester } from '@/api/openCourseApi'
import { fetchCourse } from '@/api/courseApi'
import { mapGetters } from 'vuex'
export default {
  computed: {
    ...mapGetters([
      'group',
      'semester'
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
      password: null,
      listLoading: true,
      tableData: [],
      semesterList:[],
      courseList:[],
      addFormVisible: false,
      editFormVisible: false,
      editForm: {
        id: '',
        semester: '',
        class_time: '',
        course_id_id: '',
        staff_id_id: '',
        capacity: 0,
        used_capacity: 0
      },
      addForm: {
        semester: this.$store.getters.semester,
        class_time: '',
        course_id_id: '',
        staff_id_id: '',
        capacity: 0,
        used_capacity: 0
      },
      query: {
        semester: '',
        class_time: '',
        course_id_id: '',
        staff_id_id: ''
      },
      deleteForm: {
        id: ''
      },
      querycourse:{},
      currentPage: 1, // 当前页码
      total: 20, // 总条数
      pageSize: 5 // 每页的数据条数
    }
  },
  created() {
    this.fetchData()
    this.handleSemester()
    this.handleCourse()
  },
  methods: {
    fetchData() {
      this.listLoading = true
      fetchOpenCourse(this.query).then(response => {
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
      console.log('新增', this.addForm)
      addOpenCourse(this.addForm).then(response => {
        if (response) {
          console.log('in handleAdd', response)
          this.$message({ message: '新增成功', type: 'success' })
          this.addFormVisible = false
          this.fetchData()
          this.addForm.semester = this.$store.getters.semester
          this.addForm.class_time = ''
          this.addForm.course_id_id = ''
          this.addForm.staff_id_id = ''
          this.addForm.capacity = 0
          this.addForm.used_capacity = 0
        } else {
          this.$message.error('新增失败')
        }
      })
    },
    // 编辑用户
    handleEdit(inex, row) {
      this.editFormVisible = true
      this.editForm.id = row.id
      this.editForm.semester = row.semester
      this.editForm.class_time = row.class_time
      this.editForm.course_id_id = row.course_id_id
      this.editForm.staff_id_id = row.staff_id_id
      this.editForm.capacity = row.capacity
      this.editForm.used_capacity = row.used_capacity
    },
    saveEdit() {
      updateOpenCourse(this.editForm).then(response => {
        if (response) {
          this.editFormVisible = false
          this.$message({ message: '修改成功', type: 'success' })
          console.log('in handleEdit', response)
          this.fetchData()
          this.editForm.id = ''
          this.editForm.semester = ''
          this.editForm.class_time = ''
          this.editForm.course_id_id = ''
          this.editForm.staff_id_id = ''
          this.editForm.capacity = 0
          this.editForm.used_capacity = 0
        } else {
          this.$message.error('修改失败')
        }
      })
    },
    // 删除用户
    handleDelete(inex, row) {
      this.deleteForm.id = row.id
      deleteOpenCourse(this.deleteForm).then(response => {
        if (response) {
          this.$message({ message: '删除成功', type: 'success' })
          console.log('in handleDelete', response)
          this.fetchData()
          this.deleteForm.id = ''
        } else {
          this.$message.error('删除失败')
        }
      })
    },
    handleSemester() {
      fetchSemester().then(response => {
        if (response) { console.log('获取学期成功') }
        this.semesterList = response.data
      })
    },
    handleCourse(){
      fetchCourse(this.querycourse).then(response=>{
        if (response) { console.log('获取课程信息成功') }
        this.courseList = response.data
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
  .fetchInputBox{
    width:20%
  }
  </style>

<template>
  <div class="app-container">
    <h1>开课申请</h1>
    <el-form :inline="true" class="demo-form-inline">
      <!-- 表格内容 -->
      <el-form-item>
        <el-button v-if="group==='教师'" type="primary" size="small" @click="dialogVisible = true">申请开课</el-button>
      </el-form-item>
    </el-form>

    <el-table
      v-loading="listLoading"
      :data="coruse_request_list.slice((currentPage-1)*pageSize,currentPage*pageSize)"
      title="我的申请"
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
      <el-table-column label="学时" align="center">
        <template slot-scope="scope">
          <span>{{ scope.row.credit_hours }}</span>
        </template>
      </el-table-column>
      <el-table-column label="学院号">
        <template slot-scope="scope">
          <span>{{ scope.row.dept_id_id }}</span>
        </template>
      </el-table-column>
      <el-table-column label="审核状态">
        <template slot-scope="scope">
          <span>{{ scope.row.status === 0 ? '待审核' : (scope.row.status === 1 ? '通过' : '未通过') }}</span>
        </template>
      </el-table-column>
      <el-table-column v-if="group==='管理员'" label="操作" align="center">
        <template v-if="scope.row.status === 0" slot-scope="scope">
          <el-button type="primary" size="small" @click="updateCourseRequest(scope.row.course_id, 1)">通过</el-button>
          <el-button type="danger " size="small" @click="updateCourseRequest(scope.row.course_id, 2)">拒绝</el-button>
        </template>
        <template v-else slot-scope="scope">
          <span>已审核</span>
        </template>
      </el-table-column>

    </el-table>
    <el-pagination
        align="center"
        :current-page="currentPage"
        :page-sizes="[1,5,10,20]"
        :page-size="pageSize"
        layout="total, sizes, prev, pager, next, jumper"
        :total="coruse_request_list.length"
        @size-change="handleSizeChange"
        @current-change="handleCurrentChange"
      />

    <el-dialog
      title="开课信息"
      :visible.sync="dialogVisible"
      width="30%"
      :before-close="handleClose"
    >
      <el-form :model="course_form">

        <el-form-item label="课程号" label-width="120px">
          <el-input
            v-model="course_form.course_id"
            autocomplete="off"
          />
        </el-form-item>
        <el-form-item label="课名" label-width="120px">
          <el-input
            v-model="course_form.course_name"
            autocomplete="off"
          />
        </el-form-item>
        <el-form-item label="学分" label-width="120px">
          <el-input v-model="course_form.credit" autocomplete="off" />
        </el-form-item>
        <el-form-item label="学时" label-width="120px">
          <el-input
            v-model="course_form.credit_hours"
            autocomplete="off"
          />
        </el-form-item>
        <el-form-item label="院系号" label-width="120px">
          <el-input v-model="course_form.dept_id" autocomplete="off" />
        </el-form-item>
        <el-form-item label="平时成绩占比" label-width="120px">
          <el-input
            v-model="course_form.normal_score_percent"
            autocomplete="off"
          />
        </el-form-item>

      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">取 消</el-button>
        <el-button
          type="primary"
          @click="addCourseRequest"
        >确 定</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
import { postCourseRequest, getCourseRequest, putCourseRequest } from '@/api/courseRequestApi'
export default {
  data() {
    return {
      group: 'teacher',
      listLoading: true,
      dialogVisible: false,
      course_form: {
        course_id: '',
        course_name: '',
        credit: '',
        credit_hours: '',
        dept_id: '',
        normal_score_percent: ''
      },
      coruse_request_list: [],
      currentPage: 1, // 当前页码
      total: 20, // 总条数
      pageSize: 5 // 每页的数据条数
    }
  },
  created() {
    this.group = this.$store.getters.group
    if (this.group === '教师') this.course_form.staff_id = this.$store.getters.name
    else this.course_form.staff_id = ''
    this.getCourseRequestList({ staff_id: this.course_form.staff_id })
  },
  methods: {
    handleClose(done) {
      this.$confirm('确认关闭？')
        .then((_) => {
          done()
        })
        .catch((_) => {})
    },
    // 添加课程申请
    addCourseRequest() {
      postCourseRequest(this.course_form).then((res) => {
        this.dialogVisible = false
        this.getCourseRequestList()
        this.course_form = {
          course_id: '',
          course_name: '',
          credit: '',
          credit_hours: '',
          dept_id: '',
          normal_score_percent: '',
          staff_id: this.$store.getters.name
        }
      })
    },
    // 更新课程申请状态
    updateCourseRequest(course_id, status) {
      console.log(course_id, status)
      putCourseRequest({ course_id, status }).then((res) => {
        this.getCourseRequestList()
      })
    },
    // 获取课程申请列表
    getCourseRequestList(data = {}) {
      getCourseRequest({ staff_id: this.course_form.staff_id }).then((res) => {
        this.coruse_request_list = res.data
        this.listLoading = false
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

  <style scoped>
  /* 样式 */
  </style>

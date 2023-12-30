<!--选课表-->
<template>
  <div class="app-container">
    <h1>选课管理</h1>
    <!--开课表搜索：用于选课-->
    <el-row :gutter="20">
      <el-col :span="2"><span>课程号：</span></el-col>
      <el-col :span="4">
        <el-input v-model="queryOpenCourse.staff_id_id" autocomplete="off" size="small" />
      </el-col>
      <el-col :span="2"><span>课程名：</span></el-col>
      <el-col :span="4">
        <el-input v-model="queryOpenCourse.course_name" autocomplete="off" size="small" />
      </el-col>
      <el-col :span="2"><span>教师名：</span></el-col>
      <el-col :span="4">
        <el-input v-model="queryOpenCourse.staff_name" autocomplete="off" size="small" />
      </el-col>
      <el-col :span="2"><span>教师号：</span></el-col>
      <el-col :span="4">
        <el-input v-model="queryOpenCourse.staff_id_id" autocomplete="off" size="small" />
      </el-col>
    </el-row>
    <el-row :gutter="20">
      <el-col :span="2"><span>教师职称</span></el-col>
      <el-col :span="4">
        <el-input v-model="queryOpenCourse.professional_ranks" autocomplete="off" size="small" />
      </el-col>
      <el-col :span="2"><span>剩余容量：</span></el-col>
      <el-col :span="4">
        <el-input v-model="queryOpenCourse.used_capacity" autocomplete="off" size="small" />
      </el-col>
      <el-col :span="2"><span>上课时间：</span></el-col>
      <el-col :span="4">
        <el-input v-model="queryOpenCourse.class_time" autocomplete="off" size="small" />
      </el-col>
    </el-row>
    <div align="right">
      <el-button type="primary" size="small" @click="fetchOpenCourseData()">查询课程</el-button>
    </div>
    <el-divider />
    <!--选课部分-->
    <el-table
      v-loading="listLoading"
      :data="tableDataOpenCourse.slice((currentPageOpenCourse-1)*pageSizeOpenCourse,currentPageOpenCourse*pageSizeOpenCourse)"
      element-loading-text="Loading"
      border
      fit
      highlight-current-row
    >
      <el-table-column align="center" label="序号">
        <template slot-scope="scope">
          <span>{{ scope.$index+1+pageSizeOpenCourse*(currentPageOpenCourse-1) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="课程号" align="center">
        <template slot-scope="scope">
          <span>{{ scope.row.course_id_id }}</span>
        </template>
      </el-table-column>
      <el-table-column label="课程名" align="center">
        <template slot-scope="scope">
          <span>{{ scope.row.course_name }}</span>
        </template>
      </el-table-column>
      <el-table-column label="教师名" align="center">
        <template slot-scope="scope">
          <span>{{ scope.row.staff_name }}</span>
        </template>
      </el-table-column>
      <el-table-column label="教师工号" align="center">
        <template slot-scope="scope">
          <span>{{ scope.row.staff_id_id }}</span>
        </template>
      </el-table-column>
      <el-table-column label="职称" align="center">
        <template slot-scope="scope">
          <span>{{ scope.row.professional_ranks }}</span>
        </template>
      </el-table-column>
      <el-table-column label="上课时间" align="center">
        <template slot-scope="scope">
          <span>{{ scope.row.class_time }}</span>
        </template>
      </el-table-column>
      <el-table-column label="容量" align="center">
        <template slot-scope="scope">
          <span>{{ scope.row.capacity }}</span>
        </template>
      </el-table-column>
      <el-table-column label="已选人数" align="center">
        <template slot-scope="scope">
          <span>{{ scope.row.used_capacity }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" width="200px">
        <template slot-scope="scope">
          <el-button
            size="mini"
            @click="handleAddCourse(scope.$index, scope.row)"
          >选课</el-button>
          <el-button
            size="mini"
            type="danger"
            @click="handleDeleteCourse(scope.$index, scope.row)"
          >退课</el-button>
        </template>
      </el-table-column>
    </el-table>
    <el-pagination
      align="center"
      :current-page="currentPageOpenCourse"
      :page-sizes="[1,5,10,20]"
      :page-size="pageSizeOpenCourse"
      layout="total, sizes, prev, pager, next, jumper"
      :total="tableDataOpenCourse.length"
      @size-change="handleSizeChangeOpenCourse"
      @current-change="handleCurrentChangeOpenCourse"
    />

    <h2>查询选课信息</h2>
    <el-row :gutter="20">
      <el-col :span="2"><span>学号：</span></el-col>
      <el-col :span="4">
        <el-input v-model="querySelectCourse.student_id_id" autocomplete="off" size="small" />
      </el-col>
      <el-col :span="2"><span>课程号：</span></el-col>
      <el-col :span="4">
        <el-input v-model="querySelectCourse.course_id_id" autocomplete="off" size="small" />
      </el-col>
    </el-row>
    <div align="right">
      <el-button type="primary" size="small" @click="fetchCourseSelectionData()">查询选课</el-button>
    </div>
    <el-divider />
    <!--管理学生选课部分-->
    <el-table
      v-loading="listLoading"
      :data="tableDataCourseSelection.slice((currentPageCourseSelection-1)*pageSizeCourseSelection,currentPageCourseSelection*pageSizeCourseSelection)"
      element-loading-text="Loading"
      border
      fit
      highlight-current-row
    >
      <el-table-column align="center" label="序号">
        <template slot-scope="scope">
          <span>{{ scope.$index+1+pageSizeCourseSelection*(currentPageCourseSelection-1) }}</span>
        </template>
      </el-table-column>
      <el-table-column align="center" label="学期">
        <template slot-scope="scope">
          <span>{{ scope.row.semester }}</span>
        </template>
      </el-table-column>
      <el-table-column label="课程号" align="center">
        <template slot-scope="scope">
          <span>{{ scope.row.course_id_id }}</span>
        </template>
      </el-table-column>
      <el-table-column label="教师工号" align="center">
        <template slot-scope="scope">
          <span>{{ scope.row.staff_id_id }}</span>
        </template>
      </el-table-column>
      <el-table-column label="学号" align="center">
        <template slot-scope="scope">
          <span>{{ scope.row.student_id_id }}</span>
        </template>
      </el-table-column>
      <el-table-column label="平时成绩" align="center">
        <template slot-scope="scope">
          <span>{{ scope.row.normal_score }}</span>
        </template>
      </el-table-column>
      <el-table-column label="期末成绩" align="center">
        <template slot-scope="scope">
          <span>{{ scope.row.test_score }}</span>
        </template>
      </el-table-column>
      <el-table-column label="总评成绩" align="center">
        <template slot-scope="scope">
          <span>{{ scope.row.total_score }}</span>
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
      :current-page="currentPageCourseSelection"
      :page-sizes="[1,5,10,20]"
      :page-size="pageSizeCourseSelection"
      layout="total, sizes, prev, pager, next, jumper"
      :total="tableDataCourseSelection.length"
      @size-change="handleSizeChangeCourseSelection"
      @current-change="handleCurrentChangeCourseSelection"
    />

    <el-dialog title="管理员：新增选课" :visible.sync="addFormVisible">
      <el-form :model="addOpenCourseForm" label-width="200px" algin="left">
        <el-form-item label="课程号" label-width="25%">
          <el-input v-model="addOpenCourseForm.course_id_id" autocomplete="off" :disabled="true" />
        </el-form-item>
        <el-form-item label="课程名" label-width="25%">
          <el-input v-model="addOpenCourseForm.course_name" autocomplete="off" :disabled="true" />
        </el-form-item>
        <el-form-item label="教师名" label-width="25%">
          <el-input v-model="addOpenCourseForm.staff_name" autocomplete="off" :disabled="true" />
        </el-form-item>
        <el-form-item label="教师工号" label-width="25%">
          <el-input v-model="addOpenCourseForm.staff_id_id" autocomplete="off" :disabled="true" />
        </el-form-item>
        <el-form-item label="职称" label-width="25%">
          <el-input v-model="addOpenCourseForm.professional_ranks" autocomplete="off" :disabled="true" />
        </el-form-item>
        <el-form-item label="上课时间" label-width="25%">
          <el-input v-model="addOpenCourseForm.class_time" autocomplete="off" :disabled="true" />
        </el-form-item>
        <el-form-item label="*学生学号" label-width="25%">
          <el-input v-model="addOpenCourseForm.student_id_id" autocomplete="off" />
        </el-form-item>
        <el-form-item label="学生姓名" label-width="25%">
          <el-input v-model="addOpenCourseForm.student_name" autocomplete="off" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="addFormVisible = false">取 消</el-button>
        <el-button type="primary" @click="saveOpenCourseAdd()">确 定</el-button>
      </div>
    </el-dialog>

    <el-dialog title="管理员：删除选课" :visible.sync="deleteFormVisible">
      <el-form :model="deleteOpenCourseForm" label-width="200px" algin="left">
        <el-form-item label="课程号" label-width="25%">
          <el-input v-model="deleteOpenCourseForm.course_id_id" autocomplete="off" :disabled="true" />
        </el-form-item>
        <el-form-item label="课程名" label-width="25%">
          <el-input v-model="deleteOpenCourseForm.course_name" autocomplete="off" :disabled="true" />
        </el-form-item>
        <el-form-item label="教师名" label-width="25%">
          <el-input v-model="deleteOpenCourseForm.staff_name" autocomplete="off" :disabled="true" />
        </el-form-item>
        <el-form-item label="教师工号" label-width="25%">
          <el-input v-model="deleteOpenCourseForm.staff_id_id" autocomplete="off" :disabled="true" />
        </el-form-item>
        <el-form-item label="职称" label-width="25%">
          <el-input v-model="deleteOpenCourseForm.professional_ranks" autocomplete="off" :disabled="true" />
        </el-form-item>
        <el-form-item label="上课时间" label-width="25%">
          <el-input v-model="deleteOpenCourseForm.class_time" autocomplete="off" :disabled="true" />
        </el-form-item>
        <el-form-item label="*学生学号" label-width="25%">
          <el-input v-model="deleteOpenCourseForm.student_id_id" autocomplete="off" />
        </el-form-item>
        <el-form-item label="学生姓名" label-width="25%">
          <el-input v-model="deleteOpenCourseForm.student_name" autocomplete="off" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="deleteFormVisible = false">取 消</el-button>
        <el-button type="primary" @click="saveOpenCourseDelete()">确 定</el-button>
      </div>
    </el-dialog>

    <el-dialog title="测试：编辑选课" :visible.sync="editFormVisible">
      <el-form :model="editSelectCourseForm" label-width="200px" algin="left">
        <el-form-item label="课程号" label-width="25%">
          <el-input v-model="editSelectCourseForm.course_id_id" autocomplete="off" />
        </el-form-item>
        <el-form-item label="工号" label-width="25%">
          <el-input v-model="editSelectCourseForm.staff_id_id" autocomplete="off" />
        </el-form-item>
        <el-form-item label="学生号" label-width="25%">
          <el-input v-model="editSelectCourseForm.student_id_id" autocomplete="off" />
        </el-form-item>
        <el-form-item label="平时分" label-width="25%">
          <el-input v-model="editSelectCourseForm.normal_score" autocomplete="off" />
        </el-form-item>
        <el-form-item label="期末成绩" label-width="25%">
          <el-input v-model="editSelectCourseForm.test_score" autocomplete="off" />
        </el-form-item>
        <el-form-item label="总成绩" label-width="25%">
          <el-input v-model="editSelectCourseForm.total_score" autocomplete="off" />
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
import { addCourseSelection, updateCourseSelection, fetchCourseSelection, deleteCourseSelection, fetchCoursesForSelect } from '@/api/courseSelectionApi'
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
      // 从开课表中查找并返回的数据;一定要有开课表的id
      tableDataOpenCourse: [],
      // 从选课表查找并返回的数据
      tableDataCourseSelection: [],
      addFormVisible: false,
      editFormVisible: false,
      deleteFormVisible: false,
      editSelectCourseForm: { // 测试用的，实际不会有这个
        selectcourse_id: '', // 选课表的课程id
        semester: this.$store.getters.semester,
        normal_score: '',
        test_score: '',
        course_id_id: '',
        staff_id_id: '',
        student_id_id: ''
      },
      addOpenCourseForm: {
        semester: this.$store.getters.semester,
        group: this.$store.getters.group,
        open_course_id_id: '', // 开课表的课程id
        course_id_id: '',
        course_name: '',
        staff_name: '',
        staff_id_id: '',
        professional_ranks: '',
        class_time: '',
        student_id_id: '',
        student_name: ''
      },
      queryOpenCourse: {
        semester: this.$store.getters.semester, // semester=this.semester
        staff_id_id: '',
        course_name: '',
        staff_name: '',
        staff_id_id: '',
        professional_ranks: '',
        capacity: '',
        used_capacity: ''
      },
      querySelectCourse: {
        semester: this.$store.getters.semester,
        normal_score: '',
        course_id_id: '',
        staff_id_id: '',
        student_id_id: ''
      },
      deleteOpenCourseForm: {
        // 需要open_course_id_id，student_id_id
        open_course_id_id: '',
        course_id_id: '',
        course_name: '',
        staff_name: '',
        staff_id_id: '',
        professional_ranks: '',
        used_capacity: '',
        class_time: ''
      },
      deleteForm: {
        selectcourse_id: ''
      },
      currentPageOpenCourse: 1, // 当前页码
      totalOpenCourse: 20, // 总条数
      pageSizeOpenCourse: 5, // 每页的数据条数
      currentPageCourseSelection: 1, // 当前页码
      totalCourseSelection: 20, // 总条数
      pageSizeCourseSelection: 5 // 每页的数据条数

    }
  },
  created() {
    this.fetchData()
  },
  methods: {
    fetchData() {
      this.listLoading = true
      // 先找课程表
      fetchCoursesForSelect(this.queryOpenCourse).then(response => {
        this.tableDataOpenCourse = response.data
        console.log('更新tabledata', this.tableDataOpenCourse)
        // 再找选课表
        fetchCourseSelection(this.querySelectCourse).then(responseCS => {
          this.tableDataCourseSelection = responseCS.data
          console.log('更新tabledataCS', this.tableDataCourseSelection)
          this.listLoading = false
        })
      })
    },
    // 查询选课清单
    fetchOpenCourseData() {
      this.listLoading = true
      fetchCoursesForSelect(this.queryOpenCourse).then(response => {
        this.tableDataOpenCourse = response.data
        console.log('更新tabledata', this.tableDataOpenCourse)
        this.listLoading = false
      })
    },
    // 查询某个同学的选课情况
    fetchCourseSelectionData() {
      this.listLoading = true
      fetchCourseSelection(this.querySelectCourse).then(responseCS => {
        this.tableDataCourseSelection = responseCS.data
        console.log('更新tabledataCS', this.tableDataCourseSelection)
        this.listLoading = false
      })
    },
    // 新增选课【管理员，跳出弹窗】
    handleAddCourse(index, row) {
      this.addFormVisible = true
      this.addOpenCourseForm.semester = this.$store.getters.semester
      this.addOpenCourseForm.opencourse_id_id = row.opencourse_id_id
      this.addOpenCourseForm.course_id_id = row.course_id_id
      this.addOpenCourseForm.staff_id = row.staff_id
      this.addOpenCourseForm.course_name = row.course_name
      this.addOpenCourseForm.staff_name = row.staff_name
      this.addOpenCourseForm.staff_id_id = row.staff_id_id
      this.addOpenCourseForm.professional_ranks = row.professional_ranks
      this.addOpenCourseForm.used_capacity = row.used_capacity
      this.addOpenCourseForm.class_time = row.class_time
    },
    // 删除选课(退课，OP表操作)
    handleDeleteCourse(index, row) {
      this.deleteFormVisible = true
      console.log('delete course row', row)
      this.deleteOpenCourseForm.semester = this.$store.getters.semester
      this.deleteOpenCourseForm.opencourse_id_id = row.opencourse_id_id
      this.deleteOpenCourseForm.course_id_id = row.course_id_id
      this.deleteOpenCourseForm.staff_id = row.staff_id
      this.deleteOpenCourseForm.course_name = row.course_name
      this.deleteOpenCourseForm.staff_name = row.staff_name
      this.deleteOpenCourseForm.staff_id_id = row.staff_id_id
      this.deleteOpenCourseForm.professional_ranks = row.professional_ranks
      this.deleteOpenCourseForm.used_capacity = row.used_capacity
      this.deleteOpenCourseForm.class_time = row.class_time
    },
    saveOpenCourseAdd() {
      console.log('开课传入值', this.addOpenCourseForm)
      addCourseSelection(this.addOpenCourseForm).then(response => {
        if (response) {
          console.log('in handleAdd', response)
          this.$message({ message: '新增成功', type: 'success' })
          this.addFormVisible = false
          this.fetchData()
          this.addOpenCourseForm.open_course_id_id = ''
          this.addOpenCourseForm.staff_id = ''
          this.addOpenCourseForm.course_name = ''
          this.addOpenCourseForm.staff_name = ''
          this.addOpenCourseForm.staff_id_id = ''
          this.addOpenCourseForm.professional_ranks = ''
          this.addOpenCourseForm.used_capacity = ''
          this.addOpenCourseForm.class_time = ''
        } else {
          this.$message.error('新增失败')
        }
      }).catch(error => {
        this.$message.error(error.message)
      })
    },
    saveOpenCourseDelete() {
      console.log(this.deleteOpenCourseForm)
      deleteCourseSelection(this.deleteOpenCourseForm).then(response => {
        if (response) {
          console.log('in handleDelete', response)
          this.$message({ message: '删除成功', type: 'success' })
          this.deleteFormVisible = false
          this.fetchData()
          this.deleteOpenCourseForm.open_course_id_id = ''
          this.deleteOpenCourseForm.staff_id = ''
          this.deleteOpenCourseForm.course_name = ''
          this.deleteOpenCourseForm.staff_name = ''
          this.deleteOpenCourseForm.staff_id_id = ''
          this.deleteOpenCourseForm.professional_ranks = ''
          this.deleteOpenCourseForm.used_capacity = ''
          this.deleteOpenCourseForm.class_time = ''
        } else {
          this.$message.error('删除失败')
        }
      })
    },
    // 编辑用户
    handleEdit(inex, row) {
      this.editFormVisible = true
      console.log('row=', row)
      this.editSelectCourseForm.selectcourse_id = row.id
      this.editSelectCourseForm.course_id_id = row.course_id_id
      this.editSelectCourseForm.staff_id_id = row.staff_id_id
      this.editSelectCourseForm.student_id_id = row.student_id_id
      this.editSelectCourseForm.normal_score = row.normal_score
      this.editSelectCourseForm.test_score = row.test_score
      this.editSelectCourseForm.total_score = row.total_score
    },
    saveEdit() {
      updateCourseSelection(this.editSelectCourseForm).then(response => {
        if (response) {
          console.log('in handleEdit', response)
          this.editFormVisible = false
          this.$message({ message: '修改成功', type: 'success' })
          this.fetchData()
          this.editSelectCourseForm.course_id_id = ''
          this.editSelectCourseForm.staff_id_id = ''
          this.editSelectCourseForm.student_id_id = ''
          this.editSelectCourseForm.normal_score = ''
          this.editSelectCourseForm.test_score = ''
          this.editSelectCourseForm.total_score = ''
        } else {
          this.$message.error('修改失败')
        }
      })
    },
    // 删除选课
    handleDelete(inex, row) {
      this.deleteForm.selectcourse_id = row.id
      deleteCourseSelection(this.deleteForm).then(response => {
        if (response) {
          this.$message({ message: '删除成功', type: 'success' })
          console.log('in handleDelete', response)
          this.fetchData()
          this.deleteForm.selectcourse_id = ''
        } else {
          this.$message.error('删除失败')
        }
      })
    },
    // 每页条数改变时触发 选择一页显示多少行
    handleSizeChangeOpenCourse(val) {
      console.log(`每页 ${val} 条`)
      this.currentPageOpenCourse = 1
      this.pageSizeOpenCourse = val
    },
    // 当前页改变时触发 跳转其他页
    handleCurrentChangeOpenCourse(val) {
      console.log(`当前页: ${val}`)
      this.currentPageOpenCourse = val
    },
    // 每页条数改变时触发 选择一页显示多少行
    handleSizeChangeCourseSelection(val) {
      console.log(`每页 ${val} 条`)
      this.currentPageCourseSelection = 1
      this.pageSizeCourseSelection = val
    },
    // 当前页改变时触发 跳转其他页
    handleCurrentChangeCourseSelection(val) {
      console.log(`当前页: ${val}`)
      this.currentPageCourseSelection = val
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

<!--选课页面-->
<template>
  <div class="app-container">
    <h1>选课管理</h1>
    <!--开课表搜索：用于选课-->
    <el-row :gutter="20">
      <el-col :span="2"><span>课程号：</span></el-col>
      <el-col :span="4">
        <el-input v-model="queryOpenCourse.course_id_id" autocomplete="off" size="small" />
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
    <el-table
      v-loading="listLoading"
      :data="tableDataOpenCourse"
      element-loading-text="Loading"
      border
      fit
      highlight-current-row
    >
      <el-table-column align="center" label="序号" width="95">
        <template slot-scope="scope">
          <span>{{ scope.$index }}</span>
        </template>
      </el-table-column>
      <el-table-column label="课程号" width="110" align="center">
        <template slot-scope="scope">
          <span>{{ scope.row.course_id_id }}</span>
        </template>
      </el-table-column>
      <el-table-column label="课程名" width="110" align="center">
        <template slot-scope="scope">
          <span>{{ scope.row.course_name }}</span>
        </template>
      </el-table-column>
      <el-table-column label="学分" width="110" align="center">
        <template slot-scope="scope">
          <span>{{ scope.row.credit }}</span>
        </template>
      </el-table-column>
      <el-table-column label="教师号" width="110" align="center">
        <template slot-scope="scope">
          <span>{{ scope.row.staff_id_id }}</span>
        </template>
      </el-table-column>
      <el-table-column label="教师名" width="110" align="center">
        <template slot-scope="scope">
          <span>{{ scope.row.staff_name }}</span>
        </template>
      </el-table-column>
      <el-table-column label="上课时间" align="center">
        <template slot-scope="scope">
          <span>{{ scope.row.class_time }}</span>
        </template>
      </el-table-column>
      <el-table-column label="课程容量" width="110" align="center">
        <template slot-scope="scope">
          <span>{{ scope.row.capacity }}</span>
        </template>
      </el-table-column>
      <el-table-column label="已选课人数" width="110" align="center">
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
        </template>
      </el-table-column>
    </el-table>
    <h2>已选的课程</h2>
    <!--用于学生退课-->
    <el-table
      v-loading="listLoading"
      :data="tableDataCourseSelection"
      element-loading-text="Loading"
      border
      fit
      highlight-current-row
    >
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
      <el-table-column label="学分" align="center">
        <template slot-scope="scope">
          <span>{{ scope.row.credit }}</span>
        </template>
      </el-table-column>
      <el-table-column label="教师号" align="center">
        <template slot-scope="scope">
          <span>{{ scope.row.staff_id_id }}</span>
        </template>
      </el-table-column>
      <el-table-column label="教师名" align="center">
        <template slot-scope="scope">
          <span>{{ scope.row.staff_name }}</span>
        </template>
      </el-table-column>
      <el-table-column label="上课时间" align="center">
        <template slot-scope="scope">
          <span>{{ scope.row.class_time }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="danger"
            @click="handleDelete(scope.$index, scope.row)"
          >退课</el-button>
        </template>
      </el-table-column>
    </el-table>
  </div>
</template>

<script>
import { getList } from '@/api/table'
import { addCourseSelection, updateCourseSelection, fetchCoursesForCheck, fetchCourseSelection, deleteCourseSelection, fetchCoursesForSelect } from '@/api/courseSelectionApi'
import { mapGetters } from 'vuex'
// import { addStudent, updateStudent, fetchStudent, deleteStudent,fetchStudent } from '@/api/studentApi'

export default {
  computed: {
    ...mapGetters([
      'group',
      'semester',
      'name'
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
      input: null,
      list: null,
      listLoading: true,
      // 从开课表中查找并返回的数据;一定要有开课表的id
      tableDataOpenCourse: [],
      // 从选课表查找并返回的数据
      tableDataCourseSelection: [],
      addFormVisible: false,
      deleteFormVisible: false,
      addOpenCourseForm: {
        semester: this.$store.getters.semester,
        student_id_id: this.$store.getters.name,
        group: this.$store.getters.group,
        opencourse_id_id: '', // 开课表的课程id
        course_id_id: '',
        course_name: '',
        staff_name: '',
        staff_id_id: '',
        professional_ranks: '',
        class_time: '',
        student_name: '',
        credit: ''
      },
      queryOpenCourse: {
        semester: this.$store.getters.semester, // semester=this.semester
        course_id_id: '',
        staff_id_id: '',
        course_name: '',
        staff_name: '',
        professional_ranks: '',
        capacity: '',
        used_capacity: '',
        credit: '',
        class_time: ''
      },
      deleteOpenCourseForm: {
        student_id_id: this.$store.getters.name,
        selectcourse_id: ''// 唯一值，传给后端，剩下的都是看的
      },
      querySelectCourse: {
        semester: this.$store.getters.semester,
        student_id_id: this.$store.getters.name,
        normal_score: '',
        course_id_id: '',
        staff_id_id: '',
        course_name: '',
        staff_name: '',
        class_time: '',
        credit: ''
      },
      deleteForm: {
        selectcourse_id: ''
      }
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
        fetchCoursesForCheck(this.querySelectCourse).then(responseCS => {
          this.tableDataCourseSelection = responseCS.data
          console.log('更新tabledataCS', this.tableDataCourseSelection)
          this.listLoading = false
        })
      })
      getList().then(response => {
        this.list = response.data.items
        this.listLoading = false
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
      fetchCoursesForCheck(this.querySelectCourse).then(responseCS => {
        this.tableDataCourseSelection = responseCS.data
        console.log('更新tabledataCS', this.tableDataCourseSelection)
        this.listLoading = false
      })
    },

    // 新增选课（学生）
    handleAddCourse(index, row) {
      this.addOpenCourseForm.semester = this.$store.getters.semester
      this.addOpenCourseForm.student_id_id = this.$store.getters.name
      this.addOpenCourseForm.opencourse_id_id = row.opencourse_id_id
      this.addOpenCourseForm.course_id_id = row.course_id_id
      this.addOpenCourseForm.staff_id = row.staff_id
      this.addOpenCourseForm.course_name = row.course_name
      this.addOpenCourseForm.staff_name = row.staff_name
      this.addOpenCourseForm.staff_id_id = row.staff_id_id
      this.addOpenCourseForm.professional_ranks = row.professional_ranks
      this.addOpenCourseForm.used_capacity = row.used_capacity
      this.addOpenCourseForm.class_time = row.class_time
      addCourseSelection(this.addOpenCourseForm).then(response => {
        if (response) {
          console.log('in handleAdd', response)
          this.$message({ message: '新增成功', type: 'success' })
          this.addFormVisible = false
          this.fetchData()
          this.addOpenCourseForm.opencourse_id_id = ''
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
    // 删除用户
    handleDelete(inex, row) {
      this.deleteForm.selectcourse_id = row.id
      console.log('row:', row)
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

    testButton() {
      console.log('testbutton')
      Test().then(response => {
        console.log('tttttttttttest', response)
      })
    }
  }
}
</script>

<style>
.boxes {
  width: 18%;
}
</style>

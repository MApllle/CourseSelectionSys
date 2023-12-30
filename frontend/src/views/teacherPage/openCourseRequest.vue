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
          :data="coruse_request_list" 
          title="我的申请"
          element-loading-text="Loading" 
          border 
          fit 
          highlight-current-row
        >
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
          <el-table-column label="操作" v-if="group==='管理员'">
              <template slot-scope="scope" v-if="scope.row.status === 0">
                  <el-button type="primary" size="small" @click="updateCourseRequest(scope.row.course_id, 1)" >通过</el-button>
                  <el-button type="danger " size="small" @click="updateCourseRequest(scope.row.course_id, 2)">拒绝</el-button>
              </template>
              <template slot-scope="scope" v-else>
                  <span>已审核</span>
              </template>
          </el-table-column>
  
          
        </el-table>
  
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
            ></el-input>
          </el-form-item>
          <el-form-item label="课名" label-width="120px">
            <el-input
              v-model="course_form.course_name"
              autocomplete="off"
            ></el-input>
          </el-form-item>
          <el-form-item label="学分" label-width="120px">
            <el-input v-model="course_form.credit" autocomplete="off"></el-input>
          </el-form-item>
          <el-form-item label="学时" label-width="120px">
            <el-input
              v-model="course_form.credit_hours"
              autocomplete="off"
            ></el-input>
          </el-form-item>
          <el-form-item label="院系号" label-width="120px">
            <el-input v-model="course_form.dept_id" autocomplete="off"></el-input>
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
          <el-button type="primary" @click="addCourseRequest"
            >确 定</el-button
          >
        </span>
      </el-dialog>
    </div>
  </template>
  
  <script>
      import {postCourseRequest, getCourseRequest, putCourseRequest} from "@/api/openCourseApi"
      export default {
      data() {
          return {
          group: "teacher",
          listLoading: true,
          dialogVisible: false,
          course_form: {
              course_id: "",
              course_name: "",
              credit: "",
              credit_hours: "",
              dept_id: "",
              normal_score_percent: "",
          },
          coruse_request_list: [],
          };
      },
      methods: {
          handleClose(done) {
          this.$confirm("确认关闭？")
              .then((_) => {
              done();
              })
              .catch((_) => {});
          },
          // 添加课程申请
          addCourseRequest() {
              postCourseRequest(this.course_form).then((res) => {
                  this.dialogVisible = false
                  this.getCourseRequestList()
                  this.course_form = {
                    course_id: "",
                    course_name: "",
                    credit: "",
                    credit_hours: "",
                    dept_id: "",
                    normal_score_percent: "",
                    staff_id: this.$store.getters.name
                }
              })
          },
          // 更新课程申请状态
          updateCourseRequest(course_id, status) {
            console.log(course_id, status)
              putCourseRequest({course_id, status}).then((res) => {
                  this.getCourseRequestList()
              })
          },
          // 获取课程申请列表
          getCourseRequestList(data={}) {
              getCourseRequest({staff_id: this.course_form.staff_id}).then((res) => {
                  this.coruse_request_list = res.data
                  this.listLoading = false
              })
          }
      },
      created() {
          this.group = this.$store.getters.group
          if(this.group === '教师') this.course_form.staff_id = this.$store.getters.name;
          else this.course_form.staff_id = '';
          this.getCourseRequestList({staff_id: this.course_form.staff_id})
      }
      };
  </script>
  
  <style scoped>
  /* 样式 */
  </style>
  
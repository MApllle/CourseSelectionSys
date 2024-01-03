<template>
    <div class="app-container">
      <h1>会议室</h1>
  
      <el-table
          v-loading="listLoading" 
          :data="room_list" 
          title="我的申请"
          element-loading-text="Loading" 
          border 
          fit 
          highlight-current-row
        >
          <el-table-column align="center" label="会议室ID">
            <template slot-scope="scope">
              <span>{{ scope.row.room_id }}</span>
            </template>
          </el-table-column>
          <el-table-column label="会议室名称" align="center">
            <template slot-scope="scope">
              <span>{{ scope.row.room_name }}</span>
            </template>
          </el-table-column>
          <el-table-column label="会议室类型" align="center">
            <template slot-scope="scope">
              <span>{{ scope.row.room_size }}</span>
            </template>
          </el-table-column>
          <el-table-column label="最少使用人数" align="center">
            <template slot-scope="scope">
              <span>{{ scope.row.min_number }}</span>
            </template>
          </el-table-column>
          <el-table-column label="状态" align="center">
            <template slot-scope="scope">
              <span style="color: greenyellow;">{{ scope.row.status?'使用中':'空闲' }}</span>
            </template>
          </el-table-column>
          <el-table-column label="操作" align="center">
              <template slot-scope="scope" v-if="scope.row.status === false">
                  <el-button type="primary" size="small" @click="handleOpen(scope.row.room_id)" >申请</el-button>
              </template>
              <template slot-scope="scope" v-else>
                  <span>占用中</span>
              </template>
          </el-table-column>
  
          
        </el-table>
  
      <el-dialog
        title="申请信息"
        :visible.sync="dialogVisible"
        width="30%"
        :before-close="handleClose"
      >
        <el-form :model="room_form">
          
          <el-form-item label="会议室ID" label-width="120px">
            <el-input
              v-model="room_form.room_id"
              autocomplete="off"
              disabled
            ></el-input>
          </el-form-item>
          <el-form-item label="使用人数" label-width="120px">
            <el-input
              type="Number"
              v-model="room_form.number"
              autocomplete="off"
            ></el-input>
          </el-form-item>
          <el-form-item label="时间范围" label-width="120px">
            <el-select v-model="room_form.time_range" placeholder="请选择">
                <el-option
                v-for="item in time_range_list"
                :key="item.value"
                :label="item.label"
                :value="item.value">
                </el-option>
            </el-select>
          </el-form-item>
          
        </el-form>
        <span slot="footer" class="dialog-footer">
          <el-button @click="dialogVisible = false">取 消</el-button>
          <el-button type="primary" @click="clickPutMeetingRoom"
            >确 定</el-button
          >
        </span>
      </el-dialog>
    </div>
  </template>
  
  <script>
      import {getMeetingRoom, putMeetingRoom} from '@/api/meetingRoomApi'
      export default {
      data() {
          return {
          group: "teacher",
          listLoading: true,
          dialogVisible: false,
          room_form: {
              room_id: "",
              number: "",
              time_range: "",
          },
          room_list: [],
          time_range_list: [
            {value: '8-12', label: '8-12'},
            {value: '13-17', label: '13-17'},
            {value: '18-22', label: '18-22'},
          ]
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
          // 打开模态框
          handleOpen(id){
            this.room_form.room_id = id
            this.dialogVisible = true
          },
          // 申请会议室
          clickPutMeetingRoom() {
            console.log(this.room_form)
            putMeetingRoom(this.room_form).then((res) => {
                  console.log(res)
                  this.getMeetingRoomList()
                  this.dialogVisible = false
                  
              })
          },
          // 获取课程申请列表
          getMeetingRoomList() {
            getMeetingRoom().then((res) => {
                  this.room_list = res.data
                  this.listLoading = false
              })
          }
      },
      created() {
          this.getMeetingRoomList()
      }
      };
  </script>
  
  <style scoped>
  /* 样式 */
  </style>
  
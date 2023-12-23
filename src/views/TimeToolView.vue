<template>
  <div class="base-div">
    <div class="datetime-picker">
      <div class="block">
        <span class="demonstration">选择你的目标时间</span>
        <el-date-picker
          @change="verifyTime"
          v-model="pickedDate"
          type="datetime"
          placeholder="点击这里选择时间"
          format="YYYY-MM-DD HH:mm:ss"
        />
        <el-button @click="fetchTime" type="info" round>获取时间</el-button>
      </div>

    </div>
    <div class="message">
      <el-icon>
        <Clock />
      </el-icon>
      <el-text class="mx-1" size="large">{{ message }}</el-text>
    </div>
  </div>
</template>

<script lang="ts" setup>
import { ref } from 'vue'
import axios from 'axios'
import dayjs from 'dayjs'
import { Clock } from '@element-plus/icons-vue'

const instance = axios.create({
  baseURL: 'http://localhost:5001'  // 设置基础URL，所有请求都会以这个为前缀
})

const pickedDate = ref('')
const message = ref("")
function fetchTime() {

  const params = {
    'target_time': formatDateTime(pickedDate.value)
  }
  instance.get('/time_remaining', { params })
    .then(response => {
      console.log(response.data)
      message.value = `距离目标时间还有${response.data.days}天${response.data.hours}小时${response.data.minutes}分钟`
    })
    .catch(error => {
      console.error(error)
    })
}

function verifyTime(value: string) {
  // 将传入的时间字符串转换为 Date 对象
  const inputDate = new Date(value)

  // 获取当前时间
  const currentTime = new Date()
  if (inputDate < currentTime) {
    alert('请选择一个未来的日期!')
    pickedDate.value = '点击这里选择时间'
  }
}

function formatDateTime(date: string): string {
  return dayjs(date).format('YYYY-MM-DD HH:mm:ss')
}
</script>


<style scoped>

.base-div {
  display: flex;
  flex-direction: column; /* 垂直排列 */
}

.message {
  display: flex;
  justify-content: center;
  align-items: center;
  margin: 0;
}

.datetime-picker {
  display: flex;
  width: 100%;
  padding: 0;
  flex-wrap: wrap;
}

.datetime-picker .block {
  padding: 30px 0;
  text-align: center;
  border-right: solid 1px var(--el-border-color);
  flex: 1;
}

.datetime-picker .block:last-child {
  border-right: none;
}

.datetime-picker .demonstration {
  display: block;
  color: var(--el-text-color-secondary);
  font-size: 14px;
  margin-bottom: 20px;
}
</style>

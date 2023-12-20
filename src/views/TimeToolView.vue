<template>
  <div class="demo-datetime-picker">
    <div class="block">
      <span class="demonstration">选择你的目标时间</span>
      <el-date-picker
        v-model="value1"
        type="datetime"
        placeholder="点击这里选择时间"
      />
      <el-button @click="fetchTime" type="info" round>获取时间</el-button>
    </div>
  </div>
</template>

<script lang="ts" setup>
import { ref } from 'vue'
import axios from 'axios';

const value1 = ref('')
const defaultTime = new Date(2000, 1, 1, 12, 0, 0)

function fetchTime(){
      const url = 'http://127.0.0.1:5001/time_remaining';
      const target_time = "2023-12-14 21:41:48";
      axios.post(url, { target_time })
        .then(response => {
          alert(response.data)
        })
        .catch(error => {
          console.error('发生错误:', error);
        });
}

// export default {
//   data() {
//     return {
//       currentTime: ''
//     };
//   },
//   methods: {
//     fetchTime() {
//       const url = 'http://127.0.0.1:8080/time';
//       const currentTime = new Date().toISOString();

//       axios.post(url, { currentTime })
//         .then(response => {
//           this.currentTime = response.data;
//         })
//         .catch(error => {
//           console.error('发生错误:', error);
//         });
//     }
//   }
// };

</script>
<style scoped>
.demo-datetime-picker {
  display: flex;
  width: 100%;
  padding: 0;
  flex-wrap: wrap;
}
.demo-datetime-picker .block {
  padding: 30px 0;
  text-align: center;
  border-right: solid 1px var(--el-border-color);
  flex: 1;
}
.demo-datetime-picker .block:last-child {
  border-right: none;
}
.demo-datetime-picker .demonstration {
  display: block;
  color: var(--el-text-color-secondary);
  font-size: 14px;
  margin-bottom: 20px;
}
</style>

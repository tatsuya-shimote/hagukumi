<template>
  <div>
    <v-app>
      <v-container>
        <h1 class = "edit-title">プロフィール編集</h1>
        <h2>ユーザー名: {{user.name}}</h2>
        <input v-model="user.name"/>
        <v-btn @click="submit">保存</v-btn>
      </v-container>
    </v-app>
  </div>
</template>

<script>
import axios from "axios"
export default {
  data(){
    return {
      user:{}
    }
    
  },
  methods:{
    
    resetEvents(){
      this.$store.commit("resetEvents")
    },
    
    submit(){
      axios.patch(`/api/v1/users/${this.$route.params.id}`,{name: this.user.name}, {headers: { 'X-Requested-With': 'XMLHttpRequest' }}, {withCredentials: true})
      .then(responsse => {
        alert(responsse.data.message)
      }).catch(error => {
        alert(error.data.errors)
      })
    }
  },
  created(){
    axios.get(`/api/v1/users/${this.$route.params.id}`)
    .then(ressponse => {
      this.user = ressponse.data
    }).catch(error => {
      this.$router.push("/login")
    })
  }
}

</script>

<style scoped>
@import url('https://fonts.googleapis.com/css2?family=RocknRoll+One&display=swap');
.edit-title{
  font-size: 27px;
  letter-spacing: 16px;
  font-family: 'RocknRoll One', sans-serif;
}
</style>
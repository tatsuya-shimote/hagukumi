<template>
  <div>
    
      <v-container>
        <h1 class = "edit-title">プロフィール編集</h1>
        <div id="edit-user-name">
          <div v-if="errors.length != 0">
            <ul v-for="(e, index) in errors" :key="index">
              <li><font color="red">{{ e }}</font></li>
            </ul>
          </div>
          <v-text-field
            v-model="user.name"
            color="blue"
            label="名前の変更"
          ></v-text-field>
          <v-btn 
            @click="submit"
            color="blue"
            id="save"
          >保存</v-btn>
        </div>
        <div class="img-center">
          <img src="../images/hagukumi_icon.png" id = "app-icon">
          <p>「どこでもHugしちゃう」</p>
        </div>
      </v-container>
   
  </div>
</template>

<script>
import axios from "axios"
export default {
  data(){
    return {
      user:{},
      errors:""
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
        console.error(error);
            if (error.response.data && error.response.data.errors) {
              this.errors = error.response.data.errors;
            }
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
@import url('https://fonts.googleapis.com/css2?family=Shippori+Mincho&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Kosugi+Maru&display=swap');
.edit-title{
  font-size: 27px;
  letter-spacing: 16px;
  font-family: 'RocknRoll One', sans-serif;
}
.img-center{
  margin-top: 30px;
  text-align: center;
  font-family: 'Kosugi Maru', sans-serif;
}

#app-icon{
  width: 300px;
}

#edit-user-name{
  margin-top: 30px;
}

#save{
  color: white;
}
</style>
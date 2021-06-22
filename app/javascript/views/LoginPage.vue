<template>
  <div class = "container">
    <div class="row">
      <div class="col-md-6 offset-md-3 login-form">
        <h2 class = "text-center">ログイン</h2>
         <form @submit.prevent = "login">
          <div v-if="errors.length != 0">
            <li><font color="red">{{ errors }}</font></li>
          </div>
          <label for="session_email">メールアドレス</label>
          <input class="form-control" type="email" v-model="user.email">
    
          <label for="session_password">パスワード</label>
          <input class="form-control" type="password" v-model="user.password">
          <v-app>
            <v-btn color="blue" id="login-btn" type="submit">ログイン</v-btn>
            <p class="center">初めてのご利用の方は今すぐ<router-link to="/signup" active-class="link--active" exact>新規登録</router-link></p>
          </v-app>
        </form>
        
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios"
  export default {
    data(){
      return {
        user: {
          email: "",
          password: ""
        },
        errors: ""
      }
    },
    methods:{
      login(){
        this.loginApiPost()
        this.loginAuth()
      },
      loginApiPost(){
        axios.post(`/api/v1/sessions`, this.user)
        .then(response => {
          console.log(response.data)
          let e = response.data
          alert(e.message)
          this.$router.push({ path: `/users/${e.user_id}`});
        })
        .catch(error => {
          console.error(error)
          if (error.response.data && error.response.data.errors) {
              this.errors = error.response.data.errors;
            }
        })
      },
      loginAuth(){
        this.$store.dispatch("login", {
          email: this.user.email,
          password: this.user.password,
        })
      }
    }
    
  }
</script>

<style scoped>
#login-btn{
  margin-top: 20px;
  color: white;
  
}
</style>
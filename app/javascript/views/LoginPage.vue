<template>
  <div class = "container">
    <div class="row">
      <div class="col-md-6 offset-md-3 login-form">
        <h2 class = "text-center">ログイン</h2>
         <form @submit.prevent = "login">
           <div v-if="errors.length != 0">
              <ul v-for="e in errors" :key="e">
                <li><font color="red">{{ e }}</font></li>
              </ul>
            </div>
          <label for="session_email">メールアドレス</label>
          <input class="form-control" type="email" v-model="user.email">
    
          <label for="session_password">パスワード</label>
          <input class="form-control" type="password" v-model="user.password">
          <div class="login-btn">
          <input type="submit" name="commit" value="ログイン" class="btn btn-success" data-disable-with="ログイン">
          </div>
        </form>
        <p class="center">初めてのご利用の方は今すぐ<router-link to="/signup" class="btn" active-class="link--active" exact>新規登録</router-link></p>
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
        axios.post(`/api/v1/sessions`, this.user)
        .then(response => {
          console.log(response.data)
          let e = response.data
          if(e.judge){
            alert(e.message)
            this.$router.push({ path: `/users/${e.user_id}`});
          }else{
            alert(e.message)
            this.$router.go(0)
          }
          
        })
        .catch(error => {
          console.error(error)
          if (error.response.data && error.response.data.errors) {
              this.errors = error.response.data.errors;
            }
        })
      }
    }
    
  }
</script>
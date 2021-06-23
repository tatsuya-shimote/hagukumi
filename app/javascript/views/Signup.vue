<template>
  <div class = "container">
    <div class="row">
      <div class="col-md-6 offset-md-3 login-form">
        <h2 class = "text-center">新規登録</h2>
          <form @submit.prevent="signUpAction" >
            <div v-if="errors.length != 0">
              <ul v-for="e in errors" :key="e">
                <li><font color="red">{{ e }}</font></li>
              </ul>
            </div>
            <label for="user_name">氏名</label>
            <input class="form-control" type="text" v-model="user.name">
            
            <label for="user_email">メールアドレス</label>
            <input class="form-control" type="email" v-model="user.email">
            
            <label for="user_password">パスワード</label>
            <input class="form-control" type="password" v-model="user.password">
      
            <label for="user_password_confirmation">パスワード確認</label>
            <input class="form-control" type="password" v-model="user.password_confirmation">
            <v-app>
              <v-btn color="blue" id="signup-btn" type="submit">登録</v-btn>
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
        user:{
          name:"",
          email:"",
          password:"",
          password_confirmation:"",
        },
        errors: ""
      }
    },
    methods: {
      signUpAction: async function(){
        await this.register()
        await this.signUp()
      },
      signUp: function() {
        axios
          .post('/api/v1/users', this.user,  {headers: { 'X-Requested-With': 'XMLHttpRequest' }}, {withCredentials: true})
          .then(response => {
            alert("登録に成功しました。")
            let e = response.data;
            this.$store.commit("updateUserId", e.id)
            this.$router.push({ path: `/users/${e.id}`});
          })
          .catch(error => {
            console.error(error);
            if (error.response.data && error.response.data.errors) {
              this.errors = error.response.data.errors;
            }
          });
      },
      register: function(){
        if(this.user.name && this.user.password == this.user.password_confirmation){
          this.$store.dispatch("register", {
          email: this.user.email,
          password: this.user.password,
        })
        }
      }
    }
  }
</script>

<style scoped>
#signup-btn{
  margin-top: 20px;
  color: white;
  
}
</style>
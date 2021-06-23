<template>
  <div>
    <v-app>
    <transition name="fade" mode="out-in" appear>
      <div class = "container">
        <h3 id="home-message">
          {{user.name}}さん, 今日もお疲れ様です。<br>
          ハグをして少し休みましょう。
        </h3>
        <div class="card" style="width: 18rem;">
          <div class="card-body">
            <h3 class="card-title">現在の<br>幸福度</h3>
            <p class="card-text">100</p>
              <HugRegisterDialog :hug="hug"></HugRegisterDialog>
          </div>
        </div>
        <p class="comment">コメント：とても幸せですね。その幸せを大切に，感謝を忘れずに</p>
        <img src="../images/hagukumi_icon.png" id = "app-icon">
      </div>
    </transition>
    <v-overlay
      :absolute="absolute"
      :value="this.$store.state.overlay"
    >
      <v-btn
        color="primary"
        @click="changeOverlay"
      >
        閉じる
      </v-btn>
      <HugRegisterDialog :hug="hug"></HugRegisterDialog>
      <UserCalender :hug="hug"></UserCalender>
    </v-overlay>
    </v-app>
  </div>
</template>

<script>
import UserCalender from './UserCalender.vue'
import HugRegisterDialog from './HugRegisterDialog.vue'
import axios from "axios"

let now = new Date()
let year = now.getFullYear()
let month = now.getMonth() + 1
let date = now.getDate()

  export default {
    data(){
      return {
        dialog: false,
        absolute: true,
        user: {},
        focus: '',
        hug: {
          count: 3,
          year: year,
          month: month,
          date: date,
          hugId: ""
        },
        
        }
    },
    components: {
      UserCalender,
      HugRegisterDialog
    },
    methods:{
        changeOverlay(){
          this.$store.commit("changeOverlay", false)
        },
        reset () {
        this.$refs.form.reset()
      },
      
    },
     created(){
      axios.get(`/api/v1/users/${this.$route.params.id}.json`)
      .then(response => {
        const e = response.data
        if(e.judge){
          this.$router.push("/login");
        }
        this.user = response.data //これ本番はまずい書き方？password_digestまでわかる。
      })
    },
    mounted(){
      this.$store.commit("loadUserHugInfo")
    }
  }
</script>



<style scoped>
@import url('https://fonts.googleapis.com/css2?family=RocknRoll+One&display=swap');
.fade-enter {
  opacity: 0;
}

.fade-enter-active{
  transition: opacity 2.0s;
}
.container{
  text-align: center;
}
.card{
  margin: 30px auto;
}

.card-title{
  font-size: 50px;
  letter-spacing: 16px;
  font-family: 'RocknRoll One', sans-serif;
}
.card-text{
  font-family: 'Shippori Mincho', serif;
  letter-spacing: 3px;
  font-size: 30px;
}

#home-message{
  margin-top: 30px;
  font-family: 'Shippori Mincho', serif;
  letter-spacing: 3px;
  font-size: 20px;
  line-height: 40px;
}

#app-icon{
  width: 200px;
}

.hug-record{
  color: white;
}
</style>
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
            <router-link :to="{ name: 'calender'}">
              <v-btn color="blue" id="hug-record">
                今日のハグを記録
              </v-btn>
            </router-link>
          </div>
        </div>
        <p class="comment">コメント：とても幸せですね。その幸せを大切に，感謝を忘れずに</p>
        <img src="../images/hagukumi_icon.png" id = "app-icon">
      </div>
    </transition>
    <router-view></router-view>
    </v-app>
  </div>
</template>

<script>
import axios from "axios"
  export default {
    data(){
      return {
        alert: true,
        user: {}
      }
    },
     mounted(){
      axios.get(`/api/v1/users/${this.$route.params.id}.json`)
      .then(response => {
        const e = response.data
        if(e.judge){
          this.$router.push("/login");
        }
        this.user = response.data //これ本番はまずい書き方？password_digestまでわかる。
      })
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

#hug-record{
  color: white;
}
</style>
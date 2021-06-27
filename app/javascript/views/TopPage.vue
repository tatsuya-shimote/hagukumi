<template>
  <div>
    <transition name="fade" mode="out-in" appear>
      <div id="app-title" v-if="animate">
        <h1 id="app-name">Hugクミ</h1>
        <h3 id="app-name-subtitle">~あなたのHugをかぞえましょう~</h3>
      </div>
    </transition>
    <transition name="fade" mode="out-in" appear>
      <v-container id="start-to-hugkumi">
        <h4 id="login-text">Hugの数だけ幸せになれる...</h4>
        <v-btn color="#F8BBD0"><router-link to='/login' id="login-btn">迷わず始める</router-link></v-btn>
      </v-container>
    </transition>
    <v-lazy
        :options="{
          threshold: 1
        }"
        min-height="200"
      >
      <transition name="slide" mode="out-in">
        <div class = "container sub-section" id="section1">
          <div class="sub-section-texts">
            <h2>Hugの習慣化を手助けします。</h2>
            <p class="text">あなたは１日のハグを記録するだけ。ハグの回数に応じて幸せポイントが貯まっていきます。</p>
          </div>
        </div>
      </transition>
    </v-lazy>
    <v-lazy
        :options="{
          threshold: 1
        }"
        min-height="200"
      >
      <transition name="slide" mode="out-in">
        <div class="container sub-section" id="section2">
          <div class="sub-section-texts">
            <h2>ハグの効果は絶大</h2>
            <p class="text">リラックス効果，ストレス軽減，信頼関係が深まる。そして，<span id="is-happy">幸福感が増す。</span>
            <br>ハグを習慣化することで幸せになろう。</p>
          </div>
        </div>
      </transition>
    </v-lazy>
    <v-lazy
        :options="{
          threshold: 1
        }"
        min-height="200"
      >
      <transition name="slide" mode="out-in">
      <div class="container sub-section" id="section3">
        <div class="sub-section-texts">
          <h2>Hugは誰といつするのか？</h2>
          <p class="text">
            家族，恋人，ペット，ぬいぐるみ，枕などなど自分が安心できるものにハグしましょう。
            気持ちが落ち込んだ時，嬉しいことがあったとき，不安なとき，ハグをすることで安心感を得たり，喜びを共有することができます。
          </p>
        </div>
      </div>
      </transition>
    </v-lazy>
  </div>
</template>

<script>
  export default{
    data(){
      return{
        isActive: false,
        animate: true,
      }
    },
  }
</script>

<style scoped>
@import url('https://fonts.googleapis.com/css2?family=RocknRoll+One&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Shippori+Mincho&display=swap');
.fade-enter{
  opacity: 0;
}

.fade-enter-active{
  transition: opacity 2.0s;
}

.slide-enter{
  transform: translateY(50%);
  opacity: 0;
}

.slide-enter-active{
  transition: all 2.0s;
}


#app-name{
  font-size: 70px;
  letter-spacing: 16px;
  font-family: 'RocknRoll One', sans-serif;
  color: #feffff;
}
#app-title{
  height: 500px;
  text-align: center;
  padding-top: 200px;
  box-sizing: border-box;
  background-image: url('../images/hagukumi_top_image.2.jpeg');
  background-size: cover;
  background-color: rgba(255,255,255,0.4);
  background-blend-mode: lighten;
}

#app-name-subtitle{
  font-family: 'Shippori Mincho', serif;
  color: #ffffff;
  letter-spacing: 3px;
  font-size: 18px;
  line-height: 120px;
}

.sub-section{
  font-family: 'Shippori Mincho', serif;
  color: #1d1d3c;
  height: 350px;
  margin: 40px auto;
  letter-spacing: 1.5px;
  
}

#start-to-hugkumi{
  margin-top: 20px;
  text-align: center;
  padding-bottom: 40px;
  border-radius: 10px;
  
}

#login-text{
  font-family: 'Shippori Mincho', serif;
  color: #828080;
  letter-spacing: 3px;
  font-size: 22px;
  line-height: 100px
}

#login-btn{
  color: white;
  text-decoration: none;
}

#is-happy{
  font-size: 20px;
  font-weight: 600;
  border-bottom: 3px solid rgba(249,203,118,0.8);
}

#section1{
  box-shadow: 1px 1px 10px 1px #999;
  border-radius: 10px;
  background-image: url('../images/hug_circle.jpg');
  background-size: cover;
  background-color: rgba(255,255,255,0.7);
  background-blend-mode: lighten;
}

#section3{
  box-shadow: 1px 1px 10px 1px #999;
  border-radius: 10px;
  background-image: url('../images/hug_kitty.jpg');
  background-size: cover;
  background-color: rgba(255,255,255,0.7);
  background-blend-mode: lighten;
}

.sub-section-texts{
  text-align: center;
  padding-top: 95px;
}

.text{
  font-size: 15px;
}

@media screen and (min-width:768px) { 
  #app-title{
    background-image: url('../images/hagukumi_top_image.jpeg');
  }
}

</style>
<template>
  <div>
    <transition name="fade" mode="out-in" appear>
      <div id="app-title" v-if="animate">
        <h1 id="app-name">Hugクミ</h1>
        <h4 id="app-name-subtitle">~あなたのHugをかぞえましょう~</h4>
        <!--<img src="./images/hagukumi_icon.png" id="hughug-flowers">-->
      </div>
    </transition>
    <v-lazy
        :options="{
          threshold: 1
        }"
        min-height="200"
      >
      <transition name="slide" mode="out-in">
        <div class = "container sub-section">
            <h2>日本の幸福度ランキングは右肩下がり！！</h2>
            <p>
              日本は世界幸福度ランキング５８位。主要先進国G7の中では圧倒的に低い順位である。
              上位を占める国は北欧であり，このことから日本に足りないことが明らかになった。
              <span>それはハグだ</span>
            </p>
        </div>
      </transition>
    </v-lazy>
    <v-lazy
        :options="{
          threshold: 1
        }"
        min-height="200"
      >
      <transition name="slide-reverse" mode="out-in">
        <div class="container sub-section">
          <h2>ハグの効果は絶大</h2>
          <p>リラックス効果，ストレス軽減，信頼関係が深まる。そして，<span>幸福感が増す！！</span>
          ハグを習慣化することで幸せになろう。</p>
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
      <div class="container sub-section">
        <h2>あなたのハグの習慣化の手助けをします。</h2>
        <p>このアプリはあなたの１日のハグ時間を記録し，現在のあなたの幸福度を１００点満点で計算します。</p>
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
  transform: translateX(-100%);
  opacity: 0;
}

.slide-enter-active{
  transition: all 2.0s;
}

.slide-reverse-enter{
  transform: translateX(100%);
  opacity: 0;
}

.slide-reverse-enter-active{
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
  background-image: url('../images/hagukumi_top_image.jpeg');
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
#hughug-flowers{
  height: 300px;
  width: 20%;
}

.sub-section{
  margin-top: 80px;
}



</style>
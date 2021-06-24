<template>
  <div>
    <nav class = "navbar navbar-expand headnav">
      <div class="container-fluid" @click='resetEvents'>
        <a class = "button" active-class="link--active" @click="back">戻る</a>
      </div>
    </nav>
  </div>
</template>

<script>
import axios from "axios"
export default {
  data(){
    return {
      
    }
  },
  methods:{
    
    resetEvents(){
      this.$store.commit("resetEvents")
    },
    
    back(){
      this.$router.push(`/users/${this.$route.params.id}`)
    }
    
  },
}

</script>

<style scoped>
.headnav{
  height: 50px;
  border-bottom: solid 1px rgba(0,0,0,0.7);
}
.button {
  margin-right: 10px;
  display: inline-block;
  position: relative;
  overflow: hidden;
  color: #000;
  text-decoration: none;
}

.button:after {
  position: absolute;
  bottom: 0;
  left: 0;
  width: 100%;
  height: 1px;
  background-color: #000;
  transform: translate(-100%, 0);
  transition: transform cubic-bezier(0.215, 0.61, 0.355, 1) 0.4s;
  content: "";
}

.button:hover:after {
  transform: translate(0, 0);
}
</style>
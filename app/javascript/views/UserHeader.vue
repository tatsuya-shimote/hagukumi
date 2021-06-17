<template>
  <div>
    <nav class = "navbar navbar-expand headnav">
      <div class="container-fluid">
        <router-link to="/" class="navbar-brand" active-class="link--active" exact>Hugクミ</router-link>
        <ul class="navbar-nav ml-auto">
            <li class="nav-item mr-4"><a class = "button" active-class="link--active" @click="changeOverlay">記録カレンダー</a></li> 
        </ul>
    </div>
    </nav>
  </div>
</template>
<script>
export default {
    data(){
      return {
        }
      },
      methods:{
        changeOverlay(){
          this.$store.commit("changeOverlay", true)
        }
      }
}

</script>

<style scoped>
.headnav{
  height: 50px;
  border-bottom: solid 1px rgba(0,0,0,0.7);
}
</style>
<template>
  <div>
    <nav class = "navbar navbar-expand headnav">
      <div class="container-fluid">
        <router-link to="/" class="navbar-brand" active-class="link--active" exact>Hugクミ</router-link>
        <template v-if="this.$store.getters.idToken">
            <router-link :to="{name: 'user-home', params: {id: this.$store.getters.userId}}" class = "button" active-class="link--active" exact>ユーザーページ</router-link></li> 
        </template>
        <template v-else>
          <ul class="navbar-nav ml-auto">
              <li class="nav-item mr-4"><router-link to="/signup" class = "button" active-class="link--active" exact>新規登録</router-link></li> 
              <li class="nav-item mr-1"><router-link to="/login" class="button" active-class="link--active" exact>ログイン</router-link></li>
          </ul>
        </template>
      </div>
    </nav>
  </div>
</template>

<script>
  export default {
    data(){
      return {
        drawer: false
      }
    }
  }
</script>

<style scoped>
.headnav{
  height: 50px;
  border-bottom: solid 1px rgba(0,0,0,0.7);
}
.button {
  margin-right: 5px;
  display: inline-block;
  position: relative;
  overflow: hidden;
  color: #000;
  text-decoration: none;
  top: 3px;
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
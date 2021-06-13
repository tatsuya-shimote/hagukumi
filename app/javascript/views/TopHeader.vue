<template>
  <div>
    <nav class = "navbar navbar-expand headnav">
      <div class="container-fluid">
        <router-link to="/" class="navbar-brand" active-class="link--active" exact>Hugクミ</router-link>
        <ul class="navbar-nav ml-auto">
            <li class="nav-item mr-4"><router-link to="/signup" class="btn" active-class="link--active" exact>新規登録</router-link></li> 
            <li class="nav-item mr-1"><router-link to="/login" class="btn" active-class="link--active" exact>ログイン</router-link></li>
        </ul>
    </div>
    </nav>
  </div>
</template>

<style scoped>
.headnav{
  height: 50px;
  border-bottom: solid 1px rgba(0,0,0,0.7);
}
</style>
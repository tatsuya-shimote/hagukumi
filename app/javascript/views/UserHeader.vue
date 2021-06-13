<template>
  <div>
    <nav class = "navbar navbar-expand headnav">
      <div class="container-fluid">
        <router-link to="/" class="navbar-brand" active-class="link--active" exact>Hugクミ</router-link>
        <ul class="navbar-nav ml-auto">
            <li class="nav-item mr-4">記録</li> 
            <li class="nav-item mr-1">メニュー</li>
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
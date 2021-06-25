<template>
  <div id="app">
    <v-app>
      <router-view name="header"></router-view>
      <router-view></router-view>
    </v-app>
  </div>
</template>

<script>
export default {
  data: function () {
    return {
      message: "Hello Vue!"
    }
  },
}
</script>



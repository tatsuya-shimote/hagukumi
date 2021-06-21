<template>
  <div>
    <nav class = "navbar navbar-expand headnav">
      <div class="container-fluid">
        <router-link to="/" class="navbar-brand" active-class="link--active" exact>Hugクミ</router-link>
      </div>
      <v-app-bar-nav-icon @click.stop="changeDrawer"></v-app-bar-nav-icon>
    </nav>
    <v-navigation-drawer
        :value="this.$store.state.drawer"
        absolute
        right
        mobile-breakpoint="400"
        bottom
        temporary
      >
      <v-card
        class="mx-auto"
        max-width="300"
        tile
      >
        <v-list flat>
          <v-subheader>ユーザーメニュー</v-subheader>
          <v-list-item-group
            v-model="selectedItem"
            color="primary"
          >
            <v-list-item>
              <v-list-item-content>
                <v-list-item-title>
                  <a class = "button" active-class="link--active" @click="changeBoolean">記録カレンダー</a>
                </v-list-item-title>
              </v-list-item-content>
            </v-list-item>
            <v-list-item>
              <v-list-item-content>
                <v-list-item-title>
                  <a class = "button" active-class="link--active" @click="logout">ログアウト</a>
                </v-list-item-title>
              </v-list-item-content>
            </v-list-item>
          </v-list-item-group>
        </v-list>
      </v-card>
    </v-navigation-drawer>
  </div>
</template>
<script>
import axios from "axios"
export default {
  data(){
    return {
      selectedItem: 1,
    }
  },
  methods:{
    
    changeOverlay(){
      this.$store.commit("changeOverlay", true)
    },
    
    changeDrawer(){
      this.$store.commit("changeDrawer")
    },
    
    logout(){
      axios.delete(`/api/v1/sessions/${this.$route.params.id}`)
      .then(response => {
        console.log(response)
        this.$router.push("/")
      })
    },
    
    changeBoolean(){
      this.changeDrawer()
      this.changeOverlay()
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
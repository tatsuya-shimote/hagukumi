<template>
  <div>
    <nav class = "navbar navbar-expand headnav">
      <div class="container-fluid" @click='resetEvents'>
        <router-link to="/" class="navbar-brand" active-class="link--active" exact>Hugクミ</router-link>
      </div>
      
      <v-app-bar-nav-icon @click.stop="changeDrawer"></v-app-bar-nav-icon>
    </nav>
    <v-navigation-drawer
        :value="this.$store.state.drawer"
        fixed
        right
        temporary
        id="user-menu"
      >
        <v-list flat>
          <v-subheader>
            ユーザーメニュー
            <v-avatar color="indigo" id="user-avater">
              <img :src="this.$store.getters.userImage" v-if="this.$store.getters.userImage">
              <v-icon dark v-else>
                mdi-account-circle
              </v-icon>
            </v-avatar>
          </v-subheader>
          <v-list-item-group
            v-model="selectedItem"
            color="primary"
          >
            
            <v-list-item>
              <v-list-item-content>
                <v-list-item-title>
                  <v-icon color="primary">mdi-home</v-icon>
                  <a class = "button" active-class="link--active" @click="userHome">
                    ホーム
                  </a>
                </v-list-item-title>
              </v-list-item-content>
            </v-list-item>
            
            <v-list-item>
              <v-list-item-content>
                <v-list-item-title>
                  <v-icon color="primary">mdi-account-group</v-icon>
                  <a class = "button" active-class="link--active" @click="userIndex">
                    ユーザー一覧
                  </a>
                </v-list-item-title>
              </v-list-item-content>
            </v-list-item>
            
            <v-list-item>
              <v-list-item-content>
                <v-list-item-title>
                  <v-icon color="primary">mdi-account</v-icon>
                  <a class = "button" active-class="link--active" @click="profile">
                    プロフィール
                  </a>
                </v-list-item-title>
              </v-list-item-content>
            </v-list-item>
            
            <v-list-item>
              <v-list-item-content>
                <v-list-item-title>
                  <v-icon color="primary">mdi-account-edit</v-icon>
                  <a class = "button" active-class="link--active" @click="profileEdit">
                    プロフィール編集
                  </a>
                </v-list-item-title>
              </v-list-item-content>
            </v-list-item>
            
            <v-list-item>
              <v-list-item-content>
                <v-list-item-title>
                  <v-icon color="primary">mdi-logout</v-icon>
                  <a class = "button" active-class="link--active" @click="logout">
                    ログアウト
                  </a>
                </v-list-item-title>
              </v-list-item-content>
            </v-list-item>
            
          </v-list-item-group>
        </v-list>
     
    </v-navigation-drawer>
  </div>
</template>
<script>
import axios from "axios"
export default {
  data(){
    return {
      selectedItem: 1,
      image:""
    }
  },
  methods:{
    getUserImage(){
  
    },
    
    changeOverlay(){
      this.$store.commit("changeOverlay", true)
    },
    
    changeDrawer(){
      this.$store.commit("changeDrawer")
    },
    
    logout(){
      axios.delete(`/api/v1/sessions/${this.$store.getters.userId}`)
      .then(response => {
        alert(response.data.message)
        this.$store.commit("updateUserId", null)
        this.$store.commit("updateIdToken", null)
        this.$store.commit("resetEvents")
        this.changeDrawer()
        this.$router.push("/")
      })
    },
    
    
    resetEvents(){
      this.$store.commit("resetEvents")
    },
    
    userHome(){
      this.changeDrawer()
      this.resetEvents()
      this.$router.push(`/users/${this.$store.getters.userId}`)
    },
    
    userIndex(){
      this.changeDrawer()
      this.$router.push(`/users`)
    },
    
    profile(){
      this.changeDrawer()
      this.$router.push(`/users/${this.$store.getters.userId}/profile`)
    },
    profileEdit(){
      this.changeDrawer()
      this.$router.push(`/users/${this.$store.getters.userId}/edit`)
    },
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
  position: relative;
  top: 4px;
  left: 4px;
}

.button:after {
  position: absolute;
  bottom: 0;
  left: 0;
  width: 100%;
  height: 1px;
  background-color: #000;
  transform: translate(-101%, 0);
  transition: transform cubic-bezier(0.215, 0.61, 0.355, 1) 0.4s;
  content: "";
}

.button:hover:after {
  transform: translate(0, 0);
}

#user-avater{
  margin-left:66px;
}

</style>
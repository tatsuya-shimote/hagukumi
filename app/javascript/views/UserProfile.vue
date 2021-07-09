<template>
  <div>
    <v-container>
      <v-row>
        <v-col cols="12" md="6">
          <v-avatar size="150" v-if="userImage">
            <v-img :src="userImage"></v-img>
          </v-avatar>
          <v-avatar size="150" color="indigo" v-else>
            <v-icon size="100" dark>
              mdi-account-circle
            </v-icon>
          </v-avatar>
          
          <p id="user-name">{{user.name}} 幸福度{{user.hug_count_sum}}pt</p>
          <div v-if="user.id !== this.$store.getters.userId">
            <v-btn color="blue" id="follow-btn" max-width="350" @click="follow" v-if="unfollowing">Follow</v-btn>
            <v-btn color="green accent-4" id="follow-btn" max-width="350" @click="unfollow" v-else>Following</v-btn>
          </div>
          <MicropostsRegistDialog v-else></MicropostsRegistDialog>
          <v-tabs
      v-model="tabs"
      centered
      fixed-tabs
      icons-and-text
      class="mt-4"
    >
      <v-tabs-slider></v-tabs-slider>

      <v-tab href="#tab-1">
        Follow
        <v-icon>mdi-account</v-icon>
      </v-tab>

      <v-tab href="#tab-2">
        Follwer
        <v-icon>mdi-account</v-icon>
      </v-tab>
    </v-tabs>
    <v-tabs-items v-model="tabs">
      <v-tab-item value="tab-1" >
        <v-list flat>
          <v-list-item-group
            color="primary"
          >
            <div v-for="followed in followeds" :key="followed.name">
              <router-link :to="{name:'profile_path', params:{id: followed.id}}">
                <v-list-item
                  class="mt-4"
                >
                  <v-list-item-avatar>
                    <v-img :src="followed.image.url" v-if="followed.image.url"></v-img>
                    <v-avatar color="indigo"v-else>
                      <v-icon dark>
                        mdi-account-circle
                      </v-icon>
                    </v-avatar>
                  </v-list-item-avatar>
                  <v-list-item-content>
                    <v-list-item-title>{{followed.name}}</v-list-item-title>
                  </v-list-item-content>
                </v-list-item>
              </router-link>
            </div>
          </v-list-item-group>
        </v-list>
      </v-tab-item>
      <v-tab-item value="tab-2">
        <v-list flat>
          <v-list-item-group
            color="primary"
          >
            <div v-for="follower in followers" :key="follower.name">
              <router-link :to="{name:'profile_path', params:{id: follower.id}}">
                <v-list-item
                  class="mt-4"
                >
                  <v-list-item-avatar>
                    <v-img :src="follower.image.url" v-if="follower.image.url"></v-img>
                    <v-avatar color="indigo"v-else>
                      <v-icon dark>
                        mdi-account-circle
                      </v-icon>
                    </v-avatar>
                  </v-list-item-avatar>
                  <v-list-item-content>
                    <v-list-item-title>{{follower.name}}</v-list-item-title>
                  </v-list-item-content>
                </v-list-item>
              </router-link>
            </div>
          </v-list-item-group>
        </v-list>
      </v-tab-item>
    </v-tabs-items>
    </v-col>
    <v-col cols="12" md="6">
      <v-list flat>
        <v-subheader>Posts</v-subheader>
          <v-list-item-group
            color="primary"
          >
            <template v-for="userpost in this.$store.getters.userposts">
                <v-list-item
                  :key="userpost.content"
                  class="mt-4"
                >
                  <v-list-item-content>
                    <v-list-item-title>{{userpost.content}}</v-list-item-title>
                  </v-list-item-content>
                </v-list-item>
                <v-divider></v-divider>
            </template>
          </v-list-item-group>
        </v-list>
      </v-col>
      </v-row>
      <v-snackbar
          v-model="snackbar"
          timeout="3000"
          color="light-blue"
        >
          {{ message }}
      </v-snackbar>
    </v-container>
  </div>
</template>

<script>
import axios from "axios"
import MicropostsRegistDialog from "./MicropostsRegistDialog.vue"
  export default{
    data(){
      return{
        user:{},
        followers:[],
        followeds:[],
        userImage:"",
        tabs: null,
        snackbar: false,
        message: "",
        unfollowing: "",
      }
    },
    beforeRouteUpdate(to,from,next){
      this.getUserProfileData(to.params.id)
      next()
    },
    created(){
      this.getUserProfileData(this.$route.params.id)
       axios.get(`/api/v1/users/${this.$route.params.id}/user_microposts`)
      .then(response => {
        console.log(response.data)
        this.$store.commit("getUserPosts", response.data.userposts)
      })
    },
    methods:{
      getUserProfileData(id){
        axios.get(`/api/v1/users/${id}/profile`)
        .then(response => {
          this.user = response.data
          this.unfollowing = response.data.unfollow
          this.userImage = response.data.image.url
          this.$store.commit("updateUserId", response.data.current_user_id)
          this.follower()
          this.followed()
        })
      },
      follow(){
        axios.post(`/api/v1/relationships`,{followed_id: this.user.id})
        .then(response => {
          this.message = response.data.message
          this.unfollowing = response.data.unfollow
          this.follower()
          this.followed()
          this.snackbar = true
        })
      },
      unfollow(){
        axios.delete(`/api/v1/relationships/${this.user.id}`)
        .then(response => {
          this.message = response.data.message
          this.unfollowing = response.data.unfollow
          this.follower()
          this.followed()
          this.snackbar = true
        })
      },
      follower(){
        this.followers = []
        axios.get(`/api/v1/users/${this.$route.params.id}/follower`)
        .then(response => {
          this.followers = response.data
        })
      },
      followed(){
        this.followeds = []
        axios.get(`/api/v1/users/${this.$route.params.id}/following`)
        .then(response => {
          this.followeds = response.data
        })
      },
    },
    components:{
      MicropostsRegistDialog
    }
    
  }
</script>

<style scoped>
@import url('https://fonts.googleapis.com/css2?family=RocknRoll+One&display=swap');
#user-name{
  font-family: 'RocknRoll One', sans-serif;
  font-size: 30px;
}
#follow-btn{
  font-family: 'RocknRoll One', sans-serif;
  position: relative;
  top: 10px;
  color: white;
  font-weight: bold;
}
a{
  text-decoration: none;
}
</style>
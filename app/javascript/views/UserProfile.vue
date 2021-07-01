<template>
  <div>
    <v-container>
      <v-snackbar
        v-model="snackbar"
        timeout="3000"
      >
        {{ message }}
      </v-snackbar>
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
          
          <p id="user-name">{{user.name}}</p>
          <div v-if="user.id !== this.$store.getters.userId">
            <v-btn color="blue" id="follow-btn" max-width="350" @click="follow" v-if="unfollowing">Follow</v-btn>
            <v-btn color="red" id="follow-btn" max-width="350" @click="unfollow" v-else>Unfollow</v-btn>
          </div>
        </v-col>
        <v-col cols="12" md="6">
          <v-card min-height="250">
            <v-card-title>幸福度{{user.hug_count_sum}}pt</v-card-title>
          </v-card>
        </v-col>
     </v-row>
     <v-tabs
      v-model="tab"
      background-color="white"
      centered
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

      <!--<v-tabs-items v-model="tab">-->
      <!--  <v-tab-item-->
      <!--  >-->
      <!--    <v-card flat>-->
      <!--      <v-card-text>こんにちは</v-card-text>-->
      <!--    </v-card>-->
      <!--  </v-tab-item>-->
      <!--</v-tabs-items>-->
    </v-container>
  </div>
</template>

<script>
import axios from "axios"

  export default{
    data(){
      return{
        user:{},
        userImage:"",
        tab: null,
        snackbar: false,
        message: "",
        unfollowing: ""
      }
    },
    created(){
      axios.get(`/api/v1/users/${this.$route.params.id}/profile`)
      .then(response => {
        this.user = response.data
        this.unfollowing = response.data.unfollow
        console.log(this.user)
        this.userImage = response.data.image.url
        this.$store.commit("updateUserId", response.data.current_user_id)
      })
    },
    methods:{
      follow(){
        axios.post(`/api/v1/relationships`,{followed_id: this.user.id})
        .then(response => {
          console.log(response)
          this.message = response.data.message
          this.unfollowing = response.data.unfollow
          this.snackbar = true
        })
      },
      unfollow(){
        axios.delete(`/api/v1/relationships/${this.$store.getters.userId}`)
        .then(response => {
          console.log(response)
          this.message = response.data.message
          this.unfollowing = response.data.unfollow
          this.snackbar = true
        })
      }
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
  position: relative;
  top: 10px;
}
</style>
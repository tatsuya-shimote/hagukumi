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
          <p id="user-name">{{user.name}}</p>
        </v-col>
        <v-col cols="12" md="6">
          <v-card min-height="250">
            <v-card-title>幸福度{{user.hug_count_sum}}pt</v-card-title>
            <v-btn color="#F8BBD0">お裾分け</v-btn>
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
        tab: null
      }
    },
    created(){
      axios.get(`/api/v1/users/${this.$route.params.id}/profile`)
      .then(response => {
        this.user = response.data
        console.log(this.user)
        this.userImage = response.data.image.url
        this.$store.commit("updateUserId", response.data.current_user_id)
      })
    }
  }
</script>

<style scoped>
@import url('https://fonts.googleapis.com/css2?family=RocknRoll+One&display=swap');
#user-name{
  font-family: 'RocknRoll One', sans-serif;
  font-size: 30px;
}
</style>
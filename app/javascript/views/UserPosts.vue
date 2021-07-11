<template>
  <div>
    <v-list flat>
      <v-subheader>Posts</v-subheader>
        <v-list-item-group
          color="primary"
        >
        <template v-for="(userpost, index) in this.$store.getters.userposts">
            <v-list-item
              :key="index"
              class="mt-4"
            >
              <v-list-item-content>
                <v-list-item-title>{{userpost.content}}</v-list-item-title>
              </v-list-item-content>
              <v-btn
                text
                color="red"
                @click="deleteUserpost(userpost.id)"
              >
                削除
              </v-btn>
            </v-list-item>
            <v-divider></v-divider>
        </template>
      </v-list-item-group>
    </v-list>
  </div>
</template>


<script>
import axios from "axios"
  export default{
    beforeRouteUpdate(to,from,next){
      this.getUserPosts(to.params.id)
      next()
    },
    created(){
      this.getUserPosts(this.$route.params.id)
    },
    methods: {
      getUserPosts(id){
        axios.get(`/api/v1/users/${id}/user_microposts`)
        .then(response => {
          console.log(response.data)
          this.$store.commit("getUserPosts", response.data.userposts)
        })
      },
      deleteUserpost(id){
        axios.delete(`/api/v1/microposts/${id}`)
        .then(response => {
          console.log(response.data)
          this.getUserPosts(this.$route.params.id)
        })
      }
    }
  }
</script>
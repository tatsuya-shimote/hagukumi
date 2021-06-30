<template>
  <v-container>
    <v-list flat>
    <v-subheader>ユーザー一覧</v-subheader>
      <v-list-item-group
        v-model="selectedItem"
      >
        <template v-for="(user, index) in users">
          <router-link :to="{name:'profile_path', params:{id: user.id}}">
            <v-list-item
              :key="user.name"
              class="mt-4"
            >
              <v-list-item-avatar>
                <v-img :src="user.image.url" v-if="user.image.url"></v-img>
                <v-avatar color="indigo"v-else>
                  <v-icon dark>
                    mdi-account-circle
                  </v-icon>
                </v-avatar>
              </v-list-item-avatar>
              
    
              <v-list-item-content>
                <v-list-item-title v-text="user.name"></v-list-item-title>
              </v-list-item-content>
            </v-list-item>
          </router-link>
          
        </template>
      </v-list-item-group>
    </v-list>
  </v-container>
</template>


<script>
import axios from "axios"
  export default {
    data(){
      return {
        users: "",
        selectedItem: 1
      }
      
    },
    created(){
      axios.get(`/api/v1/users`)
      .then(response => {
        console.log(response.data)
        this.users = response.data.users
        this.$store.commit("updateUserId", response.data.current_user_id)
      })
    }
  }
</script>

<style scoped>
a{
  text-decoration: none;
}
  
</style>
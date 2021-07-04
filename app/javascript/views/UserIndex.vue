<template>
  <v-container>
    <v-text-field
      solo
      label="ユーザー検索"
      prepend-icon="mdi-account-search"
      v-model="keyword"
    ></v-text-field>

    <v-list flat>
    <v-subheader>ユーザー一覧</v-subheader>
      <v-list-item-group
        color="primary"
      >
        <template v-for="user in searchUsers">
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
                <v-list-item-title>{{user.name}}</v-list-item-title>
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
        keyword: ""
      }
      
    },
    created(){
      axios.get(`/api/v1/users`)
      .then(response => {
        
        this.users = response.data.users
        this.$store.commit("updateUserId", response.data.current_user_id)
      })
    },
    computed:{
      searchUsers(){
        let users = [];
        for (let i in this.users){
          let user = this.users[i]
          if(user.name.indexOf(this.keyword) !== -1) {
            users.push(user);
          }
        }
        return users;
      }
    }
  }
</script>

<style scoped>
a{
  text-decoration: none;
}
  
</style>
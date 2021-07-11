<template>
    <v-row>
      <v-col cols="auto">
        <v-dialog
            transition="dialog-top-transition"
            v-model="dialog"
            max-width="350"
          >
          <template v-slot:activator="{ on, attrs }">
            <v-btn
              color="blue"
              v-bind="attrs"
              v-on="on"
              id="post-record"
            >幸せエピソードの投稿</v-btn>
          </template>
          <template v-slot:default="dialog">
            <v-card min-width="320" max-height="800">
              <v-container>
                <v-card-title>幸せをみんなと分け合おう</v-card-title>
                
                <div v-if="errors.length != 0">
                  <ul v-for="(e, index) in errors" :key="index">
                    <li><font color="red">{{ e }}</font></li>
                  </ul>
                </div>
                
                <v-form
                  ref="form"
                  v-model="valid"
                  lazy-validation
                >
                  <v-textarea
                    v-model="micropost"
                    clearable
                    clear-icon="mdi-close-circle"
                    label="幸せエピソード"
                    :counter="140"
                  ></v-textarea>
                  <v-btn
                    color="blue"
                    class="mr-4"
                    @click="post"
                    id = "post"
                  >
                    投稿
                  </v-btn>
                </v-form>
                
              </v-container>
            </v-card>
          </template>
        </v-dialog>
      </v-col>
      <v-snackbar
          v-model="snackbar"
          timeout="3000"
          color="light-blue"
          text
        >
          {{ message }}
      </v-snackbar>
    </v-row>
</template>

<script>
import axios from "axios"
  export default {
    data(){
      return{
        valid: true,
        dialog: false,
        micropost:"",
        errors:'',
        snackbar: false,
        message: ""
      }
    },
    methods:{
      validate () {
        this.$refs.form.validate()
      },
      post(){
        axios.post(`/api/v1/microposts`,{content: this.micropost}, {headers: { 'X-Requested-With': 'XMLHttpRequest' }}, {withCredentials: true})
        .then(response => {
          console.log(response.data)
          this.getUserPosts()
          this.dialog = false
          this.snackbar = true
          this.message = response.data.message
          this.micropost = ""
          this.errors = ""
        })
        .catch(error => {
            console.error(error);
            if (error.response.data && error.response.data.errors) {
              this.errors = error.response.data.errors;
            }
          });
      },
       getUserPosts(){
        axios.get(`/api/v1/users/${this.$route.params.id}/user_microposts`)
        .then(response => {
          console.log(response.data)
          this.$store.commit("getUserPosts", response.data.userposts)
        })
      },
    }
  }
  
</script>

<style scoped>
@import url('https://fonts.googleapis.com/css2?family=RocknRoll+One&display=swap');
#post,#post-record{
  color: white;
}
#post-record{
  font-family: 'RocknRoll One', sans-serif;
  font-weight: bold;
}

</style>
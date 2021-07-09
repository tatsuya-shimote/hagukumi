<template>
    <v-row justify="space-around">
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
            >ハグエピソードの投稿</v-btn>
          </template>
          <template v-slot:default="dialog">
            <v-card min-width="350" max-height="800">
              <v-container>
                <v-card-title>ハグエピソード</v-card-title>
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
                  <v-text-field
                    v-model="micropost"
                    :counter="140"
                    label="ハグエピソードの投稿"
                  ></v-text-field>
                  
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
        errors:''
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
          this.$store.commit("updateUserposts", this.micropost)
          this.dialog = false
          
        })
        .catch(error => {
            console.error(error);
            if (error.response.data && error.response.data.errors) {
              this.errors = error.response.data.errors;
            }
          });
      },
    }
  }
  
</script>

<style scoped>
#post,#post-record{
  color: white;
}
</style>
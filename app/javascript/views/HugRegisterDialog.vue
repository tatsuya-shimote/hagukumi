<template>
    <v-row justify="space-around">
      <v-col cols="auto">
        <v-dialog
            transition="dialog-top-transition"
            max-width="350"
          >
          <template v-slot:activator="{ on, attrs }">
            <v-btn
              color="blue"
              v-bind="attrs"
              v-on="on"
              class="hug-record"
            >今日のハグを記録</v-btn>
          </template>
          <template v-slot:default="dialog">
            <v-card min-width="350" height="250" class="hug-register">
              <v-card-title>ハグの記録</v-card-title>
                <v-form
                  ref="form"
                  v-model="valid"
                  lazy-validation
                >
                  <v-text-field
                    v-model="hug.count"
                    :counter="10"
                    label="今日のハグ数"
                  ></v-text-field>
            
                  <v-btn
                    color="blue"
                    class="mr-4"
                    @click="record"
                  >
                    記録
                  </v-btn>
              
                </v-form>
            </v-card>
          </template>
        </v-dialog>
      </v-col>
    </v-row>
</template>

<script>
import axios from "axios"
  export default {
    props:["hug"],
    data(){
      return{
        valid: true,
      }
    },
    methods:{
      record(){
        axios.post(`/api/v1/hugs`,this.hug)
        .then(response => {
          console.log(response)
          
        })
        .catch(error => {
            console.error(error);
            if (error.response.data && error.response.data.errors) {
              this.errors = error.response.data.errors;
            }
          });
        
      }
    }
  }
</script>
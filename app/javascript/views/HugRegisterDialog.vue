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
              class="hug-record"
            >今日のハグを記録</v-btn>
          </template>
          <template v-slot:default="dialog">
            <v-card min-width="350" max-height="800" class="hug-register">
              <v-container>
                <v-card-title>ハグの記録</v-card-title>
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
                    v-model="hug.year"
                    :counter="4"
                    label="年(西暦　ex:2021)"
                  ></v-text-field>
                  
                  <v-text-field
                    v-model="hug.month"
                    :counter="2"
                    label="月"
                  ></v-text-field>
                  
                  <v-text-field
                    v-model="hug.date"
                    :counter="2"
                    label="日"
                  ></v-text-field>
                  
                  <v-text-field
                    v-model="hug.count"
                    :counter="10"
                    label="今日のハグ数(数値のみ入力)"
                  ></v-text-field>
            
                  <v-btn
                    color="blue"
                    class="mr-4"
                    @click="record"
                  >
                    記録
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
    props:["hug", "dialog"],
    data(){
      return{
        valid: true,
        errors:''
      }
    },
    methods:{
      validate () {
        this.$refs.form.validate()
      },
      postRecord(){
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
      },
      calenderRecord(){
        this.$store.commit("calenderRecord", {name: `${this.hug.count}`, start: `${this.hug.year}-${this.hug.month}-${this.hug.date}`})
      },
      record(){
        this.postRecord()
        this.calenderRecord()
        this.dialog = false
      }
    }
  }
</script>

<style scoped>
.hug-record{
  color: white;
}
  
</style>
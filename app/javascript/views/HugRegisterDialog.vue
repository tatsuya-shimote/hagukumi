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
              id="hug-record"
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
                    disabled
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
                    id = "record"
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
    props:["hug"],
    data(){
      return{
        valid: true,
        dialog: false,
        errors:''
      }
    },
    methods:{
      validate () {
        this.$refs.form.validate()
      },
      record(){
        axios.post(`/api/v1/hugs`,this.hug, {headers: { 'X-Requested-With': 'XMLHttpRequest' }}, {withCredentials: true})
        .then(response => {
          const e = response.data
          this.dialog = false
          this.$store.commit("calenderRecord", {name: `${e.count}`, start: `${e.year}-${e.month}-${e.date}`, color: "blue", hug_id: `${e.id}`})
          this.errors = ''
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
#hug-record{
  color: white;
}

#record{
  color: white;
}
  
</style>
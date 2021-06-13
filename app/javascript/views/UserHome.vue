<template>
  <div>
    <p>こんにちは{{user.name}}さん</p>
  </div>
</template>

<script>
import axios from "axios"
  export default {
    data(){
      return {
        user: {}
      }
    },
    mounted(){
      axios.get(`/api/v1/users/${this.$route.params.id}.json`)
      .then(response => {
        console.log(response.data)
        this.user = response.data //これ本番はまずい書き方？password_digestまでわかる。
      })
    }
  }
</script>
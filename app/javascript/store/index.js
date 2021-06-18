import Vue from 'vue';
import Vuex from 'vuex';
import router from '../router';
import axios from 'axios'

Vue.use(Vuex);

let now = new Date()
let year = now.getFullYear()
let month = now.getMonth() + 1
let date = now.getDate()

export default new Vuex.Store({
  state: {
    overlay: false,
    events: [{
          name: "アプリを始めた日",
          start:`${year}-${month}-${date}`
        }],
  },
  mutations: {
    changeOverlay(state,overlay) {
      state.overlay = overlay ;
    },
    loadUserHugInfo(state){
      axios.get("/api/v1/hugs.json")
        .then(response => {
          console.log(response)
          const e = response.data;
          Object.keys(e).forEach(key => {
            const userHugInfo = e[key]
            state.events.push({name: `${userHugInfo.count}`, start: "2021-06-19"})
          })
        })
    },
    inputUserHugInfo(state, hugCount){
      state.events.push({name: hugCount, start: "2021-06-21"})
    }
  },
  actions: {
    
  }
});

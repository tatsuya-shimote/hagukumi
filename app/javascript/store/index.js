import Vue from 'vue';
import Vuex from 'vuex';
import router from '../router';
import axios from 'axios'
import axiosAuth from '../axios_auth.js'

Vue.use(Vuex);

let now = new Date()
let year = now.getFullYear()
let month = now.getMonth() + 1
let date = now.getDate()

export default new Vuex.Store({
  state: {
    idToken: null,
    overlay: false,
    drawer: false,
    events: [],
  },
  getters:{
    idToken: state => state.idToken
  },
  mutations: {
    
    changeOverlay(state,overlay) {
      state.overlay = overlay ;
    },
    
    changeDrawer(state) {
      state.drawer = !state.drawer;
    },
    
    updateIdToken(state, idToken) {
      state.idToken = idToken;
    },
    
    calenderRecord(state, newRecord){
      state.events.push(newRecord)
    },
    
    loadUserHugInfo(state){
      axios.get("/api/v1/hugs.json")
        .then(response => {
          const e = response.data;
          Object.keys(e).forEach(key => {
            const userHugInfo = e[key]
            state.events.push({name: `${userHugInfo.count}`, start: `${userHugInfo.year}-${userHugInfo.month}-${userHugInfo.date}`})
          })
        })
    },
  },
  
  actions: {
    
    register({ dispatch, commit }, authData){
      axiosAuth
        .post(`/accounts:signUp?key=${process.env.VUE_APP_FIREBASE_API_KEY}`,{
          email: authData.email,
          password: authData.password,
          returnSecureToken: true
        }).then(response => {
          console.log(response)
          commit('updateIdToken', response.data.idToken)
          // dispatch('setAuthData', {
          //   idToken: response.data.idToken,
          //   expiresIn: response.data.expiresIn,
          //   refreshToken: response.data.refreshToken
          // });
        });
    },
    login({commit, dispatch}, authData){
      axiosAuth
      .post(`/accounts:signInWithPassword?key=${process.env.VUE_APP_FIREBASE_API_KEY}`,{
        email: authData.email,
        password: authData.password,
        returnSecureToken: true
      }).then(response => {
          console.log(response)
          commit('updateIdToken', response.data.idToken)
      });
    }
  }
});

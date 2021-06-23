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
    userId: null,
    events: []
  },
  getters:{
    idToken: state => state.idToken,
    userId: state => state.userId
  },
  mutations: {
    
    changeOverlay(state) {
      state.overlay = !state.overlay ;
    },
    
    changeDrawer(state) {
      state.drawer = !state.drawer;
    },
    
    updateUserId(state, userId) {
      state.userId = userId;
    },
    
    updateIdToken(state, idToken) {
      state.idToken = idToken;
    },
    
    resetEvents(state){
      state.events = []
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
            state.events.push({name: `${userHugInfo.count}`, start: `${userHugInfo.year}-${userHugInfo.month}-${userHugInfo.date}`, color: "blue", hug_id: `${userHugInfo.id}`})
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
          commit('updateIdToken', response.data.idToken)
      });
    }
  }
});

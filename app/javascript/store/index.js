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
    
    loadUserHugInfo(state){
      axios.get("/api/v1/hugs.json")
        .then(response => {
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
    
    // setAuthData({ commit, dispatch }, authData) {
    //   const now = new Date();
    //   const expiryTimeMs = now.getTime() + authData.expiresIn * 1000;
    //   commit('updateIdToken', authData.idToken);
    //   localStorage.setItem('idToken', authData.idToken);
    //   localStorage.setItem('expiryTimeMs', expiryTimeMs);
    //   localStorage.setItem('refreshToken', authData.refreshToken);
      // setTimeout(() => {
      //   dispatch('refreshIdToken', authData.refreshToken);
      // }, authData.expiresIn * 1000);
    // }
    
  }
});

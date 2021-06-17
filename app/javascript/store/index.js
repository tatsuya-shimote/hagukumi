import Vue from 'vue';
import Vuex from 'vuex';
import router from '../router';

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    overlay: false
  },
  mutations: {
    changeOverlay(state,overlay) {
      state.overlay = overlay ;
    }
  },
  actions: {
    
  }
});

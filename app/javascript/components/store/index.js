import Vue from 'vue'
import Vuex from 'vuex'
import axios from 'axios'

import bike from './bike'

Vue.use(Vuex)

const Store = new Vuex.Store({
  state: {
    // isAuth: !!localStorage.isAuth,
    data: '',
    tokens: {},
    user: {}
  },

  getters: {
    isAuth: state => state.isAuth
  },

  modules: {
    bike
  }
})

export default Store
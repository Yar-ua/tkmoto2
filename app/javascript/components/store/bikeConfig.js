import axios from 'axios'
import API from './api'

export default {
  namespaced: true,
  state: {
    addItem: {},
    loading: false
  },

  getters: {
    isLoading (state) {
      return state.loading
    }
  },

  mutations: {
    updateAddItem (state, data) {
      state.addItem = data
      state.loading = false
    },
    setLoading (state, data) {
      state.loading = data
    }
  },

  actions: {

    show (context, params) {
      context.commit('setLoading', true)
      return axios.get(API.bikeConfig(params.id), '')
        .then(response => {
          context.commit('updateAddItem', response.data)
        })
    },
    update (context, params) {
      context.commit('setLoading', true)
      console.log(params.id)
      return axios.put(API.bikeConfig(params.id), params)
        .then(response => {
          context.commit('updateAddItem', response.data)
        })
    }
  }
}
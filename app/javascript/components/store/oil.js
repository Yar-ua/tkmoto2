import axios from 'axios'
import API from './api'

export default {
  namespaced: true,
  state: {
    oilsList: [],
    loading: false,
    oilLastChange: 0
  },
  
  getters: {
    isLoading(state) {
      return state.loading
    }
  },

  mutations: {
    setOilsList (state, data) {
      state.oilsList = data
      state.loading = false
    },
    setLoading (state, data) {
      state.loading = data
    }
  },

  actions: {
    index (context, params) {
      context.commit('setLoading', true)
      return axios.get(API.oils(params.bikeId))
        .then(response => {
          context.commit('setOilsList', response.data)
        })
    }
  }
}
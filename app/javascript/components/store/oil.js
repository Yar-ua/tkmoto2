import axios from 'axios'
import API from './api'

export default {
  namespaced: true,
  state: {
    oilsList: [],
    addItem: [],
    loading: false
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
    updateAddItem (state, data) {
      state.addItem = data
    },
    removeItemFromOilsList (state, data) {
      var items = state.oilsList
      items.splice(items.indexOf(state.oilsList.find(x => x.id === data.id)), 1)
      state.oisList = items
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
    },
    create (context, params) {
      context.commit('setLoading', true)
      return axios.post(API.oils(params.bikeId), params)
        .then(response => {
          if (response.status === 200) {
            context.commit('updateAddItem', response.data)
          }
        })
    },
    show (context, params) {
      context.commit('setLoading', true)
      return axios.get(API.oil(params.bikeId, params.id), params)
        .then(response => {
          if (response.status === 200) {
            context.commit('updateAddItem', response.data)
          }
        })
    },
    update (context, params) {
      context.commit('setLoading', true)
      return axios.put(API.oil(params.bikeId, params.id), params)
        .then(response => {
          if (response.status === 200) {
            context.commit('updateAddItem', response.data)
          }
        })
    },
    delete (context, params) {
      return axios.delete(API.oil(params.bikeId, params.id), '')
        .then(response => {
          if (response.status === 200) {
            context.commit('removeItemFromOilsList', params)
          }
        })
    }    
  }
}
import axios from 'axios'
import API from './api'

export default {
  namespaced: true,
  state: {
    fuelsList: [],
    addItem: {},
    loading: false
  },

  getters: {
    isLoading (state) {
      return state.loading
    }
  },

  mutations: {
    setFuelsList (state, data) {
      state.fuelsList = data
      state.loading = false
    },
    updateAddItem (state, data) {
      state.addItem = data
    },
    updateFuelsList (state, data) {
      var items = state.fuelsList
      items.splice(items.indexOf(state.fuelsList.find(x => x.id === data.id)), 1, data)
      state.fuelsList = items
    },
    removeItemFromFuelsList (state, data) {
      var items = state.fuelsList
      items.splice(items.indexOf(state.fuelsList.find(x => x.id === data.id)), 1)
      state.fuelsList = items
    },
    setLoading (state, data) {
      state.loading = data
    }
  },

  actions: {
    index (context, params) {
      context.commit('setLoading', true)
      return axios.get(API.fuels(params.bikeId))
        .then(response => {
          context.commit('setFuelsList', response.data)
          context.commit('updateAddItem', {})
        })
    },
    create (context, params) {
      context.commit('setLoading', true)      
      return axios.post(API.fuels(params.bikeId), params)
        .then(response => {
          if (response.status === 200) {
            context.commit('updateAddItem', response.data)
          }
        })
    },
    show (context, params) {
      context.commit('setLoading', true)
      return axios.get(API.fuel(params.bikeId, params.id), params)
        .then(response => {
          if (response.status === 200) {
            context.commit('updateAddItem', response.data)
          }
        })
    },
    update (context, params) {
      return axios.put(API.fuel(params.bikeId, params.id), params)
        .then(response => {
          if (response.status === 200) {
            context.commit('updateFuelsList', response.data)
          }
        })
    },
    delete (context, params) {
      return axios.delete(API.fuel(params.bikeId, params.id), '')
        .then(response => {
          if (response.status === 200) {
            context.commit('removeItemFromFuelsList', params)
          }
        })
    }
  }
}
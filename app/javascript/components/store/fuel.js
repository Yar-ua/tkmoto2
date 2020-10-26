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
          // context.commit('setLoading', false)
        })
    },
    create (context, params) {
      context.commit('setLoading', true)      
      return axios.post(API.fuels(params.bikeId), params)
        .then(response => {
          if (response.status === 200) {
            // context.commit('pushFuelsList', response.data.data)
            context.commit('updateAddItem', response.data.data)
          }
        })
    },
    update (context, params) {
      console.log(params)
      // return axios.put(API.fuel(params.bikeId, params.id), params)
      //   .then(response => {
      //     if (response.status === 200) {
      //       context.commit('updateFuelsList', response.data.data)
      //     }
      //   })
    },
    // delete (context, params) {
    //   return axios.delete(API.fuel(params.bikeId, params.id), '')
    //     .then(response => {
    //       if (response.status === 200) {
    //         context.commit('removeItemFromFuelsList', params)
    //       }
    //     })
    // },
    // fuellast (context, params) {
    //   return axios.get(API.bikeFuel(params.id), '')
    //     .then(response => {
    //       try {
    //         context.commit('setOdometer', response.data.data)
    //       } catch (e) {
    //         context.commit('setOdometer', 0)
    //       }
    //     })
    // }
  }
}
import Vue from 'vue'
import Vuex from 'vuex'
import axios from 'axios'

import API from './api'

import errors from './flash/errors'
import bike from './bike'

Vue.use(Vuex)



const Store = new Vuex.Store({
  state: {
    isAuth: localStorage.isAuth == 'true' ? true : false,
    data: '',
    tokens: {
      accessToken: localStorage.accessToken ? localStorage.accessToken : '',
      client: localStorage.client ? localStorage.client : '',
      expiry: localStorage.expiry ? localStorage.expiry : '',
      bearer: localStorage.bearer ? localStorage.bearer : '',
      uid: localStorage.uid ? localStorage.uid : ''
    },
    user: {
      id: localStorage.id ? localStorage.id : null,
      user: localStorage.user ? localStorage.user : null,
      email: localStorage.email ? localStorage.email : null
    }
  },

  getters: {
    isAuth: state => state.isAuth
  },

  modules: {
    errors,
    // home,
    bike
    // fuel,
    // repair,
    // oil,
    // errors,
    // alerts
  },

  mutations: {
    setData (state, data) {
      state.data = data
    },
    updateAuth (state, data) {
      localStorage.isAuth = data
      state.isAuth = data
    },
    updateUser (state, data) {
      localStorage.id = data.data.id
      localStorage.user = data.data.name
      localStorage.email = data.data.email
      state.user = {
        id: data.data.id,
        user: data.data.name,
        email: data.data.email
      }
    },
    updateTokens (state, headers) {
      localStorage.accessToken = headers['access-token']
      localStorage.client = headers['client']
      localStorage.expiry = headers['expiry']
      localStorage.tokenType = headers['token-type']
      localStorage.uid = headers['uid']
      state.tokens = {
        accessToken: headers['access-token'],
        client: headers['client'],
        expiry: headers['expiry'],
        bearer: headers['token-type'],
        uid: headers['uid']
      }
    },
    clearLocalStorage () {
      localStorage.clear()
    }
  },

  actions: {
    sign_up (context, params) {
      return axios.post(API.sign_up, params)
        .then(response => {
          context.commit('updateUser', response.data)
          context.commit('updateAuth', true)
          context.commit('updateTokens', response.headers)
        })
    },
    sign_in (context, params) {
      return axios.post(API.sign_in, params)
        .then(response => {
          context.commit('updateUser', response.data)
          context.commit('updateAuth', true)
          context.commit('updateTokens', response.headers)
        })
    },
    sign_out (context) {
      return axios.delete(API.sign_out, '')
        .then((response) => {
          context.commit('updateUser', {'data': {'id': '', 'name': '', 'email': ''}})
          context.commit('updateAuth', false)
          context.commit('updateTokens', response.headers)
          context.commit('clearLocalStorage', '')
        })
        .catch(err => {
          if (err.response.status !== 200) {
            this.hasError = true
            if ((err.response.status === 401) || (err.response.status === 404)) {
              context.commit('updateUser', {'data': {'id': '', 'name': '', 'email': ''}})
              context.commit('updateAuth', false)
              context.commit('updateTokens', err.response.headers)
              context.commit('clearLocalStorage', '')
            }
          }
        })
    }
  }
})

// Add a request interceptor
axios.interceptors.request.use(function (config) {
  // Do something before request is sent
  setTokensInHeaders(config)
  return config
}, function (error) {
  // Do something with request error
  return Promise.reject(error)
})

// Add a response interceptor
axios.interceptors.response.use(function (response) {
  return response
}, function (error) {
  if (error.response === undefined) {
    Store.commit('errors/setErrors', 'Internal server error')
  } else {
    Store.commit('errors/setErrors', error.response.data.errors)
    // return Promise.reject(error)
  }
})

function setTokensInHeaders (config) {
  config.headers.common['access-token'] = localStorage.accessToken
  config.headers.common['client'] = localStorage.client
  config.headers.common['expiry'] = localStorage.expiry
  config.headers.common['token-type'] = localStorage.tokenType
  config.headers.common['uid'] = localStorage.uid
  config.headers.common['Content-Type'] = 'application/json'
  config.headers.common['Access-Control-Allow-Origin'] = '*'
  config.headers.common['Content-Type'] = 'application/json'
  return config
}


export default Store
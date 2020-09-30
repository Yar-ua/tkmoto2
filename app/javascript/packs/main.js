import Vue from 'vue'
import Vuetify from 'vuetify'
// import 'vuetify/dist/vuetify.min.css'
import App from '../app.vue'
import router from '../components/router'

import store from '../components/store'

Vue.use(Vuetify)

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    router,
    store,
    components: { App },
    template: '<App/>',
    render: h => h(App)
  }).$mount()
  document.body.appendChild(app.$el)

  console.log(app)
})
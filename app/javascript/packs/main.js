import Vue from 'vue'

import VueMaterial from 'vue-material'
import 'vue-material/dist/vue-material.min.css'
import 'vue-material/dist/theme/default.css'
import Vuelidate from 'vuelidate'
import FlashMessage from '@smartweb/vue-flash-message';

import App from '../app.vue'
import router from '../components/router'

import store from '../components/store'

Vue.use(VueMaterial)
Vue.use(Vuelidate)
Vue.use(FlashMessage, {strategy: 'multiple'});

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    router,
    store,
    components: { App },
    template: '<App/>',
    render: h => h(App)
  }).$mount()
  document.body.appendChild(app.$el)
})
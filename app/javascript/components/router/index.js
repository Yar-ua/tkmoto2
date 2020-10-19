import Vue from 'vue'
import Router from 'vue-router'


// by default if you write import xxx from '../bikes' it means 
import About from '../home/About'
import Page404 from '../static/Page404'
import PageNoPermission from '../static/PageNoPermission'
import SignIn from '../SignIn'
import SignUp from '../SignUp'

import Bikes from '../bikes/Bikes'
import BikesSheet from '../bikes/BikesSheet'
import BikeForm from '../bikes/BikeForm'
import BikeItem from '../bikes/BikeItem'
import Test from '../bikes/Test'

import store from '../store'

Vue.use(Router)

export default new Router({
  // mode: 'history',
  routes: [
    // {
    //   path: '/home',
    //   name: 'Home',
    //   component: Bikes
    // },
    {
      path: '/about',
      name: 'About',
      component: About
    },
    {
      path: '/', 
      redirect: { name: 'Bikes' }
    },    
    {
      path: '/sign_up',
      name: 'SignUp',
      component: SignUp
    },
    {
      path: '/sign_in',
      name: 'SignIn',
      component: SignIn
    },
    {
      path: '/no_permission',
      name: 'PageNoPermission',
      component: PageNoPermission
    },
    // bikes CRUD
    {
      path: '/bikes',
      component: BikesSheet,
      children: [
        {
          path: '',
          name: 'Bikes',
          component: Bikes
        },
        {
          path: ':id/edit',
          name: 'BikeEdit',
          component: BikeForm
        },
        {
          path: 'new',
          name: 'BikeForm',
          component: BikeForm,
          beforeEnter (to, from, next) {
            if (store.getters.isAuth) {
              next()
            } else {
              next('/no_permission')
            }
          }
        },
        {
          path: ':id',
          name: 'BikeItem',
          component: BikeItem
        }
      ]
    },
    {
      path: '*',
      name: 'Page404',
      component: Page404
    }
  ]
})
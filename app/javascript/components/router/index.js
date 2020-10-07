import Vue from 'vue'
import Router from 'vue-router'


// by default if you write import xxx from '../bikes' it means 
import About from '../home/About'
import Page404 from '../Page404'
import SignIn from '../SignIn'
import SignUp from '../SignUp'

import Bikes from '../bikes/Bikes'
import BikesSheet from '../bikes/BikesSheet'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/home',
      name: 'Home',
      component: Bikes
    },
    {
      path: '/about',
      name: 'About',
      component: About
    },
    {
      path: '/',
      name: 'Bikes',
      component: Bikes
    },    
    {
      path: '*',
      name: 'Page404',
      component: Page404
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
    // {
    //   path: '/no_permission',
    //   name: 'PageNoPermission',
    //   component: PageNoPermission
    // },
    // // bikes CRUD
    // // index
    {
      path: '/bikes',
      component: BikesSheet,
      children: [
        {
          path: '',
          name: 'Bikes',
          component: Bikes
        },
    //     {
    //       path: ':id(\\d+|new)',
    //       name: 'BikeForm',
    //       component: BikeForm,
    //       beforeEnter (to, from, next) {
    //         if (store.getters.isAuth) {
    //           next()
    //         } else {
    //           next('/no_permission')
    //         }
    //       }
    //     },
    //     {
    //       path: ':id(\\d+)/show',
    //       name: 'BikeItem',
    //       component: BikeItem,
    //       children: [
    //         {
    //           path: 'config',
    //           name: 'BikeConfig',
    //           component: BikeConfig
    //         },
    //         {
    //           path: 'fuels',
    //           name: 'Fuels',
    //           component: Fuels
    //         },
    //         {
    //           path: 'repairs',
    //           name: 'Repairs',
    //           component: Repairs
    //         },
    //         {
    //           path: 'oil',
    //           name: 'Oil',
    //           component: Oil
    //         }
    //       ]
    //     }
      ]
    }
  ]
})
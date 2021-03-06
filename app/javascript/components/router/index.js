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
import BikeInfo from '../bikes/BikeInfo'

import BikeConfigsSheet from '../bikes/BikeConfigsSheet'
import BikeConfigs from '../bikes/BikeConfigs'
import BikeConfigForm from '../bikes/BikeConfigForm'

import FuelSheet from '../fuels/FuelSheet'
import FuelTable from '../fuels/FuelTable'
import FuelForm from '../fuels/FuelForm'

import OilSheet from '../oils/OilSheet'
import OilTable from '../oils/OilTable'
import OilForm from '../oils/OilForm'

import store from '../store'

Vue.use(Router)

export default new Router({
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
          component: BikeItem,
          redirect: { name: 'BikeInfo' },
          children: [
            {
              path: 'info',
              name: 'BikeInfo',
              component: BikeInfo
            },
            // fuels CRUD
            {
              path: 'fuels',
              component: FuelSheet,
              children: [
                {
                  path: '',
                  name: 'FuelTable',
                  component: FuelTable
                },
                {
                  path: ':fuel_id',
                  name: 'FuelForm',
                  component: FuelForm
                },
                {
                  path: ':fuel_id/edit',
                  name: 'FuelEdit',
                  component: FuelForm
                }
              ]
            },
            // oils CRUD
            {
              path: 'oils',
              component: OilSheet,
              children: [
                {
                  path: '',
                  name: 'OilTable',
                  component: OilTable
                },
                {
                  path: ':oil_id',
                  name: 'OilForm',
                  component: OilForm
                },
                {
                  path: ':oil_id/edit',
                  name: 'OilEdit',
                  component: OilForm
                }
              ]
            },
            {
              path: 'settings',
              component: BikeConfigsSheet,
              children: [
                {
                  path: '',
                  name: 'BikeConfigs',
                  component: BikeConfigs
                },
                {
                  path: 'edit',
                  name: 'BikeConfigForm',
                  component: BikeConfigForm
                }
              ]
            },
          ]
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
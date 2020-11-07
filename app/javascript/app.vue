<template>
  <div id="app">
    
  <div class="page-container">
    <md-app md-waterfall md-mode="fixed">
      <md-app-toolbar class="md-large md-dense md-primary">
        <div class="md-toolbar-row">
          <div class="md-toolbar-section-start">
            <md-button class="md-icon-button" @click="menuVisible = !menuVisible">
              <md-icon>menu</md-icon>
            </md-button>
            
            <span class="md-title">TKMoto</span>
            <app-navlinks></app-navlinks>
          </div>

          <div class="md-toolbar-section-end">
            <md-button class="md-icon-button">
              <md-icon>more_vert</md-icon>
            </md-button>
          </div>
        </div>

      </md-app-toolbar>

      <md-app-drawer :md-active.sync="menuVisible">
        <md-toolbar class="md-transparent" md-elevation="0">Navigation</md-toolbar>
          <app-navigation></app-navigation>
        </md-list>
      </md-app-drawer>
      
      <md-app-content>
        
        <p>{{ message }} :/ isAuth: {{ isAuth }} || user: {{ user }} -------</p>
        <app-flash></app-flash>
        <router-view/>
        
      </md-app-content>
    </md-app>
  </div>


  </div>
</template>

<script>

import { mapState } from 'vuex'

import Navigation from './components/Navigation'
import NavLinks from './components/NavLinks'
import Flash from './components/Flash'
import Bikes from './components/bikes/Bikes'

export default {
  message: "Hello Vue!",
  name: 'App',
  drawer: false,
  components: {
    'app-navigation': Navigation,
    'app-navlinks': NavLinks,
    'app-flash': Flash,
    'app-bikes': Bikes
  },
  props: {
    source: String
  },
  data: () => ({
    message: "Debug info",
    menuVisible: false
  }),
  computed: {
    ...mapState({
      user: 'user'
    }),
    isAuth () { return this.$store.getters.isAuth }
  },
}
</script>


<style lang="scss" scoped>

  @import url("https://fonts.googleapis.com/css?family=Material+Icons");
  
  .md-app {
    border: 5px solid rgba(#000, .12);
  }

   /* Demo purposes only */
  .md-drawer {
    width: 230px;
    max-width: calc(100vw);
  }
</style>

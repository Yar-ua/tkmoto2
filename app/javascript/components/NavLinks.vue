<template>
  <md-tabs class="md-primary">
    <md-tab id="tab-bikes" md-label="Bikes" :to="{name: 'Bikes'}"></md-tab>
    <md-tab id="tab-about" md-label="About" :to="{name: 'About'}"></md-tab>
    <md-tab id="tab-logout" md-label="Log-out" @click="logoutAction"></md-tab>
    <md-tab v-if=!isAuth id="tab-signup" md-label="Sign-up" :to="{name: 'SignUp'}"></md-tab>    
    <md-tab v-if=!isAuth id="tab-signin" md-label="Sign-in" :to="{name: 'SignIn'}"></md-tab>
    <md-tab id="tab-test" md-label="test" @click="testAction"></md-tab>
  </md-tabs>
</template>


<script>
import { mapState } from 'vuex'
import axios from 'axios'

export default {
  name: 'NavLinks',
  data: () => ({
    drawer: false
  }),
  computed: {
    ...mapState({
      user: 'user'
    }),
    isAuth: function () { return this.$store.getters.isAuth }
  },
  methods: {
    logoutAction: function () {
      this.$store.dispatch('sign_out', '')
      
      .then((response) => {
        this.$router.push({name: 'Home'})
        this.flashMessage.show({
          status: 'success',
          title: 'Success',
          message: 'You logouted cussessfully'
        })
      })
    },
    testAction: function () {
      console.log('test action')
      axios.get('/bikes/1.json', '')
        .then(response => {
          console.log(response)
        })
    }
  }
}
</script>
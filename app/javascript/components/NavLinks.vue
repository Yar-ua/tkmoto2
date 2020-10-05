<template>
  <md-tabs class="md-primary">
    <md-tab id="tab-home" md-label="Home" :to="{name: 'Home'}"></md-tab>
    <md-tab id="tab-about" md-label="About" :to="{name: 'About'}"></md-tab>
    <md-tab id="tab-signin" md-label="Sign-in" :to="{name: 'SignIn'}"></md-tab>
    <md-tab id="tab-signup" md-label="Sign-up" :to="{name: 'SignUp'}"></md-tab>
    <md-tab id="tab-signout" md-label="Log-out" @click="logoutAction"></md-tab>
  </md-tabs>
</template>


<script>
import { mapState } from 'vuex'

export default {
  name: 'NavLinks',
  data: () => ({
    drawer: false,
    flash: false
  }),
  computed: {
    ...mapState({
      user: 'user'
    }),
    isAuth () { return this.$store.getters.isAuth }
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
    }
  }
}
</script>
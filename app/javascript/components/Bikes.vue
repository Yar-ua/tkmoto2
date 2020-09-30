<template>
  <v-container fluid grid-list-lg>
      <h4>{{ msg }}</h4>
      <h6>{{ bikes }}</h6>
  </v-container>
</template>

<script>
// import { mapState, mapGetters } from 'vuex'
import axios from 'axios'
export default {
  name: 'Bikes',
  body: '',
  data () {
    return {
      msg: 'Bikes list',
      bikes: []
    }
  },
  created() {
    axios
      .get('/bikes.json')
      .then(response => (this.bikes = response.data))
      .catch(error => console.log(error));
  }
//   computed: {
//     ...mapState('bike', {
//       bikesList: 'addsList'
//     }),
//     ...mapGetters('bike', ['isLoading']),
//     ...mapState({
//       user: 'user'
//     }),
//     isAuth () { return this.$store.getters.isAuth }
//   },
//   created () {
//     this.$store.dispatch('bike/index', '')
//   }
}
</script>
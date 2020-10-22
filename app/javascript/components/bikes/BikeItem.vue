<template>
  <div class="card-expansion">
    <md-card>

      <md-card-header>
        <div class="md-title">Bike: {{ item.name }}</div>
        <app-bike-nav></app-bike-nav>
        <router-view/>
      </md-card-header>
      
    </md-card>
  </div>
</template>



<script>
import BikeNav from './BikeNav'
import { mapState } from 'vuex'
export default {
  name: 'BikeItem',
  components: {
    'app-bike-nav': BikeNav
  },
  data: () => {
    return {
      dialog: false,
      valid: true
    }
  },
  computed: {
    ...mapState('bike', {
      item: 'addItem'
    })
  },
  created () {
    this.$store.dispatch('bike/show', {id: this.$route.params.id})
  }
}
</script>


<style lang="scss" scoped>
  .card-expansion {
    height: 90%;
  }

  .md-card {
    width: 95%;
    margin: 4px;
    display: inline-block;
    vertical-align: top;
  }
  
  .md-content {
    width: 200px;
    height: 200px;
    display: inline-flex;
    justify-content: center;
    align-items: center;
  }
</style>
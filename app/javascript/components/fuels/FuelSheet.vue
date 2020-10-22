<template>
  <div>
    <md-table v-model="fuelsList" md-card @md-selected="onSelect">
      <md-table-toolbar>
        <h1 class="md-title">Fuels list</h1>
      </md-table-toolbar>

      <md-table-row slot="md-table-row" slot-scope="{ item }" :class="getClass(item)" md-selectable="single">
        <md-table-cell md-label="Odo" md-sort-by="odo">{{ item.odo }}</md-table-cell>
        <md-table-cell md-label="Odo_delta" md-sort-by="odo_delta">{{ item.odo_delta }}</md-table-cell>
        <md-table-cell md-label="Refueling" md-sort-by="refueling">{{ item.refueling }}</md-table-cell>
        <md-table-cell md-label="Fuel price" md-sort-by="price_fuel">{{ item.price_fuel }}</md-table-cell>
        <md-table-cell md-label="Fuel station" md-sort-by="fuel_station">{{ item.fuel_station }}</md-table-cell>
        <md-table-cell md-label="Fuel type" md-sort-by="fuel_type">{{ item.fuel_type }}</md-table-cell>
        <md-table-cell md-label="l per 100 km">---</md-table-cell>
        <md-table-cell md-label="l per 1 km">---</md-table-cell>
        <md-table-cell md-label="km per 1 l">---</md-table-cell>
        <md-table-cell md-label="price per 1 km">---</md-table-cell>
        <md-table-cell md-label="control">---</md-table-cell>
      </md-table-row>
    </md-table>
  </div>
</template>


<script>

import { mapState } from 'vuex'
export default {
  name: 'FuelSheet',
  data: () => {
    return {
      dialog: false,
      valid: true,
      selected: {}
    }
  },
  computed: {
    ...mapState('fuel', {
      fuelsList: 'fuelsList'
    })
  },
  methods: {
      getClass: ({ id }) => ({
        'md-primary': id === 2,
        'md-accent': id === 3
      }),
      onSelect (item) {
        this.selected = item
      }      
  },
  created () {
    this.$store.dispatch('fuel/index', {bikeId: this.$route.params.id})
  }
}
</script>




<style lang="scss" scoped>
  .md-table + .md-table {
    margin-top: 16px
  }
</style>
<template>
  <div>
    <md-table v-model="fuelsList" md-card @md-selected="onSelect">
      <md-table-toolbar>
        <h1 class="md-title">Fuels list
          <md-button class="md-icon-button md-raised md-primary" :to="{name: 'FuelForm', params: {fuel_id: 'new'}}">
            <i class="fas fa-plus-square"></i>
          </md-button>
        </h1>
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
        <md-table-cell md-label="control">
          <md-button class="md-icon-button md-raised md-primary" @click="fuelEdit(item.id)">
            <i class="far fa-edit"></i>
          </md-button>
          <md-button class="md-icon-button md-raised md-accent" @click="fuelDelete(item.id)">
            <i class="far fa-calendar-times"></i>
          </md-button>
        </md-table-cell>
      </md-table-row>
    </md-table>
  </div>
</template>


<script>

import { mapState } from 'vuex'
export default {
  name: 'FuelTable',
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
    },
    fuelEdit (id) {
      this.$router.push({ name: 'FuelEdit', params: {fuel_id: id} })
    },
    fuelDelete (id) {
      if (this.confirmDelete() === true) {
        this.$store.dispatch('fuel/delete', {bikeId: this.$route.params.id, id: id})
          .then(() => {
            this.hasError = false
            this.flashMessage.show({
              status: 'success',
              title: 'Success',
              message: 'Fuel was successfully deleted'
            })
            this.$router.push({name: 'FuelTable'})
          }).catch(err => {
            if (err.response.status !== 200) {
              this.hasError = true
            }
            this.sending = false
          })
      }
    },
    confirmDelete () {
      if (confirm('Are You sure to delete fuel data?')) {
        if (prompt('Type "Yes" to confirm delete') == 'Yes') {
          return true
        } else {
          alert('Not confirmed')
          return false
        }
      }
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
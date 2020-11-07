<template>
  <div>
    <md-table v-model="oilsList" md-card @md-selected="onSelect">
      <md-table-toolbar>
        <h1 class="md-title">Oil change list
          <md-button class="md-icon-button md-raised md-primary" :to="{name: 'OilForm', params: {oil_id: 'new'}}">
            <i class="fas fa-plus-square"></i>
          </md-button>
        </h1>
      </md-table-toolbar>

      <md-table-row slot="md-table-row" slot-scope="{ item }" :class="getClass(item)" md-selectable="single">
        <md-table-cell md-label="Oils change" md-sort-by="oil_change">{{ item.oil_change }}</md-table-cell>
        <md-table-cell md-label="control">
          <md-button class="md-icon-button md-raised md-primary" @click="oilEdit(item.id)">
            <i class="far fa-edit"></i>
          </md-button>
          <md-button class="md-icon-button md-raised md-accent" @click="oilDelete(item.id)">
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
  name: 'OilTable',
  data: () => {
    return {
      dialog: false,
      valid: true,
      selected: {}
    }
  },
  computed: {
    ...mapState('oil', {
      oilsList: 'oilsList'
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
    oilEdit (id) {
      this.$router.push({ name: 'OilEdit', params: {oil_id: id} })
    },
    oilDelete (id) {
      if (this.confirmDelete() === true) {
        this.$store.dispatch('oil/delete', {bikeId: this.$route.params.id, id: id})
          .then(() => {
            this.hasError = false
            this.flashMessage.show({
              status: 'success',
              title: 'Success',
              message: 'Oil was successfully deleted'
            })
            this.$router.push({name: 'OilTable'})
          }).catch(err => {
            if (err.response.status !== 200) {
              this.hasError = true
            }
            this.sending = false
          })
      }
    },
    confirmDelete () {
      if (confirm('Are You sure to delete oil data?')) {
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
    this.$store.dispatch('oil/index', {bikeId: this.$route.params.id})
  }
}
</script>


<style lang="scss" scoped>
  .md-table + .md-table {
    margin-top: 16px
  }
</style>
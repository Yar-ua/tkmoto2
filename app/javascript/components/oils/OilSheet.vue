<template>
  <div>
    <md-table v-model="oilsList" md-card @md-selected="onSelect">
      <md-table-toolbar>
        <h1 class="md-title">Oil change list</h1>
      </md-table-toolbar>

      <md-table-row slot="md-table-row" slot-scope="{ item }" :class="getClass(item)" md-selectable="single">
        <md-table-cell md-label="Oils change" md-sort-by="oil_change">{{ item.oil_change }}</md-table-cell>
        <md-table-cell md-label="control">---</md-table-cell>
      </md-table-row>
    </md-table>
  </div>
</template>


<script>

import { mapState } from 'vuex'
export default {
  name: 'OilSheet',
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
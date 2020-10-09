<template>
  <div class="card-expansion">
    <md-card>

      <md-card-header>
        <div class="md-title">Bike: {{ this.item.name }}</div>
        <div class="md-subhead">Subtitle here</div>
        
        
        <md-card-actions md-alignment="space-between">
          <div>
            <md-button>Settings</md-button>
            <md-button :to="{name: 'BikeForm', params: {id: this.item.id}}">Edit bike</md-button>
          </div>
        </md-card-actions>
        

        <div>
          <md-content>
            <div>
              <h6>year: {{ this.item.year }}</h6>
              <h6>color: {{ this.item.color }}</h6>
              <h6>engine volume, ccm: {{ this.item.volume }}</h6>
            </div>
          </md-content>
          <md-content class="md-primary">Primary</md-content>
          <md-content class="md-accent">Accent</md-content>
        </div>

      </md-card-header>

    </md-card>

  </div>
</template>



<script>
import { mapState } from 'vuex'
export default {
  name: 'BikeItem',
  data: () => {
    return {
      dialog: false,
      valid: true
    }
  },
  computed: {
    ...mapState({
      user: 'user'
    }),
    ...mapState('bike', {
      item: 'addItem',
      config: 'config'
    }),
    // ...mapState('fuel', {
    //   odometer: 'odometer'
    // }),
    // ...mapState('oil', {
    //   oilLastChange: 'oilLastChange'
    // }),
    isAuth () { return this.$store.getters.isAuth },
    // value: function () {
    //   let delta = this.config.oil_change - (this.odometer - this.oilLastChange)
    //   let color = this.getColor(delta)
    //   let text = `<span style="color: ${color}">${delta}</span>`
    //   return text
    // }
  },
  methods: {
    // getColor (value) {
    //   if (value >= 150) {
    //     return ''
    //   } else if ((value <= 100) && (value >= 0)) {
    //     return 'yellow'
    //   } else {
    //     return 'red'
    //   }
    // }
  },
  created () {
    this.$store.dispatch('bike/show', {id: this.$route.params.id})
    console.log(this.item)
    // this.$store.dispatch('fuel/fuellast', {id: this.$route.params.id})
    // this.$store.dispatch('bike/showConfig', {id: this.$route.params.id})
    // this.$store.dispatch('oil/oillast', {id: this.$route.params.id})
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
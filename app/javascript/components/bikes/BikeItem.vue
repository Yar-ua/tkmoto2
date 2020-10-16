<template>
  <div class="card-expansion">
    <md-card>

      <md-card-header>
        <div class="md-title">Bike: {{ item.name }}</div>
        <div class="md-subhead">Subtitle here</div>
        
        
        <md-card-actions md-alignment="space-between">
          <div>
            <md-button>Settings</md-button>
            <md-button class="md-primary" @click="bikeEdit(item.id)">Edit bike</md-button>
            <md-button class="md-accent" @click="bikeDelete(item.id)">Delete bike</md-button>
          </div>
        </md-card-actions>
        

        <div>
          <md-content>
            <div>
              <h6>year: {{ item.year }}</h6>
              <h6>color: {{ item.color }}</h6>
              <h6>engine volume, ccm: {{ item.volume }}</h6>
              <h6>id: {{ item.id }}</h6>
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
    bikeEdit (id) {
      this.$router.push({ name: 'BikeEdit', params: {id: id} })
    },
    bikeDelete (id) {
      if (this.confirmDelete() === true) {
        this.$store.dispatch('bike/delete', {id: this.$route.params.id})
          .then(() => {
            this.hasError = false
            this.flashMessage.show({
              status: 'success',
              title: 'Success',
              message: 'Bike was successfully deleted'
            })
            this.$router.push({name: 'Bikes'})
          }).catch(err => {
            if (err.response.status !== 200) {
              this.hasError = true
            }
            this.sending = false
          })
      }
    },
    confirmDelete () {
      if (confirm('Are You sure? Your bike and all information will be destroyed')) {
        var bikeName = prompt('Enter Your bike name for destroy confirmation', 'sample bikename')
        if (bikeName === this.item.name) {
          return true
        } else {
          alert('Mistake in inputed bike name')
          return false
        }
      }
    },
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
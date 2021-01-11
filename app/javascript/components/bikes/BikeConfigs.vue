<template>
  <md-card-actions md-alignment="space-between">
    <div>
      <h5>bike configuration</h5>
      <br/>
      <p>Bike oil change period, km: {{ item.oil_change }}
        <md-button class="md-primary" :to="{name: 'BikeConfigForm'}">
          <i class="far fa-edit"></i>Edit value
        </md-button>
      </p>
      <hr/>
      <md-button class="md-primary" @click="bikeEdit()">Edit bike</md-button>
      <md-button class="md-accent" @click="bikeDelete()">Delete bike</md-button>
    </div>
  </md-card-actions>
</template>


<script>
  import { mapState } from 'vuex'
  export default {
    name: 'BikeConfigs',
    computed: {
      ...mapState('bikeConfig', {
        item: 'addItem'
      })
    },    
    methods: {
      bikeConfigEdit () {
        this.$router.push({ name: 'BikeConfigForm' })
      },
      bikeEdit () {
        this.$router.push({ name: 'BikeEdit', params: {id: this.$route.params.id} })
      },
      bikeDelete () {
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
      }
    },
    created () {
      this.$store.dispatch('bikeConfig/show', {id: this.$route.params.id})
    }    
  }
</script>
<template>
  <md-card-actions md-alignment="space-between">
    <div>
      <md-button>Settings</md-button>
      <md-button class="md-primary" @click="bikeEdit()">Edit bike</md-button>
      <md-button class="md-accent" @click="bikeDelete()">Delete bike</md-button>
    </div>
  </md-card-actions>
</template>


<script>
  export default {
    name: 'BikeConfigs',
    methods: {
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
    }
  }
</script>
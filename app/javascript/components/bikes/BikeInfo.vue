<template>
  <div class="card-expansion">
    <md-card>
      <md-card-header>
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
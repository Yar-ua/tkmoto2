<template>
  <div>
    <h4>{{ msg }}</h4>
    <div>
      <md-button v-if="isAuth" class="md-raised md-primary" 
        :to="{name: 'BikeForm', params: {id: 'new'}}"
        >
        Create bike
      </md-button>
    </div>
    <template>
      <div class="card-expansion">
        <md-card v-for="item in bikesList" :key="item.message">
          <md-card-media>
            <!--<img src="/assets/examples/card-image-1.jpg" alt="People">-->
          </md-card-media>

          <md-card-header>
            <div class="md-title">Bike name: {{ item.name }}</div>
            <div class="md-subhead">color: {{ item.color }}</div>
            <div class="md-subhead">year: {{ item.year }}</div>
            <div class="md-subhead">engine volume, ccm: {{ item.volume }}</div>
          </md-card-header>

          <md-card-expand>
            <md-card-actions md-alignment="space-between">
              <div>
                <md-button>More</md-button>
                <md-button>Action</md-button>
              </div>

              <md-card-expand-trigger>
                <md-button class="md-icon-button">
                  <md-icon>keyboard_arrow_down</md-icon>
                </md-button>
              </md-card-expand-trigger>
            </md-card-actions>

            <md-card-expand-content>
              <md-card-content>
                Lorem ipsum dolor sit amet, consectetur adipisicing elit. Optio itaque ea, nostrum odio. Dolores, sed accusantium quasi non, voluptas eius illo quas, saepe voluptate pariatur in deleniti minus sint. Excepturi.
              </md-card-content>
            </md-card-expand-content>
          </md-card-expand>
        </md-card>
      </div>
    </template>
  </div>
</template>

<script>
import { mapState, mapGetters } from 'vuex'
export default {
  name: 'Bikes',
  body: '',
  data () {
    return {
      msg: 'Bikes list:'
    }
  },
  computed: {
    ...mapState('bike', {
      bikesList: 'addsList'
    }),
    ...mapGetters('bike', ['isLoading']),
    ...mapState({
      user: 'user'
    }),
    isAuth () { return this.$store.getters.isAuth }
  },
  created () {
    this.$store.dispatch('bike/index', '')
  }
}
</script>



<style lang="scss" scoped>
  /*.card-expansion {*/
    /*height: 480px;*/
  /*}*/

  .md-card {
    width: 320px;
    margin: 4px;
    display: inline-block;
    vertical-align: top;
  }
</style>
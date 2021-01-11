<template>
  <div>

    <form novalidate class="md-layout" @submit.prevent="validateOil($route.params.oil_id)">
      <md-card class="md-layout-item md-size-50 md-small-size-100">
        <md-card-header>
          <div class="md-title">New oil data</div>
        </md-card-header>

        <md-card-content>
          <div class="md-layout md-gutter">
            <div class="md-layout-item md-small-size-100">
              <md-field :class="getValidationClass('oil_change')">
                <label for="oil_change">Oil was changed on this km value, km</label>
                <md-input type="number" name="oil_change" v-model="iitem.oil_change" :disabled="sending" />
                <span class="md-error" v-if="!$v.iitem.oil_change.required">Oil change km value is required</span>
                <span class="md-error" v-else-if="!$v.iitem.oil_change.maxlength">Invalid oil change data length (50 max)</span>
              </md-field>
            </div>
          </div>
        </md-card-content>

        <md-progress-bar md-mode="indeterminate" v-if="sending" />

        <md-card-actions>
          <app-back-button v-bind:is-sending="sending"></app-back-button>
          <div v-if="isAuth">
            <md-button type="submit" class="md-primary" :disabled="sending">Save oil</md-button>
          </div>
        </md-card-actions>
      </md-card>
    </form>

  </div>
</template>

<script>
  import BackButton from '../Back_Button'
  import { mapState } from 'vuex'
  import { validationMixin } from 'vuelidate'
  import {
    required,
    maxLength
  } from 'vuelidate/lib/validators'

  export default {
    components: {
      'app-back-button': BackButton
    },    
    name: 'OilForm',
    mixins: [validationMixin],
    data: () => ({
      oilSaved: false,
      sending: false
    }),
    computed: {
      ...mapState('oil', {
        iitem: 'addItem'
      }),
      isAuth () { return this.$store.getters.isAuth }
    },    
    validations: {
      iitem: {
        oil_change: {
          required,
          maxLength: maxLength(50)
        }
      }
    },
    methods: {
      getValidationClass (fieldName) {
        const field = this.$v.iitem[fieldName]

        if (field) {
          return {
            'md-invalid': field.$invalid && field.$dirty
          }
        }
      },

      saveOil () {
        this.sending = true
        var params = {oil_change: this.iitem.oil_change}
        this.$store.dispatch('oil/create', {bikeId: this.$route.params.id, oil: params})
          .then(() => {
            this.hasError = false
            this.flashMessage.show({
              status: 'success',
              title: 'Success',
              message: 'Oil was successfully created'
            })
            this.$router.push({name: 'OilTable'})
          }).catch(err => {
            if (err.response.status !== 200) {
              this.hasError = true
            }
            this.sending = false
          })        
      },

      updateOil () {
        this.sending = true
        var params = {oil_change: this.iitem.oil_change}
        this.$store.dispatch('oil/update', {bikeId: this.$route.params.id, id: this.$route.params.oil_id, oil: params})
          .then(() => {
            this.hasError = false
            this.flashMessage.show({
              status: 'success',
              title: 'Success',
              message: 'Oil was successfully updated'
            })
            this.$router.push({name: 'OilTable'})
          }).catch(err => {
            if (err.response.status !== 200) {
              this.hasError = true
            }
            this.sending = false
          })        
      },

      validateOil (oil_id) {
        this.$v.$touch()

        if (!this.$v.$invalid) {
          if (oil_id === 'new') {
            this.saveOil()
          } else {
            this.updateOil()
          }
        }
      }
    },
    created () {
      if (this.$route.params.oil_id != 'new') {
        this.$store.dispatch('oil/show', {bikeId: this.$route.params.id, id: this.$route.params.oil_id})
      }
    }
  }
</script>

<style lang="scss" scoped>
  .md-progress-bar {
    position: absolute;
    top: 0;
    right: 0;
    left: 0;
  }
</style>
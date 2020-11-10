<template>
  <div>

    <form novalidate class="md-layout" @submit.prevent="validateBikeConfig($route.params.id)">
      <md-card class="md-layout-item md-size-50 md-small-size-100">
        <md-card-header>
          <div class="md-title">New edit bike settings</div>
        </md-card-header>

        <md-card-content>
          <div class="md-layout md-gutter">
            <div class="md-layout-item md-small-size-100">
              <md-field :class="getValidationClass('oil_change')">
                <label for="oil_change">Oil change period for this bike, km</label>
                <md-input type="number" name="oil_change" v-model="cbitem.oil_change" :disabled="sending" />
                <span class="md-error" v-if="!$v.cbitem.oil_change.required">Oil change km value is required</span>
                <span class="md-error" v-else-if="!$v.cbitem.oil_change.maxlength">Invalid oil change data length (10 max)</span>
              </md-field>
            </div>
          </div>
        </md-card-content>

        <md-progress-bar md-mode="indeterminate" v-if="sending" />

        <md-card-actions>
          <app-back-button v-bind:is-sending="sending"></app-back-button>
          <div v-if="isAuth">
            <md-button type="submit" class="md-primary" :disabled="sending">Save settings</md-button>
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
    name: 'BikeConfigForm',
    mixins: [validationMixin],
    data: () => ({
      sending: false
    }),
    computed: {
      ...mapState('bikeConfig', {
        cbitem: 'addItem'
      }),
      isAuth () { return this.$store.getters.isAuth }
    },    
    validations: {
      cbitem: {
        oil_change: {
          required,
          maxLength: maxLength(10)
        }
      }
    },
    methods: {
      getValidationClass (fieldName) {
        const field = this.$v.cbitem[fieldName]

        if (field) {
          return {
            'md-invalid': field.$invalid && field.$dirty
          }
        }
      },

      updateBikeConfig () {
        this.sending = true
        var params = {oil_change: this.cbitem.oil_change}
        this.$store.dispatch('bikeConfig/update', {id: this.$route.params.id, bike_config: params})
          .then(() => {
            this.hasError = false
            this.flashMessage.show({
              status: 'success',
              title: 'Success',
              message: 'Bike settings was successfully updated'
            })
            this.$router.push({name: 'BikeConfigs'})
          }).catch(err => {
            if (err.response.status !== 200) {
              this.hasError = true
            }
            this.sending = false
          })        
      },

      validateBikeConfig (id) {
        this.$v.$touch()

        if (!this.$v.$invalid) {
          this.updateBikeConfig()
        }
      }
    },
    created () {
      if (this.$route.params.oil_id != 'new') {
        this.$store.dispatch('bikeConfig/show', {id: this.$route.params.id})
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
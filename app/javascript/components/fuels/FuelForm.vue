<template>
  <div>
    <form novalidate class="md-layout" @submit.prevent="validateFuel($route.params.fuel_id)">
      <md-card class="md-layout-item md-size-50 md-small-size-100">
        <md-card-header>
          <div class="md-title">New fuel data</div>
        </md-card-header>

        <md-card-content>
          <div class="md-layout md-gutter">
            <div class="md-layout-item md-small-size-100">
              <md-field :class="getValidationClass('odo')">
                <label for="odo">Odometer value, km</label>
                <md-input type="number" name="odo" v-model="fitem.odo" :disabled="sending" />
                <span class="md-error" v-if="!$v.fitem.odo.required">Odometer value is required</span>
                <span class="md-error" v-else-if="!$v.fitem.odo.maxlength">Invalid odometer data length (50 max)</span>
              </md-field>
            </div>

            <div class="md-layout-item md-small-size-100">
              <md-field :class="getValidationClass('odo_delta')">
                <label for="odo_delta">Odometer delta (kilometrage), km</label>
                <md-input type="number" name="odo_delta" v-model="fitem.odo_delta" :disabled="sending" />
                <span class="md-error" v-if="!$v.fitem.odo_delta.required">Kilometrage is required</span>
                <span class="md-error" v-else-if="!$v.fitem.odo_delta.maxlength">Invalid odometer data length (50 max)</span>
              </md-field>
            </div>
          </div>

          <div class="md-layout md-gutter">
            <div class="md-layout-item md-small-size-100">
              <md-field :class="getValidationClass('refueling')">
                <label for="refueling">Refueling, liters</label>
                <md-input type="number" name="refueling" v-model="fitem.refueling" md-dense :disabled="sending" />
                <span class="md-error" v-if="!$v.fitem.refueling.required">refueling in liters </span>
                <span class="md-error" v-else-if="!$v.fitem.refueling.maxlength">Invalid refueling data length (50 max)</span>
              </md-field>
            </div>

            <div class="md-layout-item md-small-size-100">
              <md-field :class="getValidationClass('price_fuel')">
                <label for="age">Fuel price</label>
                <md-input type="number" name="price_fuel" autocomplete="price_fuel" v-model="fitem.price_fuel" :disabled="sending" />
                <span class="md-error" v-if="!$v.fitem.price_fuel.required">Fuel price required</span>
                <span class="md-error" v-else-if="!$v.fitem.price_fuel.maxlength">Invalid price data length (50 max)</span>
              </md-field>
            </div>
          </div>

          <div class="md-layout md-gutter">
            <div class="md-layout-item md-small-size-100">
              <md-field>
                <label for="fuel_station">Fuel station</label>
                <md-input name="fuel_station" v-model="fitem.fuel_station" md-dense :disabled="sending" />
              </md-field>
            </div>

            <div class="md-layout-item md-small-size-100">
              <md-field>
                <label for="age">Fuel type</label>
                <md-input name="fuel_type" autocomplete="fuel_type" v-model="fitem.fuel_type" :disabled="sending" />
              </md-field>
            </div>
          </div>
          
          <div class="block">
            <md-field :class="getValidationClass('date')">
              <label for="date">Refueling date</label>
              <md-datepicker v-model="fitem.date" />
              <span class="md-error" v-if="!$v.fitem.date.required">Date required</span>
            </md-field>
          </div>

        </md-card-content>

        <md-progress-bar md-mode="indeterminate" v-if="sending" />

        <md-card-actions>
          <app-back-button v-bind:is-sending="sending"></app-back-button>
          <div v-if="isAuth">
            <md-button type="submit" class="md-primary" :disabled="sending">Save fuel</md-button>
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
    name: 'FuelForm',
    mixins: [validationMixin],
    data: () => ({
      // fitem: (this.item || null),
      fuelSaved: false,
      sending: false
    }),
    computed: {
      ...mapState('fuel', {
        fitem: 'addItem'
      }),
      isAuth () { return this.$store.getters.isAuth }
    },    
    validations: {
      fitem: {
        odo: {
          required,
          maxLength: maxLength(50)
        },
        odo_delta: {
          required,
          maxLength: maxLength(50)
        },
        refueling: {
          required,
          maxLength: maxLength(50)
        },
        price_fuel: {
          required,
          maxLength: maxLength(50)
        },
        date: {
          required
        }
      }
    },
    methods: {
      getValidationClass (fieldName) {
        const field = this.$v.fitem[fieldName]

        if (field) {
          return {
            'md-invalid': field.$invalid && field.$dirty
          }
        }
      },

      saveFuel () {
        this.sending = true
        var params = {odo: this.fitem.odo, 
                      odo_delta: this.fitem.odo_delta, 
                      refueling: this.fitem.refueling, 
                      price_fuel: this.fitem.price_fuel, 
                      fuel_station: this.fitem.fuel_station,
                      fuel_type: this.fitem.fuel_type,
                      date: this.fitem.date
        }
        this.$store.dispatch('fuel/create', {bikeId: this.$route.params.id, fuel: params})
          .then(() => {
            this.hasError = false
            this.flashMessage.show({
              status: 'success',
              title: 'Success',
              message: 'Fuel was successfully created'
            })
            this.$router.push({name: 'FuelTable'})
          }).catch(err => {
            if (err.response.status !== 200) {
              this.hasError = true
            }
            this.sending = false
          })        
      },

      updateFuel () {
        this.sending = true
        var params = {odo: this.fitem.odo, 
                      odo_delta: this.fitem.odo_delta, 
                      refueling: this.fitem.refueling, 
                      price_fuel: this.fitem.price_fuel, 
                      fuel_station: this.fitem.fuel_station,
                      fuel_type: this.fitem.fuel_type,
                      date: this.fitem.date
        }
        this.$store.dispatch('fuel/update', {bikeId: this.$route.params.id, id: this.$route.params.fuel_id, fuel: params})
          .then(() => {
            this.hasError = false
            this.flashMessage.show({
              status: 'success',
              title: 'Success',
              message: 'Fuel was successfully updated'
            })
            this.$router.push({name: 'FuelTable'})
          }) //.catch(err => {
            // if (err.response.status !== 200) {
              // this.hasError = true
            // }
            // this.sending = false
          // })        
      },

      validateFuel (fuel_id) {
        this.$v.$touch()

        if (!this.$v.$invalid) {
          if (fuel_id === 'new') {
            this.saveFuel()
          } else {
            this.updateFuel()
          }
        }
      }
    },
    created () {
      if (this.$route.params.fuel_id != 'new') {
        this.$store.dispatch('fuel/show', {bikeId: this.$route.params.id, id: this.$route.params.fuel_id})
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
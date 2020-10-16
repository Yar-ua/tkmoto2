<template>
  <div>
    <form novalidate class="md-layout" @submit.prevent="validateBike">
      <md-card class="md-layout-item md-size-50 md-small-size-100">
        <md-card-header>
          <div class="md-title">Bike</div>
        </md-card-header>

        <md-card-content>
            
          <div class="md-layout md-gutter">
            <div class="md-layout-item md-small-size-100">
              <md-field :class="getValidationClass('name')">
                <label for="name">Bike name</label>
                <md-input name="name" id="name" autocomplete="name" v-model="item.name" :disabled="sending" />
                <span class="md-error" v-if="!$v.item.name.required">Name is required</span>
                <span class="md-error" v-else-if="!$v.item.name.maxLength">...must be not more than 50 symbols</span>
              </md-field>
            </div>
          </div>

          <md-field :class="getValidationClass('color')">
            <label>Color toggle</label>
            <md-input name="color" id="color" v-model="item.color" />
            <span class="md-error" v-if="!$v.item.color.required">Color is required</span>
            <span class="md-error" v-else-if="!$v.item.color.maxLength">...must be not more than 50 symbols</span>
          </md-field>
          
          <md-field :class="getValidationClass('year')">
            <label>Model year toggle</label>
            <md-input type="number" name="year" id="year" v-model="item.year" />
            <span class="md-error" v-if="!$v.item.year.required">Year is required</span>
            <span class="md-error" v-else-if="!$v.item.year.maxLength">...must be not more than 4 symbols</span>
          </md-field>
          
          <md-field :class="getValidationClass('volume')">
            <label>Engine volume, ccm</label>
            <md-input type="number" name="volume" id="volume" v-model="item.volume" />
            <span class="md-error" v-if="!$v.item.volume.required">Engine volume is required</span>
            <span class="md-error" v-else-if="!$v.item.year.maxLength">...must be not more than 10 symbols</span>
          </md-field>
          
        </md-card-content>

        <md-progress-bar md-mode="indeterminate" v-if="sending" />

        <md-card-actions>
          <md-button :disabled="sending" :to="{name: 'Bikes'}">Back</md-button>
          <div v-if="isAuth">
            
            <md-button v-if="($route.params.id) != 'new'" type="submit" class="md-primary" :disabled="sending">Update</md-button>
            <md-button v-else type="submit" class="md-primary" :disabled="sending">Save</md-button>
          </div>
        </md-card-actions>
        <p>asdasd {{item}} || {{$route.params}}</p>
      </md-card>

    </form>
  </div>
</template>

<script>
  import { mapState } from 'vuex'
  import { validationMixin } from 'vuelidate'
  import {
    required,
    maxLength
  } from 'vuelidate/lib/validators'

  export default {
    name: 'BikeForm',
    mixins: [validationMixin],
    data: () => ({
      bikeSaved: false,
      sending: false,
      lastBike: null
    }),
    computed: {
      ...mapState({
        user: 'user'
      }),
    ...mapState('bike', {
      item: 'addItem'
    }),
    isAuth () { return this.$store.getters.isAuth }
    },
    validations: {
      item: {
        name: {
          required,
          maxLength: maxLength(50)
        },
        color: {
          required,
          maxLength: maxLength(50)
        },
        year: {
          required,
          maxLength: maxLength(4)
        },
        volume: {
          required,
          maxLength: maxLength(10)
        }                
      }
    },
    methods: {
      getValidationClass (fieldName) {
        const field = this.$v.item[fieldName]

        if (field) {
          return {
            'md-invalid': field.$invalid && field.$dirty
          }
        }
      },
      saveBike () {
        this.sending = true
        var params = {name: this.item.name, color: this.item.color, year: this.item.year, volume: this.item.volume}
        this.$store.dispatch('bike/create', {bike: params})
          .then(() => {
            this.hasError = false
            this.flashMessage.show({
              status: 'success',
              title: 'Success',
              message: 'You was successfully registred'
            })
            this.$router.push({name: 'Bikes'})
          }).catch(err => {
            if (err.response.status !== 200) {
              this.hasError = true
            }
            this.sending = false
          })
      },
      validateBike () {
        this.$v.$touch()

        if (!this.$v.$invalid) {
          this.saveBike()
        }
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
<template>
  <div>
    <form novalidate class="md-layout" @submit.prevent="validateUser">
      <md-card class="md-layout-item md-size-50 md-small-size-100">
        <md-card-header>
          <div class="md-title">Users</div>
        </md-card-header>

        <md-card-content>
          <div class="md-layout md-gutter">
            <div class="md-layout-item md-small-size-100">
              <md-field :class="getValidationClass('name')">
                <label for="name">Name</label>
                <md-input name="name" id="name" autocomplete="name" v-model="form.name" :disabled="sending" />
                <span class="md-error" v-if="!$v.form.name.required">Name is required</span>
                <span class="md-error" v-else-if="!$v.form.name.minlength">Name</span>
              </md-field>
            </div>
          </div>

          <md-field :class="getValidationClass('email')">
            <label for="email">Email</label>
            <md-input type="email" name="email" id="email" autocomplete="email" v-model="form.email" :disabled="sending" />
            <span class="md-error" v-if="!$v.form.email.required">The email is required</span>
            <span class="md-error" v-else-if="!$v.form.email.email">Invalid email</span>
          </md-field>
          
          <md-field :class="getValidationClass('password')">
            <label>Password toggle</label>
            <md-input type="password" name="password" id="password" v-model="form.password" />
            <span class="md-error" v-if="!$v.form.password.required">Password is required</span>
            <span class="md-error" v-else-if="!$v.form.password.minlength">...must be more than 6 symbols</span>
          </md-field>

          <md-field :class="getValidationClass('passwordConfirmation')">
            <label>Password toggle</label>
            <md-input type="password" name="password" id="passwordConfirmation" v-model="form.passwordConfirmation" />
            <span class="md-error" v-if="!$v.form.passwordConfirmation.sameAsPassword">Passwords not eval</span>
          </md-field>
        </md-card-content>

        <md-progress-bar md-mode="indeterminate" v-if="sending" />

        <md-card-actions>
          <app-back-button v-bind:is-sending="sending"></app-back-button>
          <md-button type="submit" class="md-primary" :disabled="sending">Create user</md-button>
        </md-card-actions>
      </md-card>

    </form>
  </div>
</template>

<script>
  import BackButton from '../components/Back_Button'
  import { validationMixin } from 'vuelidate'
  import {
    required,
    email,
    minLength,
    sameAs
  } from 'vuelidate/lib/validators'

  export default {
    components: {
      'app-back-button': BackButton
    },
    name: 'SignUp',
    mixins: [validationMixin],
    data: () => ({
      form: {
        name: null,
        email: null,
        password: null,
        passwordConfirmation: null
      },
      userSaved: false,
      sending: false
    }),
    validations: {
      form: {
        name: {
          required,
          minLength: minLength(3)
        },
        email: {
          required,
          email
        },
        password: {
          required,
          minLength: minLength(6)
        },
        passwordConfirmation: {
          sameAsPassword: sameAs('password')
        }        
      }
    },
    methods: {
      getValidationClass (fieldName) {
        const field = this.$v.form[fieldName]

        if (field) {
          return {
            'md-invalid': field.$invalid && field.$dirty
          }
        }
      },
      saveUser () {
        this.sending = true
        var params = {name: this.form.name, email: this.form.email, password: this.form.password, password_confirmation: this.form.passwordConfirmation}
        this.$store.dispatch('sign_up', params)
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
      validateUser () {
        this.$v.$touch()

        if (!this.$v.$invalid) {
          this.saveUser()
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
<template>
  <div>
    <form novalidate class="md-layout" @submit.prevent="validateUser">
      <md-card class="md-layout-item md-size-50 md-small-size-100">
        <md-card-header>
          <div class="md-title">Users</div>
        </md-card-header>

        <md-card-content>
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
        </md-card-content>

        <md-progress-bar md-mode="indeterminate" v-if="sending" />
        
        <md-card-actions>
          <md-button :disabled="sending" :to="{name: 'Bikes'}">Back</md-button>
          <md-button type="submit" class="md-primary" :disabled="sending">Sign-in</md-button>
        </md-card-actions>
      </md-card>

      <md-snackbar :md-active.sync="userSaved">The user {{ lastUser }} was saved with success!</md-snackbar>
    </form>
  </div>
</template>

<script>
  import { validationMixin } from 'vuelidate'
  import {
    required,
    email,
    minLength
  } from 'vuelidate/lib/validators'

  export default {
    name: 'SignIn',
    mixins: [validationMixin],
    data: () => ({
      form: {
        email: null,
        password: null,
      },
      userSaved: false,
      sending: false,
      lastUser: null
    }),
    validations: {
      form: {
        email: {
          required,
          email
        },
        password: {
          required,
          minLength: minLength(6)
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
      
      signIn () {
        this.sending = true
        var params = {email: this.form.email, password: this.form.password}
        this.$store.dispatch('sign_in', params)
          .then(response => {
            this.hasError = false
            this.flashMessage.show({
              status: 'success',
              title: 'Success',
              message: 'You are successfully signed in'
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
          this.signIn()
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
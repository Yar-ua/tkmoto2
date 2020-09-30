<template>
  <div id="app">
    <p>{{ message }}</p>
    <app-bikes></app-bikes>
  </div>
</template>

<script>

import Bikes from './components/bikes/Bikes'

export default {
  message: "Hello Vue!",
  name: 'App',
  drawer: false,
  components: {
    'app-bikes': Bikes
  },
  props: {
    source: String
  },
  data: function () {
    return {
      message: "Hello Vue!"
    }
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>

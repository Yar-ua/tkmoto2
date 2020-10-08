<template>
  <div>
    <h1>{{ msg }}</h1>
  </div>
</template>

<script>
export default {
  name: 'PageNoPermission',
  data () {
    return {
      msg: 'You have not permission for this area'
    }
  }
}
</script>
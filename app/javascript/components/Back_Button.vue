<template>
  <md-button :disabled="isSending" @click="$router.go(-1)">Back</md-button>
</template>


<script>
  export default {
    name: 'BackButton',
    props: ['isSending']
  }
</script>
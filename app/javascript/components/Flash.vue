<template>
  <div>
    <FlashMessage :position="'right bottom'"></FlashMessage>
  </div>
</template>


<script>
import { mapState } from 'vuex'
export default {
  name: 'Flash',
  data () {
    return {
      hasAlert: () => {
        if ((this.alerts) && (this.alerts.length !== 0)) {
          return true
        } else {
          return false
        }
      }
    }
  },
  computed: {
    ...mapState('errors', {
      alerts: 'errors'
    })
  },
  watch: {
    alerts: function () {
      if (this.hasAlert() === true) {
        this.showAlerts(this.alerts)
      }
    }
  },
  methods: {
    showAlerts: function (array) {
      for (var key in array) {
        this.flashMessage.show({
          status: 'error',
          title: key,
          message: array[key]
        })
      }
    }
  }
}
</script>











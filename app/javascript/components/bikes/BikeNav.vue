<template>
  <div>
    <md-tabs>
      <md-tab id="tab-home" md-label="Info" :to="{name: 'BikeInfo'}"></md-tab>
      <md-tab id="tab-pages" md-label="Fuel" :to="{name: 'FuelTable'}"></md-tab>
      <md-tab id="tab-posts" md-label="Oil" :to="{name: 'OilTable'}"></md-tab>
      <md-tab id="tab-favorites" md-label="Settings" :to="{name: 'BikeConfigs'}"></md-tab>
    </md-tabs>
  </div>
</template>

<script>
  export default {
    name: 'BikeNav'
  }
</script>

<style lang="scss" scoped>
  .md-tabs {
    margin-bottom: 24px;
  }
</style>
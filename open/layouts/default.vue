<template>
  <div class="wrap">
    <TheHeader />
    <Nuxt />
    <TheFooter />
  </div>
</template>
<script>
import Vue from 'vue'
import global from '~/mixins/global'
import TheHeader from '~/components/TheHeader'
import TheFooter from '~/components/TheFooter'

Vue.mixin(global)
export default {
  components: { TheHeader, TheFooter },
}
</script>

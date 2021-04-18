<template>
  <div id="wrapper" class="wrapper">
    <TheHeader />
    <TheMain>
      <Nuxt />
      <TheFooter />
    </TheMain>
  </div>
</template>

<script>
import TheHeader from '~/components/TheHeader'
import TheMain from '~/components/TheMain'
import TheFooter from '~/components/TheFooter'
export default {
  name: 'Home',
  components: { TheMain, TheHeader, TheFooter },
}
</script>

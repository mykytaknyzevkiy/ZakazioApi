<template>
  <div class="container error-page">
    <div class="error-block">
      {{ error.message }}.<br />
      <nuxt-link to="/">Вернуться главную</nuxt-link>
    </div>
  </div>
</template>
<script>
export default {
  // eslint-disable-next-line vue/require-prop-types
  props: ['error'],
  layout: 'error', // you can set a custom layout for the error page
}
</script>

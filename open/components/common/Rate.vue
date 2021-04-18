<template>
  <div class="rate">
    <span
      v-for="i in max"
      :key="i"
      class="rate__item"
      :class="{ rate__item_active: i <= value }"
      >{{ i }}</span
    >
  </div>
</template>

<script>
export default {
  name: 'Rate',
  props: {
    value: {
      type: Number,
      default: 0,
    },
  },
  data() {
    return {
      max: 5,
    }
  },
}
</script>

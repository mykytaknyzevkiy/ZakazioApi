<template>
  <div class="order">
    <div class="order__avatar"></div>
    <div class="order__text">
      <h2 class="order__title">{{ order.title }}</h2>
      <p class="order__content">
        {{ order.content }}
      </p>
    </div>
    <div class="order__map">{{ region }}, <br />{{ city }}</div>
    <div class="order__sum">{{ order.toShareSum }} р.</div>
    <a href="https://crm.zakazy.online/login" class="order__btn"
      >Откликнуться</a
    >
    <!--    {{ order }}-->
  </div>
</template>

<script>
export default {
  name: 'OrderCard',
  props: {
    order: {
      type: Object,
      default: () => {},
    },
  },
  computed: {
    region() {
      return this.order?.city?.region?.name
    },
    city() {
      return this.order?.city?.name
    },
  },
}
</script>

<template>
  <nuxt-link :to="`executors/${user.id}`" class="executor">
    <div class="executor__avatar" style="
    display: flex;
    justify-content: center;
    align-items: center;
    overflow: hidden;
">

      <img v-if="user.avatar != null" src="https://file.zakazy.online/${user.avatar}" alt="" style="
    flex-shrink: 0;
    min-width: 100%;
    min-height: 100%
">

    </div>
    <div class="executor__user">
      <div class="executor__name">
        {{ user.firstName + ' ' + user.lastName }}
      </div>
      <div class="executor__rate"><Rate :value="user.rate" /></div>
    </div>

    <div class="executor__map">
      Россия, <br />
      Москва
    </div>
    <div class="executor__stats">
      <span class="executors__stats-n">{{ user.order.count.open }}</span>
      <span class="executors__stats-t">Открытые <br />заказы</span>
    </div>
    <div class="executor__stats">
      <span class="executors__stats-n">{{ user.order.count.close }}</span>
      <span class="executors__stats-t">Закрытые <br />заказы</span>
    </div>
  </nuxt-link>
</template>

<script>
export default {
  name: 'ExecutorCard',
  props: {
    // eslint-disable-next-line vue/require-default-prop
    user: Object,
  },
}
</script>

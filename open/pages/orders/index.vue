<template>
  <div class="orders">
    <div class="container">
      <h1 class="orders__title">Заказы</h1>
      <OrderCard v-for="order in content" :key="order.id" :order="order" />
      <Paginator :meta-info="meta" />
    </div>
  </div>
</template>
<script>
import OrderCard from '@/components/orders/OrderCard'
import global, { returnObj } from '@/mixins/global'
import Paginator from '~/components/common/Paginator'
export default {
  layout: 'default',
  components: { Paginator, OrderCard },
  mixins: [global],
  async asyncData({ $axios, route }) {
    const res = await $axios.get(
      `order/list?page=${Number(route.query.page) - 1}`
    )
    return returnObj(res)
  },
  head: {
    title: 'Заказы',
    meta: [
      {
        hid: 'description',
        name: 'description',
        content: 'Заказы на строительные работы',
      },
    ],
  },
}
</script>

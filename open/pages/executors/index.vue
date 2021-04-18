<template>
  <div class="executors">
    <div class="container">
      <h1 class="executors__title">Исполнители</h1>
      <div class="executors__list">
        <ExecutorCard
          v-for="executor in content"
          :key="executor.id"
          :user="executor"
        />
      </div>
      <Paginator :meta-info="meta" />
    </div>
  </div>
</template>
<script>
// import ExecutorsCard from '~/components/executors/ExecutorsCard'
import global, { returnObj } from '~/mixins/global'
import ExecutorCard from '~/components/executors/ExecutorCard'
import Paginator from '~/components/common/Paginator'
export default {
  components: { Paginator, ExecutorCard },
  layout: 'default',
  // components: { ExecutorsCard },
  mixins: [global],
  async asyncData({ $axios, route }) {
    const res = await $axios.get(
      `executor/list?page=${Number(route.query.page) - 1}`
    )
    return returnObj(res)
  },
  methods: {
    rand(max) {
      return Math.floor(Math.random() * Math.floor(max))
    },
  },
  head: {
    title: 'Исполнители',
    meta: [
      {
        hid: 'description',
        name: 'description',
        content: 'Исполнители строительных работ',
      },
    ],
  },
}
</script>

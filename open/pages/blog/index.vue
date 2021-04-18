<template>
  <div class="blog">
    <div class="container">
      <h1 class="blog__title">Блог</h1>
      <div class="blog__list">
        <template v-for="article in content">
          <div :key="article.id" class="blog__item">
            <div class="blog__img">
              <nuxt-link :to="`blog/${article.id}`">
                <img
                  style="max-width: 750px"
                  :src="`${storageUrl}/${article.wallpaper}`"
                  alt=""
                />
              </nuxt-link>
            </div>
            <h2 class="blog__item-title">{{ article.title }}</h2>
            <p>
              {{ article.content }}
            </p>
            <nuxt-link :to="`blog/${article.id}`">Подробнее</nuxt-link>
          </div>
          <hr :key="'hr' + article.id" class="blog__item-separator" />
        </template>
      </div>
      <Paginator :meta-info="meta" />
    </div>
  </div>
</template>

<script>
import global, { returnObj } from '~/mixins/global'
import Paginator from '~/components/common/Paginator'

export default {
  name: 'Index',
  components: { Paginator },
  mixins: [global],
  async asyncData({ $axios, route }) {
    const res = await $axios.get(
      `blog/list?page=${Number(route.query.page) - 1}`
    )
    return returnObj(res)
  },
  head: {
    title: 'Блог',
  },
}
</script>

<template>
  <div class="blog">
    <div class="container">
      <nuxt-link style="display: block; margin-bottom: 20px" to="/blog"
        >Вернться в блог</nuxt-link
      >
      <h1 class="blog__title">{{ article.title }}</h1>
      <time
        :datetime="article.creationDateTime"
        style="display: block; margin-bottom: 20px"
        >{{ article.creationDateTime | formatDate }}</time
      >
      <img
        style="display: block; max-width: 750px; margin-bottom: 20px"
        :src="`${storageUrl}/${article.wallpaper}`"
        alt=""
      />
      <p>{{ article.content }}</p>
    </div>
  </div>
</template>

<script>
import dayjs from 'dayjs'
export default {
  filters: {
    formatDate(value) {
      return dayjs(value).format('DD.MM.YYYY')
    },
  },
  async asyncData({ error, $axios, route }) {
    try {
      const res = await $axios.get(`blog/${route.params.id}`)
      return {
        article: res.data.data,
      }
    } catch (e) {
      // eslint-disable-next-line no-throw-literal
      return error({ statusCode: 404, message: 'Запись не найдена' })
    }
  },
}
</script>

<template>
  <div class="paginator">
    <ul class="paginator__list">
      <li v-if="metaInfo.currentPage > 1" class="paginator__item">
        <a
          :href="`${route}?page=${metaInfo.currentPage}`"
          class="paginator__link paginator__link_prev"
          >Назад</a
        >
      </li>
      <li
        v-for="i in prevLinks"
        :key="`page-${metaInfo.currentPage - prevLinks + i - 1}`"
        class="paginator__item"
      >
        <a
          :href="`${route}?page=${metaInfo.currentPage - prevLinks + i - 1}`"
          class="paginator__link"
          >{{ metaInfo.currentPage - prevLinks + i - 1 }}</a
        >
      </li>
      <li class="paginator__item">
        <span class="paginator__link paginator__link_current">{{
          metaInfo.currentPage
        }}</span>
      </li>
      <li
        v-for="i in nextLinks"
        :key="`page-${metaInfo.currentPage + i}`"
        class="paginator__item"
      >
        <a
          :href="`${route}?page=${metaInfo.currentPage + i}`"
          class="paginator__link"
          >{{ metaInfo.currentPage + i }}</a
        >
      </li>
      <li
        v-if="metaInfo.currentPage < metaInfo.totalPages"
        class="paginator__item"
      >
        <a
          :href="`${route}?page=${metaInfo.currentPage + 1}`"
          class="paginator__link paginator__link_next"
          >Вперед</a
        >
      </li>
    </ul>
  </div>
</template>
<script>
const side = 3
export default {
  props: {
    metaInfo: {
      type: Object,
      default() {
        return {
          currentPage: 1,
          totalElements: 1,
          totalPages: 1,
        }
      },
    },
  },
  computed: {
    // сколько всего страниц
    nextLinks() {
      const items = this.metaInfo.totalPages - this.metaInfo.currentPage
      return items > side ? side : items < 0 ? 0 : items
    },
    prevLinks() {
      const items = this.metaInfo.currentPage - 1
      return items > side ? side : items <= 0 ? 0 : items
    },
    route() {
      return this.$route.name
    },
  },
}
</script>

export const pageItemsSize = 2
export function returnObj(res) {
  return {
    content: res.data.data.content,
    meta: {
      totalPages: res.data.data.totalPages,
      totalElements: res.data.data.totalElements,
      currentPage: res.data.data.number + 1,
    },
  }
}
export default {
  data() {
    return {
      orders: [],
      meta: {
        totalPages: 0,
        totalElements: 0,
        currentPage: 1,
      },
    }
  },
  methods: {
    changePage(entity, page) {
      this.$router.replace({ query: { page } }).catch((e) => {})
      this.loadData(entity, page, this.$axios)
    },
    async loadData(entity, page) {
      const res = await this.$axios.get(
        `${entity}/list?page=${Number(page) - 1}`
      )
      this.content = res.data.data.content
      this.meta = {
        totalPages: res.data.data.totalPages,
        totalElements: res.data.data.totalElements,
        currentPage: res.data.data.number + 1,
      }
    },
  },
  computed: {
    baseUrl() {
      return process.env.baseUrl
    },
    storageUrl() {
      return process.env.storageUrl
    },
  },
}

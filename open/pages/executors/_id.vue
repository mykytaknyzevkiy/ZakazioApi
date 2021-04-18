<template>
  <div class="profile">
    <div class="container profile__container">
      <div class="profile__side">
        <div class="profile__avatar">
          <h1 class="profile__executor">
            {{ user.firstName + ' ' + user.lastName }}
          </h1>
          <hr />
          <div class="profile__rate">Рейтинг: {{ user.rate }}</div>
          <div class="profile__city">Город: {{ city }}</div>
        </div>
        <a href="https://crm.zakazy.online/login" class="profile__order-btn"
          >Заказать работу</a
        >
      </div>
      <div class="profile__area">
        <div class="profile__tabs">
          <button
            class="profile__tab"
            :class="{ profile__tab_active: TAB === TABS.PORTFOLIO }"
            @click="TAB = TABS.PORTFOLIO"
          >
            Портфолио
          </button>
          <!--          <button
            class="profile__tab"
            :class="{ profile__tab_active: TAB === TABS.PROJECTS }"
            @click="TAB = TABS.PROJECTS"
          >
            Проекты
          </button>-->
        </div>
        <div v-show="TAB === TABS.PORTFOLIO" class="profile__portfolio">
          <template v-if="portfolio.length > 0">
            <div
              v-for="pItem in portfolio"
              :key="pItem.id"
              class="profile__portfolio-item"
              @click="showPortfolio(pItem.id)"
            >
              <img :src="`${storageUrl}/${pItem.wallpaper}`" alt="" />
            </div>
          </template>
          <template v-else>
            <p class="profile__message">Нет контента.</p>
          </template>
        </div>
        <div v-show="TAB === TABS.PROJECTS" class="profile__orders">
          Нет контента.
        </div>
      </div>
    </div>
    <div
      class="profile__modal"
      :class="{ profile__modal_active: portfolioModal }"
    >
      <div class="container">
        <div v-if="currentPortFolio !== null" class="profile__modal-content">
          <div class="profile__modal-head">
            <span>{{ currentPortFolio.label }}</span>
            <button @click="hidePortfolio">x</button>
          </div>
          <div class="profile__modal-body">
            <div>
              <img
                class="profile__modal-slide"
                :src="`${storageUrl}/${currentPortFolio.wallpaper}`"
                alt=""
              />
              <p>{{ currentPortFolio.description }}</p>
            </div>
            <div v-for="slide in currentPortFolio.imageSlides" :key="slide">
              <img
                class="profile__modal-slide"
                :src="`${storageUrl}/${slide}`"
                alt=""
              />
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
/* import UserOrderCard from '~/components/user/UserOrderCard'
import UserAvatar from '~/components/user/UserAvatar'
import UserFeedbacks from '~/components/user/UserFeedbacks' */
const TABS = {
  PORTFOLIO: 'PORTFOLIO',
  PROJECTS: 'PROJECTS',
}
/* const token =
  'Bearer eyJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwiZk5hbWUiOiJTdXBlciIsImxOYW1lIjoiQWRtaW4iLCJtTmFtZSI6Ilpha2F6eSIsImV4cCI6MTYxMzY5NjUxNn0.Tqqg2o1McKY_nblEt8odNfnLSWEfM-84A9GpDS6jz2E' */
export default {
  // components: { UserFeedbacks, UserAvatar, UserOrderCard },
  async asyncData({ error, $axios, route }) {
    try {
      const res = await $axios.get(`executor/${route.params.id}`)
      const portfolioRes = await $axios.get(
        `portfolio/list/user/${route.params.id}`
        /* {
          headers: {
            Authorization: token,
          },
        } */
      )
      /* const userOrders = await $axios.get(
        `/order/list/user/${route.params.id}?size=20&page=0`,
        {
          headers: {
            Authorization: token,
          },
        }
      ) */
      return {
        user: res.data.data,
        portfolio: portfolioRes.data.data.content,
        // orders: userOrders.data.data.content,
      }
    } catch (e) {
      // eslint-disable-next-line no-throw-literal
      return error({ statusCode: 404, message: 'Профиль не найден' })
    }
  },
  data() {
    return {
      TABS,
      user: {},
      portfolio: [],
      portfolioModal: false,
      TAB: TABS.PORTFOLIO,
      showPortfolioId: null,
    }
  },
  computed: {
    city() {
      return this.user?.city?.name || 'не указан'
    },
    currentPortFolio() {
      return this.portfolio.find((i) => i.id === this.showPortfolioId) || null
    },
  },
  mounted() {
    window.addEventListener('keydown', (e) => {
      if (e.code === 'Escape') {
        this.hidePortfolio()
      }
    })
  },
  methods: {
    hidePortfolio() {
      const body = window.document.querySelector('body')
      body.classList.remove('no-overflow')
      this.portfolioModal = false
      this.showPortfolioId = null
    },
    showPortfolio(id) {
      this.showPortfolioId = id
      const body = window.document.querySelector('body')
      body.classList.add('no-overflow')
      this.portfolioModal = true
    },
  },
  head() {
    return {
      title: 'Исполнитель ' + this.user?.firstName + ' ' + this.user?.lastName,
      meta: [
        {
          hid: 'description',
          name: 'description',
          content:
            'Исполнитель ' + this.user?.firstName + ' ' + this.user?.lastName,
        },
      ],
    }
  },
}
</script>

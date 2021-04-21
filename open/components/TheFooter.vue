<template>
  <footer class="footer">
    <div class="container-fluid footer__container">
      <div class="footer__col">
        <nuxt-link to="/" class="footer__logo">{{
          contacts.companyName
        }}</nuxt-link>
      </div>
      <div class="footer__col">
        <div class="footer__copyright">
          <p class="footer__name">
            {{ COPYRIGHT }}
          </p>
          <div class="footer__numbers">
            {{ OGRN_NUMBER }} | ИНН {{ TIN_NUMBER }}
          </div>
        </div>
        <div class="footer__timetable">
          <span class="footer__timetable-label">Служба поддержки </span>
          <span class="footer__timetable-item">Будни: с 10 до 19 </span>
          <span class="footer__timetable-item">Выходные: с 11 до 18 </span>
        </div>
        <div class="footer__email">{{ contacts.email }}</div>
      </div>
      <div class="footer__col">
        <div class="footer__menu">
          <nuxt-link
            to="/executors"
            class="footer__menu-item footer__menu-item_executors"
            >Исполнители</nuxt-link
          >
          <nuxt-link
            to="/orders"
            class="footer__menu-item footer__menu-item_orders"
            >Заказы</nuxt-link
          >
          <nuxt-link to="/blog" class="footer__menu-item footer__menu-item_blog"
            >Блог</nuxt-link
          >
        </div>
      </div>
      <div class="footer__col">
        <div class="footer__links">
          <a href="#">словия использования (Оферта) </a>
          <a href="#">Политика обработки персональных данных</a>
          <a href="#">Отказ от ответственности за прибыль</a>
        </div>
      </div>
      <div class="footer__col">
        <div class="footer__contact">
          <a :href="`tel:+${contacts.phoneNumber}`" class="footer__phone">{{
            contacts.phoneNumber
          }}</a>
        </div>
      </div>
      <div class="footer__col">
        <div class="footer__socials">
          <a
            target="_blank"
            class="footer__social footer__social_fb"
            :href="contacts.facebook"
            >Zakazio в Facebook</a
          >
          <a
            target="_blank"
            class="footer__social footer__social_vk"
            :href="contacts.linkedIn"
            >Zakazio в VK</a
          >
          <a
            target="_blank"
            class="footer__social footer__social_inst"
            :href="contacts.instagram"
            >Zakazio в Instagram</a
          >
          <a
            target="_blank"
            class="footer__social footer__social_twitter"
            :href="contacts.twitter"
            >Zakazio в Twitter</a
          >
        </div>
      </div>
    </div>
  </footer>
</template>
<script>
import { mapGetters } from 'vuex'
import { TIN_NUMBER, OGRN_NUMBER, COPYRIGHT } from '~/constants/data'

export default {
  name: 'TheFooter',
  data() {
    return {
      TIN_NUMBER,
      OGRN_NUMBER,
      COPYRIGHT,
    }
  },
  computed: {
    ...mapGetters('contacts', ['contacts']),
  },
}
</script>

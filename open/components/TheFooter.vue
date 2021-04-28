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
          <a
            href="https://file.zakazy.online/document/%D0%A3%D1%81%D0%BB%D0%BE%D0%B2%D0%B8%D1%8F%20%D0%B8%D1%81%D0%BF%D0%BE%D0%BB%D1%8C%D0%B7%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D1%8F%20(%D0%9E%D1%84%D0%B5%D1%80%D1%82%D0%B0).pdf"
            >Условия использования (Оферта)
          </a>
          <a
            href="https://file.zakazy.online/document/%D0%BF%D0%BE%D0%BB%D0%B8%D1%82%D0%B8%D0%BA%D0%B0-%D0%BA%D0%BE%D0%BD%D1%84%D0%B8%D0%BD%D0%B4%D0%B5%D0%BD%D1%86%D0%B8%D0%B0%D0%BB%D1%8C%D0%BD%D0%BE%D1%81%D1%82%D0%B8%20(1).pdf"
            >Политика обработки персональных данных</a
          >
          <a
            href="https://file.zakazy.online/document/%D0%BE%D1%82%D0%BA%D0%B0%D0%B7_%D0%BE%D1%82_%D0%BE%D1%82%D0%B2%D0%B5%D1%81%D1%82%D0%B2%D0%B5%D0%BD%D0%BD%D0%BE%D1%81%D1%82%D0%B8_%D0%B7%D0%B0_%D0%BF%D1%80%D0%B8%D0%B1%D1%8B%D0%BB%D1%8C.pdf"
          >
            Отказ от ответственности за прибыль</a
          >
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
            class="footer__social footer__social_whtsp"
            :href="contacts.twitter"
            >Zakazio в Whatsapp</a
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

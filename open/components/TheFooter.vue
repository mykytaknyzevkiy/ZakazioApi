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
          <p>
            <a
              href="https://file.zakazy.online/document/Пользовательское соглашение.pdf"
            >
              Пользовательское соглашение
            </a>
          </p>
          <p>
            <a
              href="https://file.zakazy.online/document/Оферта_между_Партнером_и_Пользователем.pdf"
            >Оферта между Партнером и Пользователем</a>
          </p>
          <p>
            <a
              href="https://file.zakazy.online/document/Политика  конфиденциальности.pdf"
            >
              Политика конфиденциальности</a>
          </p>
          <p>
            <a href="https://file.zakazy.online/document/Оферта БС.pdf"
            >Оферта безопасной сделки</a>
          </p>
        </div>
      </div>
      <div class="footer__col">
        <div class="footer__visa">
          <img src="https://file.zakazy.online/document/2021-09-11%2001.56.03.jpg" style="width: 100px;"/>
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

<template>
  <header class="header">
    <div class="container header__container">
      <nuxt-link to="/" class="header__logo">{{
        contacts.companyName
      }}</nuxt-link>
      <div class="header__text">{{ SLOGAN }}</div>
      <div class="header__contact">
        <a :href="`tel:+${contacts.phoneNumber}`" class="header__phone">{{
          contacts.phoneNumber
        }}</a>
      </div>
      <div
        class="header__socials"
        :class="{ header__socials_expanded: socials }"
      >
        <button
          class="header__social-switch"
          :class="{ 'header__social-switch_expanded': socials }"
          @click="socials = !socials"
        ></button>
        <div
          class="header__social-links"
          :class="{ 'header__social-links_expanded': socials }"
        >
          <a
            target="_blank"
            class="header__social header__social_fb"
            :href="contacts.facebook"
            >Zakazio в Facebook</a
          >
          <a
            target="_blank"
            class="header__social header__social_vk"
            :href="contacts.linkedIn"
            >Zakazio в VK</a
          >
          <a
            target="_blank"
            class="header__social header__social_inst"
            :href="contacts.instagram"
            >Zakazio в Instagram</a
          >
          <a
            target="_blank"
            class="header__social header__social_twitter"
            :href="contacts.twitter"
            >Zakazio в Twitter</a
          >
        </div>
      </div>
    </div>
  </header>
</template>

<script>
import { mapGetters } from 'vuex'
import { SLOGAN } from '~/constants/data'

export default {
  name: 'TheHeader',
  data() {
    return {
      socials: false,
      SLOGAN,
    }
  },
  computed: {
    ...mapGetters('contacts', ['contacts']),
  },
}
</script>

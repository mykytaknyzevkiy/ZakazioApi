<template>
  <div class="cover">
    <div class="cover__qube">
      <h1 class="cover__title">CRM и ERP Система контроля</h1>
      <h1 class="cover__title">заказов и исполнителей в 127</h1>
      <h1 class="cover__title">нишах услуг в РФ и СНГ</h1>
      <div class="cover__blocks">
        <span class="cover__block">*ТРАФИК х ЗАЯВКИ = СДЕЛКИ*</span>
      </div>
      <div class="cover__blocks">
              <span class="cover__block">СОЗДАЙ, СВОЮ НЕЙРОСЕТЬ...</span>
      </div>
      <!--      <div class="cover__nums">
        <div class="cover__num">
          <span class="cover__num-num">36</span>
          <span class="cover__num-text">Число</span>
        </div>
        <div class="cover__num">
          <span class="cover__num-num">-50 <sup>%</sup></span>
          <span class="cover__num-text">Число</span>
        </div>
        <div class="cover__num">
          <span class="cover__num-num">8</span>
          <span class="cover__num-text">Число</span>
        </div>
        <div class="cover__num">
          <span class="cover__num-num">12</span>
          <span class="cover__num-text">Число</span>
        </div>
      </div>
      <h3 class="cover__slogan">Исполнители готовы приступить к работе</h3>-->
    </div>
    <div class="cover__side">
      <h2 class="cover__side-name">Регистрация <span>в CRM</span></h2>
      <Register />
      <div class="cover__links">
        <!--        <a :href="CONTACTS_LINK" class="cover__link cover__link_contacts"
          >Контакты</a
        >-->
        <a :href="HELP_LINK" class="cover__link cover__link_help">Помощь</a>
      </div>
    </div>
  </div>
</template>
<script>
import { CONTACTS_LINK, HELP_LINK } from '~/constants/data'
import Register from '~/components/Register'

export default {
  components: { Register },
  layout: 'home',
  data() {
    return {
      dialog: false,
      CONTACTS_LINK,
      HELP_LINK,
    }
  },
  head: {
    title: 'ZAKAZIO',
    meta: [
      {
        hid: 'description',
        name: 'description',
        content: 'Биржа строительных работ',
      },
    ],
  },
}
</script>

<template>
  <div class="cover__register-btns">
    <template v-if="step === 0">
      <button
        class="cover__register-btn cover__register-btn_partner"
        @click="openCrm()">
        Войти в личный кабинет
      </button>
    </template>
    <div class="register">
      <template v-if="step === 1">
        <input
          v-model="form.email"
          placeholder="Email"
          type="email"
          class="register__input"
        />
        <button
          class="register__button"
          :disabled="!enableStepTwo"
          @click.prevent="openCrm()"
        >
          Далее
        </button>
      </template>
      <template v-if="step === 2">
        <input
          v-model="form.code"
          placeholder="код потдтверждения (4 цифры)"
          type="text"
          class="register__input"
          maxlength="4"
          @keypress="typeNumber($event)"
        />
        <button
          :disabled="!enableStepThree"
          class="register__button"
          @click.prevent="registerSms()"
        >
          Далее
        </button>
      </template>
      <template v-if="step === 3">
        <input
          v-model="form.firstName"
          placeholder="Имя"
          type="text"
          class="register__input"
        />
        <input
          v-model="form.lastName"
          placeholder="Фамилия"
          type="text"
          class="register__input"
        />
        <input
          v-model="form.middleName"
          placeholder="Отчество"
          type="text"
          class="register__input"
        />
        <input
          v-model="form.phoneNumber"
          placeholder="Телефон"
          type="text"
          class="register__input"
          @keypress="typeNumber($event)"
        />
        <input
          v-model="form.password"
          placeholder="Пароль"
          type="password"
          class="register__input"
        />
        <button
          :disabled="!enableStepFour"
          class="register__button"
          @click.prevent="registerUser()"
        >
          Далее
        </button>
      </template>
      <template v-if="step === 4">
        <div class="register__alert">
          Регистрация успешно завершена. <br />Вы можете войти.
        </div>
        <a href="https://crm.zakazy.online/login" class="register__button">
          Войти
        </a>
      </template>
      <button v-if="step !== 0" class="register__button" @click="reset()">
        Вернуться назад
      </button>
    </div>
  </div>
</template>

<script>
const entities = {
  CLIENT: 'CLIENT',
  PARTNER: 'PARTNER',
  EXECUTOR: 'EXECUTOR',
}
const form = {
  phoneNumber: '',
  token: '',
  code: '',
  firstName: '',
  lastName: '',
  middleName: '',
  email: '',
  password: '',
}
export default {
  name: 'Register',
  data() {
    return {
      step: 0,
      error: false,
      entity: entities.CLIENT,
      form: { ...form },
    }
  },
  computed: {
    enableStepTwo() {
      return this.form.email !== '' && /.+@.+\..+/.test(this.form.email)
    },
    enableStepThree() {
      return this.form.code.length === 4
    },
    enableStepFour() {
      // return form.code.length === 4
      return (
        this.form.firstName !== '' &&
        this.form.lastName !== '' &&
        this.form.middleName !== '' &&
        this.form.email !== '' &&
        this.form.phoneNumber.length > 3 &&
        this.form.password !== '' &&
        this.form.password.length >= 4
      )
    },
  },
  methods: {
    reset() {
      this.form = { ...form }
      this.step = 0
    },
    openCrm() {
      window.open("https://crm.zakazy.online/","_self")
    },
    registerEmail() {
      const { email } = this.form
      this.$axios
        .post(`/${this.entity.toLowerCase()}/register/step/1`, {
          email,
        })
        .then((r) => {
          this.step = 2
          this.form.token = r.data.data.token
        })
    },
    registerSms() {
      const { phoneNumber, code, token } = this.form
      this.$axios
        .post(`/${this.entity.toLowerCase()}/register/step/2`, {
          phoneNumber,
          code,
          token,
        })
        .then((r) => {
          this.step = 3
          this.form.token = r.data.data.token
        })
    },
    registerUser() {
      const {
        firstName,
        lastName,
        middleName,
        phoneNumber,
        password,
      } = this.form
      this.$axios
        .post(
          `/${this.entity.toLowerCase()}/register/step/3`,
          {
            firstName,
            lastName,
            middleName,
            phoneNumber,
            password,
          },
          {
            headers: {
              token: this.form.token,
            },
          }
        )
        .then(() => {
          this.step = 4
        })
    },
    register(entity) {
      this.entity = entities[entity.toUpperCase()]
      this.step = 1
    },
    typeNumber(e) {
      if (e.keyCode >= 48 && e.keyCode <= 57) {
      } else {
        e.preventDefault()
      }
    },
  },
}
</script>

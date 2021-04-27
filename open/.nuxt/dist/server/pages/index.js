exports.ids = [5];
exports.modules = {

/***/ 49:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
// ESM COMPAT FLAG
__webpack_require__.r(__webpack_exports__);

// CONCATENATED MODULE: ./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/@nuxt/components/dist/loader.js??ref--0-0!./node_modules/vue-loader/lib??vue-loader-options!./components/Register.vue?vue&type=template&id=7df3c4b5&
var render = function () {var _vm=this;var _h=_vm.$createElement;var _c=_vm._self._c||_h;return _c('div',{staticClass:"cover__register-btns"},[_vm._ssrNode(((_vm.step === 0)?("<button class=\"cover__register-btn cover__register-btn_partner\">\n      Войти в личный кабинет\n    </button>"):"<!---->")+" <div class=\"register\">"+((_vm.step === 1)?("<input placeholder=\"Email\" type=\"email\""+(_vm._ssrAttr("value",(_vm.form.email)))+" class=\"register__input\"> <button"+(_vm._ssrAttr("disabled",!_vm.enableStepTwo))+" class=\"register__button\">\n        Далее\n      </button>"):"<!---->")+" "+((_vm.step === 2)?("<input placeholder=\"код потдтверждения (4 цифры)\" type=\"text\" maxlength=\"4\""+(_vm._ssrAttr("value",(_vm.form.code)))+" class=\"register__input\"> <button"+(_vm._ssrAttr("disabled",!_vm.enableStepThree))+" class=\"register__button\">\n        Далее\n      </button>"):"<!---->")+" "+((_vm.step === 3)?("<input placeholder=\"Имя\" type=\"text\""+(_vm._ssrAttr("value",(_vm.form.firstName)))+" class=\"register__input\"> <input placeholder=\"Фамилия\" type=\"text\""+(_vm._ssrAttr("value",(_vm.form.lastName)))+" class=\"register__input\"> <input placeholder=\"Отчество\" type=\"text\""+(_vm._ssrAttr("value",(_vm.form.middleName)))+" class=\"register__input\"> <input placeholder=\"Телефон\" type=\"text\""+(_vm._ssrAttr("value",(_vm.form.phoneNumber)))+" class=\"register__input\"> <input placeholder=\"Пароль\" type=\"password\""+(_vm._ssrAttr("value",(_vm.form.password)))+" class=\"register__input\"> <button"+(_vm._ssrAttr("disabled",!_vm.enableStepFour))+" class=\"register__button\">\n        Далее\n      </button>"):"<!---->")+" "+((_vm.step === 4)?("<div class=\"register__alert\">\n        Регистрация успешно завершена. <br>Вы можете войти.\n      </div> <a href=\"https://crm.zakazy.online/login\" class=\"register__button\">\n        Войти\n      </a>"):"<!---->")+" "+((_vm.step !== 0)?("<button class=\"register__button\">\n      Вернуться назад\n    </button>"):"<!---->")+"</div>")])}
var staticRenderFns = []


// CONCATENATED MODULE: ./components/Register.vue?vue&type=template&id=7df3c4b5&

// CONCATENATED MODULE: ./node_modules/babel-loader/lib??ref--2-0!./node_modules/@nuxt/components/dist/loader.js??ref--0-0!./node_modules/vue-loader/lib??vue-loader-options!./components/Register.vue?vue&type=script&lang=js&
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
const entities = {
  CLIENT: 'CLIENT',
  PARTNER: 'PARTNER',
  EXECUTOR: 'EXECUTOR'
};
const Registervue_type_script_lang_js_form = {
  phoneNumber: '',
  token: '',
  code: '',
  firstName: '',
  lastName: '',
  middleName: '',
  email: '',
  password: ''
};
/* harmony default export */ var Registervue_type_script_lang_js_ = ({
  name: 'Register',

  data() {
    return {
      step: 0,
      error: false,
      entity: entities.CLIENT,
      form: { ...Registervue_type_script_lang_js_form
      }
    };
  },

  computed: {
    enableStepTwo() {
      return this.form.email !== '' && /.+@.+\..+/.test(this.form.email);
    },

    enableStepThree() {
      return this.form.code.length === 4;
    },

    enableStepFour() {
      // return form.code.length === 4
      return this.form.firstName !== '' && this.form.lastName !== '' && this.form.middleName !== '' && this.form.email !== '' && this.form.phoneNumber.length > 3 && this.form.password !== '' && this.form.password.length >= 4;
    }

  },
  methods: {
    reset() {
      this.form = { ...Registervue_type_script_lang_js_form
      };
      this.step = 0;
    },

    openCrm() {
      window.open("https://crm.zakazy.online/", "_self");
    },

    registerEmail() {
      const {
        email
      } = this.form;
      this.$axios.post(`/${this.entity.toLowerCase()}/register/step/1`, {
        email
      }).then(r => {
        this.step = 2;
        this.form.token = r.data.data.token;
      });
    },

    registerSms() {
      const {
        phoneNumber,
        code,
        token
      } = this.form;
      this.$axios.post(`/${this.entity.toLowerCase()}/register/step/2`, {
        phoneNumber,
        code,
        token
      }).then(r => {
        this.step = 3;
        this.form.token = r.data.data.token;
      });
    },

    registerUser() {
      const {
        firstName,
        lastName,
        middleName,
        phoneNumber,
        password
      } = this.form;
      this.$axios.post(`/${this.entity.toLowerCase()}/register/step/3`, {
        firstName,
        lastName,
        middleName,
        phoneNumber,
        password
      }, {
        headers: {
          token: this.form.token
        }
      }).then(() => {
        this.step = 4;
      });
    },

    register(entity) {
      this.entity = entities[entity.toUpperCase()];
      this.step = 1;
    },

    typeNumber(e) {
      if (e.keyCode >= 48 && e.keyCode <= 57) {} else {
        e.preventDefault();
      }
    }

  }
});
// CONCATENATED MODULE: ./components/Register.vue?vue&type=script&lang=js&
 /* harmony default export */ var components_Registervue_type_script_lang_js_ = (Registervue_type_script_lang_js_); 
// EXTERNAL MODULE: ./node_modules/vue-loader/lib/runtime/componentNormalizer.js
var componentNormalizer = __webpack_require__(1);

// CONCATENATED MODULE: ./components/Register.vue





/* normalize component */

var component = Object(componentNormalizer["a" /* default */])(
  components_Registervue_type_script_lang_js_,
  render,
  staticRenderFns,
  false,
  null,
  null,
  "aa8c02e2"
  
)

/* harmony default export */ var Register = __webpack_exports__["default"] = (component.exports);

/***/ }),

/***/ 56:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
// ESM COMPAT FLAG
__webpack_require__.r(__webpack_exports__);

// CONCATENATED MODULE: ./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/@nuxt/components/dist/loader.js??ref--0-0!./node_modules/vue-loader/lib??vue-loader-options!./pages/index.vue?vue&type=template&id=1552664b&
var render = function () {var _vm=this;var _h=_vm.$createElement;var _c=_vm._self._c||_h;return _c('div',{staticClass:"cover"},[_vm._ssrNode("<div class=\"cover__qube\"><h1 class=\"cover__title\">CRM и ERP Система контроля</h1> <h1 class=\"cover__title\">заказов и исполнителей в 127</h1> <h1 class=\"cover__title\">нишах услуг в РФ и СНГ</h1> <div class=\"cover__blocks\"><span class=\"cover__block\">*ТРАФИК х ЗАЯВКИ = СДЕЛКИ*</span></div> <div class=\"cover__blocks\"><span class=\"cover__block\">СОЗДАЙ, СВОЮ НЕЙРОСЕТЬ...</span></div></div> "),_vm._ssrNode("<div class=\"cover__side\">","</div>",[_vm._ssrNode("<h2 class=\"cover__side-name\">Регистрация <span>в CRM</span></h2> "),_c('Register'),_vm._ssrNode(" <div class=\"cover__links\"></div>")],2)],2)}
var staticRenderFns = []


// CONCATENATED MODULE: ./pages/index.vue?vue&type=template&id=1552664b&

// EXTERNAL MODULE: ./constants/data.js
var data = __webpack_require__(6);

// EXTERNAL MODULE: ./components/Register.vue + 4 modules
var Register = __webpack_require__(49);

// CONCATENATED MODULE: ./node_modules/babel-loader/lib??ref--2-0!./node_modules/@nuxt/components/dist/loader.js??ref--0-0!./node_modules/vue-loader/lib??vue-loader-options!./pages/index.vue?vue&type=script&lang=js&
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//


/* harmony default export */ var lib_vue_loader_options_pagesvue_type_script_lang_js_ = ({
  components: {
    Register: Register["default"]
  },
  layout: 'home',

  data() {
    return {
      dialog: false,
      CONTACTS_LINK: data["a" /* CONTACTS_LINK */],
      HELP_LINK: data["c" /* HELP_LINK */]
    };
  },

  head: {
    title: 'ZAKAZIO',
    meta: [{
      hid: 'description',
      name: 'description',
      content: 'ПАРТНЕРСТВО ЗА % С ДОГОВОРА'
    }]
  }
});
// CONCATENATED MODULE: ./pages/index.vue?vue&type=script&lang=js&
 /* harmony default export */ var pagesvue_type_script_lang_js_ = (lib_vue_loader_options_pagesvue_type_script_lang_js_); 
// EXTERNAL MODULE: ./node_modules/vue-loader/lib/runtime/componentNormalizer.js
var componentNormalizer = __webpack_require__(1);

// CONCATENATED MODULE: ./pages/index.vue





/* normalize component */

var component = Object(componentNormalizer["a" /* default */])(
  pagesvue_type_script_lang_js_,
  render,
  staticRenderFns,
  false,
  null,
  null,
  "aef3258c"
  
)

/* harmony default export */ var pages = __webpack_exports__["default"] = (component.exports);

/* nuxt-component-imports */
installComponents(component, {Register: __webpack_require__(49).default})


/***/ })

};;
//# sourceMappingURL=index.js.map
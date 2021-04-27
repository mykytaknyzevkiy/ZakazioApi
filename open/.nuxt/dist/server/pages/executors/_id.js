exports.ids = [3];
exports.modules = {

/***/ 55:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
// ESM COMPAT FLAG
__webpack_require__.r(__webpack_exports__);

// CONCATENATED MODULE: ./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/@nuxt/components/dist/loader.js??ref--0-0!./node_modules/vue-loader/lib??vue-loader-options!./pages/executors/_id.vue?vue&type=template&id=48b4e663&
var render = function () {var _vm=this;var _h=_vm.$createElement;var _c=_vm._self._c||_h;return _c('div',{staticClass:"profile"},[_vm._ssrNode("<div class=\"container profile__container\"><div class=\"profile__side\"><div class=\"profile__avatar\"><h1 class=\"profile__executor\">"+_vm._ssrEscape("\n          "+_vm._s(_vm.user.firstName + ' ' + _vm.user.lastName)+"\n        ")+"</h1> <hr> <div class=\"profile__rate\">"+_vm._ssrEscape("Рейтинг: "+_vm._s(_vm.user.rate))+"</div> <div class=\"profile__city\">"+_vm._ssrEscape("Город: "+_vm._s(_vm.city))+"</div></div> <a href=\"https://crm.zakazy.online/login\" class=\"profile__order-btn\">Заказать работу</a></div> <div class=\"profile__area\"><div class=\"profile__tabs\"><button"+(_vm._ssrClass("profile__tab",{ profile__tab_active: _vm.TAB === _vm.TABS.PORTFOLIO }))+">\n          Портфолио\n        </button></div> <div class=\"profile__portfolio\""+(_vm._ssrStyle(null,null, { display: (_vm.TAB === _vm.TABS.PORTFOLIO) ? '' : 'none' }))+">"+((_vm.portfolio.length > 0)?((_vm._ssrList((_vm.portfolio),function(pItem){return ("<div class=\"profile__portfolio-item\"><img"+(_vm._ssrAttr("src",(_vm.storageUrl + "/" + (pItem.wallpaper))))+" alt></div>")}))):("<p class=\"profile__message\">Нет контента.</p>"))+"</div> <div class=\"profile__orders\""+(_vm._ssrStyle(null,null, { display: (_vm.TAB === _vm.TABS.PROJECTS) ? '' : 'none' }))+">\n        Нет контента.\n      </div></div></div> <div"+(_vm._ssrClass("profile__modal",{ profile__modal_active: _vm.portfolioModal }))+"><div class=\"container\">"+((_vm.currentPortFolio !== null)?("<div class=\"profile__modal-content\"><div class=\"profile__modal-head\"><span>"+_vm._ssrEscape(_vm._s(_vm.currentPortFolio.label))+"</span> <button>x</button></div> <div class=\"profile__modal-body\"><div><img"+(_vm._ssrAttr("src",(_vm.storageUrl + "/" + (_vm.currentPortFolio.wallpaper))))+" alt class=\"profile__modal-slide\"> <p>"+_vm._ssrEscape(_vm._s(_vm.currentPortFolio.description))+"</p></div> "+(_vm._ssrList((_vm.currentPortFolio.imageSlides),function(slide){return ("<div><img"+(_vm._ssrAttr("src",(_vm.storageUrl + "/" + slide)))+" alt class=\"profile__modal-slide\"></div>")}))+"</div></div>"):"<!---->")+"</div></div>")])}
var staticRenderFns = []


// CONCATENATED MODULE: ./pages/executors/_id.vue?vue&type=template&id=48b4e663&

// CONCATENATED MODULE: ./node_modules/babel-loader/lib??ref--2-0!./node_modules/@nuxt/components/dist/loader.js??ref--0-0!./node_modules/vue-loader/lib??vue-loader-options!./pages/executors/_id.vue?vue&type=script&lang=js&
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

/* import UserOrderCard from '~/components/user/UserOrderCard'
import UserAvatar from '~/components/user/UserAvatar'
import UserFeedbacks from '~/components/user/UserFeedbacks' */
const TABS = {
  PORTFOLIO: 'PORTFOLIO',
  PROJECTS: 'PROJECTS'
};
/* const token =
  'Bearer eyJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwiZk5hbWUiOiJTdXBlciIsImxOYW1lIjoiQWRtaW4iLCJtTmFtZSI6Ilpha2F6eSIsImV4cCI6MTYxMzY5NjUxNn0.Tqqg2o1McKY_nblEt8odNfnLSWEfM-84A9GpDS6jz2E' */

/* harmony default export */ var _idvue_type_script_lang_js_ = ({
  // components: { UserFeedbacks, UserAvatar, UserOrderCard },
  async asyncData({
    error,
    $axios,
    route
  }) {
    try {
      const res = await $axios.get(`executor/${route.params.id}`);
      const portfolioRes = await $axios.get(`portfolio/list/user/${route.params.id}`
      /* {
        headers: {
          Authorization: token,
        },
      } */
      );
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
        portfolio: portfolioRes.data.data.content // orders: userOrders.data.data.content,

      };
    } catch (e) {
      // eslint-disable-next-line no-throw-literal
      return error({
        statusCode: 404,
        message: 'Профиль не найден'
      });
    }
  },

  data() {
    return {
      TABS,
      user: {},
      portfolio: [],
      portfolioModal: false,
      TAB: TABS.PORTFOLIO,
      showPortfolioId: null
    };
  },

  computed: {
    city() {
      var _this$user, _this$user$city;

      return ((_this$user = this.user) === null || _this$user === void 0 ? void 0 : (_this$user$city = _this$user.city) === null || _this$user$city === void 0 ? void 0 : _this$user$city.name) || 'не указан';
    },

    currentPortFolio() {
      return this.portfolio.find(i => i.id === this.showPortfolioId) || null;
    }

  },

  mounted() {
    window.addEventListener('keydown', e => {
      if (e.code === 'Escape') {
        this.hidePortfolio();
      }
    });
  },

  methods: {
    hidePortfolio() {
      const body = window.document.querySelector('body');
      body.classList.remove('no-overflow');
      this.portfolioModal = false;
      this.showPortfolioId = null;
    },

    showPortfolio(id) {
      this.showPortfolioId = id;
      const body = window.document.querySelector('body');
      body.classList.add('no-overflow');
      this.portfolioModal = true;
    }

  },

  head() {
    var _this$user2, _this$user3, _this$user4, _this$user5;

    return {
      title: 'Исполнитель ' + ((_this$user2 = this.user) === null || _this$user2 === void 0 ? void 0 : _this$user2.firstName) + ' ' + ((_this$user3 = this.user) === null || _this$user3 === void 0 ? void 0 : _this$user3.lastName),
      meta: [{
        hid: 'description',
        name: 'description',
        content: 'Исполнитель ' + ((_this$user4 = this.user) === null || _this$user4 === void 0 ? void 0 : _this$user4.firstName) + ' ' + ((_this$user5 = this.user) === null || _this$user5 === void 0 ? void 0 : _this$user5.lastName)
      }]
    };
  }

});
// CONCATENATED MODULE: ./pages/executors/_id.vue?vue&type=script&lang=js&
 /* harmony default export */ var executors_idvue_type_script_lang_js_ = (_idvue_type_script_lang_js_); 
// EXTERNAL MODULE: ./node_modules/vue-loader/lib/runtime/componentNormalizer.js
var componentNormalizer = __webpack_require__(1);

// CONCATENATED MODULE: ./pages/executors/_id.vue





/* normalize component */

var component = Object(componentNormalizer["a" /* default */])(
  executors_idvue_type_script_lang_js_,
  render,
  staticRenderFns,
  false,
  null,
  null,
  "eea6ddda"
  
)

/* harmony default export */ var _id = __webpack_exports__["default"] = (component.exports);

/***/ })

};;
//# sourceMappingURL=_id.js.map
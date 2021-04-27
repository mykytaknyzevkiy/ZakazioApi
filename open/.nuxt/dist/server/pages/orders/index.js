exports.ids = [6];
exports.modules = {

/***/ 46:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
// ESM COMPAT FLAG
__webpack_require__.r(__webpack_exports__);

// CONCATENATED MODULE: ./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/@nuxt/components/dist/loader.js??ref--0-0!./node_modules/vue-loader/lib??vue-loader-options!./components/common/Paginator.vue?vue&type=template&id=6d8ee562&
var render = function () {var _vm=this;var _h=_vm.$createElement;var _c=_vm._self._c||_h;return _c('div',{staticClass:"paginator"},[_vm._ssrNode("<ul class=\"paginator__list\">"+((_vm.metaInfo.currentPage > 1)?("<li class=\"paginator__item\"><a"+(_vm._ssrAttr("href",(_vm.route + "?page=" + (_vm.metaInfo.currentPage))))+" class=\"paginator__link paginator__link_prev\">Назад</a></li>"):"<!---->")+" "+(_vm._ssrList((_vm.prevLinks),function(i){return ("<li class=\"paginator__item\"><a"+(_vm._ssrAttr("href",(_vm.route + "?page=" + (_vm.metaInfo.currentPage - _vm.prevLinks + i - 1))))+" class=\"paginator__link\">"+_vm._ssrEscape(_vm._s(_vm.metaInfo.currentPage - _vm.prevLinks + i - 1))+"</a></li>")}))+" <li class=\"paginator__item\"><span class=\"paginator__link paginator__link_current\">"+_vm._ssrEscape(_vm._s(_vm.metaInfo.currentPage))+"</span></li> "+(_vm._ssrList((_vm.nextLinks),function(i){return ("<li class=\"paginator__item\"><a"+(_vm._ssrAttr("href",(_vm.route + "?page=" + (_vm.metaInfo.currentPage + i))))+" class=\"paginator__link\">"+_vm._ssrEscape(_vm._s(_vm.metaInfo.currentPage + i))+"</a></li>")}))+" "+((_vm.metaInfo.currentPage < _vm.metaInfo.totalPages)?("<li class=\"paginator__item\"><a"+(_vm._ssrAttr("href",(_vm.route + "?page=" + (_vm.metaInfo.currentPage + 1))))+" class=\"paginator__link paginator__link_next\">Вперед</a></li>"):"<!---->")+"</ul>")])}
var staticRenderFns = []


// CONCATENATED MODULE: ./components/common/Paginator.vue?vue&type=template&id=6d8ee562&

// CONCATENATED MODULE: ./node_modules/babel-loader/lib??ref--2-0!./node_modules/@nuxt/components/dist/loader.js??ref--0-0!./node_modules/vue-loader/lib??vue-loader-options!./components/common/Paginator.vue?vue&type=script&lang=js&
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
const side = 3;
/* harmony default export */ var Paginatorvue_type_script_lang_js_ = ({
  props: {
    metaInfo: {
      type: Object,

      default() {
        return {
          currentPage: 1,
          totalElements: 1,
          totalPages: 1
        };
      }

    }
  },
  computed: {
    // сколько всего страниц
    nextLinks() {
      const items = this.metaInfo.totalPages - this.metaInfo.currentPage;
      return items > side ? side : items < 0 ? 0 : items;
    },

    prevLinks() {
      const items = this.metaInfo.currentPage - 1;
      return items > side ? side : items <= 0 ? 0 : items;
    },

    route() {
      return this.$route.name;
    }

  }
});
// CONCATENATED MODULE: ./components/common/Paginator.vue?vue&type=script&lang=js&
 /* harmony default export */ var common_Paginatorvue_type_script_lang_js_ = (Paginatorvue_type_script_lang_js_); 
// EXTERNAL MODULE: ./node_modules/vue-loader/lib/runtime/componentNormalizer.js
var componentNormalizer = __webpack_require__(1);

// CONCATENATED MODULE: ./components/common/Paginator.vue





/* normalize component */

var component = Object(componentNormalizer["a" /* default */])(
  common_Paginatorvue_type_script_lang_js_,
  render,
  staticRenderFns,
  false,
  null,
  null,
  "cd5708ce"
  
)

/* harmony default export */ var Paginator = __webpack_exports__["default"] = (component.exports);

/***/ }),

/***/ 48:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
// ESM COMPAT FLAG
__webpack_require__.r(__webpack_exports__);

// CONCATENATED MODULE: ./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/@nuxt/components/dist/loader.js??ref--0-0!./node_modules/vue-loader/lib??vue-loader-options!./components/orders/OrderCard.vue?vue&type=template&id=d90ef3e0&
var render = function () {var _vm=this;var _h=_vm.$createElement;var _c=_vm._self._c||_h;return _c('div',{staticClass:"order"},[_vm._ssrNode("<div class=\"order__avatar\"></div> <div class=\"order__text\"><h2 class=\"order__title\">"+_vm._ssrEscape(_vm._s(_vm.order.title))+"</h2> <p class=\"order__content\">"+_vm._ssrEscape("\n      "+_vm._s(_vm.order.content)+"\n    ")+"</p></div> <div class=\"order__map\">Россия, <br>Москва</div> <div class=\"order__sum\">"+_vm._ssrEscape(_vm._s(_vm.order.toShareSum)+" р.")+"</div> <a href=\"https://crm.zakazy.online/login\" class=\"order__btn\">Откликнуться</a>")])}
var staticRenderFns = []


// CONCATENATED MODULE: ./components/orders/OrderCard.vue?vue&type=template&id=d90ef3e0&

// CONCATENATED MODULE: ./node_modules/babel-loader/lib??ref--2-0!./node_modules/@nuxt/components/dist/loader.js??ref--0-0!./node_modules/vue-loader/lib??vue-loader-options!./components/orders/OrderCard.vue?vue&type=script&lang=js&
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
/* harmony default export */ var OrderCardvue_type_script_lang_js_ = ({
  name: 'OrderCard',
  props: {
    order: {
      type: Object,
      default: () => {}
    }
  }
});
// CONCATENATED MODULE: ./components/orders/OrderCard.vue?vue&type=script&lang=js&
 /* harmony default export */ var orders_OrderCardvue_type_script_lang_js_ = (OrderCardvue_type_script_lang_js_); 
// EXTERNAL MODULE: ./node_modules/vue-loader/lib/runtime/componentNormalizer.js
var componentNormalizer = __webpack_require__(1);

// CONCATENATED MODULE: ./components/orders/OrderCard.vue





/* normalize component */

var component = Object(componentNormalizer["a" /* default */])(
  orders_OrderCardvue_type_script_lang_js_,
  render,
  staticRenderFns,
  false,
  null,
  null,
  "15dee400"
  
)

/* harmony default export */ var OrderCard = __webpack_exports__["default"] = (component.exports);

/***/ }),

/***/ 53:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
// ESM COMPAT FLAG
__webpack_require__.r(__webpack_exports__);

// CONCATENATED MODULE: ./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/@nuxt/components/dist/loader.js??ref--0-0!./node_modules/vue-loader/lib??vue-loader-options!./pages/orders/index.vue?vue&type=template&id=5f3cd8df&
var render = function () {var _vm=this;var _h=_vm.$createElement;var _c=_vm._self._c||_h;return _c('div',{staticClass:"orders"},[_vm._ssrNode("<div class=\"container\">","</div>",[_vm._ssrNode("<h1 class=\"orders__title\">Заказы</h1> "),_vm._l((_vm.content),function(order){return _c('OrderCard',{key:order.id,attrs:{"order":order}})}),_vm._ssrNode(" "),_c('Paginator',{attrs:{"meta-info":_vm.meta}})],2)])}
var staticRenderFns = []


// CONCATENATED MODULE: ./pages/orders/index.vue?vue&type=template&id=5f3cd8df&

// EXTERNAL MODULE: ./components/orders/OrderCard.vue + 4 modules
var OrderCard = __webpack_require__(48);

// EXTERNAL MODULE: ./mixins/global.js
var global = __webpack_require__(14);

// EXTERNAL MODULE: ./components/common/Paginator.vue + 4 modules
var Paginator = __webpack_require__(46);

// CONCATENATED MODULE: ./node_modules/babel-loader/lib??ref--2-0!./node_modules/@nuxt/components/dist/loader.js??ref--0-0!./node_modules/vue-loader/lib??vue-loader-options!./pages/orders/index.vue?vue&type=script&lang=js&
//
//
//
//
//
//
//
//
//



/* harmony default export */ var ordersvue_type_script_lang_js_ = ({
  layout: 'default',
  components: {
    Paginator: Paginator["default"],
    OrderCard: OrderCard["default"]
  },
  mixins: [global["a" /* default */]],

  async asyncData({
    $axios,
    route
  }) {
    const res = await $axios.get(`order/list?page=${Number(route.query.page) - 1}`);
    return Object(global["b" /* returnObj */])(res);
  },

  head: {
    title: 'Заказы',
    meta: [{
      hid: 'description',
      name: 'description',
      content: 'Заказы на строительные работы'
    }]
  }
});
// CONCATENATED MODULE: ./pages/orders/index.vue?vue&type=script&lang=js&
 /* harmony default export */ var pages_ordersvue_type_script_lang_js_ = (ordersvue_type_script_lang_js_); 
// EXTERNAL MODULE: ./node_modules/vue-loader/lib/runtime/componentNormalizer.js
var componentNormalizer = __webpack_require__(1);

// CONCATENATED MODULE: ./pages/orders/index.vue





/* normalize component */

var component = Object(componentNormalizer["a" /* default */])(
  pages_ordersvue_type_script_lang_js_,
  render,
  staticRenderFns,
  false,
  null,
  null,
  "327d9af0"
  
)

/* harmony default export */ var orders = __webpack_exports__["default"] = (component.exports);

/* nuxt-component-imports */
installComponents(component, {OrderCard: __webpack_require__(48).default,Paginator: __webpack_require__(46).default})


/***/ })

};;
//# sourceMappingURL=index.js.map
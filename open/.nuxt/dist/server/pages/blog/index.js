exports.ids = [2];
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

/***/ 51:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
// ESM COMPAT FLAG
__webpack_require__.r(__webpack_exports__);

// CONCATENATED MODULE: ./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/@nuxt/components/dist/loader.js??ref--0-0!./node_modules/vue-loader/lib??vue-loader-options!./pages/blog/index.vue?vue&type=template&id=9619a48a&
var render = function () {var _vm=this;var _h=_vm.$createElement;var _c=_vm._self._c||_h;return _c('div',{staticClass:"blog"},[_vm._ssrNode("<div class=\"container\">","</div>",[_vm._ssrNode("<h1 class=\"blog__title\">Блог</h1> "),_vm._ssrNode("<div class=\"blog__list\">","</div>",[_vm._l((_vm.content),function(article){return [_vm._ssrNode("<div class=\"blog__item\">","</div>",[_vm._ssrNode("<div class=\"blog__img\">","</div>",[_c('nuxt-link',{attrs:{"to":("blog/" + (article.id))}},[_c('img',{staticStyle:{"max-width":"750px"},attrs:{"src":(_vm.storageUrl + "/" + (article.wallpaper)),"alt":""}})])],1),_vm._ssrNode(" <h2 class=\"blog__item-title\">"+_vm._ssrEscape(_vm._s(article.title))+"</h2> <p>"+_vm._ssrEscape("\n            "+_vm._s(article.content)+"\n          ")+"</p> "),_c('nuxt-link',{attrs:{"to":("blog/" + (article.id))}},[_vm._v("Подробнее")])],2),_vm._ssrNode(" <hr class=\"blog__item-separator\">")]})],2),_vm._ssrNode(" "),_c('Paginator',{attrs:{"meta-info":_vm.meta}})],2)])}
var staticRenderFns = []


// CONCATENATED MODULE: ./pages/blog/index.vue?vue&type=template&id=9619a48a&

// EXTERNAL MODULE: ./mixins/global.js
var global = __webpack_require__(14);

// EXTERNAL MODULE: ./components/common/Paginator.vue + 4 modules
var Paginator = __webpack_require__(46);

// CONCATENATED MODULE: ./node_modules/babel-loader/lib??ref--2-0!./node_modules/@nuxt/components/dist/loader.js??ref--0-0!./node_modules/vue-loader/lib??vue-loader-options!./pages/blog/index.vue?vue&type=script&lang=js&
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


/* harmony default export */ var blogvue_type_script_lang_js_ = ({
  name: 'Index',
  components: {
    Paginator: Paginator["default"]
  },
  mixins: [global["a" /* default */]],

  async asyncData({
    $axios,
    route
  }) {
    const res = await $axios.get(`blog/list?page=${Number(route.query.page) - 1}`);
    return Object(global["b" /* returnObj */])(res);
  },

  head: {
    title: 'Блог'
  }
});
// CONCATENATED MODULE: ./pages/blog/index.vue?vue&type=script&lang=js&
 /* harmony default export */ var pages_blogvue_type_script_lang_js_ = (blogvue_type_script_lang_js_); 
// EXTERNAL MODULE: ./node_modules/vue-loader/lib/runtime/componentNormalizer.js
var componentNormalizer = __webpack_require__(1);

// CONCATENATED MODULE: ./pages/blog/index.vue





/* normalize component */

var component = Object(componentNormalizer["a" /* default */])(
  pages_blogvue_type_script_lang_js_,
  render,
  staticRenderFns,
  false,
  null,
  null,
  "59f66b6d"
  
)

/* harmony default export */ var blog = __webpack_exports__["default"] = (component.exports);

/* nuxt-component-imports */
installComponents(component, {Paginator: __webpack_require__(46).default})


/***/ })

};;
//# sourceMappingURL=index.js.map
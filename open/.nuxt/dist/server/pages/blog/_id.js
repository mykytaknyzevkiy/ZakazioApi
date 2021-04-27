exports.ids = [1];
exports.modules = {

/***/ 54:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
// ESM COMPAT FLAG
__webpack_require__.r(__webpack_exports__);

// CONCATENATED MODULE: ./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/@nuxt/components/dist/loader.js??ref--0-0!./node_modules/vue-loader/lib??vue-loader-options!./pages/blog/_id.vue?vue&type=template&id=48041fec&
var render = function () {var _vm=this;var _h=_vm.$createElement;var _c=_vm._self._c||_h;return _c('div',{staticClass:"blog"},[_vm._ssrNode("<div class=\"container\">","</div>",[_c('nuxt-link',{staticStyle:{"display":"block","margin-bottom":"20px"},attrs:{"to":"/blog"}},[_vm._v("Вернться в блог")]),_vm._ssrNode(" <h1 class=\"blog__title\">"+_vm._ssrEscape(_vm._s(_vm.article.title))+"</h1> <time"+(_vm._ssrAttr("datetime",_vm.article.creationDateTime))+" style=\"display: block; margin-bottom: 20px\">"+_vm._ssrEscape(_vm._s(_vm._f("formatDate")(_vm.article.creationDateTime)))+"</time> <img"+(_vm._ssrAttr("src",(_vm.storageUrl + "/" + (_vm.article.wallpaper))))+" alt style=\"display: block; max-width: 750px; margin-bottom: 20px\"> <p>"+_vm._ssrEscape(_vm._s(_vm.article.content))+"</p>")],2)])}
var staticRenderFns = []


// CONCATENATED MODULE: ./pages/blog/_id.vue?vue&type=template&id=48041fec&

// EXTERNAL MODULE: external "dayjs"
var external_dayjs_ = __webpack_require__(45);
var external_dayjs_default = /*#__PURE__*/__webpack_require__.n(external_dayjs_);

// CONCATENATED MODULE: ./node_modules/babel-loader/lib??ref--2-0!./node_modules/@nuxt/components/dist/loader.js??ref--0-0!./node_modules/vue-loader/lib??vue-loader-options!./pages/blog/_id.vue?vue&type=script&lang=js&
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//

/* harmony default export */ var _idvue_type_script_lang_js_ = ({
  filters: {
    formatDate(value) {
      return external_dayjs_default()(value).format('DD.MM.YYYY');
    }

  },

  async asyncData({
    error,
    $axios,
    route
  }) {
    try {
      const res = await $axios.get(`blog/${route.params.id}`);
      return {
        article: res.data.data
      };
    } catch (e) {
      // eslint-disable-next-line no-throw-literal
      return error({
        statusCode: 404,
        message: 'Запись не найдена'
      });
    }
  }

});
// CONCATENATED MODULE: ./pages/blog/_id.vue?vue&type=script&lang=js&
 /* harmony default export */ var blog_idvue_type_script_lang_js_ = (_idvue_type_script_lang_js_); 
// EXTERNAL MODULE: ./node_modules/vue-loader/lib/runtime/componentNormalizer.js
var componentNormalizer = __webpack_require__(1);

// CONCATENATED MODULE: ./pages/blog/_id.vue





/* normalize component */

var component = Object(componentNormalizer["a" /* default */])(
  blog_idvue_type_script_lang_js_,
  render,
  staticRenderFns,
  false,
  null,
  null,
  "25126515"
  
)

/* harmony default export */ var _id = __webpack_exports__["default"] = (component.exports);

/***/ })

};;
//# sourceMappingURL=_id.js.map
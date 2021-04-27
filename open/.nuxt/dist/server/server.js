module.exports =
/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// object to store loaded chunks
/******/ 	// "0" means "already loaded"
/******/ 	var installedChunks = {
/******/ 		0: 0
/******/ 	};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/ 	// This file contains only the entry chunk.
/******/ 	// The chunk loading function for additional chunks
/******/ 	__webpack_require__.e = function requireEnsure(chunkId) {
/******/ 		var promises = [];
/******/
/******/
/******/ 		// require() chunk loading for javascript
/******/
/******/ 		// "0" is the signal for "already loaded"
/******/ 		if(installedChunks[chunkId] !== 0) {
/******/ 			var chunk = require("./" + ({"1":"pages/blog/_id","2":"pages/blog/index","3":"pages/executors/_id","4":"pages/executors/index","5":"pages/index","6":"pages/orders/index"}[chunkId]||chunkId) + ".js");
/******/ 			var moreModules = chunk.modules, chunkIds = chunk.ids;
/******/ 			for(var moduleId in moreModules) {
/******/ 				modules[moduleId] = moreModules[moduleId];
/******/ 			}
/******/ 			for(var i = 0; i < chunkIds.length; i++)
/******/ 				installedChunks[chunkIds[i]] = 0;
/******/ 		}
/******/ 		return Promise.all(promises);
/******/ 	};
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, { enumerable: true, get: getter });
/******/ 		}
/******/ 	};
/******/
/******/ 	// define __esModule on exports
/******/ 	__webpack_require__.r = function(exports) {
/******/ 		if(typeof Symbol !== 'undefined' && Symbol.toStringTag) {
/******/ 			Object.defineProperty(exports, Symbol.toStringTag, { value: 'Module' });
/******/ 		}
/******/ 		Object.defineProperty(exports, '__esModule', { value: true });
/******/ 	};
/******/
/******/ 	// create a fake namespace object
/******/ 	// mode & 1: value is a module id, require it
/******/ 	// mode & 2: merge all properties of value into the ns
/******/ 	// mode & 4: return value when already ns object
/******/ 	// mode & 8|1: behave like require
/******/ 	__webpack_require__.t = function(value, mode) {
/******/ 		if(mode & 1) value = __webpack_require__(value);
/******/ 		if(mode & 8) return value;
/******/ 		if((mode & 4) && typeof value === 'object' && value && value.__esModule) return value;
/******/ 		var ns = Object.create(null);
/******/ 		__webpack_require__.r(ns);
/******/ 		Object.defineProperty(ns, 'default', { enumerable: true, value: value });
/******/ 		if(mode & 2 && typeof value != 'string') for(var key in value) __webpack_require__.d(ns, key, function(key) { return value[key]; }.bind(null, key));
/******/ 		return ns;
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "/_nuxt/";
/******/
/******/ 	// uncaught error handler for webpack runtime
/******/ 	__webpack_require__.oe = function(err) {
/******/ 		process.nextTick(function() {
/******/ 			throw err; // catch this error by using import().catch()
/******/ 		});
/******/ 	};
/******/
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 22);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ (function(module, exports) {

module.exports = require("vue");

/***/ }),
/* 1 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return normalizeComponent; });
/* globals __VUE_SSR_CONTEXT__ */

// IMPORTANT: Do NOT use ES2015 features in this file (except for modules).
// This module is a runtime utility for cleaner component module output and will
// be included in the final webpack user bundle.

function normalizeComponent (
  scriptExports,
  render,
  staticRenderFns,
  functionalTemplate,
  injectStyles,
  scopeId,
  moduleIdentifier, /* server only */
  shadowMode /* vue-cli only */
) {
  // Vue.extend constructor export interop
  var options = typeof scriptExports === 'function'
    ? scriptExports.options
    : scriptExports

  // render functions
  if (render) {
    options.render = render
    options.staticRenderFns = staticRenderFns
    options._compiled = true
  }

  // functional template
  if (functionalTemplate) {
    options.functional = true
  }

  // scopedId
  if (scopeId) {
    options._scopeId = 'data-v-' + scopeId
  }

  var hook
  if (moduleIdentifier) { // server build
    hook = function (context) {
      // 2.3 injection
      context =
        context || // cached call
        (this.$vnode && this.$vnode.ssrContext) || // stateful
        (this.parent && this.parent.$vnode && this.parent.$vnode.ssrContext) // functional
      // 2.2 with runInNewContext: true
      if (!context && typeof __VUE_SSR_CONTEXT__ !== 'undefined') {
        context = __VUE_SSR_CONTEXT__
      }
      // inject component styles
      if (injectStyles) {
        injectStyles.call(this, context)
      }
      // register component module identifier for async chunk inferrence
      if (context && context._registeredComponents) {
        context._registeredComponents.add(moduleIdentifier)
      }
    }
    // used by ssr in case component is cached and beforeCreate
    // never gets called
    options._ssrRegister = hook
  } else if (injectStyles) {
    hook = shadowMode
      ? function () {
        injectStyles.call(
          this,
          (options.functional ? this.parent : this).$root.$options.shadowRoot
        )
      }
      : injectStyles
  }

  if (hook) {
    if (options.functional) {
      // for template-only hot-reload because in that case the render fn doesn't
      // go through the normalizer
      options._injectStyles = hook
      // register for functional component in vue file
      var originalRender = options.render
      options.render = function renderWithStyleInjection (h, context) {
        hook.call(context)
        return originalRender(h, context)
      }
    } else {
      // inject component registration as beforeCreate hook
      var existing = options.beforeCreate
      options.beforeCreate = existing
        ? [].concat(existing, hook)
        : [hook]
    }
  }

  return {
    exports: scriptExports,
    options: options
  }
}


/***/ }),
/* 2 */
/***/ (function(module, exports) {

module.exports = require("vuex");

/***/ }),
/* 3 */
/***/ (function(module, exports) {

module.exports = require("@nuxt/ufo");

/***/ }),
/* 4 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
// ESM COMPAT FLAG
__webpack_require__.r(__webpack_exports__);

// CONCATENATED MODULE: ./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/@nuxt/components/dist/loader.js??ref--0-0!./node_modules/vue-loader/lib??vue-loader-options!./components/TheHeader.vue?vue&type=template&id=70b79e99&
var render = function () {var _vm=this;var _h=_vm.$createElement;var _c=_vm._self._c||_h;return _c('header',{staticClass:"header"},[_vm._ssrNode("<div class=\"container header__container\">","</div>",[_c('nuxt-link',{staticClass:"header__logo",attrs:{"to":"/"}},[_vm._v(_vm._s(_vm.contacts.companyName))]),_vm._ssrNode(" <div class=\"header__text\">"+_vm._ssrEscape(_vm._s(_vm.SLOGAN))+"</div> <div class=\"header__contact\"><a"+(_vm._ssrAttr("href",("tel:+" + (_vm.contacts.phoneNumber))))+" class=\"header__phone\">"+_vm._ssrEscape(_vm._s(_vm.contacts.phoneNumber))+"</a></div> <div"+(_vm._ssrClass("header__socials",{ header__socials_expanded: _vm.socials }))+"><button"+(_vm._ssrClass("header__social-switch",{ 'header__social-switch_expanded': _vm.socials }))+"></button> <div"+(_vm._ssrClass("header__social-links",{ 'header__social-links_expanded': _vm.socials }))+"><a target=\"_blank\""+(_vm._ssrAttr("href",_vm.contacts.linkedIn))+" class=\"header__social header__social_vk\">Zakazio в VK</a> <a target=\"_blank\""+(_vm._ssrAttr("href",_vm.contacts.instagram))+" class=\"header__social header__social_inst\">Zakazio в Instagram</a> <a target=\"_blank\""+(_vm._ssrAttr("href",_vm.contacts.twitter))+" class=\"header__social header__social_whtsp\">Zakazio в WhatsApp</a></div></div>")],2)])}
var staticRenderFns = []


// CONCATENATED MODULE: ./components/TheHeader.vue?vue&type=template&id=70b79e99&

// EXTERNAL MODULE: external "vuex"
var external_vuex_ = __webpack_require__(2);

// EXTERNAL MODULE: ./constants/data.js
var data = __webpack_require__(6);

// CONCATENATED MODULE: ./node_modules/babel-loader/lib??ref--2-0!./node_modules/@nuxt/components/dist/loader.js??ref--0-0!./node_modules/vue-loader/lib??vue-loader-options!./components/TheHeader.vue?vue&type=script&lang=js&
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//


/* harmony default export */ var TheHeadervue_type_script_lang_js_ = ({
  name: 'TheHeader',

  data() {
    return {
      socials: false,
      SLOGAN: data["e" /* SLOGAN */]
    };
  },

  computed: { ...Object(external_vuex_["mapGetters"])('contacts', ['contacts'])
  }
});
// CONCATENATED MODULE: ./components/TheHeader.vue?vue&type=script&lang=js&
 /* harmony default export */ var components_TheHeadervue_type_script_lang_js_ = (TheHeadervue_type_script_lang_js_); 
// EXTERNAL MODULE: ./node_modules/vue-loader/lib/runtime/componentNormalizer.js
var componentNormalizer = __webpack_require__(1);

// CONCATENATED MODULE: ./components/TheHeader.vue





/* normalize component */

var component = Object(componentNormalizer["a" /* default */])(
  components_TheHeadervue_type_script_lang_js_,
  render,
  staticRenderFns,
  false,
  null,
  null,
  "3f1884bc"
  
)

/* harmony default export */ var TheHeader = __webpack_exports__["default"] = (component.exports);

/***/ }),
/* 5 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
// ESM COMPAT FLAG
__webpack_require__.r(__webpack_exports__);

// CONCATENATED MODULE: ./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/@nuxt/components/dist/loader.js??ref--0-0!./node_modules/vue-loader/lib??vue-loader-options!./components/TheFooter.vue?vue&type=template&id=15bcc371&
var render = function () {var _vm=this;var _h=_vm.$createElement;var _c=_vm._self._c||_h;return _c('footer',{staticClass:"footer"},[_vm._ssrNode("<div class=\"container-fluid footer__container\">","</div>",[_vm._ssrNode("<div class=\"footer__col\">","</div>",[_c('nuxt-link',{staticClass:"footer__logo",attrs:{"to":"/"}},[_vm._v(_vm._s(_vm.contacts.companyName))])],1),_vm._ssrNode(" <div class=\"footer__col\"><div class=\"footer__copyright\"><p class=\"footer__name\">"+_vm._ssrEscape("\n          "+_vm._s(_vm.COPYRIGHT)+"\n        ")+"</p> <div class=\"footer__numbers\">"+_vm._ssrEscape("\n          "+_vm._s(_vm.OGRN_NUMBER)+" | ИНН "+_vm._s(_vm.TIN_NUMBER)+"\n        ")+"</div></div></div> "),_vm._ssrNode("<div class=\"footer__col\">","</div>",[_vm._ssrNode("<div class=\"footer__menu\">","</div>",[_c('nuxt-link',{staticClass:"footer__menu-item footer__menu-item_executors",attrs:{"to":"/executors"}},[_vm._v("Исполнители")]),_vm._ssrNode(" "),_c('nuxt-link',{staticClass:"footer__menu-item footer__menu-item_orders",attrs:{"to":"/orders"}},[_vm._v("Заказы")]),_vm._ssrNode(" "),_c('nuxt-link',{staticClass:"footer__menu-item footer__menu-item_blog",attrs:{"to":"/blog"}},[_vm._v("Блог")])],2)]),_vm._ssrNode(" <div class=\"footer__col\"><div class=\"footer__links\"><a href=\"https://file.zakazy.online/document/%D0%A3%D1%81%D0%BB%D0%BE%D0%B2%D0%B8%D1%8F%20%D0%B8%D1%81%D0%BF%D0%BE%D0%BB%D1%8C%D0%B7%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D1%8F%20(%D0%9E%D1%84%D0%B5%D1%80%D1%82%D0%B0).pdf\">Условия использования (Оферта)\n        </a> <a href=\"https://file.zakazy.online/document/%D0%BF%D0%BE%D0%BB%D0%B8%D1%82%D0%B8%D0%BA%D0%B0-%D0%BA%D0%BE%D0%BD%D1%84%D0%B8%D0%BD%D0%B4%D0%B5%D0%BD%D1%86%D0%B8%D0%B0%D0%BB%D1%8C%D0%BD%D0%BE%D1%81%D1%82%D0%B8%20(1).pdf\">Политика обработки персональных данных</a> <a href=\"https://file.zakazy.online/document/%D0%BE%D1%82%D0%BA%D0%B0%D0%B7_%D0%BE%D1%82_%D0%BE%D1%82%D0%B2%D0%B5%D1%81%D1%82%D0%B2%D0%B5%D0%BD%D0%BD%D0%BE%D1%81%D1%82%D0%B8_%D0%B7%D0%B0_%D0%BF%D1%80%D0%B8%D0%B1%D1%8B%D0%BB%D1%8C.pdf\">\n          Отказ от ответственности за прибыль</a></div></div> <div class=\"footer__col\"><div class=\"footer__contact\"><a"+(_vm._ssrAttr("href",("tel:+" + (_vm.contacts.phoneNumber))))+" class=\"footer__phone\">"+_vm._ssrEscape(_vm._s(_vm.contacts.phoneNumber))+"</a></div></div> <div class=\"footer__col\"><div class=\"footer__socials\"><a target=\"_blank\""+(_vm._ssrAttr("href",_vm.contacts.linkedIn))+" class=\"footer__social footer__social_vk\">Zakazio в VK</a> <a target=\"_blank\""+(_vm._ssrAttr("href",_vm.contacts.instagram))+" class=\"footer__social footer__social_inst\">Zakazio в Instagram</a> <a target=\"_blank\""+(_vm._ssrAttr("href",_vm.contacts.twitter))+" class=\"footer__social footer__social_whtsp\">Zakazio в Whatsapp</a></div></div>")],2)])}
var staticRenderFns = []


// CONCATENATED MODULE: ./components/TheFooter.vue?vue&type=template&id=15bcc371&

// EXTERNAL MODULE: external "vuex"
var external_vuex_ = __webpack_require__(2);

// EXTERNAL MODULE: ./constants/data.js
var data = __webpack_require__(6);

// CONCATENATED MODULE: ./node_modules/babel-loader/lib??ref--2-0!./node_modules/@nuxt/components/dist/loader.js??ref--0-0!./node_modules/vue-loader/lib??vue-loader-options!./components/TheFooter.vue?vue&type=script&lang=js&
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//


/* harmony default export */ var TheFootervue_type_script_lang_js_ = ({
  name: 'TheFooter',

  data() {
    return {
      TIN_NUMBER: data["f" /* TIN_NUMBER */],
      OGRN_NUMBER: data["d" /* OGRN_NUMBER */],
      COPYRIGHT: data["b" /* COPYRIGHT */]
    };
  },

  computed: { ...Object(external_vuex_["mapGetters"])('contacts', ['contacts'])
  }
});
// CONCATENATED MODULE: ./components/TheFooter.vue?vue&type=script&lang=js&
 /* harmony default export */ var components_TheFootervue_type_script_lang_js_ = (TheFootervue_type_script_lang_js_); 
// EXTERNAL MODULE: ./node_modules/vue-loader/lib/runtime/componentNormalizer.js
var componentNormalizer = __webpack_require__(1);

// CONCATENATED MODULE: ./components/TheFooter.vue





/* normalize component */

var component = Object(componentNormalizer["a" /* default */])(
  components_TheFootervue_type_script_lang_js_,
  render,
  staticRenderFns,
  false,
  null,
  null,
  "817d4ca0"
  
)

/* harmony default export */ var TheFooter = __webpack_exports__["default"] = (component.exports);

/***/ }),
/* 6 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "f", function() { return TIN_NUMBER; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "d", function() { return OGRN_NUMBER; });
/* unused harmony export PHONE_NUMBER */
/* unused harmony export WHATSUP_LINK */
/* unused harmony export INSTAGRAM_LINK */
/* unused harmony export VK_LINK */
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "e", function() { return SLOGAN; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return CONTACTS_LINK; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "c", function() { return HELP_LINK; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "b", function() { return COPYRIGHT; });
const TIN_NUMBER = '640901136680';
const OGRN_NUMBER = '317784700217920';
const PHONE_NUMBER = '8 (965) 765 76 05';
const WHATSUP_LINK = '8 (965) 765 76 05';
const INSTAGRAM_LINK = 'https://instagram.com/';
const VK_LINK = 'https://vk.com/';
const SLOGAN = 'ПАРТНЕРСТВО ЗА % С ДОГОВОРА';
const CONTACTS_LINK = '#';
const HELP_LINK = '#';
const COPYRIGHT = `© ${new Date().getFullYear()} "Zakazy.online" - ИП Брякин Максим Игоревич`;

/***/ }),
/* 7 */
/***/ (function(module, exports) {

module.exports = require("vue-router");

/***/ }),
/* 8 */
/***/ (function(module, exports) {

module.exports = require("axios");

/***/ }),
/* 9 */
/***/ (function(module, exports) {

module.exports = require("vue-no-ssr");

/***/ }),
/* 10 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


/*
  MIT License http://www.opensource.org/licenses/mit-license.php
  Author Tobias Koppers @sokra
*/
// css base code, injected by the css-loader
// eslint-disable-next-line func-names
module.exports = function (useSourceMap) {
  var list = []; // return the list of modules as css string

  list.toString = function toString() {
    return this.map(function (item) {
      var content = cssWithMappingToString(item, useSourceMap);

      if (item[2]) {
        return "@media ".concat(item[2], " {").concat(content, "}");
      }

      return content;
    }).join('');
  }; // import a list of modules into the list
  // eslint-disable-next-line func-names


  list.i = function (modules, mediaQuery, dedupe) {
    if (typeof modules === 'string') {
      // eslint-disable-next-line no-param-reassign
      modules = [[null, modules, '']];
    }

    var alreadyImportedModules = {};

    if (dedupe) {
      for (var i = 0; i < this.length; i++) {
        // eslint-disable-next-line prefer-destructuring
        var id = this[i][0];

        if (id != null) {
          alreadyImportedModules[id] = true;
        }
      }
    }

    for (var _i = 0; _i < modules.length; _i++) {
      var item = [].concat(modules[_i]);

      if (dedupe && alreadyImportedModules[item[0]]) {
        // eslint-disable-next-line no-continue
        continue;
      }

      if (mediaQuery) {
        if (!item[2]) {
          item[2] = mediaQuery;
        } else {
          item[2] = "".concat(mediaQuery, " and ").concat(item[2]);
        }
      }

      list.push(item);
    }
  };

  return list;
};

function cssWithMappingToString(item, useSourceMap) {
  var content = item[1] || ''; // eslint-disable-next-line prefer-destructuring

  var cssMapping = item[3];

  if (!cssMapping) {
    return content;
  }

  if (useSourceMap && typeof btoa === 'function') {
    var sourceMapping = toComment(cssMapping);
    var sourceURLs = cssMapping.sources.map(function (source) {
      return "/*# sourceURL=".concat(cssMapping.sourceRoot || '').concat(source, " */");
    });
    return [content].concat(sourceURLs).concat([sourceMapping]).join('\n');
  }

  return [content].join('\n');
} // Adapted from convert-source-map (MIT)


function toComment(sourceMap) {
  // eslint-disable-next-line no-undef
  var base64 = btoa(unescape(encodeURIComponent(JSON.stringify(sourceMap))));
  var data = "sourceMappingURL=data:application/json;charset=utf-8;base64,".concat(base64);
  return "/*# ".concat(data, " */");
}

/***/ }),
/* 11 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
// ESM COMPAT FLAG
__webpack_require__.r(__webpack_exports__);

// EXPORTS
__webpack_require__.d(__webpack_exports__, "default", function() { return /* binding */ addStylesServer; });

// CONCATENATED MODULE: ./node_modules/vue-style-loader/lib/listToStyles.js
/**
 * Translates the list format produced by css-loader into something
 * easier to manipulate.
 */
function listToStyles (parentId, list) {
  var styles = []
  var newStyles = {}
  for (var i = 0; i < list.length; i++) {
    var item = list[i]
    var id = item[0]
    var css = item[1]
    var media = item[2]
    var sourceMap = item[3]
    var part = {
      id: parentId + ':' + i,
      css: css,
      media: media,
      sourceMap: sourceMap
    }
    if (!newStyles[id]) {
      styles.push(newStyles[id] = { id: id, parts: [part] })
    } else {
      newStyles[id].parts.push(part)
    }
  }
  return styles
}

// CONCATENATED MODULE: ./node_modules/vue-style-loader/lib/addStylesServer.js


function addStylesServer (parentId, list, isProduction, context) {
  if (!context && typeof __VUE_SSR_CONTEXT__ !== 'undefined') {
    context = __VUE_SSR_CONTEXT__
  }
  if (context) {
    if (!context.hasOwnProperty('styles')) {
      Object.defineProperty(context, 'styles', {
        enumerable: true,
        get: function() {
          return renderStyles(context._styles)
        }
      })
      // expose renderStyles for vue-server-renderer (vuejs/#6353)
      context._renderStyles = renderStyles
    }

    var styles = context._styles || (context._styles = {})
    list = listToStyles(parentId, list)
    if (isProduction) {
      addStyleProd(styles, list)
    } else {
      addStyleDev(styles, list)
    }
  }
}

// In production, render as few style tags as possible.
// (mostly because IE9 has a limit on number of style tags)
function addStyleProd (styles, list) {
  for (var i = 0; i < list.length; i++) {
    var parts = list[i].parts
    for (var j = 0; j < parts.length; j++) {
      var part = parts[j]
      // group style tags by media types.
      var id = part.media || 'default'
      var style = styles[id]
      if (style) {
        if (style.ids.indexOf(part.id) < 0) {
          style.ids.push(part.id)
          style.css += '\n' + part.css
        }
      } else {
        styles[id] = {
          ids: [part.id],
          css: part.css,
          media: part.media
        }
      }
    }
  }
}

// In dev we use individual style tag for each module for hot-reload
// and source maps.
function addStyleDev (styles, list) {
  for (var i = 0; i < list.length; i++) {
    var parts = list[i].parts
    for (var j = 0; j < parts.length; j++) {
      var part = parts[j]
      styles[part.id] = {
        ids: [part.id],
        css: part.css,
        media: part.media
      }
    }
  }
}

function renderStyles (styles) {
  var css = ''
  for (var key in styles) {
    var style = styles[key]
    css += '<style data-vue-ssr-id="' + style.ids.join(' ') + '"' +
        (style.media ? ( ' media="' + style.media + '"' ) : '') + '>' +
        style.css + '</style>'
  }
  return css
}


/***/ }),
/* 12 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
// ESM COMPAT FLAG
__webpack_require__.r(__webpack_exports__);

// CONCATENATED MODULE: ./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/@nuxt/components/dist/loader.js??ref--0-0!./node_modules/vue-loader/lib??vue-loader-options!./components/TheMain.vue?vue&type=template&id=01a615f1&
var render = function () {var _vm=this;var _h=_vm.$createElement;var _c=_vm._self._c||_h;return _c('div',{staticClass:"main"},[_vm._t("default")],2)}
var staticRenderFns = []


// CONCATENATED MODULE: ./components/TheMain.vue?vue&type=template&id=01a615f1&

// CONCATENATED MODULE: ./node_modules/babel-loader/lib??ref--2-0!./node_modules/@nuxt/components/dist/loader.js??ref--0-0!./node_modules/vue-loader/lib??vue-loader-options!./components/TheMain.vue?vue&type=script&lang=js&
//
//
//
//
//
//
/* harmony default export */ var TheMainvue_type_script_lang_js_ = ({
  name: 'TheMain'
});
// CONCATENATED MODULE: ./components/TheMain.vue?vue&type=script&lang=js&
 /* harmony default export */ var components_TheMainvue_type_script_lang_js_ = (TheMainvue_type_script_lang_js_); 
// EXTERNAL MODULE: ./node_modules/vue-loader/lib/runtime/componentNormalizer.js
var componentNormalizer = __webpack_require__(1);

// CONCATENATED MODULE: ./components/TheMain.vue





/* normalize component */

var component = Object(componentNormalizer["a" /* default */])(
  components_TheMainvue_type_script_lang_js_,
  render,
  staticRenderFns,
  false,
  null,
  null,
  "1740060e"
  
)

/* harmony default export */ var TheMain = __webpack_exports__["default"] = (component.exports);

/***/ }),
/* 13 */
/***/ (function(module, exports) {

module.exports = require("vue-client-only");

/***/ }),
/* 14 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* unused harmony export pageItemsSize */
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "b", function() { return returnObj; });
const pageItemsSize = 2;
function returnObj(res) {
  return {
    content: res.data.data.content,
    meta: {
      totalPages: res.data.data.totalPages,
      totalElements: res.data.data.totalElements,
      currentPage: res.data.data.number + 1
    }
  };
}
/* harmony default export */ __webpack_exports__["a"] = ({
  data() {
    return {
      orders: [],
      meta: {
        totalPages: 0,
        totalElements: 0,
        currentPage: 1
      }
    };
  },

  methods: {
    changePage(entity, page) {
      this.$router.replace({
        query: {
          page
        }
      }).catch(e => {});
      this.loadData(entity, page, this.$axios);
    },

    async loadData(entity, page) {
      const res = await this.$axios.get(`${entity}/list?page=${Number(page) - 1}`);
      this.content = res.data.data.content;
      this.meta = {
        totalPages: res.data.data.totalPages,
        totalElements: res.data.data.totalElements,
        currentPage: res.data.data.number + 1
      };
    }

  },
  computed: {
    baseUrl() {
      return "https://api.zakazy.online/api/v1";
    },

    storageUrl() {
      return "https://file.zakazy.online";
    }

  }
});

/***/ }),
/* 15 */
/***/ (function(module, exports, __webpack_require__) {

// style-loader: Adds some css to the DOM by adding a <style> tag

// load the styles
var content = __webpack_require__(25);
if(typeof content === 'string') content = [[module.i, content, '']];
if(content.locals) module.exports = content.locals;
// add CSS to SSR context
var add = __webpack_require__(11).default
module.exports.__inject__ = function (context) {
  add("7e56e4e3", content, true, context)
};

/***/ }),
/* 16 */
/***/ (function(module, exports) {

// This file is intentionally left empty for noop aliases

/***/ }),
/* 17 */
/***/ (function(module, exports) {

module.exports = require("querystring");

/***/ }),
/* 18 */
/***/ (function(module, exports) {

module.exports = require("node-fetch");

/***/ }),
/* 19 */
/***/ (function(module, exports) {

module.exports = require("vue-meta");

/***/ }),
/* 20 */
/***/ (function(module) {

module.exports = JSON.parse("{\"title\":\"zakazio-ssr\",\"meta\":[{\"hid\":\"charset\",\"charset\":\"utf-8\"},{\"hid\":\"viewport\",\"name\":\"viewport\",\"content\":\"width=device-width, initial-scale=1\"},{\"hid\":\"mobile-web-app-capable\",\"name\":\"mobile-web-app-capable\",\"content\":\"yes\"},{\"hid\":\"apple-mobile-web-app-title\",\"name\":\"apple-mobile-web-app-title\",\"content\":\"zakazio-ssr\"},{\"hid\":\"og:type\",\"name\":\"og:type\",\"property\":\"og:type\",\"content\":\"website\"},{\"hid\":\"og:title\",\"name\":\"og:title\",\"property\":\"og:title\",\"content\":\"zakazio-ssr\"},{\"hid\":\"og:site_name\",\"name\":\"og:site_name\",\"property\":\"og:site_name\",\"content\":\"zakazio-ssr\"}],\"link\":[{\"hid\":\"shortcut-icon\",\"rel\":\"shortcut icon\",\"href\":\"/_nuxt/icons/icon_64x64.6cd800.png\"},{\"hid\":\"apple-touch-icon\",\"rel\":\"apple-touch-icon\",\"href\":\"/_nuxt/icons/icon_512x512.6cd800.png\",\"sizes\":\"512x512\"},{\"rel\":\"manifest\",\"href\":\"/_nuxt/manifest.5795abaf.json\",\"hid\":\"manifest\"}],\"htmlAttrs\":{\"lang\":\"en\"}}");

/***/ }),
/* 21 */
/***/ (function(module, exports) {

module.exports = require("defu");

/***/ }),
/* 22 */
/***/ (function(module, exports, __webpack_require__) {

__webpack_require__(23);
module.exports = __webpack_require__(44);


/***/ }),
/* 23 */
/***/ (function(module, exports) {

global.installComponents = function (component, components) {
  var options = typeof component.exports === 'function'
    ? component.exports.extendOptions
    : component.options

  if (typeof component.exports === 'function') {
    options.components = component.exports.options.components
  }

  options.components = options.components || {}

  for (var i in components) {
    options.components[i] = options.components[i] || components[i]
  }


  if (options.functional) {
    provideFunctionalComponents(component, options.components)
  }
}

var functionalPatchKey = '_functionalComponents'

function provideFunctionalComponents(component, components) {
  if (component.exports[functionalPatchKey]) {
    return
  }
  component.exports[functionalPatchKey] = true

  var render = component.exports.render
  component.exports.render = function (h, vm) {
    return render(h, Object.assign({}, vm, {
      _c: function (n, a, b) {
        return vm._c(components[n] || n, a, b)
      }
    }))
  }
}


/***/ }),
/* 24 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _node_modules_vue_style_loader_index_js_ref_3_oneOf_1_0_node_modules_css_loader_dist_cjs_js_ref_3_oneOf_1_1_node_modules_vue_loader_lib_loaders_stylePostLoader_js_node_modules_postcss_loader_src_index_js_ref_3_oneOf_1_2_node_modules_nuxt_components_dist_loader_js_ref_0_0_node_modules_vue_loader_lib_index_js_vue_loader_options_nuxt_loading_vue_vue_type_style_index_0_lang_css___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(15);
/* harmony import */ var _node_modules_vue_style_loader_index_js_ref_3_oneOf_1_0_node_modules_css_loader_dist_cjs_js_ref_3_oneOf_1_1_node_modules_vue_loader_lib_loaders_stylePostLoader_js_node_modules_postcss_loader_src_index_js_ref_3_oneOf_1_2_node_modules_nuxt_components_dist_loader_js_ref_0_0_node_modules_vue_loader_lib_index_js_vue_loader_options_nuxt_loading_vue_vue_type_style_index_0_lang_css___WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(_node_modules_vue_style_loader_index_js_ref_3_oneOf_1_0_node_modules_css_loader_dist_cjs_js_ref_3_oneOf_1_1_node_modules_vue_loader_lib_loaders_stylePostLoader_js_node_modules_postcss_loader_src_index_js_ref_3_oneOf_1_2_node_modules_nuxt_components_dist_loader_js_ref_0_0_node_modules_vue_loader_lib_index_js_vue_loader_options_nuxt_loading_vue_vue_type_style_index_0_lang_css___WEBPACK_IMPORTED_MODULE_0__);
/* harmony reexport (unknown) */ for(var __WEBPACK_IMPORT_KEY__ in _node_modules_vue_style_loader_index_js_ref_3_oneOf_1_0_node_modules_css_loader_dist_cjs_js_ref_3_oneOf_1_1_node_modules_vue_loader_lib_loaders_stylePostLoader_js_node_modules_postcss_loader_src_index_js_ref_3_oneOf_1_2_node_modules_nuxt_components_dist_loader_js_ref_0_0_node_modules_vue_loader_lib_index_js_vue_loader_options_nuxt_loading_vue_vue_type_style_index_0_lang_css___WEBPACK_IMPORTED_MODULE_0__) if(["default"].indexOf(__WEBPACK_IMPORT_KEY__) < 0) (function(key) { __webpack_require__.d(__webpack_exports__, key, function() { return _node_modules_vue_style_loader_index_js_ref_3_oneOf_1_0_node_modules_css_loader_dist_cjs_js_ref_3_oneOf_1_1_node_modules_vue_loader_lib_loaders_stylePostLoader_js_node_modules_postcss_loader_src_index_js_ref_3_oneOf_1_2_node_modules_nuxt_components_dist_loader_js_ref_0_0_node_modules_vue_loader_lib_index_js_vue_loader_options_nuxt_loading_vue_vue_type_style_index_0_lang_css___WEBPACK_IMPORTED_MODULE_0__[key]; }) }(__WEBPACK_IMPORT_KEY__));


/***/ }),
/* 25 */
/***/ (function(module, exports, __webpack_require__) {

// Imports
var ___CSS_LOADER_API_IMPORT___ = __webpack_require__(10);
exports = ___CSS_LOADER_API_IMPORT___(false);
// Module
exports.push([module.i, ".nuxt-progress{position:fixed;top:0;left:0;right:0;height:2px;width:0;opacity:1;transition:width .1s,opacity .4s;background-color:#000;z-index:999999}.nuxt-progress.nuxt-progress-notransition{transition:none}.nuxt-progress-failed{background-color:red}", ""]);
// Exports
module.exports = exports;


/***/ }),
/* 26 */
/***/ (function(module, exports, __webpack_require__) {

// style-loader: Adds some css to the DOM by adding a <style> tag

// load the styles
var content = __webpack_require__(27);
if(typeof content === 'string') content = [[module.i, content, '']];
if(content.locals) module.exports = content.locals;
__webpack_require__(11).default("12ba2d00", content, true)

/***/ }),
/* 27 */
/***/ (function(module, exports, __webpack_require__) {

// Imports
var ___CSS_LOADER_API_IMPORT___ = __webpack_require__(10);
var ___CSS_LOADER_GET_URL_IMPORT___ = __webpack_require__(28);
var ___CSS_LOADER_URL_IMPORT_0___ = __webpack_require__(29);
var ___CSS_LOADER_URL_IMPORT_1___ = __webpack_require__(30);
var ___CSS_LOADER_URL_IMPORT_2___ = __webpack_require__(31);
var ___CSS_LOADER_URL_IMPORT_3___ = __webpack_require__(32);
var ___CSS_LOADER_URL_IMPORT_4___ = __webpack_require__(33);
var ___CSS_LOADER_URL_IMPORT_5___ = __webpack_require__(34);
var ___CSS_LOADER_URL_IMPORT_6___ = __webpack_require__(35);
var ___CSS_LOADER_URL_IMPORT_7___ = __webpack_require__(36);
var ___CSS_LOADER_URL_IMPORT_8___ = __webpack_require__(37);
var ___CSS_LOADER_URL_IMPORT_9___ = __webpack_require__(38);
exports = ___CSS_LOADER_API_IMPORT___(false);
var ___CSS_LOADER_URL_REPLACEMENT_0___ = ___CSS_LOADER_GET_URL_IMPORT___(___CSS_LOADER_URL_IMPORT_0___);
var ___CSS_LOADER_URL_REPLACEMENT_1___ = ___CSS_LOADER_GET_URL_IMPORT___(___CSS_LOADER_URL_IMPORT_1___);
var ___CSS_LOADER_URL_REPLACEMENT_2___ = ___CSS_LOADER_GET_URL_IMPORT___(___CSS_LOADER_URL_IMPORT_2___);
var ___CSS_LOADER_URL_REPLACEMENT_3___ = ___CSS_LOADER_GET_URL_IMPORT___(___CSS_LOADER_URL_IMPORT_2___, { hash: "?#iefix" });
var ___CSS_LOADER_URL_REPLACEMENT_4___ = ___CSS_LOADER_GET_URL_IMPORT___(___CSS_LOADER_URL_IMPORT_3___);
var ___CSS_LOADER_URL_REPLACEMENT_5___ = ___CSS_LOADER_GET_URL_IMPORT___(___CSS_LOADER_URL_IMPORT_4___);
var ___CSS_LOADER_URL_REPLACEMENT_6___ = ___CSS_LOADER_GET_URL_IMPORT___(___CSS_LOADER_URL_IMPORT_5___);
var ___CSS_LOADER_URL_REPLACEMENT_7___ = ___CSS_LOADER_GET_URL_IMPORT___(___CSS_LOADER_URL_IMPORT_6___, { hash: "#Ponter\\ Alt" });
var ___CSS_LOADER_URL_REPLACEMENT_8___ = ___CSS_LOADER_GET_URL_IMPORT___(___CSS_LOADER_URL_IMPORT_7___);
var ___CSS_LOADER_URL_REPLACEMENT_9___ = ___CSS_LOADER_GET_URL_IMPORT___(___CSS_LOADER_URL_IMPORT_8___);
var ___CSS_LOADER_URL_REPLACEMENT_10___ = ___CSS_LOADER_GET_URL_IMPORT___(___CSS_LOADER_URL_IMPORT_9___);
// Module
exports.push([module.i, "/*!\n * Bootstrap Reboot v5.0.0-beta1 (https://getbootstrap.com/)\n * Copyright 2011-2020 The Bootstrap Authors\n * Copyright 2011-2020 Twitter, Inc.\n * Licensed under MIT (https://github.com/twbs/bootstrap/blob/main/LICENSE)\n * Forked from Normalize.css, licensed MIT (https://github.com/necolas/normalize.css/blob/master/LICENSE.md)\n */*,:after,:before{box-sizing:border-box}@media(prefers-reduced-motion:no-preference){:root{scroll-behavior:smooth}}body{margin:0;font-family:system-ui,-apple-system,Segoe UI,Roboto,Ubuntu,Cantarell,Noto Sans,sans-serif,\"Segoe UI\",\"Helvetica Neue\",Arial,\"Noto Sans\",\"Liberation Sans\",\"Apple Color Emoji\",\"Segoe UI Emoji\",\"Segoe UI Symbol\",\"Noto Color Emoji\";font-size:1rem;font-weight:400;line-height:1.5;color:#212529;background-color:#fff;-webkit-text-size-adjust:100%;-webkit-tap-highlight-color:rgba(0,0,0,0)}[tabindex=\"-1\"]:focus:not(.focus-visible),[tabindex=\"-1\"]:focus:not(:focus-visible){outline:0!important}hr{margin:1rem 0;color:inherit;background-color:currentColor;border:0;opacity:.25}hr:not([size]){height:1px}h1,h2,h3,h4,h5,h6{margin-top:0;margin-bottom:.5rem;font-weight:500;line-height:1.2}h1{font-size:calc(1.375rem + 1.5vw)}@media(min-width:1200px){h1{font-size:2.5rem}}h2{font-size:calc(1.325rem + .9vw)}@media(min-width:1200px){h2{font-size:2rem}}h3{font-size:calc(1.3rem + .6vw)}@media(min-width:1200px){h3{font-size:1.75rem}}h4{font-size:calc(1.275rem + .3vw)}@media(min-width:1200px){h4{font-size:1.5rem}}h5{font-size:1.25rem}h6{font-size:1rem}p{margin-top:0;margin-bottom:1rem}abbr[data-bs-original-title],abbr[title]{text-decoration:underline;-webkit-text-decoration:underline dotted;text-decoration:underline dotted;cursor:help;-webkit-text-decoration-skip-ink:none;text-decoration-skip-ink:none}address{margin-bottom:1rem;font-style:normal;line-height:inherit}ol,ul{padding-left:2rem}dl,ol,ul{margin-top:0;margin-bottom:1rem}ol ol,ol ul,ul ol,ul ul{margin-bottom:0}dt{font-weight:700}dd{margin-bottom:.5rem;margin-left:0}blockquote{margin:0 0 1rem}b,strong{font-weight:bolder}small{font-size:.875em}mark{padding:.2em;background-color:#fcf8e3}sub,sup{position:relative;font-size:.75em;line-height:0;vertical-align:baseline}sub{bottom:-.25em}sup{top:-.5em}a{color:#0d6efd;text-decoration:underline}a:hover{color:#0a58ca}a:not([href]):not([class]),a:not([href]):not([class]):hover{color:inherit;text-decoration:none}code,kbd,pre,samp{font-family:SFMono-Regular,Menlo,Monaco,Consolas,\"Liberation Mono\",\"Courier New\",monospace;font-size:1em;direction:ltr;unicode-bidi:bidi-override}pre{display:block;margin-top:0;margin-bottom:1rem;overflow:auto;font-size:.875em}pre code{font-size:inherit;color:inherit;word-break:normal}code{font-size:.875em;color:#d63384;word-wrap:break-word}a>code{color:inherit}kbd{padding:.2rem .4rem;font-size:.875em;color:#fff;background-color:#212529;border-radius:.2rem}kbd kbd{padding:0;font-size:1em;font-weight:700}figure{margin:0 0 1rem}img,svg{vertical-align:middle}table{caption-side:bottom;border-collapse:collapse}caption{padding-top:.5rem;padding-bottom:.5rem;color:#6c757d;text-align:left}th{text-align:inherit;text-align:-webkit-match-parent}tbody,td,tfoot,th,thead,tr{border:0 solid;border-color:inherit}label{display:inline-block}button{border-radius:0}button:focus{outline:1px dotted;outline:5px auto -webkit-focus-ring-color}button,input,optgroup,select,textarea{margin:0;font-family:inherit;font-size:inherit;line-height:inherit}button,select{text-transform:none}[role=button]{cursor:pointer}select{word-wrap:normal}[list]::-webkit-calendar-picker-indicator{display:none}[type=button],[type=reset],[type=submit],button{-webkit-appearance:button}[type=button]:not(:disabled),[type=reset]:not(:disabled),[type=submit]:not(:disabled),button:not(:disabled){cursor:pointer}::-moz-focus-inner{padding:0;border-style:none}textarea{resize:vertical}fieldset{min-width:0;padding:0;margin:0;border:0}legend{float:left;width:100%;padding:0;margin-bottom:.5rem;font-size:calc(1.275rem + .3vw);line-height:inherit}@media(min-width:1200px){legend{font-size:1.5rem}}legend+*{clear:left}::-webkit-datetime-edit-day-field,::-webkit-datetime-edit-fields-wrapper,::-webkit-datetime-edit-hour-field,::-webkit-datetime-edit-minute,::-webkit-datetime-edit-month-field,::-webkit-datetime-edit-text,::-webkit-datetime-edit-year-field{padding:0}::-webkit-inner-spin-button{height:auto}[type=search]{outline-offset:-2px;-webkit-appearance:textfield}::-webkit-search-decoration{-webkit-appearance:none}::-webkit-color-swatch-wrapper{padding:0}::file-selector-button{font:inherit}::-webkit-file-upload-button{font:inherit;-webkit-appearance:button}output{display:inline-block}iframe{border:0}summary{display:list-item;cursor:pointer}progress{vertical-align:baseline}[hidden]{display:none!important}.container,.container-fluid,.container-lg,.container-md,.container-sm,.container-xl,.container-xxl{width:100%;padding-right:.75rem;padding-right:var(--bs-gutter-x,.75rem);padding-left:.75rem;padding-left:var(--bs-gutter-x,.75rem);margin-right:auto;margin-left:auto}@media(min-width:576px){.container,.container-sm{max-width:540px}}@media(min-width:768px){.container,.container-md,.container-sm{max-width:720px}}@media(min-width:992px){.container,.container-lg,.container-md,.container-sm{max-width:960px}}@media(min-width:1200px){.container,.container-lg,.container-md,.container-sm,.container-xl{max-width:1140px}}@media(min-width:1400px){.container,.container-lg,.container-md,.container-sm,.container-xl,.container-xxl{max-width:1320px}}@font-face{font-family:\"nfscarbon\";src:url(" + ___CSS_LOADER_URL_REPLACEMENT_0___ + ") format(\"woff2\"),url(" + ___CSS_LOADER_URL_REPLACEMENT_1___ + ") format(\"woff\");font-weight:400;font-style:normal}@font-face{font-family:\"Ponter Alt\";src:url(" + ___CSS_LOADER_URL_REPLACEMENT_2___ + ");src:url(" + ___CSS_LOADER_URL_REPLACEMENT_3___ + ") format(\"embedded-opentype\"),url(" + ___CSS_LOADER_URL_REPLACEMENT_4___ + ") format(\"woff2\"),url(" + ___CSS_LOADER_URL_REPLACEMENT_5___ + ") format(\"woff\"),url(" + ___CSS_LOADER_URL_REPLACEMENT_6___ + ") format(\"truetype\"),url(" + ___CSS_LOADER_URL_REPLACEMENT_7___ + ") format(\"svg\")}*{font-family:Arial,sans,serif}#wrapper{display:flex;flex-direction:column;min-height:100vh;overflow-x:hidden}.content,body.no-overflow{overflow:hidden}.header{min-height:100px;box-shadow:0 1px 36.4px 3.6px rgba(0,0,0,.4);display:flex;align-items:center}.header__logo{color:#000;margin-right:60px;font-size:31px;text-align:center;line-height:60px;text-transform:uppercase;text-decoration:none;display:flex;height:60px;position:relative;font-family:\"Ponter Alt\",sans}.header__logo:hover{color:#000}.header__logo:before{background-image:url(" + ___CSS_LOADER_URL_REPLACEMENT_8___ + ");width:70px;flex-shrink:0;margin-right:10px;height:100%;display:block;content:\"\";background-repeat:no-repeat;background-size:contain}@media(max-width:767.98px){.header__logo{height:30px;line-height:30px;font-size:16px}.header__logo:before{width:35px;margin-right:5px}}.header__text{color:#939393;font-size:16px;text-transform:uppercase}.header__container{display:flex;align-items:center;position:relative}.header__contact{margin-left:auto;margin-right:60px;height:40px;position:relative;padding-left:50px;display:flex;flex-direction:column;justify-content:space-between;flex-shrink:0}.header__contact:before{position:absolute;content:\"\";display:block;height:100%;width:40px;margin-right:10px;background-image:url(\"data:image/svg+xml;charset=utf-8,%3Csvg xmlns='http://www.w3.org/2000/svg' height='512' width='512'%3E%3Cpath d='M497 241h-33.2v-49.267c0-34.907-28.242-63.2-63.2-63.2h-17.133v-81.4C383.467 21.144 362.322 0 336.333 0H111.4C85.578 0 64.267 20.868 64.267 47.133v113.533H47.134C21.274 160.667 0 181.567 0 207.8c0 17.033 9.083 31.983 22.658 40.265a46.836 46.836 0 00-6.592 24.002c0 17.021 9.071 31.962 22.63 40.248-4.277 7.193-6.563 15.428-6.563 24.019 0 18.064 9.898 32.5 22.646 40.285a46.833 46.833 0 00-6.58 23.982c0 14.095 6.228 26.757 16.066 35.401v28.865C64.267 490.856 85.411 512 111.4 512h224.933c12.598 0 24.435-4.906 33.319-13.802 8.908-8.898 13.814-20.735 13.814-33.332v-17.133H400.6c29.683 0 54.65-20.568 61.402-48.2H497c8.284 0 15-6.716 15-15V256c0-8.284-6.716-15-15-15zM158.533 30H289.2v17.133c0 9.337-7.549 17.133-17.134 17.133h-96.399c-9.357 0-17.134-7.567-17.134-17.133zM30 207.8c0-9.338 7.552-17.133 17.134-17.133h17.133v34.267H47.134C37.687 224.933 30 217.247 30 207.8zm16.066 64.267c0-9.448 7.687-17.134 17.134-17.134h48.2c9.447 0 17.133 7.686 17.133 17.134 0 9.447-7.686 17.133-17.133 17.133H63.2c-9.447 0-17.134-7.686-17.134-17.133zm16.068 64.266c0-9.339 7.551-17.133 17.133-17.133H111.4c9.358 0 17.133 7.567 17.133 17.133 0 9.358-7.565 17.133-17.133 17.133H79.267c-9.358.001-17.133-7.566-17.133-17.133zM78.2 400.6c0-9.447 7.686-17.133 17.133-17.133s17.134 7.686 17.134 17.133-7.687 17.133-17.134 17.133S78.2 410.047 78.2 400.6zm275.267 64.267c0 9.337-7.549 17.133-17.134 17.133H111.4c-9.447 0-17.134-7.686-17.134-17.133v-17.16c.356.008.709.027 1.066.027 25.989 0 47.134-21.144 47.134-47.133a46.837 46.837 0 00-6.579-23.98c9.171-5.6 22.646-18.792 22.646-40.287 0-12.055-4.503-23.407-12.684-32.146 7.86-8.424 12.684-19.717 12.684-32.12 0-25.99-21.144-47.134-47.133-47.134H94.267V47.133C94.267 37.799 101.813 30 111.4 30h17.133v17.133c0 25.916 20.954 47.133 47.134 47.133h96.399c25.916 0 47.134-20.952 47.134-47.133V30h17.133c9.447 0 17.134 7.686 17.134 17.133v81.4h-81.4c-8.284 0-15 6.716-15 15 0 52.567 42.767 95.333 95.334 95.333h1.066zM482 369.533h-33.2c-8.284 0-15 6.716-15 15 0 18.307-14.894 33.2-33.2 33.2h-17.133V223.867c0-8.284-6.716-15-15-15H352.4c-30.864 0-56.8-21.515-63.597-50.333H400.6c18.351 0 33.2 14.841 33.2 33.2V256c0 8.284 6.716 15 15 15H482z'/%3E%3Cpath d='M256 417.733h-64.267c-8.284 0-15 6.716-15 15s6.716 15 15 15H256c8.284 0 15-6.716 15-15s-6.716-15-15-15z'/%3E%3C/svg%3E\");background-size:contain;background-repeat:no-repeat;left:0}@media(max-width:767.98px){.header__contact{height:25px;padding-left:30px}.header__contact:before{width:25px}}.header__phone{color:#f1c307;font-family:\"Ponter Alt\",sans;font-size:24px;text-decoration:none}.header__phone:hover{color:#f1c307}.header__city{font-size:8.5px;font-family:\"nfscarbon\",sans}.header__socials{display:flex;align-items:center}.header__social-switch{display:none}.header__social-links{display:flex}.header__social{display:block;height:30px;width:30px;background-size:contain;text-indent:-9999px;text-decoration:none;margin-right:20px}.header__social_vk{background-image:url(\"data:image/svg+xml;charset=utf-8,%3Csvg height='512' viewBox='0 0 24 24' width='512' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath d='M19.915 13.028c-.388-.49-.277-.708 0-1.146.005-.005 3.208-4.431 3.538-5.932l.002-.001c.164-.547 0-.949-.793-.949h-2.624c-.668 0-.976.345-1.141.731 0 0-1.336 3.198-3.226 5.271-.61.599-.892.791-1.225.791-.164 0-.419-.192-.419-.739V5.949c0-.656-.187-.949-.74-.949H9.161c-.419 0-.668.306-.668.591 0 .622.945.765 1.043 2.515v3.797c0 .832-.151.985-.486.985-.892 0-3.057-3.211-4.34-6.886-.259-.713-.512-1.001-1.185-1.001H.9c-.749 0-.9.345-.9.731 0 .682.892 4.073 4.148 8.553C6.318 17.343 9.374 19 12.154 19c1.671 0 1.875-.368 1.875-1.001 0-2.922-.151-3.198.686-3.198.388 0 1.056.192 2.616 1.667C19.114 18.217 19.407 19 20.405 19h2.624c.748 0 1.127-.368.909-1.094-.499-1.527-3.871-4.668-4.023-4.878z' fill='%234b729f'/%3E%3C/svg%3E\")}.header__social_inst{background-image:url(\"data:image/svg+xml;charset=utf-8,%3Csvg height='512pt' viewBox='0 0 512 512' width='512pt' xmlns='http://www.w3.org/2000/svg'%3E%3ClinearGradient id='a' gradientUnits='userSpaceOnUse' x1='42.966' x2='469.034' y1='469.03' y2='42.962'%3E%3Cstop offset='0' stop-color='%23ffd600'/%3E%3Cstop offset='.5' stop-color='%23ff0100'/%3E%3Cstop offset='1' stop-color='%23d800b9'/%3E%3C/linearGradient%3E%3ClinearGradient id='b' gradientUnits='userSpaceOnUse' x1='163.043' x2='348.954' y1='348.954' y2='163.043'%3E%3Cstop offset='0' stop-color='%23ff6400'/%3E%3Cstop offset='.5' stop-color='%23ff0100'/%3E%3Cstop offset='1' stop-color='%23fd0056'/%3E%3C/linearGradient%3E%3ClinearGradient id='c' gradientUnits='userSpaceOnUse' x1='370.929' x2='414.373' y1='141.068' y2='97.624'%3E%3Cstop offset='0' stop-color='%23f30072'/%3E%3Cstop offset='1' stop-color='%23e50097'/%3E%3C/linearGradient%3E%3Cpath d='M510.46 150.453c-1.245-27.25-5.573-45.86-11.901-62.14a125.466 125.466 0 00-29.528-45.344 125.503 125.503 0 00-45.344-29.535c-16.285-6.325-34.89-10.649-62.14-11.887C334.247.297 325.523 0 256 0s-78.246.297-105.547 1.54c-27.25 1.245-45.855 5.573-62.14 11.901A125.466 125.466 0 0042.968 42.97a125.488 125.488 0 00-29.535 45.34c-6.325 16.285-10.649 34.894-11.887 62.14C.297 177.754 0 186.473 0 255.996c0 69.527.297 78.25 1.547 105.55 1.242 27.247 5.57 45.856 11.898 62.142a125.451 125.451 0 0029.528 45.34 125.433 125.433 0 0045.343 29.527c16.282 6.332 34.891 10.656 62.141 11.902 27.305 1.246 36.023 1.54 105.547 1.54 69.523 0 78.246-.294 105.547-1.54 27.25-1.246 45.855-5.57 62.14-11.902a130.879 130.879 0 0074.868-74.868c6.332-16.285 10.656-34.894 11.902-62.14C511.703 334.242 512 325.523 512 256c0-69.527-.297-78.246-1.54-105.547zM464.38 359.45c-1.137 24.961-5.309 38.516-8.813 47.535a84.775 84.775 0 01-48.586 48.586c-9.02 3.504-22.574 7.676-47.535 8.813-26.988 1.234-35.086 1.492-103.445 1.492-68.363 0-76.457-.258-103.45-1.492-24.956-1.137-38.51-5.309-47.534-8.813a79.336 79.336 0 01-29.434-19.152 79.305 79.305 0 01-19.152-29.434c-3.504-9.02-7.676-22.574-8.813-47.535-1.23-26.992-1.492-35.09-1.492-103.445 0-68.36.262-76.453 1.492-103.45 1.14-24.96 5.309-38.515 8.813-47.534a79.367 79.367 0 0119.152-29.438 79.261 79.261 0 0129.438-19.148c9.02-3.508 22.574-7.676 47.535-8.817 26.992-1.23 35.09-1.492 103.445-1.492h-.004c68.356 0 76.453.262 103.45 1.496 24.96 1.137 38.511 5.309 47.534 8.813a79.375 79.375 0 0129.434 19.148 79.261 79.261 0 0119.149 29.438c3.507 9.02 7.68 22.574 8.816 47.535 1.23 26.992 1.492 35.09 1.492 103.445 0 68.36-.258 76.453-1.492 103.45zm0 0' fill='url(%23a)'/%3E%3Cpath d='M255.996 124.54c-72.601 0-131.457 58.858-131.457 131.46s58.856 131.457 131.457 131.457c72.606 0 131.461-58.855 131.461-131.457s-58.855-131.46-131.46-131.46zm0 216.792c-47.125-.004-85.332-38.207-85.328-85.336 0-47.125 38.203-85.332 85.332-85.332 47.129.004 85.332 38.207 85.332 85.332 0 47.129-38.207 85.336-85.336 85.336zm0 0' fill='url(%23b)'/%3E%3Cpath d='M423.371 119.348c0 16.965-13.754 30.718-30.719 30.718-16.968 0-30.722-13.754-30.722-30.718 0-16.97 13.754-30.723 30.722-30.723 16.965 0 30.72 13.754 30.72 30.723zm0 0' fill='url(%23c)'/%3E%3C/svg%3E\")}.header__social_fb{background-image:url(\"data:image/svg+xml;charset=utf-8,%3Csvg xmlns='http://www.w3.org/2000/svg' width='48' height='48'%3E%3Cpath fill='%23039be5' d='M24 5a19 19 0 100 38 19 19 0 100-38z'/%3E%3Cpath fill='%23fff' d='M26.572 29.036h4.917l.772-4.995h-5.69v-2.73c0-2.075.678-3.915 2.619-3.915h3.119v-4.359c-.548-.074-1.707-.236-3.897-.236-4.573 0-7.254 2.415-7.254 7.917v3.323h-4.701v4.995h4.701v13.729c.931.14 1.874.235 2.842.235.875 0 1.729-.08 2.572-.194v-13.77z'/%3E%3C/svg%3E\")}.header__social_twitter{background-image:url(\"data:image/svg+xml;charset=utf-8,%3Csvg xmlns='http://www.w3.org/2000/svg' width='48' height='48'%3E%3Cpath fill='%2303A9F4' d='M42 12.429a14.978 14.978 0 01-4.247 1.162 7.38 7.38 0 003.251-4.058 14.829 14.829 0 01-4.693 1.776A7.377 7.377 0 0030.926 9c-4.08 0-7.387 3.278-7.387 7.32 0 .572.067 1.129.193 1.67a21.05 21.05 0 01-15.224-7.654 7.23 7.23 0 00-1 3.686c0 2.541 1.301 4.778 3.285 6.096a7.52 7.52 0 01-3.349-.914v.086c0 3.551 2.547 6.508 5.923 7.181a7.346 7.346 0 01-1.941.263c-.477 0-.942-.054-1.392-.135.94 2.902 3.667 5.023 6.898 5.086a14.925 14.925 0 01-9.174 3.134 14.61 14.61 0 01-1.761-.104A21.109 21.109 0 0017.321 38c13.585 0 21.017-11.156 21.017-20.834 0-.317-.01-.633-.025-.945A14.532 14.532 0 0042 12.429'/%3E%3C/svg%3E\")}.header__social_whtsp{background-image:url(\"data:image/svg+xml;charset=utf-8,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 418.135 418.135'%3E%3Cg fill='%237ad06d'%3E%3Cpath d='M198.929.242C88.5 5.5 1.356 97.466 1.691 208.02c.102 33.672 8.231 65.454 22.571 93.536L2.245 408.429c-1.191 5.781 4.023 10.843 9.766 9.483l104.723-24.811c26.905 13.402 57.125 21.143 89.108 21.631 112.869 1.724 206.982-87.897 210.5-200.724C420.113 93.065 320.295-5.538 198.929.242zm124.957 321.955c-30.669 30.669-71.446 47.559-114.818 47.559-25.396 0-49.71-5.698-72.269-16.935l-14.584-7.265-64.206 15.212 13.515-65.607-7.185-14.07c-11.711-22.935-17.649-47.736-17.649-73.713 0-43.373 16.89-84.149 47.559-114.819 30.395-30.395 71.837-47.56 114.822-47.56 43.372.001 84.147 16.891 114.816 47.559 30.669 30.669 47.559 71.445 47.56 114.817-.001 42.986-17.166 84.428-47.561 114.822z'/%3E%3Cpath d='M309.712 252.351l-40.169-11.534a14.971 14.971 0 00-14.816 3.903l-9.823 10.008c-4.142 4.22-10.427 5.576-15.909 3.358-19.002-7.69-58.974-43.23-69.182-61.007-2.945-5.128-2.458-11.539 1.158-16.218l8.576-11.095a14.97 14.97 0 001.847-15.21l-16.9-38.223c-4.048-9.155-15.747-11.82-23.39-5.356-11.211 9.482-24.513 23.891-26.13 39.854-2.851 28.144 9.219 63.622 54.862 106.222 52.73 49.215 94.956 55.717 122.449 49.057 15.594-3.777 28.056-18.919 35.921-31.317 5.362-8.453 1.128-19.679-8.494-22.442z'/%3E%3C/g%3E%3C/svg%3E\");margin-right:0}@media(max-width:991.98px){.header__text{display:none}}@media(max-width:767.98px){.header__container{justify-content:space-between}.header__logo{margin-right:0}.header__contact{margin-right:0;margin-left:0}.header__socials{height:20px;width:20px;overflow:hidden;position:relative}.header__socials_expanded{overflow:visible}.header__social-links{display:none}.header__social-links_expanded{background-color:#fff;padding:5px;position:absolute;top:30px;left:-3px;display:flex;flex-direction:column;border-radius:20px}.header__social{width:20px;height:20px;margin-bottom:10px;margin-right:0}.header__social-switch{height:20px;width:20px;display:block;background-image:url(\"data:image/svg+xml;charset=utf-8,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 512 512'%3E%3Cpath d='M406 332c-29.636 0-55.969 14.402-72.378 36.571l-141.27-72.195A89.738 89.738 0 00196 271a89.51 89.51 0 00-6.574-33.753l148.06-88.958C354.006 167.679 378.59 180 406 180c49.626 0 90-40.374 90-90S455.626 0 406 0s-90 40.374-90 90a89.54 89.54 0 006.09 32.54l-148.43 89.18C157.152 192.902 132.941 181 106 181c-49.626 0-90 40.374-90 90s40.374 90 90 90c30.122 0 56.832-14.876 73.177-37.666l140.86 71.985A89.702 89.702 0 00316 422c0 49.626 40.374 90 90 90s90-40.374 90-90-40.374-90-90-90zm0-302c33.084 0 60 26.916 60 60s-26.916 60-60 60-60-26.916-60-60 26.916-60 60-60zM106 331c-33.084 0-60-26.916-60-60s26.916-60 60-60 60 26.916 60 60-26.916 60-60 60zm300 151c-33.084 0-60-26.916-60-60s26.916-60 60-60 60 26.916 60 60-26.916 60-60 60z'/%3E%3C/svg%3E\");border:none;background-color:transparent}.header__social-switch:focus{outline:none}.header__social-switch_expanded{background-image:url(\"data:image/svg+xml;charset=utf-8,%3Csvg xmlns='http://www.w3.org/2000/svg' height='24' width='24'%3E%3Cpath d='M0 0h24v24H0z' fill='none'/%3E%3Cpath d='M19 6.41L17.59 5 12 10.59 6.41 5 5 6.41 10.59 12 5 17.59 6.41 19 12 13.41 17.59 19 19 17.59 13.41 12z'/%3E%3C/svg%3E\")}.header__phone{font-size:11px}.header__city{font-size:4px}}.main{background-image:linear-gradient(0deg,rgba(0,0,0,.5),rgba(0,0,0,.5)),url(" + ___CSS_LOADER_URL_REPLACEMENT_9___ + ");background-size:cover}.wrap{display:flex;flex-direction:column;min-height:100vh}.error-page{flex-grow:1}.footer{background-color:rgba(73,73,73,.8);min-height:130px;padding-top:30px;padding-bottom:30px}.footer,.footer__container{display:flex;align-items:center}.footer__container{flex-wrap:wrap;justify-content:space-between}.footer__logo{color:#fff;font-size:31px;text-align:center;line-height:60px;text-transform:uppercase;text-decoration:none;display:flex;height:60px;position:relative;font-family:\"Ponter Alt\",sans}.footer__logo:hover{color:#fff}.footer__logo:before{background-image:url(" + ___CSS_LOADER_URL_REPLACEMENT_10___ + ");width:70px;flex-shrink:0;margin-right:10px;height:100%;display:block;content:\"\";background-repeat:no-repeat;background-size:contain}@media(max-width:767.98px){.footer__logo{height:30px;line-height:30px;font-size:16px}.footer__logo:before{width:35px;margin-right:5px}}.footer__col{max-width:calc(16.66667% - 24px);margin-left:12px;margin-right:12px}.footer__menu{display:table-caption}.footer__contact{height:40px;position:relative;padding-left:50px;display:flex;flex-direction:column;justify-content:space-between;flex-shrink:0}.footer__contact:before{position:absolute;content:\"\";display:block;height:100%;width:40px;margin-right:10px;background-image:url(\"data:image/svg+xml;charset=utf-8,%3Csvg xmlns='http://www.w3.org/2000/svg' height='512' width='512'%3E%3Cpath d='M497 241h-33.2v-49.267c0-34.907-28.242-63.2-63.2-63.2h-17.133v-81.4C383.467 21.144 362.322 0 336.333 0H111.4C85.578 0 64.267 20.868 64.267 47.133v113.533H47.134C21.274 160.667 0 181.567 0 207.8c0 17.033 9.083 31.983 22.658 40.265a46.836 46.836 0 00-6.592 24.002c0 17.021 9.071 31.962 22.63 40.248-4.277 7.193-6.563 15.428-6.563 24.019 0 18.064 9.898 32.5 22.646 40.285a46.833 46.833 0 00-6.58 23.982c0 14.095 6.228 26.757 16.066 35.401v28.865C64.267 490.856 85.411 512 111.4 512h224.933c12.598 0 24.435-4.906 33.319-13.802 8.908-8.898 13.814-20.735 13.814-33.332v-17.133H400.6c29.683 0 54.65-20.568 61.402-48.2H497c8.284 0 15-6.716 15-15V256c0-8.284-6.716-15-15-15zM158.533 30H289.2v17.133c0 9.337-7.549 17.133-17.134 17.133h-96.399c-9.357 0-17.134-7.567-17.134-17.133zM30 207.8c0-9.338 7.552-17.133 17.134-17.133h17.133v34.267H47.134C37.687 224.933 30 217.247 30 207.8zm16.066 64.267c0-9.448 7.687-17.134 17.134-17.134h48.2c9.447 0 17.133 7.686 17.133 17.134 0 9.447-7.686 17.133-17.133 17.133H63.2c-9.447 0-17.134-7.686-17.134-17.133zm16.068 64.266c0-9.339 7.551-17.133 17.133-17.133H111.4c9.358 0 17.133 7.567 17.133 17.133 0 9.358-7.565 17.133-17.133 17.133H79.267c-9.358.001-17.133-7.566-17.133-17.133zM78.2 400.6c0-9.447 7.686-17.133 17.133-17.133s17.134 7.686 17.134 17.133-7.687 17.133-17.134 17.133S78.2 410.047 78.2 400.6zm275.267 64.267c0 9.337-7.549 17.133-17.134 17.133H111.4c-9.447 0-17.134-7.686-17.134-17.133v-17.16c.356.008.709.027 1.066.027 25.989 0 47.134-21.144 47.134-47.133a46.837 46.837 0 00-6.579-23.98c9.171-5.6 22.646-18.792 22.646-40.287 0-12.055-4.503-23.407-12.684-32.146 7.86-8.424 12.684-19.717 12.684-32.12 0-25.99-21.144-47.134-47.133-47.134H94.267V47.133C94.267 37.799 101.813 30 111.4 30h17.133v17.133c0 25.916 20.954 47.133 47.134 47.133h96.399c25.916 0 47.134-20.952 47.134-47.133V30h17.133c9.447 0 17.134 7.686 17.134 17.133v81.4h-81.4c-8.284 0-15 6.716-15 15 0 52.567 42.767 95.333 95.334 95.333h1.066zM482 369.533h-33.2c-8.284 0-15 6.716-15 15 0 18.307-14.894 33.2-33.2 33.2h-17.133V223.867c0-8.284-6.716-15-15-15H352.4c-30.864 0-56.8-21.515-63.597-50.333H400.6c18.351 0 33.2 14.841 33.2 33.2V256c0 8.284 6.716 15 15 15H482z'/%3E%3Cpath d='M256 417.733h-64.267c-8.284 0-15 6.716-15 15s6.716 15 15 15H256c8.284 0 15-6.716 15-15s-6.716-15-15-15z'/%3E%3C/svg%3E\");background-size:contain;background-repeat:no-repeat;left:0}@media(max-width:767.98px){.footer__contact{height:25px;padding-left:30px}.footer__contact:before{width:25px}}.footer__contact:before{background-image:url(\"data:image/svg+xml;charset=utf-8,%3Csvg fill='%23fff' height='512' width='512' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath d='M497 241h-33.2v-49.267c0-34.907-28.242-63.2-63.2-63.2h-17.133v-81.4C383.467 21.144 362.322 0 336.333 0H111.4C85.578 0 64.267 20.868 64.267 47.133v113.533H47.134C21.274 160.667 0 181.567 0 207.8c0 17.033 9.083 31.983 22.658 40.265a46.836 46.836 0 00-6.592 24.002c0 17.021 9.071 31.962 22.63 40.248-4.277 7.193-6.563 15.428-6.563 24.019 0 18.064 9.898 32.5 22.646 40.285a46.833 46.833 0 00-6.58 23.982c0 14.095 6.228 26.757 16.066 35.401v28.865C64.267 490.856 85.411 512 111.4 512h224.933c12.598 0 24.435-4.906 33.319-13.802 8.908-8.898 13.814-20.735 13.814-33.332v-17.133H400.6c29.683 0 54.65-20.568 61.402-48.2H497c8.284 0 15-6.716 15-15V256c0-8.284-6.716-15-15-15zM158.533 30H289.2v17.133c0 9.337-7.549 17.133-17.134 17.133h-96.399c-9.357 0-17.134-7.567-17.134-17.133zM30 207.8c0-9.338 7.552-17.133 17.134-17.133h17.133v34.267H47.134C37.687 224.933 30 217.247 30 207.8zm16.066 64.267c0-9.448 7.687-17.134 17.134-17.134h48.2c9.447 0 17.133 7.686 17.133 17.134 0 9.447-7.686 17.133-17.133 17.133H63.2c-9.447 0-17.134-7.686-17.134-17.133zm16.068 64.266c0-9.339 7.551-17.133 17.133-17.133H111.4c9.358 0 17.133 7.567 17.133 17.133 0 9.358-7.565 17.133-17.133 17.133H79.267c-9.358.001-17.133-7.566-17.133-17.133zM78.2 400.6c0-9.447 7.686-17.133 17.133-17.133s17.134 7.686 17.134 17.133-7.687 17.133-17.134 17.133S78.2 410.047 78.2 400.6zm275.267 64.267c0 9.337-7.549 17.133-17.134 17.133H111.4c-9.447 0-17.134-7.686-17.134-17.133v-17.16c.356.008.709.027 1.066.027 25.989 0 47.134-21.144 47.134-47.133a46.837 46.837 0 00-6.579-23.98c9.171-5.6 22.646-18.792 22.646-40.287 0-12.055-4.503-23.407-12.684-32.146 7.86-8.424 12.684-19.717 12.684-32.12 0-25.99-21.144-47.134-47.133-47.134H94.267V47.133C94.267 37.799 101.813 30 111.4 30h17.133v17.133c0 25.916 20.954 47.133 47.134 47.133h96.399c25.916 0 47.134-20.952 47.134-47.133V30h17.133c9.447 0 17.134 7.686 17.134 17.133v81.4h-81.4c-8.284 0-15 6.716-15 15 0 52.567 42.767 95.333 95.334 95.333h1.066zM482 369.533h-33.2c-8.284 0-15 6.716-15 15 0 18.307-14.894 33.2-33.2 33.2h-17.133V223.867c0-8.284-6.716-15-15-15H352.4c-30.864 0-56.8-21.515-63.597-50.333H400.6c18.351 0 33.2 14.841 33.2 33.2V256c0 8.284 6.716 15 15 15H482z'/%3E%3Cpath d='M256 417.733h-64.267c-8.284 0-15 6.716-15 15s6.716 15 15 15H256c8.284 0 15-6.716 15-15s-6.716-15-15-15z'/%3E%3C/svg%3E\")}.footer__phone{font-family:\"Ponter Alt\",sans;display:block;color:#f1c307;font-size:24px;line-height:22px;text-decoration:none}.footer__phone:hover{color:#ffcd00}.footer__city{font-family:\"nfscarbon\",sans;display:block;font-size:8.5px;color:#949494}.footer__name{font-size:10px;color:#ffcd00;margin-bottom:2px}.footer__numbers{font-size:14px;color:#fff;margin-bottom:0}.footer__links{max-width:280px;margin-bottom:20px}.footer__menu-item{font-family:\"Ponter Alt\",sans;font-size:11px;text-decoration:none;color:#fff;margin-right:35px;padding-left:25px;background-size:contain;background-repeat:no-repeat}.footer__menu-item:hover{color:#fff}.footer__menu-item:last-child{margin-right:0}.footer__menu-item_executors{background-image:url(\"data:image/svg+xml;charset=utf-8,%3Csvg fill='%23ffcd00' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 512 512'%3E%3Cpath d='M356 429c-5.52 0-10 4.48-10 10s4.48 10 10 10 10-4.48 10-10-4.48-10-10-10zM156 429c-5.52 0-10 4.48-10 10s4.48 10 10 10 10-4.48 10-10-4.48-10-10-10z'/%3E%3Cpath d='M447.645 377.21c-11.257-17.424-26.726-31.269-44.847-40.21a9.947 9.947 0 00-5.678-2.613C384.013 328.823 370.197 326 356 326h-30v-26.383A114.708 114.708 0 00361.894 243H366c22.056 0 40-17.944 40-40 0-10.452-4.034-19.976-10.622-27.11a30.8 30.8 0 001.833-1.679C402.879 168.543 406 161.01 406 153c0-13.163-8.526-24.366-20.343-28.396-3.533-45.984-35.806-85.28-80.241-97.596C302.783 13.256 291.434 0 276 0h-40c-15.434 0-26.783 13.256-29.416 27.008-44.431 12.315-76.701 51.604-80.24 97.582a29.893 29.893 0 00-11.555 7.199C109.121 137.457 106 144.99 106 153c0 9.163 4.134 17.375 10.63 22.882C110.038 183.016 106 192.544 106 203c0 22.056 17.944 40 40 40h4.078c5.052 18.357 14.631 35.21 27.994 49.131a112.945 112.945 0 007.928 7.478V326h-30c-14.198 0-28.014 2.823-41.12 8.386a9.95 9.95 0 00-5.677 2.613c-18.123 8.942-33.591 22.787-44.848 40.21C52.347 395.796 46 417.163 46 439v63c0 5.522 4.477 10 10 10h400c5.523 0 10-4.478 10-10v-63c0-21.837-6.347-43.204-18.355-61.79zM106 492H66v-53c0-30.417 15.582-59.571 40-76.878V492zm260-269h-.456c.298-3.327.456-6.666.456-10v-30c11.028 0 20 8.972 20 20s-8.972 20-20 20zM206 48.139V93c0 5.523 4.477 10 10 10s10-4.477 10-10V35.063 33c0-6.196 5.234-13 10-13h40c4.766 0 10 6.804 10 13v60c0 5.523 4.477 10 10 10s10-4.477 10-10V48.139c32.29 11.427 55.6 40.647 59.441 74.861H146.559C150.4 88.786 173.71 59.566 206 48.139zM146 223c-11.028 0-20-8.972-20-20s8.972-20 20-20v30c0 3.334.158 6.674.456 10H146zm0-60h-10c-5.514 0-10-4.486-10-10a9.93 9.93 0 012.931-7.068A9.933 9.933 0 01136 143h240c5.514 0 10 4.486 10 10a9.93 9.93 0 01-2.931 7.068A9.93 9.93 0 01376 163H146zm21.817 68.183c-.02-.109-.039-.217-.063-.324A92.231 92.231 0 01166 213v-30h180v30c0 5.978-.593 11.981-1.754 17.855-.024.108-.043.217-.063.326a94.729 94.729 0 01-34.847 56.241C293.69 299.576 275.247 306 256 306s-37.69-6.424-53.351-18.589a92.671 92.671 0 01-10.145-9.126c-12.615-13.142-21.147-29.423-24.687-47.102zM246 492h-80v-23c0-5.523-4.477-10-10-10s-10 4.477-10 10v23h-20V351.474a84.642 84.642 0 0120-4.882V409c0 5.523 4.477 10 10 10s10-4.477 10-10v-63h25.715L246 403v89zm-40-160v-18.626C221.431 321.669 238.427 326 256 326c17.574 0 34.571-4.332 50-12.625V332l-50 52.5-50-52.5zm180 160h-20v-23c0-5.523-4.477-10-10-10s-10 4.477-10 10v23h-80v-89l54.285-57H346v63c0 5.523 4.477 10 10 10s10-4.477 10-10v-62.408a84.656 84.656 0 0120 4.883V492zm60 0h-40V362.121c24.418 17.307 40 46.461 40 76.879v53z'/%3E%3C/svg%3E\")}.footer__menu-item_orders{background-image:url(\"data:image/svg+xml;charset=utf-8,%3Csvg fill='%23ffcd00' height='511pt' viewBox='0 -1 511.999 511' width='511pt' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath d='M282.672 289.469l139.285 139.285c1.465 1.465 3.387 2.195 5.305 2.195s3.84-.73 5.3-2.195a7.497 7.497 0 000-10.606L293.278 278.863a7.497 7.497 0 00-10.605 0 7.497 7.497 0 000 10.606zm0 0M163.46 159.652a7.497 7.497 0 000 10.606l37.622 37.62a7.473 7.473 0 005.305 2.196 7.47 7.47 0 005.3-2.195 7.497 7.497 0 000-10.606l-37.62-37.62a7.497 7.497 0 00-10.606 0zm0 0'/%3E%3Cpath d='M252.176 290.395l120.797-133.688 8.988 8.07a13.553 13.553 0 009.07 3.465c3.715 0 7.418-1.508 10.094-4.469l2.375-2.628 8.453 7.636-3.355 3.711a20.307 20.307 0 00-5.25 14.746 20.322 20.322 0 006.71 14.137l20.364 18.398a20.29 20.29 0 0014.742 5.25c5.457-.273 10.477-2.66 14.14-6.71l45.192-50.02c7.559-8.367 6.902-21.32-1.46-28.883l-20.364-18.398c-4.05-3.66-9.285-5.52-14.742-5.25a20.32 20.32 0 00-13.578 6.113l-8.461-7.645 3.05-3.382c5.024-5.555 4.59-14.164-.964-19.192l-67.68-61.234v-.004c-18.371-16.598-42.332-27.04-67.469-29.406-25.058-2.36-48.613 3.48-66.328 16.43a13.567 13.567 0 00-5.2 14.167 13.56 13.56 0 0011.087 10.239c51.265 8.148 65.187 24.664 68.793 31.386 3.644 6.797 3.41 14.496-.72 23.532-1.858 4.074-1.589 8.648.528 12.363L199.891 243.156c-6.211-3.562-14.293-2.457-19.286 3.063l-8.984 9.945c-5.02 5.555-5.273 13.773-1.023 19.598l-31.286 22.129c-.046.035-.093.066-.14.101a238.686 238.686 0 00-34.824 31.617l-89.676 99.246c-17.805 19.704-16.258 50.22 3.445 68.024 8.926 8.066 20.29 12.43 32.23 12.43.829 0 1.66-.02 2.497-.063 12.847-.648 24.672-6.266 33.297-15.812l89.68-99.247a238.713 238.713 0 0027.933-37.843l.086-.145 18.851-33.363a15.402 15.402 0 007.84 2.125 15.458 15.458 0 0011.559-5.125l8.984-9.945a15.444 15.444 0 003.992-11.215 15.439 15.439 0 00-2.89-8.281zm-10.895-10.317l-30.023-27.129 120.43-133.285 30.117 27.027zm227.406-149.332a5.424 5.424 0 013.93 1.399l20.36 18.394a5.452 5.452 0 01.39 7.695l-45.191 50.02a5.43 5.43 0 01-3.77 1.789 5.42 5.42 0 01-3.926-1.398l-20.363-18.399a5.452 5.452 0 01-.39-7.695l45.195-50.016a5.406 5.406 0 013.766-1.789zm-24.402 2.25l-22.273 24.656-8.453-7.636 22.277-24.657zM258.172 27.602c31.203-20.348 80.648-14.438 112.062 13.941l66.637 60.293-45.934 50.84-56.41-50.617c5.703-13.043 5.664-25.121-.129-35.918-12.87-23.996-51.863-34.332-76.226-38.54zm-67.348 321.14a223.776 223.776 0 01-26.137 35.387l-89.675 99.246c-5.938 6.574-14.082 10.441-22.93 10.89-8.848.45-17.336-2.577-23.91-8.515-6.57-5.938-10.438-14.082-10.883-22.926-.45-8.847 2.574-17.34 8.512-23.91l89.68-99.25a223.973 223.973 0 0132.562-29.574l33.691-23.828 29.387 26.554zm49.117-48.91l-8.984 9.945a.515.515 0 01-.383.18c-.23-.012-.355-.102-.394-.14l-47.387-42.813a.555.555 0 01-.04-.781l8.985-9.946a.555.555 0 01.782-.039l47.382 42.817a.512.512 0 01.184.379.51.51 0 01-.145.398zm0 0'/%3E%3Cpath d='M33.71 164.402c19.497 15.774 45.79 22.317 72.134 17.957 10.785-1.789 21.965 1.887 29.902 9.825l35.129 35.125a7.464 7.464 0 005.3 2.195 7.502 7.502 0 005.305-12.805l-35.125-35.125c-11.355-11.351-27.414-16.59-42.96-14.015-22.122 3.664-44.082-1.739-60.25-14.82-18.446-14.923-28.801-37.626-28.114-61.266l45.23 36.593c12.626 10.215 31.204 8.254 41.41-4.37L122.45 98.02c4.946-6.118 7.215-13.79 6.39-21.61-.823-7.824-4.648-14.855-10.76-19.8L72.843 20.011c24.05-5.887 49.258.199 68.027 16.586 16.504 14.41 25.445 36.379 24.527 60.273-.543 14.215 4.762 27.984 14.555 37.781l45.86 45.86a7.504 7.504 0 0010.605 0 7.502 7.502 0 000-10.61l-45.86-45.855c-6.847-6.852-10.554-16.547-10.167-26.602 1.09-28.445-9.72-54.742-29.657-72.148C127.266 4.809 95.387-2.234 65.461 6.465a13.24 13.24 0 00-9.313 10.14 13.272 13.272 0 004.672 12.977l47.82 38.688a14.35 14.35 0 015.282 9.714 14.335 14.335 0 01-3.137 10.602l-20.773 25.68c-5.012 6.187-14.121 7.152-20.313 2.14L21.883 77.72a13.294 13.294 0 00-13.68-1.864 13.232 13.232 0 00-7.96 11.207c-2.169 29.72 10.343 58.63 33.468 77.34zm0 0M499.29 432.773l-181.282-181.28a7.502 7.502 0 00-10.605 10.61l181.28 181.276c11.098 11.101 11.098 29.164 0 40.262-11.101 11.097-29.16 11.105-40.253.004L277.53 312.75a7.502 7.502 0 00-10.61 0 7.504 7.504 0 000 10.605l170.9 170.899c8.472 8.473 19.6 12.707 30.73 12.707 11.129 0 22.265-4.238 30.738-12.715 16.945-16.945 16.945-44.523 0-61.473zm0 0'/%3E%3C/svg%3E\")}.footer__menu-item_blog{background-image:url(\"data:image/svg+xml;charset=utf-8,%3Csvg xmlns='http://www.w3.org/2000/svg' width='512' height='512' viewBox='0 0 511 512'%3E%3Cpath xmlns='http://www.w3.org/2000/svg' d='M444.465 4.395c-5.856-5.86-15.356-5.86-21.211 0L307.648 120H45.5c-24.812 0-45 20.188-45 45v209.996c0 24.816 20.188 45 45 45h16v77a15 15 0 0025.723 10.492l85.586-87.492H347.5c24.813 0 45-20.184 45-45V204.852L508.105 89.246c5.856-5.86 5.856-15.355 0-21.215zM306.578 248.344l-42.426-42.426L391.434 78.641l42.425 42.425zm-58.406-15.98l31.96 31.96-54.78 22.82zM362.5 374.995c0 8.274-6.73 15-15 15h-181a15.006 15.006 0 00-10.723 4.512L91.5 460.215v-55.219c0-8.281-6.715-15-15-15h-31c-8.27 0-15-6.726-15-15V165c0-8.273 6.73-15 15-15h232.145l-45.313 45.312a15.329 15.329 0 00-3.312 5.012L187.5 300h-81c-8.285 0-15 6.715-15 15 0 8.281 6.715 14.988 15 14.988h91.004c1.93 0 4-.394 5.894-1.207l108.774-45.304c1.812-.707 3.64-1.938 5.015-3.313l45.313-45.312zm92.57-275.144l-42.425-42.426 21.214-21.211 42.426 42.426zm0 0' fill='%23ffcd00' data-original='%23000000'/%3E%3C/svg%3E\")}.footer__links a{color:#fff;text-transform:uppercase;font-size:11px}.footer__links a,.footer__links a:hover{text-decoration:none}.footer__timetable{display:flex;flex-direction:column}.footer__email,.footer__timetable{margin-top:10px;color:#fff}.footer__socials{display:flex;align-items:center}.footer__social{display:block;height:30px;width:30px;background-size:contain;text-indent:-9999px;text-decoration:none;margin-right:20px}.footer__social_fb{background-image:url(\"data:image/svg+xml;charset=utf-8,%3Csvg xmlns='http://www.w3.org/2000/svg' width='50' height='50'%3E%3Cpath d='M25 3C12.852 3 3 12.852 3 25c0 11.031 8.125 20.137 18.71 21.727V30.832h-5.44v-5.785h5.44v-3.848c0-6.37 3.106-9.168 8.4-9.168 2.538 0 3.878.188 4.511.274v5.05h-3.61c-2.25 0-3.034 2.13-3.034 4.532v3.16h6.59l-.895 5.785h-5.695v15.941C38.715 45.316 47 36.137 47 25c0-12.148-9.852-22-22-22zm0 0' fill='%23ffcd00'/%3E%3C/svg%3E\")}.footer__social_vk{background-image:url(\"data:image/svg+xml;charset=utf-8,%3Csvg fill='%23f0bf03' height='512' viewBox='0 0 24 24' width='512' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath d='M19.915 13.028c-.388-.49-.277-.708 0-1.146.005-.005 3.208-4.431 3.538-5.932l.002-.001c.164-.547 0-.949-.793-.949h-2.624c-.668 0-.976.345-1.141.731 0 0-1.336 3.198-3.226 5.271-.61.599-.892.791-1.225.791-.164 0-.419-.192-.419-.739V5.949c0-.656-.187-.949-.74-.949H9.161c-.419 0-.668.306-.668.591 0 .622.945.765 1.043 2.515v3.797c0 .832-.151.985-.486.985-.892 0-3.057-3.211-4.34-6.886-.259-.713-.512-1.001-1.185-1.001H.9c-.749 0-.9.345-.9.731 0 .682.892 4.073 4.148 8.553C6.318 17.343 9.374 19 12.154 19c1.671 0 1.875-.368 1.875-1.001 0-2.922-.151-3.198.686-3.198.388 0 1.056.192 2.616 1.667C19.114 18.217 19.407 19 20.405 19h2.624c.748 0 1.127-.368.909-1.094-.499-1.527-3.871-4.668-4.023-4.878z'/%3E%3C/svg%3E\")}.footer__social_inst{background-image:url(\"data:image/svg+xml;charset=utf-8,%3Csvg fill='%23f0bf03' xmlns='http://www.w3.org/2000/svg' width='169.063' height='169.063'%3E%3Cpath d='M122.406 0H46.654C20.929 0 0 20.93 0 46.655v75.752c0 25.726 20.929 46.655 46.654 46.655h75.752c25.727 0 46.656-20.93 46.656-46.655V46.655C169.063 20.93 148.133 0 122.406 0zm31.657 122.407c0 17.455-14.201 31.655-31.656 31.655H46.654C29.2 154.063 15 139.862 15 122.407V46.655C15 29.201 29.2 15 46.654 15h75.752c17.455 0 31.656 14.201 31.656 31.655v75.752z'/%3E%3Cpath d='M84.531 40.97c-24.021 0-43.563 19.542-43.563 43.563 0 24.02 19.542 43.561 43.563 43.561s43.563-19.541 43.563-43.561c0-24.021-19.542-43.563-43.563-43.563zm0 72.123c-15.749 0-28.563-12.812-28.563-28.561 0-15.75 12.813-28.563 28.563-28.563s28.563 12.813 28.563 28.563c0 15.749-12.814 28.561-28.563 28.561zM129.921 28.251c-2.89 0-5.729 1.17-7.77 3.22a11.053 11.053 0 00-3.23 7.78c0 2.891 1.18 5.73 3.23 7.78 2.04 2.04 4.88 3.22 7.77 3.22 2.9 0 5.73-1.18 7.78-3.22 2.05-2.05 3.22-4.89 3.22-7.78 0-2.9-1.17-5.74-3.22-7.78-2.04-2.05-4.88-3.22-7.78-3.22z'/%3E%3C/svg%3E\")}.footer__social_twitter{background-image:url(\"data:image/svg+xml;charset=utf-8,%3Csvg xmlns='http://www.w3.org/2000/svg' width='48' height='48'%3E%3Cpath d='M42 12.43a14.946 14.946 0 01-4.246 1.16 7.39 7.39 0 003.25-4.059 14.805 14.805 0 01-4.691 1.778A7.376 7.376 0 0030.925 9c-4.078 0-7.387 3.277-7.387 7.32 0 .57.066 1.13.191 1.668a21.027 21.027 0 01-15.222-7.652 7.3 7.3 0 002.285 9.781 7.496 7.496 0 01-3.348-.914v.086c0 3.55 2.547 6.508 5.922 7.184a7.393 7.393 0 01-1.941.261c-.477 0-.942-.054-1.39-.136.937 2.902 3.663 5.023 6.898 5.086a14.936 14.936 0 01-10.938 3.03A21.125 21.125 0 0017.32 38c13.586 0 21.02-11.156 21.02-20.836 0-.316-.012-.633-.028-.941A14.614 14.614 0 0042 12.43' fill='%23f1c307'/%3E%3C/svg%3E\")}.footer__social_whtsp{background-image:url(\"data:image/svg+xml;charset=utf-8,%3Csvg fill='%23f0bf03' height='512' viewBox='0 0 24 24' width='512' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath d='M17.507 14.307l-.009.075c-2.199-1.096-2.429-1.242-2.713-.816-.197.295-.771.964-.944 1.162-.175.195-.349.21-.646.075-.3-.15-1.263-.465-2.403-1.485-.888-.795-1.484-1.77-1.66-2.07-.293-.506.32-.578.878-1.634.1-.21.049-.375-.025-.524-.075-.15-.672-1.62-.922-2.206-.24-.584-.487-.51-.672-.51-.576-.05-.997-.042-1.368.344-1.614 1.774-1.207 3.604.174 5.55 2.714 3.552 4.16 4.206 6.804 5.114.714.227 1.365.195 1.88.121.574-.091 1.767-.721 2.016-1.426.255-.705.255-1.29.18-1.425-.074-.135-.27-.21-.57-.345z'/%3E%3Cpath d='M20.52 3.449C12.831-3.984.106 1.407.101 11.893c0 2.096.549 4.14 1.595 5.945L0 24l6.335-1.652c7.905 4.27 17.661-1.4 17.665-10.449 0-3.176-1.24-6.165-3.495-8.411zm1.482 8.417c-.006 7.633-8.385 12.4-15.012 8.504l-.36-.214-3.75.975 1.005-3.645-.239-.375c-4.124-6.565.614-15.145 8.426-15.145a9.865 9.865 0 017.021 2.91 9.788 9.788 0 012.909 6.99z'/%3E%3C/svg%3E\");margin-right:0}@media(max-width:1399.98px){.footer__col{min-width:calc(33.33333% - 24px);margin-bottom:24px}}@media(max-width:767.98px){.footer__phone{font-size:12px}.footer__city{font-size:4px}.footer__col{min-width:100%;margin-bottom:24px;margin-left:0;margin-right:0}}.cover{flex-grow:1;flex-shrink:0;display:flex;min-height:calc(100vh - 100px)}[dir=ltr] .cover__title{text-align:left}[dir=rtl] .cover__title{text-align:right}.cover__title{font-family:\"Ponter Alt\",sans;text-transform:uppercase;font-size:3.5vw;color:#ffcd00;margin-bottom:.2vw}.cover__qube{flex-grow:0;flex-shrink:1;display:flex;flex-direction:column;justify-content:center;align-items:center;padding:30px;width:calc(100% - 640px)}.cover__blocks{display:flex;margin-bottom:.5vw;flex-wrap:wrap;justify-content:start}.cover__block{color:#fff;font-family:\"Ponter Alt\",sans;font-size:2.5vw;margin-left:1.5vw;margin-right:1.5vw}.cover__block:last-child,.cover__side{margin-right:0}.cover__side{width:640px;background-color:rgba(255,205,0,.8);flex-grow:0;margin-left:auto;display:flex;flex-direction:column;align-items:center;justify-content:space-around}.cover__side-name{font-family:\"Ponter Alt\",sans;font-size:48px}.cover__side-name span{font-family:\"Ponter Alt\",sans;color:#fff}.cover__slogan{color:#fff;text-transform:uppercase;font-size:31px}.cover__nums{display:flex;margin-bottom:5.1vw;flex-wrap:wrap;justify-content:center}.cover__num{flex-direction:column;margin:2.5vw}.cover__num,.cover__num-num{display:flex;justify-content:center;align-items:center}.cover__num-num{background-color:#ffcd00;height:5.5vw;width:5.5vw;border-radius:50%;font-size:3vw;font-family:\"Ponter Alt\",sans;margin-bottom:.6vw}.cover__num-num sup{font-size:1.5vw;font-family:\"Ponter Alt\",sans}.cover__num-num:last-child{margin-right:0}.cover__num-text{font-size:.8vw;color:#fff;font-family:\"Ponter Alt\",sans}.cover__register-btns{width:100%;max-width:400px;flex-grow:0}.cover__register-btn{display:block;height:70px;background-color:#000;border-radius:35px;margin-bottom:20px;color:#fff;font-size:16px;text-transform:uppercase;font-weight:700;text-decoration:none;line-height:70px;padding-left:90px;position:relative;text-align:left;border:none;width:100%}.cover__register-btn:before{display:block;height:30px;width:30px;content:\"\";position:absolute;top:0;bottom:0;margin:auto;left:35px;background-size:contain}.cover__register-btn_client:before{background-image:url(\"data:image/svg+xml;charset=utf-8,%3Csvg fill='%23fff' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 482.9 482.9'%3E%3Cpath d='M239.7 260.2h3.2c29.3-.5 53-10.8 70.5-30.5 38.5-43.4 32.1-117.8 31.4-124.9-2.5-53.3-27.7-78.8-48.5-90.7C280.8 5.2 262.7.4 242.5 0H240.8c-11.1 0-32.9 1.8-53.8 13.7-21 11.9-46.6 37.4-49.1 91.1-.7 7.1-7.1 81.5 31.4 124.9 17.4 19.7 41.1 30 70.4 30.5zm-75.1-152.9c0-.3.1-.6.1-.8 3.3-71.7 54.2-79.4 76-79.4H241.9c27 .6 72.9 11.6 76 79.4 0 .3 0 .6.1.8.1.7 7.1 68.7-24.7 104.5-12.6 14.2-29.4 21.2-51.5 21.4h-1c-22-.2-38.9-7.2-51.4-21.4-31.7-35.6-24.9-103.9-24.8-104.5z'/%3E%3Cpath d='M446.8 383.6v-.3c0-.8-.1-1.6-.1-2.5-.6-19.8-1.9-66.1-45.3-80.9-.3-.1-.7-.2-1-.3-45.1-11.5-82.6-37.5-83-37.8-6.1-4.3-14.5-2.8-18.8 3.3-4.3 6.1-2.8 14.5 3.3 18.8 1.7 1.2 41.5 28.9 91.3 41.7 23.3 8.3 25.9 33.2 26.6 56 0 .9 0 1.7.1 2.5.1 9-.5 22.9-2.1 30.9-16.2 9.2-79.7 41-176.3 41-96.2 0-160.1-31.9-176.4-41.1-1.6-8-2.3-21.9-2.1-30.9 0-.8.1-1.6.1-2.5.7-22.8 3.3-47.7 26.6-56 49.8-12.8 89.6-40.6 91.3-41.7 6.1-4.3 7.6-12.7 3.3-18.8-4.3-6.1-12.7-7.6-18.8-3.3-.4.3-37.7 26.3-83 37.8-.4.1-.7.2-1 .3-43.4 14.9-44.7 61.2-45.3 80.9 0 .9 0 1.7-.1 2.5v.3c-.1 5.2-.2 31.9 5.1 45.3 1 2.6 2.8 4.8 5.2 6.3 3 2 74.9 47.8 195.2 47.8s192.2-45.9 195.2-47.8c2.3-1.5 4.2-3.7 5.2-6.3 5-13.3 4.9-40 4.8-45.2z'/%3E%3C/svg%3E\")}.cover__register-btn_partner:before{background-image:url(\"data:image/svg+xml;charset=utf-8,%3Csvg fill='%23fff' height='512' viewBox='0 0 512.016 512.016' width='512' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath d='M508.803 192.482l-13.337-23.101c-2.761-4.782-8.873-6.421-13.66-3.66-4.783 2.761-6.422 8.877-3.66 13.66l13.337 23.101c.704 1.218.547 2.378.391 2.961s-.601 1.667-1.819 2.37l-35.268 20.362a3.91 3.91 0 01-5.332-1.429l-70.95-122.886a3.91 3.91 0 011.429-5.333l35.267-20.361a3.91 3.91 0 015.333 1.428l12.612 21.845c2.762 4.784 8.878 6.423 13.66 3.66 4.783-2.761 6.422-8.877 3.66-13.66l-12.612-21.845c-6.589-11.413-21.235-15.34-32.652-8.749l-35.268 20.362a23.816 23.816 0 00-10.81 13.439h-99.98c-14.037 0-27.234 5.466-37.161 15.392l-10.244 10.244a118.309 118.309 0 00-27.438-3.242h-31.044c-1.551-5.991-5.404-11.383-11.174-14.715l-35.268-20.362a23.75 23.75 0 00-18.139-2.388 23.745 23.745 0 00-14.514 11.137L3.213 213.599C.021 219.128-.828 225.57.824 231.738s5.608 11.322 11.138 14.514l35.268 20.362a23.753 23.753 0 0016.301 2.787l28.866 28.867a36.374 36.374 0 00-.671 6.96c0 9.609 3.742 18.644 10.537 25.438 6.506 6.505 14.904 9.988 23.439 10.459a36.529 36.529 0 00-.202 3.798c0 9.61 3.742 18.644 10.537 25.438 6.795 6.795 15.829 10.537 25.438 10.537.261 0 .519-.013.779-.019-.006.26-.019.518-.019.779 0 9.61 3.742 18.644 10.537 25.438 6.795 6.795 15.829 10.537 25.438 10.537.261 0 .519-.013.779-.019-.006.26-.019.518-.019.779 0 9.609 3.742 18.644 10.537 25.438s15.829 10.537 25.438 10.537 18.644-3.742 25.438-10.537l14.226-14.225a35.75 35.75 0 008.782-14.387c6.32 4.664 13.83 6.997 21.343 6.996 9.211-.001 18.426-3.507 25.438-10.52 4.196-4.196 7.223-9.247 8.929-14.758 5.789 3.785 12.551 5.821 19.629 5.821 9.609 0 18.644-3.742 25.438-10.537 5.049-5.05 8.409-11.336 9.804-18.176a36.032 36.032 0 0011.343 1.827c9.609 0 18.645-3.742 25.439-10.538 14.026-14.027 14.026-36.85 0-50.877l-23.34-23.34 42.603-42.603c.946.113 1.899.177 2.856.177 4.053 0 8.157-1.03 11.911-3.197l35.268-20.361c5.529-3.193 9.485-8.347 11.138-14.515s.805-12.607-2.387-18.136zm-486.842 36.45a3.882 3.882 0 01-1.818-2.37 3.887 3.887 0 01.391-2.962l70.949-122.888a3.885 3.885 0 012.37-1.818 4.011 4.011 0 011.021-.133 3.85 3.85 0 011.94.523l35.268 20.362a3.909 3.909 0 011.429 5.332L62.562 247.865a3.909 3.909 0 01-5.332 1.429zm89.765 76.295a15.87 15.87 0 014.68-11.297l8.63-8.63a15.923 15.923 0 0111.297-4.672c4.09 0 8.182 1.558 11.296 4.672 3.018 3.018 4.68 7.029 4.68 11.296s-1.662 8.279-4.68 11.296l-8.63 8.63c-6.229 6.23-16.364 6.229-22.593 0a15.864 15.864 0 01-4.68-11.295zm49.75 55.671a15.87 15.87 0 01-11.296-4.679c-3.018-3.017-4.68-7.029-4.68-11.296s1.662-8.279 4.68-11.296l14.225-14.225a15.925 15.925 0 0111.296-4.671c4.092 0 8.183 1.557 11.297 4.671 3.018 3.017 4.68 7.029 4.68 11.296s-1.662 8.279-4.68 11.296l-14.225 14.225a15.871 15.871 0 01-11.297 4.679zm36.735 36.736a15.87 15.87 0 01-11.296-4.679c-3.018-3.017-4.68-7.029-4.68-11.296s1.662-8.279 4.68-11.297l14.225-14.225c3.114-3.114 7.205-4.671 11.296-4.671s8.183 1.557 11.297 4.672c3.018 3.017 4.68 7.029 4.68 11.296s-1.662 8.279-4.68 11.296l-14.225 14.225a15.872 15.872 0 01-11.297 4.679zm62.257 17.831l-14.226 14.226c-3.017 3.017-7.028 4.679-11.296 4.679s-8.279-1.662-11.296-4.679a15.87 15.87 0 01-4.68-11.296 15.87 15.87 0 014.68-11.297l14.225-14.225a15.923 15.923 0 0111.297-4.672c4.09 0 8.182 1.558 11.296 4.671 6.229 6.228 6.229 16.364 0 22.593zm156.146-64.271a15.87 15.87 0 01-11.297 4.68 15.87 15.87 0 01-11.296-4.68l-95.45-95.45c-3.905-3.904-10.235-3.905-14.143 0-3.905 3.905-3.905 10.237 0 14.142l85.6 85.601c3.018 3.017 4.68 7.029 4.68 11.296s-1.662 8.279-4.68 11.297c-3.017 3.017-7.028 4.679-11.296 4.679s-8.279-1.662-11.296-4.679L244.575 275.219c-3.905-3.904-10.237-3.904-14.143 0-3.905 3.905-3.905 10.237 0 14.142l85.6 85.601c3.018 3.017 4.68 7.029 4.68 11.296s-1.662 8.279-4.68 11.296c-6.228 6.229-16.363 6.231-22.593 0l-18.826-18.826c-.026-.026-.055-.048-.081-.073-7.202-7.159-16.702-10.628-26.138-10.425.006-.265.019-.529.019-.796 0-9.609-3.742-18.644-10.537-25.439-7.211-7.211-16.747-10.704-26.218-10.501.006-.265.019-.529.019-.795 0-9.61-3.742-18.644-10.537-25.439-7.886-7.886-18.553-11.337-28.873-10.356-.413-8.973-4.102-17.351-10.496-23.745-14.027-14.027-36.851-14.024-50.878 0l-8.63 8.63-.03.031-22.206-22.206L149.64 137.04h34.66c3.396 0 6.783.18 10.151.53l-11.431 11.431c-6.795 6.795-10.537 15.83-10.537 25.439 0 9.61 3.742 18.644 10.537 25.439 7.014 7.013 16.227 10.52 25.438 10.52 9.213 0 18.426-3.506 25.439-10.52l26.996-26.996 155.72 155.719c6.229 6.228 6.229 16.364.001 22.592zm-96.078-146.955a56.749 56.749 0 0023.472-45.993c0-5.523-4.478-10-10-10s-10 4.477-10 10c0 13.063-6.9 24.978-17.909 31.557l-38.088-38.088c-3.906-3.905-10.227-4.007-14.133-.102l-34.123 34.123c-6.229 6.229-16.364 6.228-22.593 0-3.018-3.017-4.68-7.029-4.68-11.296s1.662-8.279 4.68-11.297l38.963-38.963c6.148-6.148 14.323-9.534 23.019-9.534h102.495l70.495 122.102c.167.289.349.564.526.843l-39.386 39.386z'/%3E%3Cpath d='M464.308 145.414c2.63 0 5.2-1.07 7.07-2.93a10.098 10.098 0 002.93-7.07 10.1 10.1 0 00-2.93-7.08 10.084 10.084 0 00-7.07-2.92c-2.64 0-5.21 1.06-7.07 2.92a10.056 10.056 0 00-2.93 7.08c0 2.63 1.06 5.2 2.93 7.07a10.054 10.054 0 007.07 2.93z'/%3E%3C/svg%3E\")}.cover__register-btn_executor:before{background-image:url(\"data:image/svg+xml;charset=utf-8,%3Csvg fill='%23fff' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 512 512'%3E%3Cpath d='M356 429c-5.52 0-10 4.48-10 10s4.48 10 10 10 10-4.48 10-10-4.48-10-10-10zM156 429c-5.52 0-10 4.48-10 10s4.48 10 10 10 10-4.48 10-10-4.48-10-10-10z'/%3E%3Cpath d='M447.645 377.21c-11.257-17.424-26.726-31.269-44.847-40.21a9.947 9.947 0 00-5.678-2.613C384.013 328.823 370.197 326 356 326h-30v-26.383A114.708 114.708 0 00361.894 243H366c22.056 0 40-17.944 40-40 0-10.452-4.034-19.976-10.622-27.11a30.8 30.8 0 001.833-1.679C402.879 168.543 406 161.01 406 153c0-13.163-8.526-24.366-20.343-28.396-3.533-45.984-35.806-85.28-80.241-97.596C302.783 13.256 291.434 0 276 0h-40c-15.434 0-26.783 13.256-29.416 27.008-44.431 12.315-76.701 51.604-80.24 97.582a29.893 29.893 0 00-11.555 7.199C109.121 137.457 106 144.99 106 153c0 9.163 4.134 17.375 10.63 22.882C110.038 183.016 106 192.544 106 203c0 22.056 17.944 40 40 40h4.078c5.052 18.357 14.631 35.21 27.994 49.131a112.945 112.945 0 007.928 7.478V326h-30c-14.198 0-28.014 2.823-41.12 8.386a9.95 9.95 0 00-5.677 2.613c-18.123 8.942-33.591 22.787-44.848 40.21C52.347 395.796 46 417.163 46 439v63c0 5.522 4.477 10 10 10h400c5.523 0 10-4.478 10-10v-63c0-21.837-6.347-43.204-18.355-61.79zM106 492H66v-53c0-30.417 15.582-59.571 40-76.878V492zm260-269h-.456c.298-3.327.456-6.666.456-10v-30c11.028 0 20 8.972 20 20s-8.972 20-20 20zM206 48.139V93c0 5.523 4.477 10 10 10s10-4.477 10-10V35.063 33c0-6.196 5.234-13 10-13h40c4.766 0 10 6.804 10 13v60c0 5.523 4.477 10 10 10s10-4.477 10-10V48.139c32.29 11.427 55.6 40.647 59.441 74.861H146.559C150.4 88.786 173.71 59.566 206 48.139zM146 223c-11.028 0-20-8.972-20-20s8.972-20 20-20v30c0 3.334.158 6.674.456 10H146zm0-60h-10c-5.514 0-10-4.486-10-10a9.93 9.93 0 012.931-7.068A9.933 9.933 0 01136 143h240c5.514 0 10 4.486 10 10a9.93 9.93 0 01-2.931 7.068A9.93 9.93 0 01376 163H146zm21.817 68.183c-.02-.109-.039-.217-.063-.324A92.231 92.231 0 01166 213v-30h180v30c0 5.978-.593 11.981-1.754 17.855-.024.108-.043.217-.063.326a94.729 94.729 0 01-34.847 56.241C293.69 299.576 275.247 306 256 306s-37.69-6.424-53.351-18.589a92.671 92.671 0 01-10.145-9.126c-12.615-13.142-21.147-29.423-24.687-47.102zM246 492h-80v-23c0-5.523-4.477-10-10-10s-10 4.477-10 10v23h-20V351.474a84.642 84.642 0 0120-4.882V409c0 5.523 4.477 10 10 10s10-4.477 10-10v-63h25.715L246 403v89zm-40-160v-18.626C221.431 321.669 238.427 326 256 326c17.574 0 34.571-4.332 50-12.625V332l-50 52.5-50-52.5zm180 160h-20v-23c0-5.523-4.477-10-10-10s-10 4.477-10 10v23h-80v-89l54.285-57H346v63c0 5.523 4.477 10 10 10s10-4.477 10-10v-62.408a84.656 84.656 0 0120 4.883V492zm60 0h-40V362.121c24.418 17.307 40 46.461 40 76.879v53z'/%3E%3C/svg%3E\")}.cover__register-btn:hover{color:#fff}.cover__register-btn:last-of-type{margin-bottom:0}.cover__link{font-size:14px;color:#000;font-weight:700;text-transform:uppercase;text-decoration:none;height:20px;line-height:20px;display:inline-flex;align-items:center}.cover__link_contacts{margin-right:30px}.cover__link_contacts:before{background-image:url(\"data:image/svg+xml;charset=utf-8,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 211.621 211.621'%3E%3Cpath d='M180.948 27.722C163.07 9.844 139.299-.001 114.017 0a7.5 7.5 0 000 15c21.276-.001 41.279 8.284 56.324 23.329 15.046 15.045 23.331 35.049 23.33 56.326a7.5 7.5 0 0015 .001c.001-25.285-9.844-49.056-27.723-66.934z'/%3E%3Cpath d='M150.096 94.656c0 4.142 3.358 7.5 7.501 7.499a7.5 7.5 0 007.499-7.5c-.002-28.16-22.916-51.073-51.078-51.077h-.001a7.5 7.5 0 00-.001 15c19.893.003 36.078 16.187 36.08 36.078zM133.5 132.896c-11.432-.592-17.256 7.91-20.049 11.994a7.5 7.5 0 1012.381 8.469c3.3-4.825 4.795-5.584 6.823-5.488 6.491.763 32.056 19.497 34.616 25.355.642 1.725.618 3.416-.071 5.473-2.684 7.966-7.127 13.564-12.851 16.188-5.438 2.493-12.105 2.267-19.276-.651-26.777-10.914-50.171-26.145-69.531-45.271l-.023-.023c-19.086-19.341-34.289-42.705-45.185-69.441-2.919-7.177-3.145-13.845-.652-19.282 2.624-5.724 8.222-10.167 16.181-12.848 2.064-.692 3.752-.714 5.461-.078 5.879 2.569 24.612 28.133 25.368 34.551.108 2.104-.657 3.598-5.478 6.892a7.5 7.5 0 108.461 12.385c4.086-2.79 12.586-8.598 11.996-20.069-.65-11.982-23.958-43.713-35.095-47.808-4.953-1.846-10.163-1.878-15.491-.09-11.988 4.037-20.646 11.235-25.038 20.815-4.26 9.294-4.125 20.077.395 31.189 11.661 28.612 27.976 53.647 48.491 74.412.05.051.101.101.153.15 20.75 20.477 45.756 36.762 74.33 48.409 5.722 2.327 11.357 3.492 16.746 3.492 5.074 0 9.932-1.032 14.438-3.098 9.581-4.391 16.778-13.048 20.818-25.044 1.784-5.318 1.755-10.526-.077-15.456-4.109-11.167-35.84-34.475-47.841-35.127z'/%3E%3C/svg%3E\")}.cover__link_help:before{background-image:url(\"data:image/svg+xml;charset=utf-8,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 512 512'%3E%3Ccircle cx='256' cy='378.5' r='25'/%3E%3Cpath d='M256 0C114.516 0 0 114.497 0 256c0 141.484 114.497 256 256 256 141.484 0 256-114.497 256-256C512 114.516 397.503 0 256 0zm0 472c-119.377 0-216-96.607-216-216 0-119.377 96.607-216 216-216 119.377 0 216 96.607 216 216 0 119.377-96.607 216-216 216z'/%3E%3Cpath d='M256 128.5c-44.112 0-80 35.888-80 80 0 11.046 8.954 20 20 20s20-8.954 20-20c0-22.056 17.944-40 40-40s40 17.944 40 40-17.944 40-40 40c-11.046 0-20 8.954-20 20v50c0 11.046 8.954 20 20 20s20-8.954 20-20v-32.531c34.466-8.903 60-40.26 60-77.469 0-44.112-35.888-80-80-80z'/%3E%3C/svg%3E\")}.cover__link:before{display:inline-block;width:20px;height:20px;content:\"\";margin-right:10px}.cover__link:hover{color:#000}@media(max-width:991.98px){.cover__side{min-width:100%;padding:20px}.cover__qube{display:none;padding:20px}.cover__register-btn{width:100%;height:50px;font-size:16px;line-height:50px;margin-bottom:10px}.cover__register-btn:before{height:30px;width:30px;background-size:contain}.cover__side-name{font-size:26px;margin-bottom:44px}}.register{display:block}.register__input{height:70px;display:block;width:100%;border:3px solid #000;border-radius:35px;font-size:16px;line-height:70px;padding:0 40px;margin-bottom:25px}.register__input:focus{outline:none}.register__button{display:block;height:70px;background-color:#000;border-radius:35px;margin-bottom:20px;color:#fff;font-size:16px;text-transform:uppercase;font-weight:700;text-decoration:none;line-height:70px;position:relative;text-align:center;border:none;width:100%;padding:0 40px}.register__button:hover{color:#fff}.register__button:disabled{background-color:#4d4d4d}.register__alert{text-align:center;font-weight:700;width:100%;background-color:transparent;border:3px solid #000;color:#000;padding:20px;border-radius:45px;margin-bottom:25px;font-size:16px;text-transform:uppercase}.orders{background-color:#c6c6c6;flex-grow:1;padding-top:100px;padding-bottom:50px}.orders__title{font-family:\"Ponter Alt\",sans;margin-bottom:20px}@media(max-width:767.98px){.orders{padding-top:30px}}.order{padding:20px;background-color:#fff;margin-bottom:30px;display:flex;align-items:center;max-width:1080px;justify-content:space-between}.order__avatar{height:80px;width:80px;flex-shrink:0;background-color:#ffcd00;background-size:40px;background-repeat:no-repeat;background-position:50%;background-image:url(\"data:image/svg+xml;charset=utf-8,%3Csvg height='512pt' viewBox='0 0 512 512.017' width='512pt' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath d='M486.41 298.684H460.81v-85.332c-.028-23.555-19.114-42.641-42.668-42.668H281.609c-23.554.027-42.64 19.113-42.668 42.668v85.332H213.34c-14.13.015-25.582 11.468-25.598 25.601v85.332c.067 22.457 17.551 41.004 39.965 42.395l-12.27 42.937H135.68c-4.082-19.847-21.54-34.105-41.805-34.133H76.809V67.941c.011-26.691 20.644-48.836 47.27-50.726s50.183 17.113 53.968 43.535l.148 1.035c-11.011 4.535-17.406 16.098-15.39 27.832l2.328 13.778-22.817 39.183a17.084 17.084 0 00-.066 17.067 17.077 17.077 0 0014.746 8.597c.977 0 1.953-.082 2.914-.246l81.867-13.836a17.08 17.08 0 0013.602-12.265 17.061 17.061 0 00-5.336-17.516l-34.426-29.512-2.328-13.777a25.548 25.548 0 00-17.98-20.18l-.368-2.574C189.898 23.039 158.43-2.355 122.867.172s-63.125 32.117-63.125 67.77v392.874H42.676v-8.53a8.534 8.534 0 10-17.067 0v12.148a42.697 42.697 0 00-25.601 39.05c0 4.711 3.82 8.532 8.535 8.532h494.934c4.71 0 8.53-3.82 8.53-8.532a8.533 8.533 0 00-8.53-8.535h-19.165l-12.269-42.937c22.414-1.39 39.898-19.938 39.965-42.395v-85.332c-.016-14.133-11.469-25.586-25.598-25.601zM238.934 137.332l-81.868 13.84 22.36-38.399 25.777-4.355 33.793 28.898zm-41.047-44.988l-16.828 2.844-1.426-8.415a8.546 8.546 0 016.992-9.835 8.553 8.553 0 019.844 6.992zm83.722 95.406h136.532c14.132.016 25.586 11.469 25.601 25.602v86.906a25.548 25.548 0 00-17.066 24.027v17.285a42.25 42.25 0 00-25.602-8.754h-30.597l19.566-19.566c3.23-3.348 3.187-8.672-.106-11.96a8.53 8.53 0 00-11.96-.106L358.41 320.75v-39.133a8.536 8.536 0 00-17.07 0v39.133l-19.567-19.566a8.53 8.53 0 00-11.96.105c-3.293 3.29-3.336 8.613-.106 11.961l19.566 19.566h-30.597a42.25 42.25 0 00-25.602 8.754v-17.285a25.548 25.548 0 00-17.066-24.027v-86.906c.015-14.133 11.469-25.586 25.601-25.602zm119.465 162.133c14.133.015 25.586 11.469 25.602 25.601v8.532H273.074v-8.532c.016-14.132 11.469-25.586 25.602-25.601zm12.117 102.402l24.383 42.664H262.18l24.379-42.664zm13.485-17.07H273.074v-34.133h153.602zm-221.867-25.598v-85.332c.003-4.71 3.824-8.527 8.53-8.535h34.138c4.707.008 8.527 3.824 8.53 8.535v110.93H230.41c-14.133-.016-25.586-11.465-25.601-25.598zM18.539 494.95a25.64 25.64 0 0124.137-17.066h51.199a25.643 25.643 0 0124.137 17.066zm214.648 0l12.192-42.664h21.527l-24.379 42.664zm224.036 0l-24.38-42.664h21.528l12.191 42.664zm37.718-85.332c-.015 14.133-11.468 25.582-25.601 25.598h-25.598v-110.93c.004-4.71 3.824-8.527 8.531-8.535h34.137c4.707.008 8.524 3.824 8.531 8.535zm0 0'/%3E%3C/svg%3E\");margin-right:22px}.order__title{font-size:16px;font-family:\"Ponter Alt\",sans;margin-bottom:10px}.order__text{width:260px;margin-right:50px}.order__content{font-size:12px;margin-bottom:0}.order__map{font-family:\"Ponter Alt\",sans;font-size:14px;display:flex;margin-right:50px}.order__map:before{content:\"\";width:40px;height:40px;display:block;background-repeat:no-repeat;margin-right:12px;background-image:url(\"data:image/svg+xml;charset=utf-8,%3Csvg fill='%23ffcd00' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 512 512'%3E%3Cpath d='M256 0C148.48 0 61 87.48 61 195c0 42.55 13.44 82.98 38.9 116.9l144.08 194.051c.36.47.91.65 1.31 1.07 7.2 7.71 17.59 5.77 22.72-1.07C309.5 450.591 385.55 347.2 414.79 308.2c0 0 .01-.03.02-.05l.18-.24C438.55 274.81 451 235.77 451 195 451 87.48 363.52 0 256 0zm0 300.2c-57.89 0-105.2-47.31-105.2-105.2S198.11 89.8 256 89.8 361.2 137.11 361.2 195 313.89 300.2 256 300.2z'/%3E%3C/svg%3E\")}.order__sum{font-size:23px;font-family:\"Ponter Alt\",sans;display:flex;align-items:center;margin-right:50px}.order__sum:before{display:block;content:\"\";margin-right:10px;background-image:url(\"data:image/svg+xml;charset=utf-8,%3Csvg fill='%23ffcd00' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 512 512'%3E%3Cpath d='M253.614 333.891c-14.336 0-25.999 11.663-25.999 25.999s11.664 25.999 25.999 25.999 25.999-11.663 25.999-25.999-11.662-25.999-25.999-25.999zm0 31.999c-3.309 0-6-2.691-6-6s2.691-6 6-6 6 2.691 6 6-2.691 6-6 6zM333.878 300.75a10.077 10.077 0 00-7.07-2.931c-2.63 0-5.21 1.07-7.07 2.931a10.029 10.029 0 00-2.93 7.069 10.03 10.03 0 002.93 7.07 10.071 10.071 0 007.07 2.93c2.63 0 5.21-1.069 7.07-2.93a10.072 10.072 0 002.93-7.07c0-2.63-1.07-5.21-2.93-7.069z'/%3E%3Cpath d='M461.994 143.987h-10.781L310.158 2.932c-3.905-3.905-10.238-3.905-14.142 0L259.88 39.069 115.356.344c-5.335-1.431-10.819 1.736-12.248 7.071L66.516 143.987h-24.51c-23.158 0-41.999 18.84-41.999 41.999 0 .555.021 1.106.042 1.656a9.944 9.944 0 00-.042.832v273.528C.007 489.57 22.437 512 50.006 512h357.989c.155 0 .307-.01.462-.012h53.536c27.569 0 49.998-22.429 49.998-49.999V193.985c.001-27.57-22.428-49.998-49.997-49.998zm-8.934 19.999h8.934c16.542 0 29.999 13.458 29.999 29.999v80.143c0 13.069-10.633 23.701-23.701 23.701h-10.298v-39.846c0-27.221-21.869-49.415-48.959-49.973l44.025-44.024zM269.94 57.293l.003-.004 33.145-33.145L433.854 154.91l-52.75 52.75H362.81l23.928-23.929c3.905-3.905 3.905-10.237 0-14.142-8.095-8.095-8.095-21.265 0-29.36 3.905-3.905 3.905-10.237 0-14.143L331.91 71.26c-3.905-3.905-10.237-3.905-14.143 0-8.095 8.096-21.266 8.096-29.36 0-3.905-3.905-10.238-3.905-14.142 0l-136.4 136.401h-18.294L269.94 57.293zm-29.429 112.798c-22.828 0-41.954 16.119-46.619 37.57h-27.745L282.213 91.595c12.811 7.636 28.937 7.636 41.748 0l42.441 42.441c-7.635 12.81-7.635 28.938 0 41.748l-31.877 31.877H287.13c-4.665-21.452-23.79-37.57-46.619-37.57zm25.786 37.57h-51.568c4.058-10.277 14.083-17.57 25.784-17.57s21.725 7.293 25.784 17.57zm-157.295-17.715l26.482-98.833c7.261.117 14.484-1.737 20.953-5.474 6.47-3.735 11.676-9.046 15.217-15.409l45.005 12.059-65.311 65.311-42.346 42.346zM119.839 22.25L243.55 55.398 232.989 65.96l-64.63-17.318a9.996 9.996 0 00-12.247 7.071 20.631 20.631 0 01-9.673 12.606 20.628 20.628 0 01-15.755 2.074c-5.333-1.43-10.818 1.736-12.247 7.071L83.463 207.985H70.071L119.839 22.25zM42.006 163.986h19.149l-11.79 43.999h-7.36c-12.131 0-21.999-9.869-21.999-21.999.001-12.131 9.871-22 22-22zm449.987 298.003c0 16.542-13.458 29.999-29.999 29.999h-14.018c6.287-8.36 10.018-18.745 10.018-29.987v-40.176h6c10.444 0 20.111-3.363 27.999-9.049v49.213zm0-88.162c0 15.439-12.561 27.999-27.999 27.999H254c-23.158 0-41.999-18.84-41.999-41.999s18.84-41.999 41.999-41.999h30.306c5.523 0 10-4.478 10-10s-4.477-10-10-10H254c-34.186 0-61.998 27.812-61.998 61.998 0 34.186 27.812 61.998 61.998 61.998h183.995V462c0 16.387-13.209 29.75-29.537 29.999H68.005V379.39c0-5.522-4.477-10-10-10s-10 4.478-10 10v112.536c-15.612-1.033-27.999-14.056-27.999-29.924v-240.26a41.738 41.738 0 0021.999 6.242h365.989c16.542 0 29.999 13.458 29.999 29.999v39.846H365.69c-5.523 0-10 4.478-10 10s4.477 10 10 10h102.602a43.425 43.425 0 0023.701-7.015v63.013z'/%3E%3Cpath d='M65.076 333.318c-1.86-1.859-4.44-2.93-7.07-2.93s-5.21 1.07-7.07 2.93a10.076 10.076 0 00-2.93 7.07c0 2.63 1.07 5.21 2.93 7.07 1.86 1.86 4.44 2.93 7.07 2.93s5.21-1.07 7.07-2.93c1.86-1.86 2.93-4.44 2.93-7.07a10.084 10.084 0 00-2.93-7.07z'/%3E%3C/svg%3E\");width:40px;height:40px;background-repeat:no-repeat;background-size:contain}.order__btn{height:40px;display:block;background-color:#ffcd00;font-family:\"Ponter Alt\",sans;color:#000;font-size:14px;line-height:40px;text-decoration:none;padding:0 22px}.order__btn:hover{color:#000}@media(max-width:767.98px){.order{flex-wrap:wrap;align-items:flex-start}.order__avatar{height:40px;width:40px;background-size:20px;order:3;margin-right:20px}.order__map{order:1;width:50%;margin-bottom:20px;margin-right:auto}.order__map:before{height:18px;width:18px}.order__map br{display:none}.order__sum{order:2;width:50%;font-size:14px;margin-left:auto;margin-right:0;justify-content:flex-end}.order__sum:before{height:18px;width:18px}.order__text{order:4;width:calc(100% - 60px);margin:0 0 20px}.order__btn{order:5}}.executors{background-color:#dedede;flex-grow:1;padding-top:100px;padding-bottom:50px}.executors__title{font-family:\"Ponter Alt\",sans;margin-bottom:20px}@media(max-width:575.98px){.executors{padding-top:30px}}.executor{padding:20px;background-color:#fff;display:flex;align-items:center;justify-content:space-between;margin-bottom:30px;text-decoration:none;translate:transform .3s}.executor:hover{transform:scale(1.01)}.executor>*{color:#000;text-decoration:none}.executor__avatar{height:80px;width:80px;flex-shrink:0;background-color:#ffcd00;background-size:40px;background-repeat:no-repeat;background-position:50%;background-image:url(\"data:image/svg+xml;charset=utf-8,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 19.738 19.738'%3E%3Cg fill='%23010002'%3E%3Cpath d='M18.18 19.738h-2c0-3.374-2.83-6.118-6.311-6.118s-6.31 2.745-6.31 6.118h-2c0-4.478 3.729-8.118 8.311-8.118 4.581 0 8.31 3.64 8.31 8.118zM9.87 10.97a5.492 5.492 0 01-5.484-5.485A5.49 5.49 0 019.87 0c3.025 0 5.486 2.46 5.486 5.485S12.895 10.97 9.87 10.97zm0-8.97C7.948 2 6.385 3.563 6.385 5.485S7.948 8.97 9.87 8.97c1.923 0 3.486-1.563 3.486-3.485S11.791 2 9.87 2z'/%3E%3C/g%3E%3C/svg%3E\")}.executor__user{margin-left:20px}.executor__name{font-size:35px;font-family:\"Ponter Alt\",sans}.executor__map{font-family:\"Ponter Alt\",sans;font-size:14px;display:flex}.executor__map:before{content:\"\";width:40px;height:40px;display:block;background-repeat:no-repeat;margin-right:12px;background-image:url(\"data:image/svg+xml;charset=utf-8,%3Csvg fill='%23ffcd00' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 512 512'%3E%3Cpath d='M256 0C148.48 0 61 87.48 61 195c0 42.55 13.44 82.98 38.9 116.9l144.08 194.051c.36.47.91.65 1.31 1.07 7.2 7.71 17.59 5.77 22.72-1.07C309.5 450.591 385.55 347.2 414.79 308.2c0 0 .01-.03.02-.05l.18-.24C438.55 274.81 451 235.77 451 195 451 87.48 363.52 0 256 0zm0 300.2c-57.89 0-105.2-47.31-105.2-105.2S198.11 89.8 256 89.8 361.2 137.11 361.2 195 313.89 300.2 256 300.2z'/%3E%3C/svg%3E\")}.executor__stats{font-size:14.11px;display:flex;align-items:center}.executors__stats-n{font-size:58px;color:#ffcd00;font-family:\"Ponter Alt\",sans;margin-right:10px}.executors__stats-t{font-family:\"Ponter Alt\",sans;font-size:14px}@media(max-width:767.98px){.executor{flex-wrap:wrap}.executor__map{order:1;width:100%;margin-bottom:20px}.executor__map:before{height:18px;width:18px}.executor__map br{display:none}.executor__avatar{order:2;width:80px;margin-bottom:20px}.executor__user{order:3;width:calc(100% - 100px);margin-bottom:20px}.executor__stats{order:4;margin-left:0}.executor__stats:last-of-type{margin-left:20px;margin-right:auto}}.rate{display:flex}.rate__item{height:20px;width:20px;text-indent:-9999px;margin-right:10px;background-image:url(\"data:image/svg+xml;charset=utf-8,%3Csvg fill='%23babab8' height='511pt' viewBox='0 -10 511.987 511' width='511pt' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath d='M114.594 491.14c-5.61 0-11.18-1.75-15.934-5.187a27.223 27.223 0 01-10.582-28.094l32.938-145.09L9.312 214.81a27.188 27.188 0 01-7.976-28.907 27.208 27.208 0 0123.402-18.71l147.797-13.419L230.97 17.027C235.277 6.98 245.089.492 255.992.492s20.715 6.488 25.024 16.512l58.433 136.77 147.774 13.417c10.882.98 20.054 8.344 23.425 18.711 3.372 10.368.254 21.739-7.957 28.907L390.988 312.75l32.938 145.086c2.414 10.668-1.727 21.7-10.578 28.098-8.832 6.398-20.61 6.89-29.91 1.3l-127.446-76.16-127.445 76.203c-4.309 2.559-9.11 3.864-13.953 3.864zm141.398-112.874c4.844 0 9.64 1.3 13.953 3.859l120.278 71.938-31.086-136.942a27.21 27.21 0 018.62-26.516l105.473-92.5-139.543-12.671a27.18 27.18 0 01-22.613-16.493L255.992 39.895 200.844 168.96c-3.883 9.195-12.524 15.512-22.547 16.43L38.734 198.062l105.47 92.5c7.554 6.614 10.858 16.77 8.62 26.54l-31.062 136.937 120.277-71.914c4.309-2.559 9.11-3.86 13.953-3.86zm-84.586-221.848s0 .023-.023.043zm169.13-.063l.023.043c0-.023 0-.023-.024-.043zm0 0'/%3E%3C/svg%3E\");background-size:contain}.rate__item_active{background-image:url(\"data:image/svg+xml;charset=utf-8,%3Csvg xmlns='http://www.w3.org/2000/svg' height='24' width='24'%3E%3Cpath fill='none' d='M0 0h24v24H0z'/%3E%3Cpath d='M14.43 10L12 2l-2.43 8H2l6.18 4.41L5.83 22 12 17.31 18.18 22l-2.35-7.59L22 10z'/%3E%3C/svg%3E\")}.paginator{display:block}.paginator__list{display:flex;padding:0;margin-bottom:0}.paginator__item{list-style-type:none;display:flex;height:40px;margin-right:20px}.paginator__link{height:100%;font-size:24px;line-height:40px;text-decoration:none;font-family:\"Ponter Alt\",sans;background-color:#fff;min-width:40px;text-align:center;padding-left:10px;padding-right:10px;color:#aeadab}.paginator__link_next,.paginator__link_prev{overflow:hidden;text-indent:-9999px;background-color:#aeadab;background-size:20px;background-repeat:no-repeat;background-position:50%;background-image:url(\"data:image/svg+xml;charset=utf-8,%3Csvg fill='%23fff' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 492.004 492.004'%3E%3Cpath d='M382.678 226.804L163.73 7.86C158.666 2.792 151.906 0 144.698 0s-13.968 2.792-19.032 7.86l-16.124 16.12c-10.492 10.504-10.492 27.576 0 38.064L293.398 245.9l-184.06 184.06c-5.064 5.068-7.86 11.824-7.86 19.028 0 7.212 2.796 13.968 7.86 19.04l16.124 16.116c5.068 5.068 11.824 7.86 19.032 7.86s13.968-2.792 19.032-7.86L382.678 265c5.076-5.084 7.864-11.872 7.848-19.088.016-7.244-2.772-14.028-7.848-19.108z'/%3E%3C/svg%3E\")}.paginator__link_prev{transform:rotate(180deg)}.paginator__link:hover{color:#aeadab}.paginator__link_current{background-color:#ffcd00;color:#fff}.paginator__link_current:hover{color:#fff}.profile{flex-grow:1;padding-top:100px;padding-bottom:50px}.profile__container{display:flex;align-items:flex-start}.profile__side{width:300px;margin-right:24px;padding:12px}.profile__area,.profile__side{box-shadow:0 0 6.44px .56px rgba(28,65,71,.09)}.profile__area{width:calc(100% - 324px);background-color:#fff}.profile__tabs{display:flex;width:100%}.profile__tab{width:100%;height:80px;border:none;font-family:\"Ponter Alt\",sans;background-color:#d2d2d2}.profile__tab_active{background-color:#ffcd00}.profile__tab:focus{outline:none}.profile__executor{font-family:\"Ponter Alt\",sans}.profile__city,.profile__rate{font-size:20px}.profile__order-btn{display:block;border:none;background-color:#ffcd00;height:40px;line-height:40px;font-family:\"Ponter Alt\",sans;text-align:center;margin-top:20px}.profile__order-btn,.profile__order-btn:hover{color:#000;text-decoration:none}.profile__portfolio{display:flex;flex-wrap:wrap;padding:12px;margin-left:-12px;margin-right:-12px}.profile__portfolio-item{background-color:#6c0f0f;width:calc(25% - 24px);margin-left:12px;margin-right:12px;aspect-ratio:1;overflow:hidden;margin-bottom:24px}.profile__portfolio-item img{width:100%;height:100%;-o-object-fit:cover;object-fit:cover}.profile__orders{padding:12px}.profile__modal{display:none}.profile__modal_active{position:fixed;height:100vh;width:100%;background-color:rgba(0,0,0,.5);top:0;bottom:0;left:0;right:0;display:flex;align-items:center;justify-content:center;overflow-y:auto;z-index:1000}.profile__modal-content{height:calc(100vh - 100px);background-color:#fff;overflow-y:hidden}.profile__modal-head{height:50px;border-bottom:1px solid #333;font-family:\"Ponter Alt\",sans;display:flex;align-items:center;padding-left:20px;justify-content:space-between}.profile__modal-body{padding:20px;overflow-y:scroll;height:calc(100% - 50px)}.profile__modal-body-inner{height:100%;overflow-y:scroll}.profile__modal-head>span{font-family:\"Ponter Alt\",sans}.profile__modal-head>button{background-color:transparent;border:none;height:50px;width:50px}.profile__modal-slide{max-height:400px;-o-object-fit:cover;object-fit:cover;width:100%;margin-bottom:20px}.profile__message{padding:24px 24px 0}@media(max-width:991.98px){.profile__portfolio-item{width:100%}}@media(max-width:767.98px){.profile__container{flex-wrap:wrap}.profile__side{width:100%;margin-bottom:24px;margin-right:0}.profile__area,.profile__portfolio-item{width:100%}}.blog{flex-grow:1;padding-top:100px;padding-bottom:50px}.blog__title{font-family:\"Ponter Alt\",sans;margin-bottom:20px}.blog__img{margin-bottom:30px;width:100%}.blog__img img{max-width:100%;-o-object-fit:contain;object-fit:contain}.blog__item{margin-bottom:30px;background-color:#fff}.blog__item-separator{margin-bottom:60px}.blog__item-title{font-family:\"Ponter Alt\",sans;font-size:20px}", ""]);
// Exports
module.exports = exports;


/***/ }),
/* 28 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


module.exports = function (url, options) {
  if (!options) {
    // eslint-disable-next-line no-param-reassign
    options = {};
  } // eslint-disable-next-line no-underscore-dangle, no-param-reassign


  url = url && url.__esModule ? url.default : url;

  if (typeof url !== 'string') {
    return url;
  } // If url is already wrapped in quotes, remove them


  if (/^['"].*['"]$/.test(url)) {
    // eslint-disable-next-line no-param-reassign
    url = url.slice(1, -1);
  }

  if (options.hash) {
    // eslint-disable-next-line no-param-reassign
    url += options.hash;
  } // Should url be wrapped?
  // See https://drafts.csswg.org/css-values-3/#urls


  if (/["'() \t\n]/.test(url) || options.needQuotes) {
    return "\"".concat(url.replace(/"/g, '\\"').replace(/\n/g, '\\n'), "\"");
  }

  return url;
};

/***/ }),
/* 29 */
/***/ (function(module, exports, __webpack_require__) {

module.exports = __webpack_require__.p + "fonts/nfscarbonfont.96f79d7.woff2";

/***/ }),
/* 30 */
/***/ (function(module, exports, __webpack_require__) {

module.exports = __webpack_require__.p + "fonts/nfscarbonfont.61b918f.woff";

/***/ }),
/* 31 */
/***/ (function(module, exports, __webpack_require__) {

module.exports = __webpack_require__.p + "fonts/alt.449b6ca.eot";

/***/ }),
/* 32 */
/***/ (function(module, exports, __webpack_require__) {

module.exports = __webpack_require__.p + "fonts/alt.3180af9.woff2";

/***/ }),
/* 33 */
/***/ (function(module, exports, __webpack_require__) {

module.exports = __webpack_require__.p + "fonts/alt.6bd50b7.woff";

/***/ }),
/* 34 */
/***/ (function(module, exports, __webpack_require__) {

module.exports = __webpack_require__.p + "fonts/alt.14ce4c1.ttf";

/***/ }),
/* 35 */
/***/ (function(module, exports, __webpack_require__) {

module.exports = __webpack_require__.p + "img/alt.9173067.svg";

/***/ }),
/* 36 */
/***/ (function(module, exports, __webpack_require__) {

module.exports = __webpack_require__.p + "img/logo.336b122.png";

/***/ }),
/* 37 */
/***/ (function(module, exports, __webpack_require__) {

module.exports = __webpack_require__.p + "img/cover.f0a1828.jpg";

/***/ }),
/* 38 */
/***/ (function(module, exports, __webpack_require__) {

module.exports = __webpack_require__.p + "img/logo_footer.52ddc89.png";

/***/ }),
/* 39 */
/***/ (function(module, exports, __webpack_require__) {

// style-loader: Adds some css to the DOM by adding a <style> tag

// load the styles
var content = __webpack_require__(40);
if(typeof content === 'string') content = [[module.i, content, '']];
if(content.locals) module.exports = content.locals;
__webpack_require__(11).default("517a8dd7", content, true)

/***/ }),
/* 40 */
/***/ (function(module, exports, __webpack_require__) {

// Imports
var ___CSS_LOADER_API_IMPORT___ = __webpack_require__(10);
exports = ___CSS_LOADER_API_IMPORT___(false);
// Module
exports.push([module.i, "code[class*=language-],pre[class*=language-]{color:#000;background:none;text-shadow:0 1px #fff;font-family:Consolas,Monaco,\"Andale Mono\",\"Ubuntu Mono\",monospace;font-size:1em;text-align:left;white-space:pre;word-spacing:normal;word-break:normal;word-wrap:normal;line-height:1.5;-moz-tab-size:4;-o-tab-size:4;tab-size:4;-webkit-hyphens:none;-ms-hyphens:none;hyphens:none}code[class*=language-]::-moz-selection,code[class*=language-] ::-moz-selection,pre[class*=language-]::-moz-selection,pre[class*=language-] ::-moz-selection{text-shadow:none;background:#b3d4fc}code[class*=language-]::selection,code[class*=language-] ::selection,pre[class*=language-]::selection,pre[class*=language-] ::selection{text-shadow:none;background:#b3d4fc}@media print{code[class*=language-],pre[class*=language-]{text-shadow:none}}pre[class*=language-]{padding:1em;margin:.5em 0;overflow:auto}:not(pre)>code[class*=language-],pre[class*=language-]{background:#f5f2f0}:not(pre)>code[class*=language-]{padding:.1em;border-radius:.3em;white-space:normal}.token.cdata,.token.comment,.token.doctype,.token.prolog{color:#708090}.token.punctuation{color:#999}.token.namespace{opacity:.7}.token.boolean,.token.constant,.token.deleted,.token.number,.token.property,.token.symbol,.token.tag{color:#905}.token.attr-name,.token.builtin,.token.char,.token.inserted,.token.selector,.token.string{color:#690}.language-css .token.string,.style .token.string,.token.entity,.token.operator,.token.url{color:#9a6e3a;background:hsla(0,0%,100%,.5)}.token.atrule,.token.attr-value,.token.keyword{color:#07a}.token.class-name,.token.function{color:#dd4a68}.token.important,.token.regex,.token.variable{color:#e90}.token.bold,.token.important{font-weight:700}.token.italic{font-style:italic}.token.entity{cursor:help}", ""]);
// Exports
module.exports = exports;


/***/ }),
/* 41 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "actions", function() { return actions; });
const actions = {
  async nuxtServerInit({
    commit
  }, {
    $axios
  }) {
    const {
      data: {
        data
      }
    } = await $axios.get('settings/contacts');
    commit('contacts/setContacts', data);
  }

};

/***/ }),
/* 42 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "state", function() { return state; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "getters", function() { return getters; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "mutations", function() { return mutations; });
const state = () => ({
  data: {
    companyName: 'companyName',
    phoneNumber: 'phoneNumber',
    email: 'email',
    facebook: 'facebook',
    instagram: 'instagram',
    twitter: 'twitter',
    linkedIn: 'LinkedIn'
  }
});
const getters = {
  contacts: state => {
    return state.data;
  }
};
const mutations = {
  setContacts(state, payload) {
    state.data = { ...payload
    };
  }

};

/***/ }),
/* 43 */
/***/ (function(module, exports) {

module.exports = require("property-information");

/***/ }),
/* 44 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
// ESM COMPAT FLAG
__webpack_require__.r(__webpack_exports__);

// EXTERNAL MODULE: external "querystring"
var external_querystring_ = __webpack_require__(17);

// EXTERNAL MODULE: external "vue"
var external_vue_ = __webpack_require__(0);
var external_vue_default = /*#__PURE__*/__webpack_require__.n(external_vue_);

// EXTERNAL MODULE: external "@nuxt/ufo"
var ufo_ = __webpack_require__(3);

// EXTERNAL MODULE: external "node-fetch"
var external_node_fetch_ = __webpack_require__(18);
var external_node_fetch_default = /*#__PURE__*/__webpack_require__.n(external_node_fetch_);

// CONCATENATED MODULE: ./.nuxt/middleware.js
const middleware = {};
/* harmony default export */ var _nuxt_middleware = (middleware);
// CONCATENATED MODULE: ./.nuxt/utils.js

 // window.{{globals.loadedCallback}} hook
// Useful for jsdom testing or plugins (https://github.com/tmpvar/jsdom#dealing-with-asynchronous-script-loading)

if (false) {}

function empty() {}
function globalHandleError(error) {
  if (external_vue_default.a.config.errorHandler) {
    external_vue_default.a.config.errorHandler(error);
  }
}
function interopDefault(promise) {
  return promise.then(m => m.default || m);
}
function hasFetch(vm) {
  return vm.$options && typeof vm.$options.fetch === 'function' && !vm.$options.fetch.length;
}
function purifyData(data) {
  if (true) {
    return data;
  }

  return Object.entries(data).filter(([key, value]) => {
    const valid = !(value instanceof Function) && !(value instanceof Promise);

    if (!valid) {
      console.warn(`${key} is not able to be stringified. This will break in a production environment.`);
    }

    return valid;
  }).reduce((obj, [key, value]) => {
    obj[key] = value;
    return obj;
  }, {});
}
function getChildrenComponentInstancesUsingFetch(vm, instances = []) {
  const children = vm.$children || [];

  for (const child of children) {
    if (child.$fetch) {
      instances.push(child);
      continue; // Don't get the children since it will reload the template
    }

    if (child.$children) {
      getChildrenComponentInstancesUsingFetch(child, instances);
    }
  }

  return instances;
}
function applyAsyncData(Component, asyncData) {
  if ( // For SSR, we once all this function without second param to just apply asyncData
  // Prevent doing this for each SSR request
  !asyncData && Component.options.__hasNuxtData) {
    return;
  }

  const ComponentData = Component.options._originDataFn || Component.options.data || function () {
    return {};
  };

  Component.options._originDataFn = ComponentData;

  Component.options.data = function () {
    const data = ComponentData.call(this, this);

    if (this.$ssrContext) {
      asyncData = this.$ssrContext.asyncData[Component.cid];
    }

    return { ...data,
      ...asyncData
    };
  };

  Component.options.__hasNuxtData = true;

  if (Component._Ctor && Component._Ctor.options) {
    Component._Ctor.options.data = Component.options.data;
  }
}
function sanitizeComponent(Component) {
  // If Component already sanitized
  if (Component.options && Component._Ctor === Component) {
    return Component;
  }

  if (!Component.options) {
    Component = external_vue_default.a.extend(Component); // fix issue #6

    Component._Ctor = Component;
  } else {
    Component._Ctor = Component;
    Component.extendOptions = Component.options;
  } // If no component name defined, set file path as name, (also fixes #5703)


  if (!Component.options.name && Component.options.__file) {
    Component.options.name = Component.options.__file;
  }

  return Component;
}
function getMatchedComponents(route, matches = false, prop = 'components') {
  return Array.prototype.concat.apply([], route.matched.map((m, index) => {
    return Object.keys(m[prop]).map(key => {
      matches && matches.push(index);
      return m[prop][key];
    });
  }));
}
function getMatchedComponentsInstances(route, matches = false) {
  return getMatchedComponents(route, matches, 'instances');
}
function flatMapComponents(route, fn) {
  return Array.prototype.concat.apply([], route.matched.map((m, index) => {
    return Object.keys(m.components).reduce((promises, key) => {
      if (m.components[key]) {
        promises.push(fn(m.components[key], m.instances[key], m, key, index));
      } else {
        delete m.components[key];
      }

      return promises;
    }, []);
  }));
}
function resolveRouteComponents(route, fn) {
  return Promise.all(flatMapComponents(route, async (Component, instance, match, key) => {
    // If component is a function, resolve it
    if (typeof Component === 'function' && !Component.options) {
      Component = await Component();
    }

    match.components[key] = Component = sanitizeComponent(Component);
    return typeof fn === 'function' ? fn(Component, instance, match, key) : Component;
  }));
}
async function getRouteData(route) {
  if (!route) {
    return;
  } // Make sure the components are resolved (code-splitting)


  await resolveRouteComponents(route); // Send back a copy of route with meta based on Component definition

  return { ...route,
    meta: getMatchedComponents(route).map((Component, index) => {
      return { ...Component.options.meta,
        ...(route.matched[index] || {}).meta
      };
    })
  };
}
async function setContext(app, context) {
  // If context not defined, create it
  if (!app.context) {
    app.context = {
      isStatic: false,
      isDev: false,
      isHMR: false,
      app,
      store: app.store,
      payload: context.payload,
      error: context.error,
      base: '/',
      env: {
        "baseUrl": "https://api.zakazy.online/api/v1",
        "storageUrl": "https://file.zakazy.online"
      }
    }; // Only set once

    if ( true && context.req) {
      app.context.req = context.req;
    }

    if ( true && context.res) {
      app.context.res = context.res;
    }

    if (context.ssrContext) {
      app.context.ssrContext = context.ssrContext;
    }

    app.context.redirect = (status, path, query) => {
      if (!status) {
        return;
      }

      app.context._redirected = true; // if only 1 or 2 arguments: redirect('/') or redirect('/', { foo: 'bar' })

      let pathType = typeof path;

      if (typeof status !== 'number' && (pathType === 'undefined' || pathType === 'object')) {
        query = path || {};
        path = status;
        pathType = typeof path;
        status = 302;
      }

      if (pathType === 'object') {
        path = app.router.resolve(path).route.fullPath;
      } // "/absolute/route", "./relative/route" or "../relative/route"


      if (/(^[.]{1,2}\/)|(^\/(?!\/))/.test(path)) {
        app.context.next({
          path,
          query,
          status
        });
      } else {
        path = formatUrl(path, query);

        if (true) {
          app.context.next({
            path,
            status
          });
        }

        if (false) {}
      }
    };

    if (true) {
      app.context.beforeNuxtRender = fn => context.beforeRenderFns.push(fn);
    }

    if (false) {}
  } // Dynamic keys


  const [currentRouteData, fromRouteData] = await Promise.all([getRouteData(context.route), getRouteData(context.from)]);

  if (context.route) {
    app.context.route = currentRouteData;
  }

  if (context.from) {
    app.context.from = fromRouteData;
  }

  app.context.next = context.next;
  app.context._redirected = false;
  app.context._errored = false;
  app.context.isHMR = false;
  app.context.params = app.context.route.params || {};
  app.context.query = app.context.route.query || {};
}
function middlewareSeries(promises, appContext) {
  if (!promises.length || appContext._redirected || appContext._errored) {
    return Promise.resolve();
  }

  return promisify(promises[0], appContext).then(() => {
    return middlewareSeries(promises.slice(1), appContext);
  });
}
function promisify(fn, context) {
  let promise;

  if (fn.length === 2) {
    // fn(context, callback)
    promise = new Promise(resolve => {
      fn(context, function (err, data) {
        if (err) {
          context.error(err);
        }

        data = data || {};
        resolve(data);
      });
    });
  } else {
    promise = fn(context);
  }

  if (promise && promise instanceof Promise && typeof promise.then === 'function') {
    return promise;
  }

  return Promise.resolve(promise);
} // Imported from vue-router

function getLocation(base, mode) {
  if (mode === 'hash') {
    return window.location.hash.replace(/^#\//, '');
  }

  base = decodeURI(base).slice(0, -1); // consideration is base is normalized with trailing slash

  let path = decodeURI(window.location.pathname);

  if (base && path.startsWith(base)) {
    path = path.slice(base.length);
  }

  const fullPath = (path || '/') + window.location.search + window.location.hash;
  return Object(ufo_["normalizeURL"])(fullPath);
} // Imported from path-to-regexp

/**
 * Compile a string to a template function for the path.
 *
 * @param  {string}             str
 * @param  {Object=}            options
 * @return {!function(Object=, Object=)}
 */

function compile(str, options) {
  return tokensToFunction(parse(str, options), options);
}
function getQueryDiff(toQuery, fromQuery) {
  const diff = {};
  const queries = { ...toQuery,
    ...fromQuery
  };

  for (const k in queries) {
    if (String(toQuery[k]) !== String(fromQuery[k])) {
      diff[k] = true;
    }
  }

  return diff;
}
function normalizeError(err) {
  let message;

  if (!(err.message || typeof err === 'string')) {
    try {
      message = JSON.stringify(err, null, 2);
    } catch (e) {
      message = `[${err.constructor.name}]`;
    }
  } else {
    message = err.message || err;
  }

  return { ...err,
    message,
    statusCode: err.statusCode || err.status || err.response && err.response.status || 500
  };
}
/**
 * The main path matching regexp utility.
 *
 * @type {RegExp}
 */

const PATH_REGEXP = new RegExp([// Match escaped characters that would otherwise appear in future matches.
// This allows the user to escape special characters that won't transform.
'(\\\\.)', // Match Express-style parameters and un-named parameters with a prefix
// and optional suffixes. Matches appear as:
//
// "/:test(\\d+)?" => ["/", "test", "\d+", undefined, "?", undefined]
// "/route(\\d+)"  => [undefined, undefined, undefined, "\d+", undefined, undefined]
// "/*"            => ["/", undefined, undefined, undefined, undefined, "*"]
'([\\/.])?(?:(?:\\:(\\w+)(?:\\(((?:\\\\.|[^\\\\()])+)\\))?|\\(((?:\\\\.|[^\\\\()])+)\\))([+*?])?|(\\*))'].join('|'), 'g');
/**
 * Parse a string for the raw tokens.
 *
 * @param  {string}  str
 * @param  {Object=} options
 * @return {!Array}
 */

function parse(str, options) {
  const tokens = [];
  let key = 0;
  let index = 0;
  let path = '';
  const defaultDelimiter = options && options.delimiter || '/';
  let res;

  while ((res = PATH_REGEXP.exec(str)) != null) {
    const m = res[0];
    const escaped = res[1];
    const offset = res.index;
    path += str.slice(index, offset);
    index = offset + m.length; // Ignore already escaped sequences.

    if (escaped) {
      path += escaped[1];
      continue;
    }

    const next = str[index];
    const prefix = res[2];
    const name = res[3];
    const capture = res[4];
    const group = res[5];
    const modifier = res[6];
    const asterisk = res[7]; // Push the current path onto the tokens.

    if (path) {
      tokens.push(path);
      path = '';
    }

    const partial = prefix != null && next != null && next !== prefix;
    const repeat = modifier === '+' || modifier === '*';
    const optional = modifier === '?' || modifier === '*';
    const delimiter = res[2] || defaultDelimiter;
    const pattern = capture || group;
    tokens.push({
      name: name || key++,
      prefix: prefix || '',
      delimiter,
      optional,
      repeat,
      partial,
      asterisk: Boolean(asterisk),
      pattern: pattern ? escapeGroup(pattern) : asterisk ? '.*' : '[^' + escapeString(delimiter) + ']+?'
    });
  } // Match any characters still remaining.


  if (index < str.length) {
    path += str.substr(index);
  } // If the path exists, push it onto the end.


  if (path) {
    tokens.push(path);
  }

  return tokens;
}
/**
 * Prettier encoding of URI path segments.
 *
 * @param  {string}
 * @return {string}
 */


function encodeURIComponentPretty(str, slashAllowed) {
  const re = slashAllowed ? /[?#]/g : /[/?#]/g;
  return encodeURI(str).replace(re, c => {
    return '%' + c.charCodeAt(0).toString(16).toUpperCase();
  });
}
/**
 * Encode the asterisk parameter. Similar to `pretty`, but allows slashes.
 *
 * @param  {string}
 * @return {string}
 */


function encodeAsterisk(str) {
  return encodeURIComponentPretty(str, true);
}
/**
 * Escape a regular expression string.
 *
 * @param  {string} str
 * @return {string}
 */


function escapeString(str) {
  return str.replace(/([.+*?=^!:${}()[\]|/\\])/g, '\\$1');
}
/**
 * Escape the capturing group by escaping special characters and meaning.
 *
 * @param  {string} group
 * @return {string}
 */


function escapeGroup(group) {
  return group.replace(/([=!:$/()])/g, '\\$1');
}
/**
 * Expose a method for transforming tokens into the path function.
 */


function tokensToFunction(tokens, options) {
  // Compile all the tokens into regexps.
  const matches = new Array(tokens.length); // Compile all the patterns before compilation.

  for (let i = 0; i < tokens.length; i++) {
    if (typeof tokens[i] === 'object') {
      matches[i] = new RegExp('^(?:' + tokens[i].pattern + ')$', flags(options));
    }
  }

  return function (obj, opts) {
    let path = '';
    const data = obj || {};
    const options = opts || {};
    const encode = options.pretty ? encodeURIComponentPretty : encodeURIComponent;

    for (let i = 0; i < tokens.length; i++) {
      const token = tokens[i];

      if (typeof token === 'string') {
        path += token;
        continue;
      }

      const value = data[token.name || 'pathMatch'];
      let segment;

      if (value == null) {
        if (token.optional) {
          // Prepend partial segment prefixes.
          if (token.partial) {
            path += token.prefix;
          }

          continue;
        } else {
          throw new TypeError('Expected "' + token.name + '" to be defined');
        }
      }

      if (Array.isArray(value)) {
        if (!token.repeat) {
          throw new TypeError('Expected "' + token.name + '" to not repeat, but received `' + JSON.stringify(value) + '`');
        }

        if (value.length === 0) {
          if (token.optional) {
            continue;
          } else {
            throw new TypeError('Expected "' + token.name + '" to not be empty');
          }
        }

        for (let j = 0; j < value.length; j++) {
          segment = encode(value[j]);

          if (!matches[i].test(segment)) {
            throw new TypeError('Expected all "' + token.name + '" to match "' + token.pattern + '", but received `' + JSON.stringify(segment) + '`');
          }

          path += (j === 0 ? token.prefix : token.delimiter) + segment;
        }

        continue;
      }

      segment = token.asterisk ? encodeAsterisk(value) : encode(value);

      if (!matches[i].test(segment)) {
        throw new TypeError('Expected "' + token.name + '" to match "' + token.pattern + '", but received "' + segment + '"');
      }

      path += token.prefix + segment;
    }

    return path;
  };
}
/**
 * Get the flags for a regexp from the options.
 *
 * @param  {Object} options
 * @return {string}
 */


function flags(options) {
  return options && options.sensitive ? '' : 'i';
}
/**
 * Format given url, append query to url query string
 *
 * @param  {string} url
 * @param  {string} query
 * @return {string}
 */


function formatUrl(url, query) {
  let protocol;
  const index = url.indexOf('://');

  if (index !== -1) {
    protocol = url.substring(0, index);
    url = url.substring(index + 3);
  } else if (url.startsWith('//')) {
    url = url.substring(2);
  }

  let parts = url.split('/');
  let result = (protocol ? protocol + '://' : '//') + parts.shift();
  let path = parts.join('/');

  if (path === '' && parts.length === 1) {
    result += '/';
  }

  let hash;
  parts = path.split('#');

  if (parts.length === 2) {
    [path, hash] = parts;
  }

  result += path ? '/' + path : '';

  if (query && JSON.stringify(query) !== '{}') {
    result += (url.split('?').length === 2 ? '&' : '?') + formatQuery(query);
  }

  result += hash ? '#' + hash : '';
  return result;
}
/**
 * Transform data object to query string
 *
 * @param  {object} query
 * @return {string}
 */


function formatQuery(query) {
  return Object.keys(query).sort().map(key => {
    const val = query[key];

    if (val == null) {
      return '';
    }

    if (Array.isArray(val)) {
      return val.slice().map(val2 => [key, '=', val2].join('')).join('&');
    }

    return key + '=' + val;
  }).filter(Boolean).join('&');
}

function addLifecycleHook(vm, hook, fn) {
  if (!vm.$options[hook]) {
    vm.$options[hook] = [];
  }

  if (!vm.$options[hook].includes(fn)) {
    vm.$options[hook].push(fn);
  }
}
function urlJoin() {
  return [].slice.call(arguments).join('/').replace(/\/+/g, '/').replace(':/', '://');
}
function stripTrailingSlash(path) {
  return path.replace(/\/+$/, '') || '/';
}
function isSamePath(p1, p2) {
  return stripTrailingSlash(p1) === stripTrailingSlash(p2);
}
function setScrollRestoration(newVal) {
  try {
    window.history.scrollRestoration = newVal;
  } catch (e) {}
}
// CONCATENATED MODULE: ./.nuxt/mixins/fetch.server.js



async function serverPrefetch() {
  if (!this._fetchOnServer) {
    return;
  } // Call and await on $fetch


  try {
    await this.$options.fetch.call(this);
  } catch (err) {
    if (false) {}

    this.$fetchState.error = normalizeError(err);
  }

  this.$fetchState.pending = false; // Define an ssrKey for hydration

  this._fetchKey = this.$ssrContext.nuxt.fetch.length; // Add data-fetch-key on parent element of Component

  const attrs = this.$vnode.data.attrs = this.$vnode.data.attrs || {};
  attrs['data-fetch-key'] = this._fetchKey; // Add to ssrContext for window.__NUXT__.fetch

  this.$ssrContext.nuxt.fetch.push(this.$fetchState.error ? {
    _error: this.$fetchState.error
  } : purifyData(this._data));
}

/* harmony default export */ var fetch_server = ({
  created() {
    if (!hasFetch(this)) {
      return;
    }

    if (typeof this.$options.fetchOnServer === 'function') {
      this._fetchOnServer = this.$options.fetchOnServer.call(this) !== false;
    } else {
      this._fetchOnServer = this.$options.fetchOnServer !== false;
    } // Added for remove vue undefined warning while ssr


    this.$fetch = () => {}; // issue #8043


    external_vue_default.a.util.defineReactive(this, '$fetchState', {
      pending: true,
      error: null,
      timestamp: Date.now()
    });
    addLifecycleHook(this, 'serverPrefetch', serverPrefetch);
  }

});
// EXTERNAL MODULE: external "vuex"
var external_vuex_ = __webpack_require__(2);
var external_vuex_default = /*#__PURE__*/__webpack_require__.n(external_vuex_);

// EXTERNAL MODULE: external "vue-meta"
var external_vue_meta_ = __webpack_require__(19);
var external_vue_meta_default = /*#__PURE__*/__webpack_require__.n(external_vue_meta_);

// EXTERNAL MODULE: external "vue-client-only"
var external_vue_client_only_ = __webpack_require__(13);
var external_vue_client_only_default = /*#__PURE__*/__webpack_require__.n(external_vue_client_only_);

// EXTERNAL MODULE: external "vue-no-ssr"
var external_vue_no_ssr_ = __webpack_require__(9);
var external_vue_no_ssr_default = /*#__PURE__*/__webpack_require__.n(external_vue_no_ssr_);

// EXTERNAL MODULE: external "vue-router"
var external_vue_router_ = __webpack_require__(7);
var external_vue_router_default = /*#__PURE__*/__webpack_require__.n(external_vue_router_);

// CONCATENATED MODULE: ./.nuxt/router.scrollBehavior.js


if (false) {}

/* harmony default export */ var router_scrollBehavior = (function (to, from, savedPosition) {
  // If the returned position is falsy or an empty object, will retain current scroll position
  let position = false;
  const Pages = getMatchedComponents(to); // Scroll to the top of the page if...

  if ( // One of the children set `scrollToTop`
  Pages.some(Page => Page.options.scrollToTop) || // scrollToTop set in only page without children
  Pages.length < 2 && Pages.every(Page => Page.options.scrollToTop !== false)) {
    position = {
      x: 0,
      y: 0
    };
  } // savedPosition is only available for popstate navigations (back button)


  if (savedPosition) {
    position = savedPosition;
  }

  const nuxt = window.$nuxt;

  if ( // Route hash changes
  to.path === from.path && to.hash !== from.hash || // Initial load (vuejs/vue-router#3199)
  to === from) {
    nuxt.$nextTick(() => nuxt.$emit('triggerScroll'));
  }

  return new Promise(resolve => {
    // wait for the out transition to complete (if necessary)
    nuxt.$once('triggerScroll', () => {
      // coords will be used if no selector is provided,
      // or if the selector didn't match any element.
      if (to.hash) {
        let hash = to.hash; // CSS.escape() is not supported with IE and Edge.

        if (typeof window.CSS !== 'undefined' && typeof window.CSS.escape !== 'undefined') {
          hash = '#' + window.CSS.escape(hash.substr(1));
        }

        try {
          if (document.querySelector(hash)) {
            // scroll to anchor by returning the selector
            position = {
              selector: hash
            };
          }
        } catch (e) {
          console.warn('Failed to save scroll position. Please add CSS.escape() polyfill (https://github.com/mathiasbynens/CSS.escape).');
        }
      }

      resolve(position);
    });
  });
});
// CONCATENATED MODULE: ./.nuxt/router.js






const _0d981dd8 = () => interopDefault(__webpack_require__.e(/* import() | pages/blog/index */ 2).then(__webpack_require__.bind(null, 51)));

const _9fc70ab8 = () => interopDefault(__webpack_require__.e(/* import() | pages/executors/index */ 4).then(__webpack_require__.bind(null, 52)));

const _0f1f5a52 = () => interopDefault(__webpack_require__.e(/* import() | pages/orders/index */ 6).then(__webpack_require__.bind(null, 53)));

const _5973287c = () => interopDefault(__webpack_require__.e(/* import() | pages/blog/_id */ 1).then(__webpack_require__.bind(null, 54)));

const _fdde53e8 = () => interopDefault(__webpack_require__.e(/* import() | pages/executors/_id */ 3).then(__webpack_require__.bind(null, 55)));

const _5410899a = () => interopDefault(__webpack_require__.e(/* import() | pages/index */ 5).then(__webpack_require__.bind(null, 56))); // TODO: remove in Nuxt 3


const emptyFn = () => {};

const originalPush = external_vue_router_default.a.prototype.push;

external_vue_router_default.a.prototype.push = function push(location, onComplete = emptyFn, onAbort) {
  return originalPush.call(this, location, onComplete, onAbort);
};

external_vue_default.a.use(external_vue_router_default.a);
const routerOptions = {
  mode: 'history',
  base: '/',
  linkActiveClass: 'nuxt-link-active',
  linkExactActiveClass: 'nuxt-link-exact-active',
  scrollBehavior: router_scrollBehavior,
  routes: [{
    path: "/blog",
    component: _0d981dd8,
    name: "blog"
  }, {
    path: "/executors",
    component: _9fc70ab8,
    name: "executors"
  }, {
    path: "/orders",
    component: _0f1f5a52,
    name: "orders"
  }, {
    path: "/blog/:id",
    component: _5973287c,
    name: "blog-id"
  }, {
    path: "/executors/:id",
    component: _fdde53e8,
    name: "executors-id"
  }, {
    path: "/",
    component: _5410899a,
    name: "index"
  }],
  fallback: false
};

function decodeObj(obj) {
  for (const key in obj) {
    if (typeof obj[key] === 'string') {
      obj[key] = Object(ufo_["decode"])(obj[key]);
    }
  }
}

function createRouter() {
  const router = new external_vue_router_default.a(routerOptions);
  const resolve = router.resolve.bind(router);

  router.resolve = (to, current, append) => {
    if (typeof to === 'string') {
      to = Object(ufo_["normalizeURL"])(to);
    }

    const r = resolve(to, current, append);

    if (r && r.resolved && r.resolved.query) {
      decodeObj(r.resolved.query);
    }

    return r;
  };

  return router;
}
// CONCATENATED MODULE: ./.nuxt/components/nuxt-child.js
/* harmony default export */ var nuxt_child = ({
  name: 'NuxtChild',
  functional: true,
  props: {
    nuxtChildKey: {
      type: String,
      default: ''
    },
    keepAlive: Boolean,
    keepAliveProps: {
      type: Object,
      default: undefined
    }
  },

  render(_, {
    parent,
    data,
    props
  }) {
    const h = parent.$createElement;
    data.nuxtChild = true;
    const _parent = parent;
    const transitions = parent.$nuxt.nuxt.transitions;
    const defaultTransition = parent.$nuxt.nuxt.defaultTransition;
    let depth = 0;

    while (parent) {
      if (parent.$vnode && parent.$vnode.data.nuxtChild) {
        depth++;
      }

      parent = parent.$parent;
    }

    data.nuxtChildDepth = depth;
    const transition = transitions[depth] || defaultTransition;
    const transitionProps = {};
    transitionsKeys.forEach(key => {
      if (typeof transition[key] !== 'undefined') {
        transitionProps[key] = transition[key];
      }
    });
    const listeners = {};
    listenersKeys.forEach(key => {
      if (typeof transition[key] === 'function') {
        listeners[key] = transition[key].bind(_parent);
      }
    });

    if (false) {} // make sure that leave is called asynchronous (fix #5703)


    if (transition.css === false) {
      const leave = listeners.leave; // only add leave listener when user didnt provide one
      // or when it misses the done argument

      if (!leave || leave.length < 2) {
        listeners.leave = (el, done) => {
          if (leave) {
            leave.call(_parent, el);
          }

          _parent.$nextTick(done);
        };
      }
    }

    let routerView = h('routerView', data);

    if (props.keepAlive) {
      routerView = h('keep-alive', {
        props: props.keepAliveProps
      }, [routerView]);
    }

    return h('transition', {
      props: transitionProps,
      on: listeners
    }, [routerView]);
  }

});
const transitionsKeys = ['name', 'mode', 'appear', 'css', 'type', 'duration', 'enterClass', 'leaveClass', 'appearClass', 'enterActiveClass', 'enterActiveClass', 'leaveActiveClass', 'appearActiveClass', 'enterToClass', 'leaveToClass', 'appearToClass'];
const listenersKeys = ['beforeEnter', 'enter', 'afterEnter', 'enterCancelled', 'beforeLeave', 'leave', 'afterLeave', 'leaveCancelled', 'beforeAppear', 'appear', 'afterAppear', 'appearCancelled'];
// CONCATENATED MODULE: ./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/@nuxt/components/dist/loader.js??ref--0-0!./node_modules/vue-loader/lib??vue-loader-options!./layouts/error.vue?vue&type=template&id=912ed0bc&
var render = function () {var _vm=this;var _h=_vm.$createElement;var _c=_vm._self._c||_h;return _c('div',{staticClass:"container error-page"},[_vm._ssrNode("<div class=\"error-block\">","</div>",[_vm._ssrNode(_vm._ssrEscape("\n    "+_vm._s(_vm.error.message)+".")+"<br> "),_c('nuxt-link',{attrs:{"to":"/"}},[_vm._v("Вернуться главную")])],2)])}
var staticRenderFns = []


// CONCATENATED MODULE: ./layouts/error.vue?vue&type=template&id=912ed0bc&

// CONCATENATED MODULE: ./node_modules/babel-loader/lib??ref--2-0!./node_modules/@nuxt/components/dist/loader.js??ref--0-0!./node_modules/vue-loader/lib??vue-loader-options!./layouts/error.vue?vue&type=script&lang=js&
//
//
//
//
//
//
//
//
/* harmony default export */ var errorvue_type_script_lang_js_ = ({
  // eslint-disable-next-line vue/require-prop-types
  props: ['error'],
  layout: 'error' // you can set a custom layout for the error page

});
// CONCATENATED MODULE: ./layouts/error.vue?vue&type=script&lang=js&
 /* harmony default export */ var layouts_errorvue_type_script_lang_js_ = (errorvue_type_script_lang_js_); 
// EXTERNAL MODULE: ./node_modules/vue-loader/lib/runtime/componentNormalizer.js
var componentNormalizer = __webpack_require__(1);

// CONCATENATED MODULE: ./layouts/error.vue





/* normalize component */

var error_component = Object(componentNormalizer["a" /* default */])(
  layouts_errorvue_type_script_lang_js_,
  render,
  staticRenderFns,
  false,
  null,
  null,
  "30b4a935"
  
)

/* harmony default export */ var layouts_error = (error_component.exports);
// CONCATENATED MODULE: ./.nuxt/components/nuxt.js




/* harmony default export */ var components_nuxt = ({
  name: 'Nuxt',
  components: {
    NuxtChild: nuxt_child,
    NuxtError: layouts_error
  },
  props: {
    nuxtChildKey: {
      type: String,
      default: undefined
    },
    keepAlive: Boolean,
    keepAliveProps: {
      type: Object,
      default: undefined
    },
    name: {
      type: String,
      default: 'default'
    }
  },

  errorCaptured(error) {
    // if we receive and error while showing the NuxtError component
    // capture the error and force an immediate update so we re-render
    // without the NuxtError component
    if (this.displayingNuxtError) {
      this.errorFromNuxtError = error;
      this.$forceUpdate();
    }
  },

  computed: {
    routerViewKey() {
      // If nuxtChildKey prop is given or current route has children
      if (typeof this.nuxtChildKey !== 'undefined' || this.$route.matched.length > 1) {
        return this.nuxtChildKey || compile(this.$route.matched[0].path)(this.$route.params);
      }

      const [matchedRoute] = this.$route.matched;

      if (!matchedRoute) {
        return this.$route.path;
      }

      const Component = matchedRoute.components.default;

      if (Component && Component.options) {
        const {
          options
        } = Component;

        if (options.key) {
          return typeof options.key === 'function' ? options.key(this.$route) : options.key;
        }
      }

      const strict = /\/$/.test(matchedRoute.path);
      return strict ? this.$route.path : this.$route.path.replace(/\/$/, '');
    }

  },

  beforeCreate() {
    external_vue_default.a.util.defineReactive(this, 'nuxt', this.$root.$options.nuxt);
  },

  render(h) {
    // if there is no error
    if (!this.nuxt.err) {
      // Directly return nuxt child
      return h('NuxtChild', {
        key: this.routerViewKey,
        props: this.$props
      });
    } // if an error occurred within NuxtError show a simple
    // error message instead to prevent looping


    if (this.errorFromNuxtError) {
      this.$nextTick(() => this.errorFromNuxtError = false);
      return h('div', {}, [h('h2', 'An error occurred while showing the error page'), h('p', 'Unfortunately an error occurred and while showing the error page another error occurred'), h('p', `Error details: ${this.errorFromNuxtError.toString()}`), h('nuxt-link', {
        props: {
          to: '/'
        }
      }, 'Go back to home')]);
    } // track if we are showing the NuxtError component


    this.displayingNuxtError = true;
    this.$nextTick(() => this.displayingNuxtError = false);
    return h(layouts_error, {
      props: {
        error: this.nuxt.err
      }
    });
  }

});
// CONCATENATED MODULE: ./node_modules/babel-loader/lib??ref--2-0!./node_modules/@nuxt/components/dist/loader.js??ref--0-0!./node_modules/vue-loader/lib??vue-loader-options!./.nuxt/components/nuxt-loading.vue?vue&type=script&lang=js&
/* harmony default export */ var nuxt_loadingvue_type_script_lang_js_ = ({
  name: 'NuxtLoading',

  data() {
    return {
      percent: 0,
      show: false,
      canSucceed: true,
      reversed: false,
      skipTimerCount: 0,
      rtl: false,
      throttle: 200,
      duration: 5000,
      continuous: false
    };
  },

  computed: {
    left() {
      if (!this.continuous && !this.rtl) {
        return false;
      }

      return this.rtl ? this.reversed ? '0px' : 'auto' : !this.reversed ? '0px' : 'auto';
    }

  },

  beforeDestroy() {
    this.clear();
  },

  methods: {
    clear() {
      clearInterval(this._timer);
      clearTimeout(this._throttle);
      this._timer = null;
    },

    start() {
      this.clear();
      this.percent = 0;
      this.reversed = false;
      this.skipTimerCount = 0;
      this.canSucceed = true;

      if (this.throttle) {
        this._throttle = setTimeout(() => this.startTimer(), this.throttle);
      } else {
        this.startTimer();
      }

      return this;
    },

    set(num) {
      this.show = true;
      this.canSucceed = true;
      this.percent = Math.min(100, Math.max(0, Math.floor(num)));
      return this;
    },

    get() {
      return this.percent;
    },

    increase(num) {
      this.percent = Math.min(100, Math.floor(this.percent + num));
      return this;
    },

    decrease(num) {
      this.percent = Math.max(0, Math.floor(this.percent - num));
      return this;
    },

    pause() {
      clearInterval(this._timer);
      return this;
    },

    resume() {
      this.startTimer();
      return this;
    },

    finish() {
      this.percent = this.reversed ? 0 : 100;
      this.hide();
      return this;
    },

    hide() {
      this.clear();
      setTimeout(() => {
        this.show = false;
        this.$nextTick(() => {
          this.percent = 0;
          this.reversed = false;
        });
      }, 500);
      return this;
    },

    fail(error) {
      this.canSucceed = false;
      return this;
    },

    startTimer() {
      if (!this.show) {
        this.show = true;
      }

      if (typeof this._cut === 'undefined') {
        this._cut = 10000 / Math.floor(this.duration);
      }

      this._timer = setInterval(() => {
        /**
         * When reversing direction skip one timers
         * so 0, 100 are displayed for two iterations
         * also disable css width transitioning
         * which otherwise interferes and shows
         * a jojo effect
         */
        if (this.skipTimerCount > 0) {
          this.skipTimerCount--;
          return;
        }

        if (this.reversed) {
          this.decrease(this._cut);
        } else {
          this.increase(this._cut);
        }

        if (this.continuous) {
          if (this.percent >= 100) {
            this.skipTimerCount = 1;
            this.reversed = !this.reversed;
          } else if (this.percent <= 0) {
            this.skipTimerCount = 1;
            this.reversed = !this.reversed;
          }
        }
      }, 100);
    }

  },

  render(h) {
    let el = h(false);

    if (this.show) {
      el = h('div', {
        staticClass: 'nuxt-progress',
        class: {
          'nuxt-progress-notransition': this.skipTimerCount > 0,
          'nuxt-progress-failed': !this.canSucceed
        },
        style: {
          width: this.percent + '%',
          left: this.left
        }
      });
    }

    return el;
  }

});
// CONCATENATED MODULE: ./.nuxt/components/nuxt-loading.vue?vue&type=script&lang=js&
 /* harmony default export */ var components_nuxt_loadingvue_type_script_lang_js_ = (nuxt_loadingvue_type_script_lang_js_); 
// CONCATENATED MODULE: ./.nuxt/components/nuxt-loading.vue
var nuxt_loading_render, nuxt_loading_staticRenderFns


function injectStyles (context) {
  
  var style0 = __webpack_require__(24)
if (style0.__inject__) style0.__inject__(context)

}

/* normalize component */

var nuxt_loading_component = Object(componentNormalizer["a" /* default */])(
  components_nuxt_loadingvue_type_script_lang_js_,
  nuxt_loading_render,
  nuxt_loading_staticRenderFns,
  false,
  injectStyles,
  null,
  "3016a1a0"
  
)

/* harmony default export */ var nuxt_loading = (nuxt_loading_component.exports);
// EXTERNAL MODULE: ./assets/scss/main.scss
var main = __webpack_require__(26);

// EXTERNAL MODULE: ./node_modules/prismjs/themes/prism.css
var prism = __webpack_require__(39);

// CONCATENATED MODULE: ./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/@nuxt/components/dist/loader.js??ref--0-0!./node_modules/vue-loader/lib??vue-loader-options!./layouts/default.vue?vue&type=template&id=2950b2eb&
var defaultvue_type_template_id_2950b2eb_render = function () {var _vm=this;var _h=_vm.$createElement;var _c=_vm._self._c||_h;return _c('div',{staticClass:"wrap"},[_c('TheHeader'),_vm._ssrNode(" "),_c('Nuxt'),_vm._ssrNode(" "),_c('TheFooter')],2)}
var defaultvue_type_template_id_2950b2eb_staticRenderFns = []


// CONCATENATED MODULE: ./layouts/default.vue?vue&type=template&id=2950b2eb&

// EXTERNAL MODULE: ./mixins/global.js
var mixins_global = __webpack_require__(14);

// EXTERNAL MODULE: ./components/TheHeader.vue + 4 modules
var TheHeader = __webpack_require__(4);

// EXTERNAL MODULE: ./components/TheFooter.vue + 4 modules
var TheFooter = __webpack_require__(5);

// CONCATENATED MODULE: ./node_modules/babel-loader/lib??ref--2-0!./node_modules/@nuxt/components/dist/loader.js??ref--0-0!./node_modules/vue-loader/lib??vue-loader-options!./layouts/default.vue?vue&type=script&lang=js&
//
//
//
//
//
//
//




external_vue_default.a.mixin(mixins_global["a" /* default */]);
/* harmony default export */ var defaultvue_type_script_lang_js_ = ({
  components: {
    TheHeader: TheHeader["default"],
    TheFooter: TheFooter["default"]
  }
});
// CONCATENATED MODULE: ./layouts/default.vue?vue&type=script&lang=js&
 /* harmony default export */ var layouts_defaultvue_type_script_lang_js_ = (defaultvue_type_script_lang_js_); 
// CONCATENATED MODULE: ./layouts/default.vue





/* normalize component */

var default_component = Object(componentNormalizer["a" /* default */])(
  layouts_defaultvue_type_script_lang_js_,
  defaultvue_type_template_id_2950b2eb_render,
  defaultvue_type_template_id_2950b2eb_staticRenderFns,
  false,
  null,
  null,
  "404d17ae"
  
)

/* harmony default export */ var layouts_default = (default_component.exports);

/* nuxt-component-imports */
installComponents(default_component, {TheHeader: __webpack_require__(4).default,TheFooter: __webpack_require__(5).default})

// CONCATENATED MODULE: ./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/@nuxt/components/dist/loader.js??ref--0-0!./node_modules/vue-loader/lib??vue-loader-options!./layouts/home.vue?vue&type=template&id=a9484654&
var homevue_type_template_id_a9484654_render = function () {var _vm=this;var _h=_vm.$createElement;var _c=_vm._self._c||_h;return _c('div',{staticClass:"wrapper",attrs:{"id":"wrapper"}},[_c('TheHeader'),_vm._ssrNode(" "),_c('TheMain',[_c('Nuxt'),_vm._v(" "),_c('TheFooter')],1)],2)}
var homevue_type_template_id_a9484654_staticRenderFns = []


// CONCATENATED MODULE: ./layouts/home.vue?vue&type=template&id=a9484654&

// EXTERNAL MODULE: ./components/TheMain.vue + 4 modules
var TheMain = __webpack_require__(12);

// CONCATENATED MODULE: ./node_modules/babel-loader/lib??ref--2-0!./node_modules/@nuxt/components/dist/loader.js??ref--0-0!./node_modules/vue-loader/lib??vue-loader-options!./layouts/home.vue?vue&type=script&lang=js&
//
//
//
//
//
//
//
//
//
//



/* harmony default export */ var homevue_type_script_lang_js_ = ({
  name: 'Home',
  components: {
    TheMain: TheMain["default"],
    TheHeader: TheHeader["default"],
    TheFooter: TheFooter["default"]
  }
});
// CONCATENATED MODULE: ./layouts/home.vue?vue&type=script&lang=js&
 /* harmony default export */ var layouts_homevue_type_script_lang_js_ = (homevue_type_script_lang_js_); 
// CONCATENATED MODULE: ./layouts/home.vue





/* normalize component */

var home_component = Object(componentNormalizer["a" /* default */])(
  layouts_homevue_type_script_lang_js_,
  homevue_type_template_id_a9484654_render,
  homevue_type_template_id_a9484654_staticRenderFns,
  false,
  null,
  null,
  "172e5e7c"
  
)

/* harmony default export */ var home = (home_component.exports);

/* nuxt-component-imports */
installComponents(home_component, {TheHeader: __webpack_require__(4).default,TheFooter: __webpack_require__(5).default,TheMain: __webpack_require__(12).default})

// CONCATENATED MODULE: ./.nuxt/App.js








const layouts = {
  "_default": sanitizeComponent(layouts_default),
  "_home": sanitizeComponent(home)
};
/* harmony default export */ var App = ({
  render(h, props) {
    const loadingEl = h('NuxtLoading', {
      ref: 'loading'
    });
    const layoutEl = h(this.layout || 'nuxt');
    const templateEl = h('div', {
      domProps: {
        id: '__layout'
      },
      key: this.layoutName
    }, [layoutEl]);
    const transitionEl = h('transition', {
      props: {
        name: 'layout',
        mode: 'out-in'
      },
      on: {
        beforeEnter(el) {
          // Ensure to trigger scroll event after calling scrollBehavior
          window.$nuxt.$nextTick(() => {
            window.$nuxt.$emit('triggerScroll');
          });
        }

      }
    }, [templateEl]);
    return h('div', {
      domProps: {
        id: '__nuxt'
      }
    }, [loadingEl, transitionEl]);
  },

  data: () => ({
    isOnline: true,
    layout: null,
    layoutName: '',
    nbFetching: 0
  }),

  beforeCreate() {
    external_vue_default.a.util.defineReactive(this, 'nuxt', this.$options.nuxt);
  },

  created() {
    // Add this.$nuxt in child instances
    this.$root.$options.$nuxt = this;

    if (false) {} // Add $nuxt.error()


    this.error = this.nuxt.error; // Add $nuxt.context

    this.context = this.$options.context;
  },

  async mounted() {
    this.$loading = this.$refs.loading;
  },

  watch: {
    'nuxt.err': 'errorChanged'
  },
  computed: {
    isOffline() {
      return !this.isOnline;
    },

    isFetching() {
      return this.nbFetching > 0;
    }

  },
  methods: {
    refreshOnlineStatus() {
      if (false) {}
    },

    async refresh() {
      const pages = getMatchedComponentsInstances(this.$route);

      if (!pages.length) {
        return;
      }

      this.$loading.start();
      const promises = pages.map(page => {
        const p = []; // Old fetch

        if (page.$options.fetch && page.$options.fetch.length) {
          p.push(promisify(page.$options.fetch, this.context));
        }

        if (page.$fetch) {
          p.push(page.$fetch());
        } else {
          // Get all component instance to call $fetch
          for (const component of getChildrenComponentInstancesUsingFetch(page.$vnode.componentInstance)) {
            p.push(component.$fetch());
          }
        }

        if (page.$options.asyncData) {
          p.push(promisify(page.$options.asyncData, this.context).then(newData => {
            for (const key in newData) {
              external_vue_default.a.set(page.$data, key, newData[key]);
            }
          }));
        }

        return Promise.all(p);
      });

      try {
        await Promise.all(promises);
      } catch (error) {
        this.$loading.fail(error);
        globalHandleError(error);
        this.error(error);
      }

      this.$loading.finish();
    },

    errorChanged() {
      if (this.nuxt.err) {
        if (this.$loading) {
          if (this.$loading.fail) {
            this.$loading.fail(this.nuxt.err);
          }

          if (this.$loading.finish) {
            this.$loading.finish();
          }
        }

        let errorLayout = (layouts_error.options || layouts_error).layout;

        if (typeof errorLayout === 'function') {
          errorLayout = errorLayout(this.context);
        }

        this.setLayout(errorLayout);
      }
    },

    setLayout(layout) {
      if (!layout || !layouts['_' + layout]) {
        layout = 'default';
      }

      this.layoutName = layout;
      this.layout = layouts['_' + layout];
      return this.layout;
    },

    loadLayout(layout) {
      if (!layout || !layouts['_' + layout]) {
        layout = 'default';
      }

      return Promise.resolve(layouts['_' + layout]);
    }

  },
  components: {
    NuxtLoading: nuxt_loading
  }
});
// CONCATENATED MODULE: ./.nuxt/store.js


external_vue_default.a.use(external_vuex_default.a);
const VUEX_PROPERTIES = ['state', 'getters', 'actions', 'mutations'];
let store_store = {};

(function updateModules() {
  store_store = normalizeRoot(__webpack_require__(41), 'store/index.js'); // If store is an exported method = classic mode (deprecated)
  // Enforce store modules

  store_store.modules = store_store.modules || {};
  resolveStoreModules(__webpack_require__(42), 'contacts.js'); // If the environment supports hot reloading...
})(); // createStore


const createStore = store_store instanceof Function ? store_store : () => {
  return new external_vuex_default.a.Store(Object.assign({
    strict: "production" !== 'production'
  }, store_store));
};

function normalizeRoot(moduleData, filePath) {
  moduleData = moduleData.default || moduleData;

  if (moduleData.commit) {
    throw new Error(`[nuxt] ${filePath} should export a method that returns a Vuex instance.`);
  }

  if (typeof moduleData !== 'function') {
    // Avoid TypeError: setting a property that has only a getter when overwriting top level keys
    moduleData = Object.assign({}, moduleData);
  }

  return normalizeModule(moduleData, filePath);
}

function normalizeModule(moduleData, filePath) {
  if (moduleData.state && typeof moduleData.state !== 'function') {
    console.warn(`'state' should be a method that returns an object in ${filePath}`);
    const state = Object.assign({}, moduleData.state); // Avoid TypeError: setting a property that has only a getter when overwriting top level keys

    moduleData = Object.assign({}, moduleData, {
      state: () => state
    });
  }

  return moduleData;
}

function resolveStoreModules(moduleData, filename) {
  moduleData = moduleData.default || moduleData; // Remove store src + extension (./foo/index.js -> foo/index)

  const namespace = filename.replace(/\.(js|mjs)$/, '');
  const namespaces = namespace.split('/');
  let moduleName = namespaces[namespaces.length - 1];
  const filePath = `store/${filename}`;
  moduleData = moduleName === 'state' ? normalizeState(moduleData, filePath) : normalizeModule(moduleData, filePath); // If src is a known Vuex property

  if (VUEX_PROPERTIES.includes(moduleName)) {
    const property = moduleName;
    const propertyStoreModule = getStoreModule(store_store, namespaces, {
      isProperty: true
    }); // Replace state since it's a function

    mergeProperty(propertyStoreModule, moduleData, property);
    return;
  } // If file is foo/index.js, it should be saved as foo


  const isIndexModule = moduleName === 'index';

  if (isIndexModule) {
    namespaces.pop();
    moduleName = namespaces[namespaces.length - 1];
  }

  const storeModule = getStoreModule(store_store, namespaces);

  for (const property of VUEX_PROPERTIES) {
    mergeProperty(storeModule, moduleData[property], property);
  }

  if (moduleData.namespaced === false) {
    delete storeModule.namespaced;
  }
}

function normalizeState(moduleData, filePath) {
  if (typeof moduleData !== 'function') {
    console.warn(`${filePath} should export a method that returns an object`);
    const state = Object.assign({}, moduleData);
    return () => state;
  }

  return normalizeModule(moduleData, filePath);
}

function getStoreModule(storeModule, namespaces, {
  isProperty = false
} = {}) {
  // If ./mutations.js
  if (!namespaces.length || isProperty && namespaces.length === 1) {
    return storeModule;
  }

  const namespace = namespaces.shift();
  storeModule.modules[namespace] = storeModule.modules[namespace] || {};
  storeModule.modules[namespace].namespaced = true;
  storeModule.modules[namespace].modules = storeModule.modules[namespace].modules || {};
  return getStoreModule(storeModule.modules[namespace], namespaces, {
    isProperty
  });
}

function mergeProperty(storeModule, moduleData, property) {
  if (!moduleData) {
    return;
  }

  if (property === 'state') {
    storeModule.state = moduleData || storeModule.state;
  } else {
    storeModule[property] = Object.assign({}, storeModule[property], moduleData);
  }
}
// CONCATENATED MODULE: ./.nuxt/components/plugin.js

const globalComponents = {};

for (const name in globalComponents) {
  external_vue_default.a.component(name, globalComponents[name]);
}
// EXTERNAL MODULE: ./.nuxt/empty.js
var _nuxt_empty = __webpack_require__(16);

// CONCATENATED MODULE: ./.nuxt/content/nuxt-content.js
const info = __webpack_require__(43);

const rootKeys = ['class-name', 'class', 'style'];
const rxOn = /^@|^v-on:/;
const rxBind = /^:|^v-bind:/;
const rxModel = /^v-model/;
const nativeInputs = ['select', 'textarea', 'input'];

function evalInContext(code, context) {
  return new Function("with(this) { return (" + code + ") }").call(context);
}

function propsToData(node, doc) {
  const {
    tag,
    props
  } = node;
  return Object.keys(props).reduce(function (data, key) {
    const k = key.replace(/.*:/, '');
    let obj = rootKeys.includes(k) ? data : data.attrs;
    const value = props[key];
    const {
      attribute
    } = info.find(info.html, key);
    const native = nativeInputs.includes(tag);

    if (rxModel.test(key) && value in doc && !native) {
      const mods = key.replace(rxModel, '').split('.').filter(d => d).reduce((d, k) => (d[k] = true, d), {}); // As of yet we don't resolve custom v-model field/event names from components

      const field = 'value';
      const event = mods.lazy ? 'change' : 'input';
      const processor = mods.number ? d => +d : mods.trim ? d => d.trim() : d => d;
      obj[field] = evalInContext(value, doc);
      data.on = data.on || {};

      data.on[event] = e => doc[value] = processor(e);
    } else if (key === 'v-bind') {
      const val = value in doc ? doc[value] : evalInContext(value, doc);
      obj = Object.assign(obj, val);
    } else if (rxOn.test(key)) {
      key = key.replace(rxOn, '');
      data.on = data.on || {};
      data.on[key] = evalInContext(value, doc);
    } else if (rxBind.test(key)) {
      key = key.replace(rxBind, '');
      obj[key] = value in doc ? doc[value] : evalInContext(value, doc);
    } else if (Array.isArray(value)) {
      obj[attribute] = value.join(' ');
    } else {
      obj[attribute] = value;
    }

    return data;
  }, {
    attrs: {}
  });
}
/**
 * Create the scoped slots from `node` template children. Templates for default
 * slots are processed as regular children in `processNode`.
 */


function slotsToData(node, h, doc) {
  const data = {};
  const children = node.children || [];
  children.forEach(child => {
    // Regular children and default templates are processed inside `processNode`.
    if (!isTemplate(child) || isDefaultTemplate(child)) {
      return;
    } // Non-default templates are converted into slots.


    data.scopedSlots = data.scopedSlots || {};
    const template = child;
    const name = getSlotName(template);
    const vDomTree = template.content.map(tmplNode => processNode(tmplNode, h, doc));

    data.scopedSlots[name] = function () {
      return vDomTree;
    };
  });
  return data;
}

function processNode(node, h, doc) {
  /**
   * Return raw value as it is
   */
  if (node.type === 'text') {
    return node.value;
  }

  const slotData = slotsToData(node || {}, h, doc);
  const propData = propsToData(node || {}, doc);
  const data = Object.assign({}, slotData, propData);
  /**
   * Process child nodes, flat-mapping templates pointing to default slots.
   */

  const children = [];

  for (const child of node.children) {
    // Template nodes pointing to non-default slots are processed inside `slotsToData`.
    if (isTemplate(child) && !isDefaultTemplate(child)) {
      continue;
    }

    const processQueue = isDefaultTemplate(child) ? child.content : [child];
    children.push(...processQueue.map(node => processNode(node, h, doc)));
  }

  return h(node.tag, data, children);
}

const DEFAULT_SLOT = 'default';

function isDefaultTemplate(node) {
  return isTemplate(node) && getSlotName(node) === DEFAULT_SLOT;
}

function isTemplate(node) {
  return node.tag === 'template';
}

function getSlotName(node) {
  let name = '';

  for (const propName of Object.keys(node.props)) {
    if (!propName.startsWith('#') && !propName.startsWith('v-slot:')) {
      continue;
    }

    name = propName.split(/[:#]/, 2)[1];
    break;
  }

  return name || DEFAULT_SLOT;
}

/* harmony default export */ var nuxt_content = ({
  name: 'NuxtContent',
  functional: true,
  props: {
    document: {
      required: true
    }
  },

  render(h, {
    data,
    props
  }) {
    const {
      document
    } = props;
    const {
      body
    } = document || {};

    if (!body || !body.children || !Array.isArray(body.children)) {
      return;
    }

    let classes = [];

    if (Array.isArray(data.class)) {
      classes = data.class;
    } else if (typeof data.class === 'object') {
      const keys = Object.keys(data.class);
      classes = keys.filter(key => data.class[key]);
    } else {
      classes = [data.class];
    }

    data.class = classes.concat('nuxt-content');
    data.props = Object.assign({ ...body.props
    }, data.props);
    return h('div', data, body.children.map(child => processNode(child, h, document)));
  }

});
// CONCATENATED MODULE: ./.nuxt/content/plugin.server.js


external_vue_default.a.component(nuxt_content.name, nuxt_content);
/* harmony default export */ var plugin_server = ((ctx, inject) => {
  const $content = ctx.ssrContext.$content;
  inject('content', $content);
  ctx.$content = $content;
});
// CONCATENATED MODULE: ./.nuxt/pwa/meta.utils.js
function mergeMeta(to, from) {
  if (typeof to === 'function') {
    // eslint-disable-next-line no-console
    console.warn('Cannot merge meta. Avoid using head as a function!');
    return;
  }

  for (const key in from) {
    const value = from[key];

    if (Array.isArray(value)) {
      to[key] = to[key] || [];

      for (const item of value) {
        // Avoid duplicates
        if (item.hid && hasMeta(to[key], 'hid', item.hid) || item.name && hasMeta(to[key], 'name', item.name)) {
          continue;
        } // Add meta


        to[key].push(item);
      }
    } else if (typeof value === 'object') {
      to[key] = to[key] || {};

      for (const attr in value) {
        to[key][attr] = value[attr];
      }
    } else if (to[key] === undefined) {
      to[key] = value;
    }
  }
}

function hasMeta(arr, key, val) {
  return arr.find(obj => val ? obj[key] === val : obj[key]);
}
// EXTERNAL MODULE: ./.nuxt/pwa/meta.json
var meta = __webpack_require__(20);

// CONCATENATED MODULE: ./.nuxt/pwa/meta.plugin.js


/* harmony default export */ var meta_plugin = (function ({
  app
}) {
  mergeMeta(app.head, meta);
});
// CONCATENATED MODULE: ./.nuxt/pwa/icon.plugin.js
/* harmony default export */ var icon_plugin = (async function (ctx, inject) {
  const icons = {
    "64x64": "/_nuxt/icons/icon_64x64.6cd800.png",
    "120x120": "/_nuxt/icons/icon_120x120.6cd800.png",
    "144x144": "/_nuxt/icons/icon_144x144.6cd800.png",
    "152x152": "/_nuxt/icons/icon_152x152.6cd800.png",
    "192x192": "/_nuxt/icons/icon_192x192.6cd800.png",
    "384x384": "/_nuxt/icons/icon_384x384.6cd800.png",
    "512x512": "/_nuxt/icons/icon_512x512.6cd800.png",
    "ipad_1536x2048": "/_nuxt/icons/splash_ipad_1536x2048.6cd800.png",
    "ipadpro9_1536x2048": "/_nuxt/icons/splash_ipadpro9_1536x2048.6cd800.png",
    "ipadpro10_1668x2224": "/_nuxt/icons/splash_ipadpro10_1668x2224.6cd800.png",
    "ipadpro12_2048x2732": "/_nuxt/icons/splash_ipadpro12_2048x2732.6cd800.png",
    "iphonese_640x1136": "/_nuxt/icons/splash_iphonese_640x1136.6cd800.png",
    "iphone6_50x1334": "/_nuxt/icons/splash_iphone6_50x1334.6cd800.png",
    "iphoneplus_1080x1920": "/_nuxt/icons/splash_iphoneplus_1080x1920.6cd800.png",
    "iphonex_1125x2436": "/_nuxt/icons/splash_iphonex_1125x2436.6cd800.png",
    "iphonexr_828x1792": "/_nuxt/icons/splash_iphonexr_828x1792.6cd800.png",
    "iphonexsmax_1242x2688": "/_nuxt/icons/splash_iphonexsmax_1242x2688.6cd800.png"
  };

  const getIcon = size => icons[size + 'x' + size] || '';

  inject('icon', getIcon);
});
// EXTERNAL MODULE: external "axios"
var external_axios_ = __webpack_require__(8);
var external_axios_default = /*#__PURE__*/__webpack_require__.n(external_axios_);

// EXTERNAL MODULE: external "defu"
var external_defu_ = __webpack_require__(21);
var external_defu_default = /*#__PURE__*/__webpack_require__.n(external_defu_);

// CONCATENATED MODULE: ./.nuxt/axios.js

 // Axios.prototype cannot be modified

const axiosExtra = {
  setBaseURL(baseURL) {
    this.defaults.baseURL = baseURL;
  },

  setHeader(name, value, scopes = 'common') {
    for (const scope of Array.isArray(scopes) ? scopes : [scopes]) {
      if (!value) {
        delete this.defaults.headers[scope][name];
        return;
      }

      this.defaults.headers[scope][name] = value;
    }
  },

  setToken(token, type, scopes = 'common') {
    const value = !token ? null : (type ? type + ' ' : '') + token;
    this.setHeader('Authorization', value, scopes);
  },

  onRequest(fn) {
    this.interceptors.request.use(config => fn(config) || config);
  },

  onResponse(fn) {
    this.interceptors.response.use(response => fn(response) || response);
  },

  onRequestError(fn) {
    this.interceptors.request.use(undefined, error => fn(error) || Promise.reject(error));
  },

  onResponseError(fn) {
    this.interceptors.response.use(undefined, error => fn(error) || Promise.reject(error));
  },

  onError(fn) {
    this.onRequestError(fn);
    this.onResponseError(fn);
  },

  create(options) {
    return createAxiosInstance(external_defu_default()(options, this.defaults));
  }

}; // Request helpers ($get, $post, ...)

for (const method of ['request', 'delete', 'get', 'head', 'options', 'post', 'put', 'patch']) {
  axiosExtra['$' + method] = function () {
    return this[method].apply(this, arguments).then(res => res && res.data);
  };
}

const extendAxiosInstance = axios => {
  for (const key in axiosExtra) {
    axios[key] = axiosExtra[key].bind(axios);
  }
};

const createAxiosInstance = axiosOptions => {
  // Create new axios instance
  const axios = external_axios_default.a.create(axiosOptions);
  axios.CancelToken = external_axios_default.a.CancelToken;
  axios.isCancel = external_axios_default.a.isCancel; // Extend axios proto

  extendAxiosInstance(axios); // Intercept to apply default headers

  axios.onRequest(config => {
    config.headers = { ...axios.defaults.headers.common,
      ...config.headers
    };
  }); // Setup interceptors

  setupProgress(axios);
  return axios;
};

const setupProgress = axios => {
  if (true) {
    return;
  } // A noop loading inteterface for when $nuxt is not yet ready


  const noopLoading = {
    finish: () => {},
    start: () => {},
    fail: () => {},
    set: () => {}
  };

  const $loading = () => {
    const $nuxt = typeof window !== 'undefined' && window['$nuxt'];
    return $nuxt && $nuxt.$loading && $nuxt.$loading.set ? $nuxt.$loading : noopLoading;
  };

  let currentRequests = 0;
  axios.onRequest(config => {
    if (config && config.progress === false) {
      return;
    }

    currentRequests++;
  });
  axios.onResponse(response => {
    if (response && response.config && response.config.progress === false) {
      return;
    }

    currentRequests--;

    if (currentRequests <= 0) {
      currentRequests = 0;
      $loading().finish();
    }
  });
  axios.onError(error => {
    if (error && error.config && error.config.progress === false) {
      return;
    }

    currentRequests--;

    if (external_axios_default.a.isCancel(error)) {
      if (currentRequests <= 0) {
        currentRequests = 0;
        $loading().finish();
      }

      return;
    }

    $loading().fail();
    $loading().finish();
  });

  const onProgress = e => {
    if (!currentRequests || !e.total) {
      return;
    }

    const progress = e.loaded * 100 / (e.total * currentRequests);
    $loading().set(Math.min(100, progress));
  };

  axios.defaults.onUploadProgress = onProgress;
  axios.defaults.onDownloadProgress = onProgress;
};

/* harmony default export */ var _nuxt_axios = ((ctx, inject) => {
  // runtimeConfig
  const runtimeConfig = ctx.$config && ctx.$config.axios || {}; // baseURL

  const baseURL =  false ? undefined : runtimeConfig.baseURL || runtimeConfig.baseUrl || process.env._AXIOS_BASE_URL_ || 'https://api.zakazy.online/api/v1'; // Create fresh objects for all default header scopes
  // Axios creates only one which is shared across SSR requests!
  // https://github.com/mzabriskie/axios/blob/master/lib/defaults.js

  const headers = {
    "common": {
      "Accept": "application/json, text/plain, */*"
    },
    "delete": {},
    "get": {},
    "head": {},
    "post": {},
    "put": {},
    "patch": {}
  };
  const axiosOptions = {
    baseURL,
    headers
  }; // Proxy SSR request headers headers

  if ( true && ctx.req && ctx.req.headers) {
    const reqHeaders = { ...ctx.req.headers
    };

    for (const h of ["accept", "cf-connecting-ip", "cf-ray", "content-length", "content-md5", "content-type", "host", "x-forwarded-host", "x-forwarded-port", "x-forwarded-proto"]) {
      delete reqHeaders[h];
    }

    axiosOptions.headers.common = { ...reqHeaders,
      ...axiosOptions.headers.common
    };
  }

  if (true) {
    // Don't accept brotli encoding because Node can't parse it
    axiosOptions.headers.common['accept-encoding'] = 'gzip, deflate';
  }

  const axios = createAxiosInstance(axiosOptions); // Inject axios to the context as $axios

  ctx.$axios = axios;
  inject('axios', axios);
});
// CONCATENATED MODULE: ./.nuxt/index.js












/* Plugins */

 // Source: ./components/plugin.js (mode: 'all')

 // Source: ./content/plugin.client.js (mode: 'client')

 // Source: ./content/plugin.server.js (mode: 'server')

 // Source: ./workbox.js (mode: 'client')

 // Source: ./pwa/meta.plugin.js (mode: 'all')

 // Source: ./pwa/icon.plugin.js (mode: 'all')

 // Source: ./axios.js (mode: 'all')
// Component: <ClientOnly>

external_vue_default.a.component(external_vue_client_only_default.a.name, external_vue_client_only_default.a); // TODO: Remove in Nuxt 3: <NoSsr>

external_vue_default.a.component(external_vue_no_ssr_default.a.name, { ...external_vue_no_ssr_default.a,

  render(h, ctx) {
    if (false) {}

    return external_vue_no_ssr_default.a.render(h, ctx);
  }

}); // Component: <NuxtChild>

external_vue_default.a.component(nuxt_child.name, nuxt_child);
external_vue_default.a.component('NChild', nuxt_child); // Component NuxtLink is imported in server.js or client.js
// Component: <Nuxt>

external_vue_default.a.component(components_nuxt.name, components_nuxt);
Object.defineProperty(external_vue_default.a.prototype, '$nuxt', {
  get() {
    return this.$root.$options.$nuxt;
  },

  configurable: true
});
external_vue_default.a.use(external_vue_meta_default.a, {
  "keyName": "head",
  "attribute": "data-n-head",
  "ssrAttribute": "data-n-head-ssr",
  "tagIDKeyName": "hid"
});
const defaultTransition = {
  "name": "page",
  "mode": "out-in",
  "appear": false,
  "appearClass": "appear",
  "appearActiveClass": "appear-active",
  "appearToClass": "appear-to"
};
const originalRegisterModule = external_vuex_default.a.Store.prototype.registerModule;
const baseStoreOptions = {
  preserveState: false
};

function registerModule(path, rawModule, options = {}) {
  return originalRegisterModule.call(this, path, rawModule, { ...baseStoreOptions,
    ...options
  });
}

async function createApp(ssrContext, config = {}) {
  const router = await createRouter(ssrContext);
  const store = createStore(ssrContext); // Add this.$router into store actions/mutations

  store.$router = router; // Fix SSR caveat https://github.com/nuxt/nuxt.js/issues/3757#issuecomment-414689141

  store.registerModule = registerModule; // Create Root instance
  // here we inject the router and store to all child components,
  // making them available everywhere as `this.$router` and `this.$store`.

  const app = {
    head: {
      "title": "zakazio-ssr",
      "meta": [{
        "charset": "utf-8"
      }, {
        "name": "viewport",
        "content": "width=device-width, initial-scale=1"
      }, {
        "hid": "description",
        "name": "description",
        "content": ""
      }, {
        "name": "yandex-verification",
        "content": "03775f89455316b7"
      }],
      "link": [{
        "rel": "icon",
        "type": "image\u002Fx-icon",
        "href": "\u002Ffavicon.ico"
      }],
      "style": [],
      "script": []
    },
    store,
    router,
    nuxt: {
      defaultTransition,
      transitions: [defaultTransition],

      setTransitions(transitions) {
        if (!Array.isArray(transitions)) {
          transitions = [transitions];
        }

        transitions = transitions.map(transition => {
          if (!transition) {
            transition = defaultTransition;
          } else if (typeof transition === 'string') {
            transition = Object.assign({}, defaultTransition, {
              name: transition
            });
          } else {
            transition = Object.assign({}, defaultTransition, transition);
          }

          return transition;
        });
        this.$options.nuxt.transitions = transitions;
        return transitions;
      },

      err: null,
      dateErr: null,

      error(err) {
        err = err || null;
        app.context._errored = Boolean(err);
        err = err ? normalizeError(err) : null;
        let nuxt = app.nuxt; // to work with @vue/composition-api, see https://github.com/nuxt/nuxt.js/issues/6517#issuecomment-573280207

        if (this) {
          nuxt = this.nuxt || this.$options.nuxt;
        }

        nuxt.dateErr = Date.now();
        nuxt.err = err; // Used in src/server.js

        if (ssrContext) {
          ssrContext.nuxt.error = err;
        }

        return err;
      }

    },
    ...App
  }; // Make app available into store via this.app

  store.app = app;
  const next = ssrContext ? ssrContext.next : location => app.router.push(location); // Resolve route

  let route;

  if (ssrContext) {
    route = router.resolve(ssrContext.url).route;
  } else {
    const path = getLocation(router.options.base, router.options.mode);
    route = router.resolve(path).route;
  } // Set context to app.context


  await setContext(app, {
    store,
    route,
    next,
    error: app.nuxt.error.bind(app),
    payload: ssrContext ? ssrContext.payload : undefined,
    req: ssrContext ? ssrContext.req : undefined,
    res: ssrContext ? ssrContext.res : undefined,
    beforeRenderFns: ssrContext ? ssrContext.beforeRenderFns : undefined,
    ssrContext
  });

  function inject(key, value) {
    if (!key) {
      throw new Error('inject(key, value) has no key provided');
    }

    if (value === undefined) {
      throw new Error(`inject('${key}', value) has no value provided`);
    }

    key = '$' + key; // Add into app

    app[key] = value; // Add into context

    if (!app.context[key]) {
      app.context[key] = value;
    } // Add into store


    store[key] = app[key]; // Check if plugin not already installed

    const installKey = '__nuxt_' + key + '_installed__';

    if (external_vue_default.a[installKey]) {
      return;
    }

    external_vue_default.a[installKey] = true; // Call Vue.use() to install the plugin into vm

    external_vue_default.a.use(() => {
      if (!Object.prototype.hasOwnProperty.call(external_vue_default.a.prototype, key)) {
        Object.defineProperty(external_vue_default.a.prototype, key, {
          get() {
            return this.$root.$options[key];
          }

        });
      }
    });
  } // Inject runtime config as $config


  inject('config', config);

  if (false) {} // Add enablePreview(previewData = {}) in context for plugins


  if (false) {} // Plugin execution


  if (typeof /* Cannot get final name for export "default" in "./.nuxt/components/plugin.js" (known exports: , known reexports: ) */ undefined === 'function') {
    await /* Cannot get final name for export "default" in "./.nuxt/components/plugin.js" (known exports: , known reexports: ) */ undefined(app.context, inject);
  }

  if (false) {}

  if ( true && typeof plugin_server === 'function') {
    await plugin_server(app.context, inject);
  }

  if (false) {}

  if (typeof meta_plugin === 'function') {
    await meta_plugin(app.context, inject);
  }

  if (typeof icon_plugin === 'function') {
    await icon_plugin(app.context, inject);
  }

  if (typeof _nuxt_axios === 'function') {
    await _nuxt_axios(app.context, inject);
  } // Lock enablePreview in context


  if (false) {} // If server-side, wait for async component to be resolved first


  if ( true && ssrContext && ssrContext.url) {
    await new Promise((resolve, reject) => {
      router.push(ssrContext.url, resolve, err => {
        // https://github.com/vuejs/vue-router/blob/v3.4.3/src/util/errors.js
        if (!err._isRouter) return reject(err);
        if (err.type !== 2
        /* NavigationFailureType.redirected */
        ) return resolve(); // navigated to a different route in router guard

        const unregister = router.afterEach(async (to, from) => {
          ssrContext.url = to.fullPath;
          app.context.route = await getRouteData(to);
          app.context.params = to.params || {};
          app.context.query = to.query || {};
          unregister();
          resolve();
        });
      });
    });
  }

  return {
    store,
    app,
    router
  };
}


// CONCATENATED MODULE: ./.nuxt/components/nuxt-link.server.js

/* harmony default export */ var nuxt_link_server = ({
  name: 'NuxtLink',
  extends: external_vue_default.a.component('RouterLink'),
  props: {
    prefetch: {
      type: Boolean,
      default: true
    },
    noPrefetch: {
      type: Boolean,
      default: false
    }
  }
});
// CONCATENATED MODULE: ./.nuxt/server.js








 // should be included after ./index.js
// Update serverPrefetch strategy

external_vue_default.a.config.optionMergeStrategies.serverPrefetch = external_vue_default.a.config.optionMergeStrategies.created; // Fetch mixin

if (!external_vue_default.a.__nuxt__fetch__mixin__) {
  external_vue_default.a.mixin(fetch_server);
  external_vue_default.a.__nuxt__fetch__mixin__ = true;
} // Component: <NuxtLink>


external_vue_default.a.component(nuxt_link_server.name, nuxt_link_server);
external_vue_default.a.component('NLink', nuxt_link_server);

if (!global.fetch) {
  global.fetch = external_node_fetch_default.a;
}

const noopApp = () => new external_vue_default.a({
  render: h => h('div')
});

function server_urlJoin() {
  return Array.prototype.slice.call(arguments).join('/').replace(/\/+/g, '/');
}

const createNext = ssrContext => opts => {
  // If static target, render on client-side
  ssrContext.redirected = opts;

  if (ssrContext.target === 'static' || !ssrContext.res) {
    ssrContext.nuxt.serverRendered = false;
    return;
  }

  opts.query = Object(external_querystring_["stringify"])(opts.query);
  opts.path = opts.path + (opts.query ? '?' + opts.query : '');
  const routerBase = '/';

  if (!opts.path.startsWith('http') && routerBase !== '/' && !opts.path.startsWith(routerBase)) {
    opts.path = server_urlJoin(routerBase, opts.path);
  } // Avoid loop redirect


  if (decodeURI(opts.path) === decodeURI(ssrContext.url)) {
    ssrContext.redirected = false;
    return;
  }

  ssrContext.res.writeHead(opts.status, {
    Location: Object(ufo_["normalizeURL"])(opts.path)
  });
  ssrContext.res.end();
}; // This exported function will be called by `bundleRenderer`.
// This is where we perform data-prefetching to determine the
// state of our application before actually rendering it.
// Since data fetching is async, this function is expected to
// return a Promise that resolves to the app instance.


/* harmony default export */ var server = __webpack_exports__["default"] = (async ssrContext => {
  // Create ssrContext.next for simulate next() of beforeEach() when wanted to redirect
  ssrContext.redirected = false;
  ssrContext.next = createNext(ssrContext); // Used for beforeNuxtRender({ Components, nuxtState })

  ssrContext.beforeRenderFns = []; // Nuxt object (window.{{globals.context}}, defaults to window.__NUXT__)

  ssrContext.nuxt = {
    layout: 'default',
    data: [],
    fetch: [],
    error: null,
    state: null,
    serverRendered: true,
    routePath: ''
  }; // Remove query from url is static target

  if (false) {} // Public runtime config


  ssrContext.nuxt.config = ssrContext.runtimeConfig.public; // Create the app definition and the instance (created for each request)

  const {
    app,
    router,
    store
  } = await createApp(ssrContext, { ...ssrContext.runtimeConfig.public,
    ...ssrContext.runtimeConfig.private
  });

  const _app = new external_vue_default.a(app); // Add ssr route path to nuxt context so we can account for page navigation between ssr and csr


  ssrContext.nuxt.routePath = app.context.route.path; // Add meta infos (used in renderer.js)

  ssrContext.meta = _app.$meta(); // Keep asyncData for each matched component in ssrContext (used in app/utils.js via this.$ssrContext)

  ssrContext.asyncData = {};

  const beforeRender = async () => {
    // Call beforeNuxtRender() methods
    await Promise.all(ssrContext.beforeRenderFns.map(fn => promisify(fn, {
      Components,
      nuxtState: ssrContext.nuxt
    })));

    ssrContext.rendered = () => {
      // Add the state from the vuex store
      ssrContext.nuxt.state = store.state;
    };
  };

  const renderErrorPage = async () => {
    // Don't server-render the page in static target
    if (ssrContext.target === 'static') {
      ssrContext.nuxt.serverRendered = false;
    } // Load layout for error page


    const layout = (layouts_error.options || layouts_error).layout;
    const errLayout = typeof layout === 'function' ? layout.call(layouts_error, app.context) : layout;
    ssrContext.nuxt.layout = errLayout || 'default';
    await _app.loadLayout(errLayout);

    _app.setLayout(errLayout);

    await beforeRender();
    return _app;
  };

  const render404Page = () => {
    app.context.error({
      statusCode: 404,
      path: ssrContext.url,
      message: 'This page could not be found'
    });
    return renderErrorPage();
  }; // Components are already resolved by setContext -> getRouteData (app/utils.js)


  const Components = getMatchedComponents(router.match(ssrContext.url));
  /*
  ** Dispatch store nuxtServerInit
  */

  if (store._actions && store._actions.nuxtServerInit) {
    try {
      await store.dispatch('nuxtServerInit', app.context);
    } catch (err) {
      console.debug('Error occurred when calling nuxtServerInit: ', err.message);
      throw err;
    }
  } // ...If there is a redirect or an error, stop the process


  if (ssrContext.redirected) {
    return noopApp();
  }

  if (ssrContext.nuxt.error) {
    return renderErrorPage();
  }
  /*
  ** Call global middleware (nuxt.config.js)
  */


  let midd = [];
  midd = midd.map(name => {
    if (typeof name === 'function') {
      return name;
    }

    if (typeof _nuxt_middleware[name] !== 'function') {
      app.context.error({
        statusCode: 500,
        message: 'Unknown middleware ' + name
      });
    }

    return _nuxt_middleware[name];
  });
  await middlewareSeries(midd, app.context); // ...If there is a redirect or an error, stop the process

  if (ssrContext.redirected) {
    return noopApp();
  }

  if (ssrContext.nuxt.error) {
    return renderErrorPage();
  }
  /*
  ** Set layout
  */


  let layout = Components.length ? Components[0].options.layout : layouts_error.layout;

  if (typeof layout === 'function') {
    layout = layout(app.context);
  }

  await _app.loadLayout(layout);

  if (ssrContext.nuxt.error) {
    return renderErrorPage();
  }

  layout = _app.setLayout(layout);
  ssrContext.nuxt.layout = _app.layoutName;
  /*
  ** Call middleware (layout + pages)
  */

  midd = [];
  layout = sanitizeComponent(layout);

  if (layout.options.middleware) {
    midd = midd.concat(layout.options.middleware);
  }

  Components.forEach(Component => {
    if (Component.options.middleware) {
      midd = midd.concat(Component.options.middleware);
    }
  });
  midd = midd.map(name => {
    if (typeof name === 'function') {
      return name;
    }

    if (typeof _nuxt_middleware[name] !== 'function') {
      app.context.error({
        statusCode: 500,
        message: 'Unknown middleware ' + name
      });
    }

    return _nuxt_middleware[name];
  });
  await middlewareSeries(midd, app.context); // ...If there is a redirect or an error, stop the process

  if (ssrContext.redirected) {
    return noopApp();
  }

  if (ssrContext.nuxt.error) {
    return renderErrorPage();
  }
  /*
  ** Call .validate()
  */


  let isValid = true;

  try {
    for (const Component of Components) {
      if (typeof Component.options.validate !== 'function') {
        continue;
      }

      isValid = await Component.options.validate(app.context);

      if (!isValid) {
        break;
      }
    }
  } catch (validationError) {
    // ...If .validate() threw an error
    app.context.error({
      statusCode: validationError.statusCode || '500',
      message: validationError.message
    });
    return renderErrorPage();
  } // ...If .validate() returned false


  if (!isValid) {
    // Render a 404 error page
    return render404Page();
  } // If no Components found, returns 404


  if (!Components.length) {
    return render404Page();
  } // Call asyncData & fetch hooks on components matched by the route.


  const asyncDatas = await Promise.all(Components.map(Component => {
    const promises = []; // Call asyncData(context)

    if (Component.options.asyncData && typeof Component.options.asyncData === 'function') {
      const promise = promisify(Component.options.asyncData, app.context);
      promise.then(asyncDataResult => {
        ssrContext.asyncData[Component.cid] = asyncDataResult;
        applyAsyncData(Component);
        return asyncDataResult;
      });
      promises.push(promise);
    } else {
      promises.push(null);
    } // Call fetch(context)


    if (Component.options.fetch && Component.options.fetch.length) {
      promises.push(Component.options.fetch(app.context));
    } else {
      promises.push(null);
    }

    return Promise.all(promises);
  })); // datas are the first row of each

  ssrContext.nuxt.data = asyncDatas.map(r => r[0] || {}); // ...If there is a redirect or an error, stop the process

  if (ssrContext.redirected) {
    return noopApp();
  }

  if (ssrContext.nuxt.error) {
    return renderErrorPage();
  } // Call beforeNuxtRender methods & add store state


  await beforeRender();
  return _app;
});

/***/ }),
/* 45 */
/***/ (function(module, exports) {

module.exports = require("dayjs");

/***/ })
/******/ ]);
//# sourceMappingURL=server.js.map
<template>
  <div v-if="hasKey" class="container-fluid">
    <h2 class="title">Создать заказ</h2>
    <div v-show="step === 0" class="order">
      <div class="order__title">Выберите категорию</div>
      <AutoComplete
        placeholder="выберите категорию"
        v-model="ORDER_FORM.parentCategoryID"
        :list="parentCategories"
      />
      <button
        class="order__next"
        :disabled="ORDER_FORM.parentCategoryID === null"
        @click="nextStep(1)"
      >
        Дальше
      </button>
    </div>
    <div v-show="step === 1" class="order">
      <div class="order__title">Выберите подкатегорию</div>
      <AutoComplete
        placeholder="выберите подкатегорию"
        v-model="ORDER_FORM.categoryID"
        :list="subCategories"
      />
      <button
        class="order__next"
        :disabled="ORDER_FORM.categoryID === null"
        @click="nextStep(2)"
      >
        Дальше
      </button>
    </div>
    <div v-show="step === 2" class="order">
      <div class="order__title">Выберите регион</div>
      <AutoComplete
        placeholder="выберите регион"
        v-model="ORDER_FORM.regionID"
        :list="regions"
      />
      <button
        class="order__next"
        :disabled="ORDER_FORM.regionID === null"
        @click="nextStep(3)"
      >
        Дальше
      </button>
    </div>
    <div v-show="step === 3" class="order">
      <div class="order__title">Выберите город</div>
      <AutoComplete
        placeholder="выберите город"
        v-model="ORDER_FORM.cityID"
        :list="cities"
      />
      <button
        class="order__next"
        :disabled="ORDER_FORM.cityID === null"
        @click="nextStep(4)"
      >
        Дальше
      </button>
    </div>
    <div v-show="step === 4" class="order">
      <div class="order__title">Заполните информацию о заказе</div>
      <input
        v-model="ORDER_FORM.title"
        class="order__input"
        placeholder="Название заказа"
        type="text"
      />
      <textarea
        v-model="ORDER_FORM.content"
        class="order__input order__input_textarea"
        placeholder="Описание заказа"
        name=""
        id=""
        cols="30"
        rows="10"
      ></textarea>
      <hr class="order__hr" />
      <div class="col-12 mb-3">
        <div class="mb-3">Файлы</div>
        <div v-if="ORDER_FORM.files.length === 0" class="text-dark">
          нет файлов
        </div>
        <div class="d-flex">
          <div
            :key="file"
            v-for="(file, i) in ORDER_FORM.files"
            class="card ms-3"
            style="
              width: 80px;
              height: 80px;
              display: flex;
              align-items: center;
              justify-content: center;
              position: relative;
            "
          >
            <img :src="require('@/assets/img/file.svg')" alt="" />
            <button
              style="
                position: absolute;
                top: 5px;
                right: 5px;
                border: none;
                background-color: transparent;
                width: 20px;
                height: 20px;
                display: flex;
                justify-content: center;
                align-items: center;
                padding: 0;
              "
              type="button"
              @click.prevent="deleteFile(i)"
            >
              <img :src="require('@/assets/img/trash.svg')" alt="" />
            </button>
          </div>
        </div>

        <input
          ref="selectFile"
          class="d-none"
          type="file"
          @change="uploadFile($event)"
        />
        <br />
        <button
          class="order__add-file"
          @click.prevent="$refs.selectFile.click()"
        >
          Добавить файл
        </button>
      </div>
      <button
        class="order__next"
        :disabled="!isValidStepFour"
        @click="nextStep(5)"
      >
        Дальше
      </button>
    </div>
    <div class="order" v-show="step === 5">
      <div class="order__title">Укажите дату завершения</div>
      <input
        v-model="ORDER_FORM.dateLine"
        class="order__input"
        placeholder="Предполагаемая дата завершения"
      />
      <div class="order__title">Укажите стоимость в рублях</div>
      <input
        v-model="ORDER_FORM.price"
        class="order__input"
        placeholder="Стоимость в рублях"
      />
      <button
        class="order__next"
        :disabled="!isValidStepFive"
        @click="nextStep(6)"
      >
        Дальше
      </button>
    </div>
    <div v-show="step === 6" class="order">
      <div class="order__title">Заполните данные клиента</div>
      <div class="order__client">
        <input
          v-model="ORDER_FORM.client_first_name"
          class="order__input"
          placeholder="Имя"
          type="text"
        />
        <input
          v-model="ORDER_FORM.client_last_name"
          class="order__input"
          placeholder="Фамилия"
          type="text"
        />
        <input
          v-model="ORDER_FORM.client_middle_name"
          class="order__input"
          placeholder="Отчество"
          type="text"
        />
        <input
          v-model="ORDER_FORM.client_email"
          class="order__input"
          placeholder="Email"
          type="text"
        />
        <input
          v-model="ORDER_FORM.client_phone"
          class="order__input"
          placeholder="Телефон"
          inputmode="tel"
          v-maska="'8 ##########'"
          type="text"
        />
      </div>
      <button
        class="order__next"
        :disabled="!isValidStepSix"
        @click="makeOrder"
      >
        Создать заказ
      </button>
    </div>
    <div v-show="step === 7" class="order">
      <div class="order__title order__title_finish">Ваш заказ опубликован!</div>
    </div>
  </div>
  <div class="container-fluid" v-else>
    <div class="order">
      <div class="order__title order__title_finish">
        Отсутсвует ключ приложения!
      </div>
    </div>
  </div>
</template>
<script>
import AutoComplete from "../components/AutoComplete";
const ORDER_FORM = {
  title: "",
  content: "",
  price: 0,
  dateLine: "",
  regionID: null,
  cityID: null,
  parentCategoryID: null,
  categoryID: null,
  executorID: null,
  client_first_name: "",
  client_last_name: "",
  client_middle_name: "",
  client_phone: "",
  client_email: "",
  files: [],
};

const token =
  "Bearer eyJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwiZk5hbWUiOiJTdXBlciIsImxOYW1lIjoiQWRtaW4iLCJtTmFtZSI6Ilpha2F6eSIsImV4cCI6MTYxNDcyNzA5NX0.CLfkUKPRzxc9zDhJLwNtjWzXykWJruNqdl-xC7M0glQ";
const url = "https://api.zakazy.online/api/v1";

const params = new URLSearchParams(window.location.search);
const appId = params.has("key") ? params.get("key") : null;

const myHeaders = new Headers();
myHeaders.append("Authorization", token);
const requestOptions = {
  method: "GET",
  headers: myHeaders,
  redirect: "follow",
};

import axios from "axios";
export default {
  components: { AutoComplete },
  watch: {
    "ORDER_FORM.regionID"(value) {
      if (value !== null) {
        this.getCities();
      }
    },
  },
  data() {
    return {
      step: 0,
      currentRegion: null,
      currentCity: null,
      regions: [],
      cities: [],
      categories: [],
      ORDER_FORM: { ...{}, ...ORDER_FORM },
      validation: false,
      regionFilterString: "",
      cityFilterString: "",
      categoryFilterString: "",
      regionsListActive: false,
      citiesListActive: false,
      categoriesListActive: false,
    };
  },
  computed: {
    hasKey() {
      return appId !== null;
    },
    parentCategories() {
      return this.categories.map((category) => ({
        name: category.parent.name,
        id: category.parent.id,
      }));
    },
    subCategories() {
      return this.categories
        .find(
          (category) => category.parent.id === this.ORDER_FORM.parentCategoryID
        )
        ?.childList.map((category) => ({
          name: category.name,
          id: category.id,
        }));
    },
    filteredCities() {
      return this.cities.filter((c) => {
        const pos = c.name
          .toLowerCase()
          .indexOf(this.cityFilterString.toLowerCase());
        return pos >= 0;
      });
    },

    isValidStepFour() {
      return this.isValidTitle && this.isValidContent;
    },
    isValidStepFive() {
      return this.isValidPrice && this.isValidDateLine;
    },
    isValidStepSix() {
      return (
        this.ORDER_FORM.client_first_name !== "" &&
        this.ORDER_FORM.client_last_name !== "" &&
        this.ORDER_FORM.client_middle_name &&
        /.+@.+\..+/.test(this.ORDER_FORM.client_email) &&
        this.ORDER_FORM.client_phone !== ""
      );
    },
    isValidTitle() {
      return this.ORDER_FORM.title !== "";
    },
    isValidContent() {
      return this.ORDER_FORM.content !== "";
    },
    isValidPrice() {
      return this.ORDER_FORM.price !== 0;
    },
    isValidDateLine() {
      return this.ORDER_FORM.dateLine !== "";
    },
    isValidCity() {
      return !this.validation || this.ORDER_FORM.cityID !== null;
    },
    isValidCategory() {
      return !this.validation || this.ORDER_FORM.categoryID !== null;
    },
    isValidFirstName() {
      return !this.validation || this.ORDER_FORM.client_first_name !== "";
    },
    isValidLastName() {
      return !this.validation || this.ORDER_FORM.client_last_name !== "";
    },
    isValidMiddleName() {
      return !this.validation || this.ORDER_FORM.client_middle_name !== "";
    },
    isValidEmail() {
      return !this.validation || /.+@.+\..+/.test(this.ORDER_FORM.client_email);
    },
    isValidPhone() {
      return !this.validation || this.ORDER_FORM.client_phone !== "";
    },
    enableToMakeOrder() {
      return (
        this.isValidTitle &&
        this.isValidContent &&
        this.isValidPrice &&
        this.isValidDateLine &&
        this.isValidCity &&
        this.isValidCategory &&
        this.isValidFirstName &&
        this.isValidLastName &&
        this.isValidMiddleName &&
        this.isValidEmail &&
        this.isValidPhone
      );
    },
  },
  methods: {
    uploadFile(e) {
      const formData = new FormData();
      formData.append("file", e.target.files[0]);
      axios.post(`${url}/app/${appId}/file/add`, formData).then((r) => {
        this.ORDER_FORM.files.push(r.data);
      });
    },
    makeOrder() {
      axios.post(`${url}/app/${appId}/order/add`, this.ORDER_FORM).then(() => {
        this.step = 7;
        this.ORDER_FORM = { ...{}, ...ORDER_FORM };
      });
    },

    nextStep(step) {
      this.step = step;
    },
    resetForm() {
      this.validation = false;
      this.ORDER_FORM = { ...ORDER_FORM };
    },
    deleteFile(i) {
      this.ORDER_FORM.files.splice(i, 1);
    },
    selectFile(e) {
      this.ORDER_FORM.files.push(e.target.files[0]);
    },
    getCategories() {
      axios.get(`${url}/category/global/search?query=`).then((r) => {
        this.categories = r.data.data;
      });
      /* fetch(`${url}/category/list/active/search?query=`, requestOptions)
        .then((response) => response.json())
        .then((r) => {
          this.categories = r.data.content;
          console.log(r.data.content);
        })
        .catch((error) => console.log("error", error));*/
    },
    getCities() {
      // ${url}/region/${this.ORDER_FORM.regionID}/city/list?size=1000&page=0

      fetch(
        `${url}/region/${this.ORDER_FORM.regionID}/city/search?query=`,
        requestOptions
      )
        .then((response) => response.json())
        .then((r) => {
          this.cities = r.data.content;
        })
        .catch((error) => console.log("error", error));
    },
    getRegions() {
      fetch(`${url}/region/list?size=1000&page=0`, requestOptions)
        .then((response) => response.json())
        .then((r) => {
          this.regions = r.data.content;
        })
        .catch((error) => console.log("error", error));
    },
  },
  created() {
    this.getRegions();
    this.getCategories();
  },
};
</script>
<style lang="scss">
@import "@/assets/scss/order.scss";
</style>

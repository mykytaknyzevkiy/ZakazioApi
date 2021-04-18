<template>
  <div id="selectRegion" :class="`autocomplete autocomplete-${$.uid}`">
    <input
      @focus="focus($event)"
      @input="search($event)"
      :value="filterString"
      :placeholder="placeholder"
      class="autocomplete__search"
      type="text"
    />
    <div
      class="autocomplete__list"
      :class="{ autocomplete__list_active: listActive }"
    >
      <button
        :key="item.id"
        v-for="item in filteredItems"
        @click="select(item)"
        class="autocomplete__item"
      >
        {{ item.name }}
      </button>
    </div>
  </div>
</template>

<script>
export default {
  name: "AutoComplete",
  props: {
    list: {
      type: Array,
      default: () => [],
    },
    placeholder: {
      type: String,
      default: "выберите пункт",
    },
    modelValue: {
      type: Number,
      default: null,
    },
  },
  data() {
    return {
      filterString: "",
      listActive: false,
    };
  },
  created() {
    this.filterString = this.selectedItem;
    document.addEventListener("click", this.clickOutsideCallback);
  },
  beforeUnmount() {
    document.removeEventListener("click", this.clickOutsideCallback);
  },
  watch: {
    modelValue() {
      this.filterString = this.selectedItem;
    },
  },
  methods: {
    clickOutsideCallback(event) {
      if (event.target.closest(`.autocomplete-${this.$.uid}`)) return;
      this.listActive = false;
    },
    select(item) {
      this.$emit("update:modelValue", item.id);
      this.listActive = false;
    },
    focus() {
      this.listActive = true;
    },
    search(e) {
      this.filterString = e.target.value;
    },
  },
  computed: {
    selectedItem() {
      const item = this.list.find((item) => item.id === this.modelValue);
      if (!this.modelValue || !item) return "";
      return item["name"] || "";
    },
    filteredItems() {
      return this.list.filter((r) => {
        const pos = r.name
          .toLowerCase()
          .indexOf(this.filterString.toLowerCase());
        return pos >= 0;
      });
    },
  },
};
</script>

<style scoped lang="scss">
@font-face {
  font-family: "Ponter Alt";
  src: url("~@/assets/fonts/alt.eot");
  src: url("~@/assets/fonts/alt.eot?#iefix") format("embedded-opentype"),
    url("~@/assets/fonts/alt.woff2") format("woff2"),
    url("~@/assets/fonts/alt.woff") format("woff"),
    url("~@/assets/fonts/alt.ttf") format("truetype"),
    url("~@/assets/fonts/alt.svg#Ponter Alt") format("svg");
}
$alt: "Ponter Alt";

.autocomplete {
  height: 70px;
  position: relative;
  background-color: #dedede;
  display: flex;
  align-items: center;
  cursor: pointer;
  &:after {
    position: absolute;
    right: 20px;
    margin-left: auto;
    margin-right: 0;
    content: "";
    display: block;
    width: 10px;
    height: 10px;
    margin-top: 10px;
    border: 10px solid transparent; /* Прозрачные границы */
    border-top: 10px solid #000; /* Добавляем треугольник */
  }
}
.autocomplete__search {
  display: block;
  height: 100%;
  border: none;
  width: 100%;
  background-color: #dedede;
  line-height: 100%;
  padding: 0 40px 0 20px;
  font-family: $alt;
  &:focus {
    background-color: #fff;
    outline: none;
    border-top: 2px solid #000;
    border-left: 2px solid #000;
    border-right: 2px solid #000;
  }
}
.autocomplete__list {
  display: none;
  position: absolute;
  width: 100%;
  top: calc(100%);
  background-color: #dedede;
  max-height: 200px;
  overflow-y: scroll;
  border-bottom: 2px solid #000;
  border-left: 2px solid #000;
  border-right: 2px solid #000;
}
.autocomplete__list_active {
  display: block;
  background-color: #dedede;
}
.autocomplete__item {
  width: 100%;
  border: none;
  padding: 20px;
  text-transform: uppercase;
  font-weight: bold;
  &:hover {
    background-color: #000;
    color: #fff;
  }
}
</style>

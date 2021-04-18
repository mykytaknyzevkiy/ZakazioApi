<template>
  <div class="container">
    <HelloWorld msg="Выберите виджет" />
    <AutoComplete />
  </div>
</template>

<script>
// @ is an alias to /src
import HelloWorld from "@/components/HelloWorld.vue";
import AutoComplete from "../components/AutoComplete";

export default {
  name: "Home",
  components: {
    AutoComplete,
    HelloWorld,
  },
};
</script>

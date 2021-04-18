<template>
  <div v-if="$route.name === 'home'" id="nav">
    <router-link to="/">Home</router-link> |
    <router-link to="/order">Заказ</router-link>
  </div>
  <router-view />
</template>

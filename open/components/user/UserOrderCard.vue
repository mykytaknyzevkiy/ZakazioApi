<template>
  <div>OrderCard</div>
  <!--  <v-card class="mb-5" flat outlined>
    <v-card-title class="px-5 justify-space-between">
      <h2 class="font-weight-bold subtitle-1 mb-0" style="line-height: 19.2px">
        Full Stack Engineer
      </h2>
      <span
        style="color: rgba(0, 0, 0, 0.54); line-height: 16px"
        class="subtitle-2 font-weight-light"
        ><v-icon size="14">mdi-google-maps</v-icon> Москва</span
      >
    </v-card-title>
    <v-card-text class="px-5 py-0"
      >We are looking for a Full Stack Engineer You’ll be part of a
      cross-functional product team, working in close collaboration with Product
      Managers and Designers to ship new features...
    </v-card-text>
    <v-card-actions class="px-5 justify-space-between">
      <v-chip-group>
        <v-chip label x-small color="primary">#new</v-chip>
        <v-chip label x-small dark color="pink">#new</v-chip>
        <v-chip label x-small color="dangerous">#new</v-chip>
      </v-chip-group>
      <span class="text-caption">500 рублей</span>
    </v-card-actions>
    <v-divider />
    <v-card-text class="d-flex align-center">
      <v-avatar size="36px" class="mr-5">
        <img
          alt="Avatar"
          src="https://avatars0.githubusercontent.com/u/9064066?v=4&s=460"
        />
      </v-avatar>
      <div class="subtitle-1">Николай Козлов</div>
    </v-card-text>
  </v-card>-->
</template>

<script>
export default {
  name: 'UserOrderCard',
  props: {
    order: {
      type: Object,
      default: () => {},
    },
  },
}
</script>

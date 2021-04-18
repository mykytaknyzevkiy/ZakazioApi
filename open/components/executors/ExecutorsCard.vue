<template>
  <div>executor card</div>
  <!--  <v-row class="pa-5">
    <nuxt-link
      v-for="(user, index) in [...users]"
      :key="index"
      class="col col-4 d-flex mb-2 user-card"
      :to="`users/${user.id}`"
    >
      <v-avatar color="primary" class="mr-3">
        <img
          v-if="user.avatar !== null"
          :src="`${storageUrl}/${user.avatar}`"
          alt="John"
        />
        <span v-else class="white&#45;&#45;text">{{
          user.firstName[0] + user.lastName[0]
        }}</span>
      </v-avatar>
      <div>
        <div class="font-weight-bold">
          {{ `${user.firstName} ${user.lastName}` }}
        </div>
        <div class="font-weight-thin grey&#45;&#45;text">
          <v-icon color="grey" size="16">mdi-google-maps</v-icon
          >{{ user.city || 'нет города' }}
        </div>
        <div class="d-flex align-center">
          <v-rating
            class="px-0"
            hover
            length="5"
            size="17"
            :value="user.rate"
            readonly
          ></v-rating>
        </div>
        <div class="text-caption">
          Открытые заказы: {{ user.order.count.open }}
        </div>
        <div class="text-caption">
          Закрытые заказы: {{ user.order.count.close }}
        </div>
      </div>
    </nuxt-link>
  </v-row>-->
</template>

<script>
export default {
  name: 'ExecutorsCard',
  props: {
    users: {
      type: Array,
      default: () => [],
    },
  },
  methods: {
    rand(max) {
      return Math.floor(Math.random() * Math.floor(max))
    },
  },
}
</script>

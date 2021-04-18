<template>
  <div>user avatar</div>
  <!--  <v-card class="mb-3 d-sm-flex d-md-block" flat>
    <v-img
      v-if="user.avatar !== null"
      class="avatar-img"
      :src="`${storageUrl}/${user.avatar}`"
      aspect-ratio="1"
    ></v-img>
    <template v-else>
      <div class="avatar">
        <span>{{ user.firstName[0] + user.lastName[0] }}</span>
      </div>
    </template>
  </v-card>-->
</template>

<script>
export default {
  name: 'UserAvatar',
  props: {
    user: {
      type: Object,
      default: () => {},
    },
  },
}
</script>

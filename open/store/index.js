export const actions = {
  async nuxtServerInit({ commit }, { $axios }) {
    const {
      data: { data },
    } = await $axios.get('settings/contacts')
    commit('contacts/setContacts', data)
  },
}

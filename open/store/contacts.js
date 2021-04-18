export const state = () => ({
  data: {
    companyName: 'companyName',
    phoneNumber: 'phoneNumber',
    email: 'email',
    facebook: 'facebook',
    instagram: 'instagram',
    twitter: 'twitter',
    linkedIn: 'LinkedIn',
  },
})
export const getters = {
  contacts: (state) => {
    return state.data
  },
}
export const mutations = {
  setContacts(state, payload) {
    state.data = { ...payload }
  },
}

export { default as Register } from '../../components/Register.vue'
export { default as TheFooter } from '../../components/TheFooter.vue'
export { default as TheHeader } from '../../components/TheHeader.vue'
export { default as TheMain } from '../../components/TheMain.vue'
export { default as Paginator } from '../../components/common/Paginator.vue'
export { default as Rate } from '../../components/common/Rate.vue'
export { default as ExecutorCard } from '../../components/executors/ExecutorCard.vue'
export { default as ExecutorsCard } from '../../components/executors/ExecutorsCard.vue'
export { default as OrderCard } from '../../components/orders/OrderCard.vue'
export { default as UserAvatar } from '../../components/user/UserAvatar.vue'
export { default as UserFeedbacks } from '../../components/user/UserFeedbacks.vue'
export { default as UserOrderCard } from '../../components/user/UserOrderCard.vue'

export const LazyRegister = import('../../components/Register.vue' /* webpackChunkName: "components/register" */).then(c => c.default || c)
export const LazyTheFooter = import('../../components/TheFooter.vue' /* webpackChunkName: "components/the-footer" */).then(c => c.default || c)
export const LazyTheHeader = import('../../components/TheHeader.vue' /* webpackChunkName: "components/the-header" */).then(c => c.default || c)
export const LazyTheMain = import('../../components/TheMain.vue' /* webpackChunkName: "components/the-main" */).then(c => c.default || c)
export const LazyPaginator = import('../../components/common/Paginator.vue' /* webpackChunkName: "components/paginator" */).then(c => c.default || c)
export const LazyRate = import('../../components/common/Rate.vue' /* webpackChunkName: "components/rate" */).then(c => c.default || c)
export const LazyExecutorCard = import('../../components/executors/ExecutorCard.vue' /* webpackChunkName: "components/executor-card" */).then(c => c.default || c)
export const LazyExecutorsCard = import('../../components/executors/ExecutorsCard.vue' /* webpackChunkName: "components/executors-card" */).then(c => c.default || c)
export const LazyOrderCard = import('../../components/orders/OrderCard.vue' /* webpackChunkName: "components/order-card" */).then(c => c.default || c)
export const LazyUserAvatar = import('../../components/user/UserAvatar.vue' /* webpackChunkName: "components/user-avatar" */).then(c => c.default || c)
export const LazyUserFeedbacks = import('../../components/user/UserFeedbacks.vue' /* webpackChunkName: "components/user-feedbacks" */).then(c => c.default || c)
export const LazyUserOrderCard = import('../../components/user/UserOrderCard.vue' /* webpackChunkName: "components/user-order-card" */).then(c => c.default || c)

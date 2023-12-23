import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'
import TimeToolView from '../views/TimeToolView.vue'

const router = createRouter({
  history: createWebHistory('/my-tool-page'),
  routes: [
    {
      path: '/',
      name: 'home',
      component: HomeView
    },
    {
      path: '/about',
      name: 'about',
      // route level code-splitting
      // this generates a separate chunk (About.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: () => import('../views/AboutView.vue')
    },
    {
      path: '/time_tool',
      name: 'time tool',
      component: TimeToolView
    }
  ]
})

export default router

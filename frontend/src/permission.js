import router from './router'
import store from './store'
import { Message } from 'element-ui'
import NProgress from 'nprogress' // progress bar
import 'nprogress/nprogress.css' // progress bar style
import { getToken } from '@/utils/auth' // get token from cookie
import getPageTitle from '@/utils/get-page-title'

NProgress.configure({ showSpinner: false }) // NProgress Configuration

const whiteList = ['/login'] // no redirect whitelist

router.beforeEach(async(to, from, next) => {
  // start progress bar
  NProgress.start()

  // set page title
  document.title = getPageTitle(to.meta.title)

  // determine whether the user has logged in
  const hasToken = getToken()

  if (hasToken) {
    console.log('有token')
    if (to.path === '/login') {
      // if is logged in, redirect to the home page
      next({ path: '/' })
      NProgress.done()
    } else {
      const hasGroup = store.getters.group && store.getters.group.length > 0 // 1. 根据用户是否具有权限列表，判断用户时候已经登录
      const hasGetUserInfo = store.getters.name
      console.log("hasGetUserInfo",hasGetUserInfo,"hasGroup",hasGroup)
      if (hasGetUserInfo && hasGroup) {
        next()
      } else {
        try {
          console.log("测试位置")
          const { group } = await store.dispatch('user/getInfo')          // 2. 首次登录从用户信息中获取用户权限列表
          console.log("USERINFO正常")
          const accessRoutes = await store.dispatch('permission/generateRoutes', group)   // 3. 根据用户权限列表生成用户可访问动态路由表
          console.log("ROUTER正常")
          router.addRoutes(accessRoutes)                    // 4. 将用户动态路由表挂载到 router
          next({ ...to, replace: true })  
        } catch (error) {
          // remove token and go to login page to re-login
           await store.dispatch('user/resetToken')
          Message.error(error || 'Has Error')
          next(`/login?redirect=${to.path}`)
          NProgress.done()
        } 
      }
    }
  } else {
    /* has no token*/

    if (whiteList.indexOf(to.path) !== -1) {
      // in the free login whitelist, go directly
      next()
    } else {
      // other pages that do not have permission to access are redirected to the login page.
      next(`/login?redirect=${to.path}`)
      NProgress.done()
    }
  }
})

router.afterEach(() => {
  // finish progress bar
  NProgress.done()
})

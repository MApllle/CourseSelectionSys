import { asyncRoutes, constantRoutes } from '@/router'

// 校验用户是否具有进入该路由权限
function hasPermission(group, route) {
  if (route.meta && route.meta.group) {
    if (route.meta.group!=group){
        return false}
    else{ 
    return true}
  } else {
    return true
  }
}

// 递归过滤 asyncRoutes 路由中的 roles 可进入的路由
export function filterAsyncRoutes(routes, group) {
  const res = []
  routes.forEach(route => {
    const tmp = { ...route }
    if (hasPermission(group, tmp)) {
      if (tmp.children) {
        tmp.children = filterAsyncRoutes(tmp.children, group)
      }
      res.push(tmp)
    }
  })
  console.log("递归过滤结果",res)
  return res
}

// 全局保存动态路由
const state = {
  routes: [],
  addRoutes: []
}

const mutations = {
  SET_ROUTES: (state, routes) => {
    state.addRoutes = routes
    state.routes = constantRoutes.concat(routes)
  }
}

// 根据用户权限生成动态路由表
const actions = {
  generateRoutes({ commit }, group) {
    return new Promise(resolve => {
      let accessedRoutes
      if (group=='管理员') {
        accessedRoutes = asyncRoutes || []
      } else {
        accessedRoutes = filterAsyncRoutes(asyncRoutes, group)
      }
      commit('SET_ROUTES', accessedRoutes)
      resolve(accessedRoutes)
    })
  }
}

export default {
  namespaced: true,
  state,
  mutations,
  actions
}

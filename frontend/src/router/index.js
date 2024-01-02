import Vue from 'vue'
import Router from 'vue-router'

Vue.use(Router)

/* Layout */
import Layout from '@/layout'

/**
 * Note: sub-menu only appear when route children.length >= 1
 * Detail see: https://panjiachen.github.io/vue-element-admin-site/guide/essentials/router-and-nav.html
 *
 * hidden: true                   if set true, item will not show in the sidebar(default is false)
 * alwaysShow: true               if set true, will always show the root menu
 *                                if not set alwaysShow, when item has more than one children route,
 *                                it will becomes nested mode, otherwise not show the root menu
 * redirect: noRedirect           if set noRedirect will no redirect in the breadcrumb
 * name:'router-name'             the name is used by <keep-alive> (must set!!!)
 * meta : {
    roles: ['admin','editor']    control the page roles (you can set multiple roles)
    title: 'title'               the name show in sidebar and breadcrumb (recommend set)
    icon: 'svg-name'/'el-icon-x' the icon show in the sidebar
    breadcrumb: false            if set false, the item will hidden in breadcrumb(default is true)
    activeMenu: '/example/list'  if set path, the sidebar will highlight the path you set
  }
 */

/**
 * constantRoutes
 * a base page that does not have permission requirements
 * all roles can be accessed
 */
export const constantRoutes = [
  {
    path: '/login',
    component: () => import('@/views/login/index'),
    hidden: true
  },

  {
    path: '/404',
    component: () => import('@/views/404'),
    hidden: true
  },

  {
    path: '/',
    component: Layout,
    redirect: '/dashboard',
    children: [{
      path: 'dashboard',
      name: 'dashboard',
      component: () => import('@/views/dashboard/index'),
      meta: { title: '选课系统首页', icon: 'dashboard' }
    }]
  }
]

export const asyncRoutes = [
  {
    path: '/studentPage',
    component: Layout,
    // redirect: '/studentPage/courseSelect',
    name: 'studentPage',
    meta: {
      title: '学生选课',
      icon: 'nested',
      group: '学生'
    },
    children: [
      {
        path: 'selectCourse',
        component: () => import('@/views/studentPage/selectCourse'), // Parent router-view
        name: 'selectCourse',
        meta: { title: '选课', group: '学生' }
      },
      {
        path: 'viewHistoryCourseSelection',
        component: () => import('@/views/studentPage/viewHistoryCourseSelection'),
        name: 'viewHistoryCourseSelection',
        meta: { title: '查看过往选课', group: '学生' }
      },
      {
        path: 'viewSchedule',
        component: () => import('@/views/studentPage/viewSchedule'),
        name: 'viewSchedule',
        meta: { title: '查看课表', group: '学生' }
      },
      {
        path: 'studentComment',
        component: () => import('@/views/studentPage/studentComment'),
        name: 'studentComment',
        meta: { title: '评论', group: '学生' }
      }
    ]
  },
  {
    path: '/adminPage',
    component: Layout,
    // redirect: '/studentPage/courseSelect',
    name: 'adminPage',
    meta: {
      title: '后台管理',
      icon: 'nested',
      group: '管理员'
    },
    children: [
      {
        path: 'handleDept',
        component: () => import('@/views/adminPage/handleDept'),
        name: 'handleDept',
        meta: { title: '院系管理', group: '管理员' }
      },
      {
        path: 'hadleTeacher',
        component: () => import('@/views/adminPage/hadleTeacher'),
        name: 'hadleTeacher',
        meta: { title: '教师管理', group: '管理员' }
      },
      {
        path: 'hadleStudent',
        component: () => import('@/views/adminPage/hadleStudent'),
        name: 'hadleStudent',
        meta: { title: '学生管理', group: '管理员' }
      },
      {
        path: 'handleCourse',
        component: () => import('@/views/adminPage/handleCourse'),
        name: 'handleCourse',
        meta: { title: '课程管理', group: '管理员' }
      },
      {
        path: 'openCourseRequest',
        component: () => import('@/views/teacherPage/openCourseRequest'),
        name: 'manageScore',
        meta: { title: '开课申请审批', group: '管理员' }
      },
      {
        path: 'handleOpenCourse',
        component: () => import('@/views/adminPage/handleOpenCourse'),
        name: 'handleOpenCourse',
        meta: { title: '开课管理', group: '管理员' }
      },
      {
        path: 'handleCourseSelect',
        component: () => import('@/views/adminPage/handleCourseSelect'),
        name: 'handleCourseSelect',
        meta: { title: '选课管理', group: '管理员' }
      },
      {
        path: 'handleUser',
        component: () => import('@/views/adminPage/handleUser'),
        name: 'handleUser',
        meta: { title: '系统账号管理', group: '管理员' }
      }

    ]
  },
  {
    path: '/teacherPage',
    component: Layout,
    // redirect: '/studentPage/courseSelect',
    name: 'teacherPage',
    meta: {
      title: '教师课程管理',
      icon: 'nested',
      group: '教师'
    },
    children: [
      {
        path: 'viewSchedule',
        component: () => import('@/views/teacherPage/viewSchedule'), // Parent router-view
        name: 'viewSchedule',
        meta: { title: '查看课表', group: '教师' }
      },
      {
        path: 'manageScore',
        component: () => import('@/views/teacherPage/manageScore'),
        name: 'manageScore',
        meta: { title: '成绩管理', group: '教师' }
      },
      {
        path: 'openCourseRequest',
        component: () => import('@/views/teacherPage/openCourseRequest'),
        name: 'manageScore',
        meta: { title: '申请开课', group: '教师' }
      },
      {
        path: 'studentComments',
        component: () => import('@/views/teacherPage/studentComments'),
        name: 'manageScore',
        meta: { title: '学生评论', group: '教师' }
      }
    ]
  },

  // 404 page must be placed at the end !!!
  { path: '*', redirect: '/404', hidden: true }
]

const createRouter = () => new Router({
  // mode: 'history', // require service support
  scrollBehavior: () => ({ y: 0 }),
  routes: constantRoutes
})

const router = createRouter()

// Detail see: https://github.com/vuejs/vue-router/issues/1234#issuecomment-357941465
export function resetRouter() {
  const newRouter = createRouter()
  router.matcher = newRouter.matcher // reset router
}

export default router

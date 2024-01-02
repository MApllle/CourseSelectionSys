import { login, logout, getInfo } from '@/api/user'
import { getToken, setToken, removeToken } from '@/utils/auth'
import { resetRouter } from '@/router'

const getDefaultState = () => {
  return {
    token: getToken(),
    name: '',
    avatar: '',
    semester: '',
    group: ''
  }
}

const state = getDefaultState()

const mutations = {
  RESET_STATE: (state) => {
    Object.assign(state, getDefaultState())
  },
  SET_TOKEN: (state, token) => {
    state.token = token
  },
  SET_NAME: (state, name) => {
    state.name = name
  },
  SET_AVATAR: (state, avatar) => {
    state.avatar = avatar
  },
  SET_SEMESTER: (state, semester) => {
    state.semester = semester
  },
  SET_GROUP: (state, group) => {
    state.group = group
  }
}

const actions = {
  // user login
  login({ commit }, userInfo) {
    const { username, password, group, semester } = userInfo
    return new Promise((resolve, reject) => {
      login({ username: username.trim(), password: password, group: group, semester: semester }).then(response => {
        const { data } = response
        console.log('login actions返回的消息', data)
        commit('SET_TOKEN', data.token)
        commit('SET_SEMESTER', data.semester)
        commit('SET_GROUP', data.group)
        setToken(data.token)
        resolve()
      }).catch(error => {
        reject(error)
      })
    })
  },

  // get user info
  getInfo({ commit, state }) {
    return new Promise((resolve, reject) => {
      console.log('before getInfo', state.token)
      getInfo(state.token).then(response => {
        const { data } = response
        console.log('getInfo返回了', response)
        if (!data) {
          return reject('Verification failed, please Login again.')
        }

        const { name, avatar, group } = data
        commit('SET_NAME', name)
        commit('SET_AVATAR', avatar)
        commit('SET_GROUP', group)
        resolve(data)
      }).catch(error => {
        console.log('getInfo函数出错', error)
        reject(error)
      })
    })
  },

  // user logout
  logout({ commit, state }) {
    return new Promise((resolve, reject) => {
      logout(state.token).then(() => {
        removeToken() // must remove  token  first
        resetRouter()
        commit('RESET_STATE')
        resolve()
      }).catch(error => {
        reject(error)
      })
    })
  },

  // remove token
  resetToken({ commit, newsemester }) {
    return new Promise(resolve => {
      removeToken() // must remove  token  first
      commit('RESET_STATE')
      resolve()
    })
  },

  //管理员修改学期
  changeSemester({ commit }, semester){
    console.log('进入修改学期')
    const newsemester = semester
    commit('SET_SEMESTER',newsemester)
  }
}

export default {
  namespaced: true,
  state,
  mutations,
  actions
}


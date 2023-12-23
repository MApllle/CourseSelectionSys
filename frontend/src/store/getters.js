const getters = {
  sidebar: state => state.app.sidebar,
  device: state => state.app.device,
  token: state => state.user.token,
  avatar: state => state.user.avatar,
  name: state => state.user.name,
  semester:state => state.user.semester,
  group: state => state.user.group,
  permission_routes: state => state.permission.routes,
}
export default getters

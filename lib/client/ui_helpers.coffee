helpers =
  avatarUser : (owner={}) ->
    login = owner.login || @user?.login || @login
    services:
      github:
        username: login

  routeIs : (route) ->
    Router.current().route.getName() is route

  formatDate : (date, str) ->
    if str instanceof String
      moment(date).format(str)
    else
      moment(date).fromNow()

# register helpers
for key, val of helpers
  UI.registerHelper key, val

App = @App || {}
App.helpers = helpers
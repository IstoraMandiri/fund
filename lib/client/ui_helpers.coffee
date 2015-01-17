App = @App || {}

App.helpers = App.helpers || {}

App.helpers.avatarUser = avatarUser = (owner={}) ->
  login = owner.login || @user?.login || @login
  services:
    github:
      username: login

UI.registerHelper 'routeIs', (route) ->
  Router.current().route.getName() is route

UI.registerHelper 'avatarUser', avatarUser
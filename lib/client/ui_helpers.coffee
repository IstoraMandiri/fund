helpers =
  _equals: (var1, var2) -> var1 is var2

  _multiply: (var1, var2) -> var1 * var2

  toJSON: (obj) -> marked "```" + JSON.stringify((obj || @), null, 2) + "```"

  avatarUser : (owner={}) ->
    login = @services?.github?.username || owner.login || @user?.login || @login
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

  countTo: (num) -> [0...num]

# register helpers
for key, val of helpers
  UI.registerHelper key, val

@App || @App = {} # init @App if it isn't defined yet
App.helpers = helpers

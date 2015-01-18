CURRENCY = "$"

helpers =
  _equals: (var1, var2) -> var1 is var2

  _multiply: (var1, var2) -> var1 * var2

  toJSON: (obj) ->
    marked """
      ```
      #{JSON.stringify((obj || @), null, 2)}
      ```
    """

  avatarUser : (owner={}) ->
    login = @services?.github?.username || owner.login || @user?.login || @login
    services:
      github:
        username: login

  routeIs : (route) ->
    Router.current().route.getName() is route

  formatDate : (date, str) ->
    unless date
      return false
    if str instanceof String
      moment(date).format(str)
    else
      moment(date).fromNow()

  countTo: (num) -> [0...num]

  routeName: -> Router.current().route.getName()

  formatCurrency : (nStr, hideSign) ->
    if !nStr?
      return ' -'
    nStr += ''
    x = nStr.split('.')
    x1 = x[0]
    x2 = if (x.length > 1) then ('.' + x[1]) else ''
    rgx = /(\d+)(\d{3})/
    while rgx.test(x1)
      x1 = x1.replace(rgx, '$1' + ',' + '$2')

    numberString = x1 + x2
    if hideSign is 'hide'
      sign = ''
    else
      sign = CURRENCY || ''
    return "#{sign}#{numberString}"



# register helpers
for key, val of helpers
  UI.registerHelper key, val

@App || @App = {} # init @App if it isn't defined yet
App.helpers = helpers

Accounts.onCreateUser (options, user) ->
  accessToken = user.services.github.accessToken

  result = Meteor.http.get "https://api.github.com/user",
    params:
      access_token: accessToken
    headers:
      "User-Agent": "Meteor/1.0"

  if result.error
    console.log result
    throw result.error

  profile = _.pick(result.data, "login", "name", "url", "company", "blog", "location", "email", "bio", "html_url")
  user.profile = profile

  return user
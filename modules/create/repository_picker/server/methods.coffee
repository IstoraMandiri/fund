cleanUrls = (obj) ->
  for key, val of obj
    if key.indexOf('_url') > -1
      delete obj[key]
    else if val is Object(val)
      val = cleanUrls(val)
  return obj

Meteor.methods
  createFund : (options) ->
    unless Meteor.userId()
      throw new Meteor.Error 'You must be logged in to create a fund'
    else unless options.issue_number and options.repo_name
      throw new Meteor.Error 'Invalid params'

    repoUrl = "https://api.github.com/repos/#{options.repo_name}"
    issueUrl = "https://api.github.com/repos/#{options.repo_name}/issues/#{options.issue_number}"

    repoRes = do Meteor.wrapAsync (callback) -> Meteor.http.get repoUrl, {headers: {"User-Agent": "Meteor/1.0"}}, callback
    issueRes = do Meteor.wrapAsync (callback) -> Meteor.http.get issueUrl, {headers: {"User-Agent": "Meteor/1.0"}}, callback

    unless repoRes.data and issueRes.data
      throw new Meteor.Error 'Problem reaching github'

    user = Meteor.users.findOne Meteor.userId()

    fund =
      published: false
      creatorId: user._id
      issue: cleanUrls issueRes.data
      repo: cleanUrls repoRes.data

    unless user.services.github.username is fund.repo.owner.login
      throw new Meteor.Error 'You can only create funds for repos you own right now'

    if Fund.cols.Funds.findOne {'issue.id' : fund.issue.id, 'creatorId': user._id}
      throw new Meteor.Error 'You have already created a fund on this issue'

    return Fund.cols.Funds.insert fund

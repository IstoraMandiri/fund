issue = new ReactiveDict()
comments = new ReactiveDict()
commentsLoaded = new ReactiveVar false

Template.githubIssueTab.created = (e, tmpl) ->
  fund = @data
  $.get("https://api.github.com/repos/#{fund.repo.full_name}/issues/#{fund.issue.number}").done (data) ->
    issue.set fund._id, data

Template.githubIssueTab.helpers
  issue: -> issue.get @_id

Template.fundGithubComments.created = (e, tmpl) ->
  fund = @data
  unless comments.get fund._id
    commentsLoaded.set false
  $.get("https://api.github.com/repos/#{fund.repo.full_name}/issues/#{fund.issue.number}/comments").done (data) ->
    comments.set fund._id, data
    commentsLoaded.set true

Template.fundGithubComments.helpers
  comments: -> comments.get @_id
  commentsLoaded: -> commentsLoaded.get @_id
template_name = 'repository_picker'

issues = new ReactiveDict

Template[template_name].helpers
  issues : -> issues.get @id

Template[template_name].events
  'click .repo-name' : (e) ->
    repo = @
    $target = $(e.currentTarget)
    unless $target.hasClass 'text-loading' # prevent double clicking
      $target.addClass 'text-loading'
      $.get("https://api.github.com/repos/#{repo.full_name}/issues").done (data) ->
        data = _.map data, (issue) ->
          issue.repo_name = repo.full_name
          return issue
        issues.set repo.id, data
        $target.removeClass 'text-loading'

  'click .issue-name' : (e) ->
    $target = $(e.currentTarget)
    unless $target.hasClass 'text-loading' # prevent double clicking
      $target.addClass 'text-loading'
      Meteor.call 'createFund',
        issue_number: @number
        repo_name: @repo_name
      , (err, fundId) ->
        if err
          EZModal
            title: "Error!"
            body: err.error
        else
          Router.go 'fund', {_id: fundId}

        $target.removeClass 'text-loading'

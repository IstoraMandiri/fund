issues = new ReactiveVar null

Router.route '/create',

  template: 'issue_finder'

  data:
    issues: -> issues.get()

  onBeforeAction: ->
    githubToken = Meteor.user()?.services?.github?.accessToken
    if githubToken
      $.get "https://api.github.com/issues",
        access_token : githubToken
        filter: 'all'
        state: 'open'
      .done (data) ->
        issues.set data
    @next()

Template.issue_finder.helpers
  tableSettings: ->
    collection: issues.get()
    rowClass: (obj) -> if obj.repository.private then 'text-muted'
    rowsPerPage : 30
    fields: [
      key: 'created_at'
      label: 'Created'
    ,
      key:'repository.full_name'
      label: "Repo Name"
    ,
      label: 'Issue'
      key: 'title'
      tmpl: Template['issue_finder_issue_cell']
    ,
      label: 'Type'
      key: 'repository.private'
      fn: (val) -> if val then 'Private' else 'Public'
    ]

Template.issue_finder_issue_cell.events
  'click .new-issue' : (e) ->
    e.preventDefault()
    $target = $(e.currentTarget)
    unless $target.hasClass 'text-loading' # prevent double clicking
      $target.addClass 'text-loading'
      Meteor.call 'createFund',
        issue_number: @number
        repo_name: @repository.full_name
      , (err, fundId) ->
        if err
          EZModal
            title: "Error!"
            body: err.error
        else
          Router.go 'fund', {_id: fundId}

        $target.removeClass 'text-loading'

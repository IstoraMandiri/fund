githubComments = new ReactiveDict()

Router.route '/fund/:_id',
  template: 'fund'
  name: 'fund'
  onBeforeAction: ->
    fund = Fund.cols.Funds.findOne @params._id
    if fund
      $.get("https://api.github.com/repos/#{fund.repo.full_name}/issues/#{fund.issue.number}/comments").done (data) ->
        githubComments.set fund._id, data

    @next()
  data: ->
    thisId = @params._id
    fund: -> Fund.cols.Funds.findOne thisId
    githubComments: -> githubComments.get thisId

Template.fund.events
  'click .history-back a' : (e) ->
    e.preventDefault()
    history.back()
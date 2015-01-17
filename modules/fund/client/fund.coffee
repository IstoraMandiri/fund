activeTab = new ReactiveVar()

Router.route '/fund/:_id', ->
  fund = => App.cols.Funds.findOne @params._id

  activeTab.set 'fundDetails'

  if fund()
    @render 'fund',
      data: fund
  else
    @render 'spinner'
,
  name: 'fund'


Template.fund.helpers
  tabTemplate: -> Template["#{activeTab.get()}Tab"]
  activeTabIs: (tab) -> activeTab.get() is tab
  isOwner: -> @creatorId is Meteor.userId()
  fundCreatorIsIssueCreator: -> @creatorId is @

Template.fund.events
  'click .history-back' : (e) ->
    e.preventDefault()
    history.back()

  'click .tab-switch' : (e) ->
    activeTab.set $(e.currentTarget).data('tab')
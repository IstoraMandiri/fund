activeTab = new ReactiveDict()

Router.route '/fund/:_id', ->
  fund = => App.cols.Funds.findOne @params._id

  activeTab.setDefault @params._id, 'fundDetails'

  if fund()
    @render 'fund',
      data: fund
  else
    @render 'spinner'
,
  name: 'fund'


Template.fund.helpers
  tabTemplate: -> Template["#{activeTab.get(@_id)}Tab"]

Template.fundSubMenu.helpers
  isOwner: -> @creatorId is Meteor.userId()
  activeTabIs: (tab) -> activeTab.get(@_id) is tab

Template.fundSubMenu.events
  'click .tab-switch' : (e) ->
    activeTab.set @_id, $(e.currentTarget).data('tab')
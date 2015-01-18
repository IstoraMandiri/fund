slugs =
  'details':'fundDetails'
  'developer':'creatorProfile'
  'comments':'fundComments'
  'issue':'githubIssue'
  'activity':'fundActivity'
  'settings':'fundSettings'


Router.route '/fund/:_id', ->
  @redirect @originalUrl + '/details'
,
  name: 'fund'


Router.route '/fund/:_id/:slug', ->

  fund = => App.cols.Funds.findOne @params._id

  if fund()
    @render 'fund',
      to: 'aboveContent'
      data: fund

    @render "#{slugs[@params.slug]}Tab",
      data: fund

  else
    @render 'spinner'
,
  name: 'fundTab'

Template.fundSubMenu.helpers
  isOwner: -> @creatorId is Meteor.userId()
  activeTabIs: (tab) -> tab is Router.current().params.slug
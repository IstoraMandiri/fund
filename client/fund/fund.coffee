slugs =
  'details':'fundDetails'
  'pledge':'makePledge'
  'developer':'creatorProfile'
  'comments':'fundComments'
  'issue':'githubIssue'
  'activity':'fundActivity'
  'settings':'fundSettings'


Router.route '/fund/:_id', ->
  $(window).scrollTop(0)
  @redirect @originalUrl + '/details'
,
  name: 'fund'


getFund = (_id) -> App.cols.Funds.findOne _id

Router.route '/fund/:_id/:slug', ->

  if getFund @params._id
    @render 'fund',
      to: 'aboveContent'
      data: -> getFund @params._id

    @render "#{slugs[@params.slug]}Tab",
      data: -> getFund @params._id

  else
    @render 'spinner'
,
  name: 'fundTab'

Template.fundSubMenu.helpers
  isOwner: -> @creatorId is Meteor.userId()
  activeTabIs: (tab) -> tab is Router.current().params.slug
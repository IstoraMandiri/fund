@Fund =
  cols :
    Funds : new Mongo.Collection 'Funds'
    Pledges : new Mongo.Collection 'Pledges'




Fund.cols.Funds.helpers
  creator : ->
    Meteor.users.findOne @creatorId
Funds = new Mongo.Collection 'Funds'

Funds.helpers
  creator: -> Meteor.users.findOne @creatorId

App.cols.Funds = Funds

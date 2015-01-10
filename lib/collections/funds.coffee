Funds = new Mongo.Collection 'Funds'

Funds.helpers
  creator: -> Meteor.users.findOne @creatorId

Fund.cols.Funds = Funds

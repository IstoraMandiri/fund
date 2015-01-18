Funds = new Mongo.Collection 'Funds'

Funds.helpers
  creator: -> Meteor.users.findOne @creatorId

  percentOfGoal: -> Math.ceil((@fund.amountRaised / @fund.targetAmount) * 100)

App.cols.Funds = Funds

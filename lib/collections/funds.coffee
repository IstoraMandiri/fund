Funds = new Mongo.Collection 'Funds'

Funds.helpers
  creator: -> Meteor.users.findOne @creatorId

  percentOfGoal: -> Math.ceil((@fund.amountRaised / @fund.targetAmount) * 100) || 0

  recentPledges: (limit) -> App.cols.Pledges.find({fundId: @_id}, {sort:{createdAt:-1}, limit:limit})

App.cols.Funds = Funds

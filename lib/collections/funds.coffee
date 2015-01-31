Funds = new Mongo.Collection 'Funds'

Funds.helpers
  bonuses: (query={}, options={}) ->
    query.fundId = @_id
    options.sort?= {}
    options.sort.minimumPledge = 1
    App.cols.Bonuses.find query, options

  createBonus : ->
    App.cols.Bonuses.insert {fundId : @_id}

  creator: ->
    Meteor.users.findOne @creatorId

  percentOfGoal: ->
    Math.floor((@fund.amountRaised / @fund.targetAmount) * 100) || 0

  recentPledges: (limit) ->
    App.cols.Pledges.find({fundId: @_id}, {sort:{createdAt:-1}, limit:limit})

App.cols.Funds = Funds

Meteor.methods
  makePledge : (options) ->
    user = Meteor.users.findOne @userId
    fund = App.cols.Funds.findOne options.fundId
    bonus = App.cols.Bonuses.findOne options.bonusId

    # TODO do some validation
    # min/max amount, etc.
    # validate bonus is available

    unless user and fund
      throw new Meteor.Error 'Incorrect params'

    newPledge = App.cols.Pledges.insert
      userId: user._id
      user: user.profile
      fundId: fund._id
      bonus: bonus
      createdAt: new Date()
      amount: options.amount

    unless newPledge
      throw new Meteor.Error 'Error creating pledge'

    # That's it! Fund total is handled by observer

    return newPledge
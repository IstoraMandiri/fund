Meteor.methods
  makePledge : (fundId, amount) ->
    user = Meteor.users.findOne @userId
    fund = App.cols.Funds.findOne fundId

    # do some validation
    # min/max amount, etc.

    unless user and fund
      throw new Meteor.Error 'Incorrect params'

    newPledge = App.cols.Pledges.insert
      userId: user._id
      user: user.profile
      fundId: fund._id
      createdAt: new Date()
      amount: amount

    unless newPledge
      throw new Meteor.Error 'Error creating pledge'

    # That's it! Fund total is handled by observer

    return newPledge
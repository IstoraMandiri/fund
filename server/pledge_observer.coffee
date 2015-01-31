# run aggergation each time items pledges is modified

recalculateFund = (doc) ->
  total = App.cols.Pledges.aggregate [
    $match:
      fundId: doc.fundId
  ,
    $group:
      _id: null
      amountRaised:
        $sum: "$amount"
  ]

  fund = App.cols.Funds.findOne doc.fundId
  newTotal = total[0].amountRaised

  update = {'fund.amountRaised': newTotal}
  update['fund.targetReached'] = newTotal >= fund.fund.targetAmount

  App.cols.Funds.update doc.fundId,
    $set: update

Meteor.startup ->
  App.cols.Pledges.find().observe
    _suppress_initial: true
    added : recalculateFund
    removed : recalculateFund
    changed : recalculateFund

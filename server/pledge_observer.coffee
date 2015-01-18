# run aggergation each time items pledges is modified

recalculateFund = (doc) ->
  total = App.cols.Pledges.aggregate [
    $match:
      fundId: doc.fundId
  ,
    $group:
      _id: null
      totalRaised:
        $sum: "$amount"
  ]

  App.cols.Funds.update doc.fundId,
    $set:
      'fund.amountRaised': total[0].totalRaised

Meteor.startup ->
  App.cols.Pledges.find().observe
    _suppress_initial: true
    added : recalculateFund
    removed : recalculateFund
    updated : recalculateFund

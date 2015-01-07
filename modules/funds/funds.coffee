Router.route '/funds',
  data:
    funds: -> Fund.cols.Funds.find()
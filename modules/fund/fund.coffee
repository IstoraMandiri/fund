Router.route '/fund/:_id',
  template: 'fund'
  name: 'fund'
  data: -> Fund.cols.Funds.findOne @params._id
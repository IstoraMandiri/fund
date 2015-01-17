Router.route '/funds',
  data:
    funds: -> App.cols.Funds.find({}, {sort:{createdAt: -1}})

Template.funds.helpers
  tableSettings : ->
    collection: @funds()
    rowsPerPage : 30
    fields: [
      key: 'createdAt'
      label: 'Created'
      sort: 'desc'
    ,
      key: 'repo.full_name'
      label: "Repo Name"
    ,
      label: '#'
      key: 'issue.number'
    ,
      label: 'Name'
      key: 'fund.title'
      tmpl: Template['funds_issue_cell']
    ,
      label: 'Creator'
      key: 'creatorId'
      fn: (val) -> Meteor.users.findOne(val)?.profile.login
    ]

    # console.log 'hello table', @
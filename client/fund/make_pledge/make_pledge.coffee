
Template.makePledgeTab.events
  'click .make-pledge' : (e) ->
    amount = $(e.currentTarget).data('amount')
    thisId = @_id

    EZModal
      title: "Please Confirm"
      bodyHtml: "<p>Make a pledge for <strong>#{App.helpers.formatCurrency amount}</strong></p><p>on <strong>#{@fund.title}</strong>"
      leftButtons : [ html : 'Cancel' ]
      rightButtons: [
        html: 'Confirm'
        color: 'success'
        fn : ->
          thisModal = @EZModal
          Meteor.call 'makePledge', thisId, amount, (err) ->
            thisModal.modal 'hide'
            EZModal 'Thanks!'
      ]


Template.makePledgeTab.helpers
  tableSettings: ->
    collection: App.cols.Pledges.find({fundId: @_id})
    rowsPerPage : 30
    fields: [
      key: 'createdAt'
      label: 'Created'
      sort: 'desc'
      sortByValue: true
      fn: (val) -> App.helpers.formatDate val
    ,
      key: 'amount'
      label: "Amount"
      sortByValue: true
      fn: (val) -> App.helpers.formatCurrency val
    ,
      key: 'user.login'
      label: 'User Login'
    ,
      key: 'user.name'
      label: 'Name'
    ]

currentPledgeAmount = new ReactiveVar 1
bonusSelected = new ReactiveVar()

Template.makePledgeTab.rendered = ->
  currentPledgeAmount.set 1
  bonusSelected.set null


Template.makePledgeTab.events
  'click .submit-pledge' : (e, tmpl) ->
    fundId = @_id
    bonusId = bonusSelected.get()
    amount = currentPledgeAmount.get()

    # show warning if no bonus selected

    EZModal
      title: "Please Confirm"
      dataContext:
        fund: @fund
        bonus: App.cols.Bonuses.findOne bonusId
        amount: amount
      bodyTemplate: 'makePledgeModalConfirm'
      leftButtons : [ html : 'Cancel' ]
      rightButtons: [
        html: 'Confirm'
        color: 'success'
        fn : ->
          thisModal = @EZModal
          Meteor.call 'makePledge',
            fundId: fundId
            bonusId: bonusId
            amount: amount
          , (err) ->
            thisModal.modal 'hide'
            EZModal 'Thanks!'
      ]




  'input .pledge-amount-slider, change .pledge-amount-number' : (e) ->
    currentPledgeAmount.set parseInt e.currentTarget.value

  'click .select-bonus .bonus.enabled': ->
    bonusSelected.set @_id

Template.makePledgeTab.helpers
  enabledBonuses: ->
    @bonuses {enabled: true}

  currentPledgeAmount : -> currentPledgeAmount.get()

  bonusAvailable: ->
    if @minimumPledge <= currentPledgeAmount.get()
      return true
    else if bonusSelected.get() is @_id
      bonusSelected.set null

  isBonusSelected: ->
    bonusSelected.get() is @_id

  selectedBonusId: -> bonusSelected.get()

  willReachGoal : ->
    # return true if the current pledge will cause the goal to be reached
    if @fund.amountRaised >= @fund.targetAmount
      return false
    else if (@fund.targetAmount - @fund.amountRaised) <= currentPledgeAmount.get()
      return true

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
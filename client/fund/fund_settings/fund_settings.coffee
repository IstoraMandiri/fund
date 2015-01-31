Template.fundSettingsTab.events
  'submit .fund-settings' : (e, tmpl) ->
    e.preventDefault()
    query = $set: {}
    for formItem in $(e.target).serializeArray()
      if formItem.name is 'fund.targetAmount'
        formItem.value = parseInt formItem.value
      query.$set[formItem.name] = formItem.value
    App.cols.Funds.update @_id, query
    return false


editingBonusId = new ReactiveVar()

Template.bonusesEditor.events

  'click .bonus-item' : ->
    editingBonusId.set @_id

  'click .create-bonus' : ->
    newBonus = @createBonus()
    editingBonusId.set newBonus

  'click .save-bonus' : (e, tmpl) ->
    query = $set: {enabled:false}
    for formItem in $(tmpl.firstNode).find('form').serializeArray()
      if formItem.name is 'enabled'
        formItem.value = true
      if formItem.name is 'minimumPledge'
        formItem.value = parseInt formItem.value
      query.$set[formItem.name] = formItem.value
    App.cols.Bonuses.update @_id, query
    editingBonusId.set null

  'click .remove-bonus': (e) ->
    self = @
    EZModal
      title: 'Please confirm bonus removal'
      body: self.title
      leftButtons: [
        html:'Cancel'
      ]
      rightButtons: [
        color:'danger'
        html:'Remove Bonus'
        fn: ->
          App.cols.Bonuses.remove self._id
          editingBonusId.set null
          @EZModal.modal('hide')
      ]

Template.bonusesEditor.helpers

  isEditingBonus : ->
    editingBonusId.get() is @_id

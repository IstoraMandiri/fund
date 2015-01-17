Template.fundSettingsTab.events
  'submit .fund-settings' : (e, tmpl) ->
    e.preventDefault()
    query = $set: {}
    for formItem in $(e.target).serializeArray()
      query.$set[formItem.name] = formItem.value
    App.cols.Funds.update @_id, query
    return false
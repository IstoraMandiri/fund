Template.fundAmountTracker.helpers
  hideButton: -> Router.current().params.slug is 'pledge'
  pbColor: ->
    perecent = @percentOfGoal()
    if perecent < 25
      'danger'
    else if perecent < 50
      'warning'
    else if perecent < 75
      'info'
    else if perecent < 100
      'primary'
    else
      'success'

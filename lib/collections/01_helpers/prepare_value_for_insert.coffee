@App.cols_helpers ?= {}

App.cols_helpers.insertValueOrUnset = (context, value) ->
  # Set the value only a new document is inserted
  if context.isInsert
    return value
  else if context.isUpsert
    return {$setOnInsert: value}
  else
    context.unset()
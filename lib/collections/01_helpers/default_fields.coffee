@App.cols_helpers ?= {}

helpers = App.cols_helpers

App.cols_helpers.time_fields =
  createdAt:
    type: Date
    autoValue: ->
      helpers.insertValueOrUnset(@, new Date)

  updatedAt:
    type: Date
    denyInsert: true
    optional: true
    autoValue: ->
      if this.isUpdate
        return new Date()
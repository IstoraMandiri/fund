helpers = App.cols_helpers

SimpleSchema.messages
  unknownUserid: "Unknown userid"

Schema =
  published:
    type: Boolean

  creatorId:
    type: String
    autoValue: () ->
      helpers.insertValueOrUnset(@, this.value)
    custom: () ->
      value = "" + @value

      # From simple-schema docs: "Any non-string return value means the value is valid"
      if not Meteor.users.findOne({_id: value})?
        return "unknownUserid"

  # XXX we need to check this periodically, preferably fetch it from github
  # each time
  creatorIsCollaborator:
    type: Boolean

  issue:
    type: Object
    blackbox: true

  fund:
    type: Object
    blackbox: true

  repo:
    type: Object
    blackbox: true

  amountRaised:
    type: Number
    defaultValue: 0

  targetAmount:
    type: Number
    defaultValue: 500

_.extend(Schema, helpers.time_fields)

Funds = new Mongo.Collection 'Funds'

Funds.attachSchema Schema

Funds.helpers
  creator: -> Meteor.users.findOne @creatorId

  percentOfGoal: -> Math.ceil((@fund.amountRaised / @fund.targetAmount) * 100) || 0

  recentPledges: (limit) -> App.cols.Pledges.find({fundId: @_id}, {sort:{createdAt:-1}, limit:limit})

# Export
App.cols.Funds = Funds

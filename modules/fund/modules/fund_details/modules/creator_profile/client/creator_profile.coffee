profiles = new ReactiveDict()

Template.creatorProfile.created = ->
  console.log @
  # $.get("https://api.github.com/users/#{fund.repo.full_name}/issues/#{fund.issue.number}").done (data) ->
    # issue.set fund._id, data

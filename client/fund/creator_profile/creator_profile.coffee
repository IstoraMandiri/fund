profiles = new ReactiveDict()

Template.creatorProfileTab.created = ->
  creatorGithub = @data.creator().profile.login
  $.get("https://api.github.com/users/#{creatorGithub}").done (data) ->
    profiles.set creatorGithub, data

Template.creatorProfileTab.helpers
  githubData: -> profiles.get @profile.login
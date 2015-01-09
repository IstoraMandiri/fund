loaded = new ReactiveVar false
repos = new ReactiveVar null

sub_layout = 'main_create'
template_name = 'repository_picker'

#console.log Router.regionsMapper([template_name, sub_layout])
Router.route '/create',
  template: "create_layout"

  yieldRegions: Router.regionsMapper([template_name, sub_layout])

  data:
    repos: -> repos.get()
    loaded: -> loaded.get()

  onBeforeAction: ->
    loaded.set false
    githubUsername = Meteor.user()?.services?.github?.username
    if githubUsername
      $.get("https://api.github.com/users/#{githubUsername}/repos").done (data) ->
        repos.set data
        loaded.set true
    @next()

moment.locale("en")

Router.configure
  onAfterAction: ->
    $(window).scrollTop(0);

Accounts.ui.config
  requestPermissions:
    github: ['user', 'repo']

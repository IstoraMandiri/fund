moment.locale("en")

Router.configure
  onAfterAction: ->
    $(window).scrollTop(0);
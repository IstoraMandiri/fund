Template.fundOwnership.helpers
  owners: ->
    repoOwner = @repo.owner
    fundOwner = @creator()?.profile

    unless repoOwner and fundOwner
      return []

    if fundOwner.login is repoOwner.login
      users = [
        label: 'Fund Creator and Respository Owner'
        user: fundOwner
        collaborator: true
      ]

    else
      users = [
        label: 'Fund Creator'
        user: fundOwner
        collaborator: @creatorIsCollaborator
      ,
        label: 'Respository Owner'
        user: repoOwner
      ]

    return users
Template.fundOwnership.helpers
  owners: ->
    repoOwner = @repo.owner
    issueOwner = @issue.user
    fundOwner = @creator()?.profile

    unless repoOwner and issueOwner and fundOwner
      return []

    else if repoOwner.login is issueOwner.login is fundOwner.login
      users = [
        label: 'Fund Creator, Issue Author and Repository Collaborator'
        user: fundOwner
      ]

    else if fundOwner.login is issueOwner.login
      users = [
        label: 'Fund Creator and Issue Author'
        user: fundOwner
      ,
        label: 'Repository Owner'
        user: repoOwner
      ]

    else if fundOwner.login is repoOwner.login
      users = [
        label: 'Fund Creator and Respository Collaborator'
        user: fundOwner
      ,
        label: 'Issue Author'
        user: issueOwner
      ]

    else
      users = [
        label: 'Fund Creator'
        user: fundOwner
      ,
        label: 'Issue Author'
        user: issueOwner
      ,
        label: 'Respository Owner'
        user: repoOwner
      ]

    return users
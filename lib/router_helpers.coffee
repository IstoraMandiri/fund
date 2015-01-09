_.extend Router,
  regionsMapper: ->
    # converts [from , to], [from, to]... arguments to {from: {to: to}, from: {to: to}} object
    regions_map = {}

    for i in arguments
      regions_map[i[0]] = {to: i[1]}

    return regions_map

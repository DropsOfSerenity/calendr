isAfterNowFilter = ->
  return (items) ->
    return _.filter items, (item) ->
      return moment(item.due_date).isAfter(moment())

isBeforeNowFilter = ->
  return (items) ->
    return _.filter items, (item) ->
      return moment(item.due_date).isBefore(moment())

angular.module 'calendr'
  .filter 'isAfterNow', isAfterNowFilter
  .filter 'isBeforeNow', isBeforeNowFilter

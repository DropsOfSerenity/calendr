isAfterNowFilter = ->
  return (items) ->
    return _.filter items, (item) ->
      return moment(item.due_date).isAfter(new Date())

isBeforeNowFilter = ->
  return (items) ->
    return _.filter items, (item) ->
      return moment(item.due_date).isBefore(new Date())

angular.module 'calendr'
  .filter 'isAfterNow', isAfterNowFilter
  .filter 'isBeforeNow', isBeforeNowFilter

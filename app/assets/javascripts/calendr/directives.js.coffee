jsCalendar = ->
  return {
    rescrict: 'E'
    templateUrl: 'directives/calendar.html'
    scope: {}
    link: (scope, elem, attrs) ->
      scope.selected = moment()
  }

angular
  .module 'calendr'
  .directive 'jsCalendar', jsCalendar

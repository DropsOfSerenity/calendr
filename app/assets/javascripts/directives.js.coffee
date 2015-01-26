#*
# small wrapper directive around pickadate.js
#
pickADate = ($filter) ->
  return {
    restrict: 'A'
    scope: {
      'ngModel': '=?'
    }
    require: 'ngModel'
    link: (scope, elem, attrs, ngModel) ->
      ngModel.$parsers.push (data) ->
        return data

      ngModel.$formatters.push (data) ->
        return $filter('date')(data, "fullDate")

      picker = $(elem).pickadate({
        onSet: (context) ->
          if context.hasOwnProperty 'clear'
            ngModel.$setViewValue ''
          else
            selected = this.get('select')
            date = new Date(selected.year, selected.month, selected.date)
            scope.ngModel = date
          elem.trigger 'input'
          scope.$apply()
        onOpen: () ->
          # fixes a bug in pickadate on ios 8
          $(elem).blur()
      })
      return
  }

clearServerError = ->
  return {
    restrict: 'A'
    require: '?ngModel'
    link: (scope, elem, attrs, ctrl) ->
      elem.on 'input', ->
        scope.$apply ->
          ctrl.$setValidity('server', true)
  }

angular.module 'calendr'
  .directive 'pickADate', pickADate
  .directive 'clearServerError', clearServerError

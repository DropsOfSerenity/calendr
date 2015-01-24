#*
# small wrapper directive around pickadate.js
#
pickADate = ->
  return {
    restrict: 'A'
    scope: {}
    require: 'ngModel'
    link: (scope, elem, attrs, ngModel) ->
      picker = $(elem).pickadate({
        onSet: (context) ->
          if context.hasOwnProperty 'clear'
            ngModel.$setViewValue ''
          else
            ngModel.$setViewValue(this.get('select')?.obj)
          elem.trigger 'input'
          scope.$apply()
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

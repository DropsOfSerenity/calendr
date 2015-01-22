#*
# small wrapper directive around pickadate.js
#
pickADate = ->
  return {
    restrict: 'A'
    scope:
      pickADate: '='
    link: (scope, elem, attrs) ->
      picker = $(elem).pickadate({
        onSet: (context) ->
          if context.hasOwnProperty 'clear'
            scope.pickADate = ''
          else
            scope.pickADate = this.get('select')?.obj
          scope.$apply()
      })
      return
  }

angular.module 'calendr'
  .directive 'pickADate', pickADate

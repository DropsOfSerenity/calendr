
BaseCtrl = ($mdDialog) ->
  @showLogin = (ev) ->
    $mdDialog.show({
      controller: 'LoginCtrl'
      templateUrl: 'partials/_login.html'
      targetEvent: ev
    })

  @showRegister = (ev) ->
    $mdDialog.show({
      controller: 'RegisterCtrl'
      templateUrl: 'partials/_register.html'
      targetEvent: ev
    })

  return

AllCtrl = ->
  @

HomeworkAddCtrl = () ->
  @homework = {}

  @create = =>
    console.log @homework

  @

LoginCtrl = ($scope) ->
  $scope.login = {}

  $scope.doLogin = ->
    console.log $scope.login

RegisterCtrl = ($scope) ->
  $scope.register = {}

  $scope.doRegister = ->
    console.log $scope.register

angular
  .module 'calendr'
  .controller 'AllCtrl', AllCtrl
  .controller 'BaseCtrl', BaseCtrl
  .controller 'HomeworkAddCtrl', HomeworkAddCtrl
  .controller 'LoginCtrl', LoginCtrl
  .controller 'RegisterCtrl', RegisterCtrl

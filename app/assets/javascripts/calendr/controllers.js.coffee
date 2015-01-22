BaseCtrl = ($mdDialog, Auth) ->
  # authentication stuff here
  Auth.currentUser()
    .then (user) =>
      @current_user = user
    , (error) =>
      @current_user = null

  @loggedIn = Auth.isAuthenticated
  @logout = Auth.logout

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

LoginCtrl = ($scope, Auth, $mdDialog, $state) ->
  $scope.login = {}

  $scope.doLogin = ->
    Auth.login($scope.login)
      .then (user) ->
        $state.go('base.planner-tabs')
        $mdDialog.hide()
      , (error) ->
        $scope.loginForm.password.$setValidity('server', false)

RegisterCtrl = ($scope, Auth, $mdDialog) ->
  $scope.register = {}
  $scope.errors = {}

  $scope.doRegister = ->
    Auth.register($scope.register)
      .then (registeredUser) ->
        $state.go('base.planner-tabs')
        $mdDialog.hide()
      , (response) ->
        angular.forEach response.data.errors, (e, field) ->
          $scope.registerForm[field].$setValidity('server', false)
          $scope.errors[field] = e.join(', ')
angular
  .module 'calendr'
  .controller 'AllCtrl', AllCtrl
  .controller 'BaseCtrl', BaseCtrl
  .controller 'HomeworkAddCtrl', HomeworkAddCtrl
  .controller 'LoginCtrl', LoginCtrl
  .controller 'RegisterCtrl', RegisterCtrl

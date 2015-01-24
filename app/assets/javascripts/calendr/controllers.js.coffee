BaseCtrl = ($scope, $mdDialog, Auth, PusherService, HomeworkService) ->
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

  $scope.$on 'devise:login', (event, currentUser) ->
    HomeworkService.init()
    PusherService.subscribe()
      .then ->
        PusherService.channel.bind 'create', (data) ->
          console.log 'new homework has been created server side...'
          HomeworkService.add(data)

  $scope.$on 'devise:logout', (event, currentUser) ->
    HomeworkService.clear()
    PusherService.unsubscribe()


  return

AllCtrl = (HomeworkService) ->
  @homework = HomeworkService

  @

HomeworkAddCtrl = ($scope, HomeworkService, $state) ->
  @form = {}
  $scope.errors = {}

  @create = =>
    HomeworkService.create(@form)
      .then ->
        $state.go('base.planner-tabs')
      , (response) ->
        angular.forEach response.data.errors, (e, field) ->
          console.log e, field
          $scope.addHomeworkForm[field].$setValidity('server', false)
          $scope.errors[field] = e.join(', ')

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
        $mdDialog.hide()
        $state.go('base.planner-tabs')
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

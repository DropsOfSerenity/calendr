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
        PusherService.channel.bind 'update', (data) ->
          console.log 'existing homework has been updated server side...'
          HomeworkService.update(data)

  $scope.$on 'devise:new-registration', (event, user) ->
    HomeworkService.init()
    PusherService.subscribe()
      .then ->
        PusherService.channel.bind 'create', (data) ->
          console.log 'new homework has been created server side...'
          HomeworkService.add(data)
        PusherService.channel.bind 'update', (data) ->
          console.log 'existing homework has been updated server side...'
          HomeworkService.update(data)

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
  $scope.submitting = false

  $scope.doLogin = ->
    $scope.submitting = true
    Auth.login($scope.login)
      .then (user) ->
        $state.go('base.planner-tabs')
        $mdDialog.hide()
      , (error) ->
        $scope.submitting = false
        $scope.loginForm.password.$setValidity('server', false)

RegisterCtrl = ($scope, Auth, $mdDialog) ->
  $scope.register = {}
  $scope.errors = {}
  $scope.submitting = false

  $scope.doRegister = ->
    $scope.submitting = true
    Auth.register($scope.register)
      .then (registeredUser) ->
        $mdDialog.hide()
      , (response) ->
        $scope.submitting = false
        angular.forEach response.data.errors, (e, field) ->
          $scope.registerForm[field].$setValidity('server', false)
          $scope.errors[field] = e.join(', ')

# controller to provide actionables across all planner tabs
PlannerCtrl = ($mdBottomSheet) ->
  @showBottomGrid = (homework) ->
    console.log homework
    $mdBottomSheet.show {
      templateUrl: 'partials/_actionable-bottom-grid.html'
      controller: ($scope, $mdBottomSheet) ->
        $scope.items = [
          { name: 'Complete', icon: 'check' },
        ]
        $scope.listItemClick = ($index) =>
          if $scope.items[$index].name == 'Complete'
            homework.completed_at = new Date()
            homework.put()

          $mdBottomSheet.hide()
    }
  @

angular
  .module 'calendr'
  .controller 'PlannerCtrl', PlannerCtrl
  .controller 'AllCtrl', AllCtrl
  .controller 'BaseCtrl', BaseCtrl
  .controller 'HomeworkAddCtrl', HomeworkAddCtrl
  .controller 'LoginCtrl', LoginCtrl
  .controller 'RegisterCtrl', RegisterCtrl

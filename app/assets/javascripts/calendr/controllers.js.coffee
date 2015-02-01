BaseCtrl = ($scope, $mdDialog, Auth,
            PusherService, SubjectService, HomeworkService) ->
  # authentication stuff here
  @showLoginAttempt = () ->
    $mdDialog.show({
      templateUrl: 'partials/_login_attempt.html'
      clickOutsideToClose: false
      escapeToClose: false
    })

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

  # here we should block until this is resolved
  @showLoginAttempt()
  Auth.currentUser()
    .then (user) =>
      @current_user = user
      $mdDialog.hide()
    , (error) =>
      @current_user = null
      $mdDialog.hide()
      @showLogin()

  @loggedIn = Auth.isAuthenticated
  @logout = Auth.logout

  $scope.$on 'devise:login', (event, currentUser) ->
    HomeworkService.init()
    SubjectService.init()
    PusherService.subscribe()

  $scope.$on 'devise:new-registration', (event, user) ->
    HomeworkService.init()
    SubjectService.init()
    PusherService.subscribe()

  $scope.$on 'devise:logout', (event, currentUser) ->
    HomeworkService.clear()
    SubjectService.clear()
    PusherService.unsubscribe()


  return

AllCtrl = (HomeworkService) ->
  @homework = HomeworkService

  @upcomingOpen = true
  @pastDueOpen = false
  @completedOpen = false

  @

HomeworkAddCtrl = ($scope, $mdSidenav, SubjectService, HomeworkService, $state) ->
  @subjects = SubjectService

  @newSubject = {color: '#454987'}

  @currentSubject = null
  @selectSubject = (subject) =>
    $mdSidenav('right').toggle()
    @currentSubject = subject


  @addSubject = () =>
    SubjectService.post(@newSubject)
      .then (data) =>
        @newSubject = {color: '#454987'}

  @form = {}
  $scope.errors = {}

  @create = =>
    @form.subject_id = @currentSubject.id
    HomeworkService.post(@form)
      .then ->
        $state.go('base.planner-tabs')
      , (response) ->
        angular.forEach response.data.errors, (e, field) ->
          console.log e, field
          $scope.addHomeworkForm[field].$setValidity('server', false)
          $scope.errors[field] = e.join(', ')

  @toggleSubjectSelector = ->
    $mdSidenav('right').toggle()

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

calendrRun = ->
  FastClick.attach(document.body)
  return

calendrConfig = (
    $stateProvider,
    $locationProvider,
    $urlRouterProvider,
    $mdThemingProvider
  ) ->

  $mdThemingProvider.theme('dark', 'default')
    .dark()

  $stateProvider

    .state 'base',
      url: '/'
      templateUrl: 'base.html'
      controller: 'BaseCtrl as base'
      abstract: true

    .state 'base.planner-tabs',
      url: 'planner'
      views: {
        "": {
          templateUrl: 'planner-tabs.html'
        }
        "all@base.planner-tabs": {
          templateUrl: 'all.html'
          controller: 'AllCtrl as all'
        }
        "priority@base.planner-tabs": {
          templateUrl: 'priority.html'
        }
        "subject@base.planner-tabs": {
          templateUrl: 'subject.html'
        }
      }

    .state 'base.add-homework',
      url: 'homework'
      templateUrl: 'homework.html'
      controller: 'HomeworkAddCtrl as hw'

  $urlRouterProvider.otherwise '/planner'

  # enable HTML5 Mode for SEO
  $locationProvider.html5Mode true

  return

angular
  .module 'calendr', [
    'templates',
    'ui.router',
    'ngAnimate',
    'ngMessages',
    'ngAria',
    'ngMaterial'
  ]
  .run calendrRun
  .config calendrConfig

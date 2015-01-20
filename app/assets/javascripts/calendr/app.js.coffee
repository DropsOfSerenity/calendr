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
      }

    .state 'base.add-homework',
      url: 'homework'
      templateUrl: 'homework.html'

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
  .config calendrConfig

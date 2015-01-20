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
      views: {
        "@": {
          templateUrl: 'base.html'
          controller: 'BaseCtrl as base'
        }
        "all@base": {
          templateUrl: 'all.html'
          controller: 'AllCtrl as all'
        }
      }

  $urlRouterProvider.otherwise '/'

  # enable HTML5 Mode for SEO
  $locationProvider.html5Mode true

  return

angular
  .module 'calendr', [
    'templates',
    'ui.router',
    'ngAnimate',
    'ngAria',
    'ngMaterial'
  ]
  .config calendrConfig

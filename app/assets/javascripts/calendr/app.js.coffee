calendrConfig = (
    $stateProvider,
    $locationProvider,
    $urlRouterProvider,
    $mdThemingProvider
  ) ->

  $mdThemingProvider.theme('default')
    .primaryColor('deep-orange')
    .accentColor('teal')

  $mdThemingProvider.theme('dark', 'default')
    .dark()

  $stateProvider

    .state 'base',
      url: '/'
      templateUrl: 'base.html'
      controller: 'BaseCtrl as base'

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

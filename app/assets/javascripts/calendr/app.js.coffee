calendrConfig = ($stateProvider, $locationProvider, $urlRouterProvider) ->
  $stateProvider

    .state 'base',
      url: '/'
      templateUrl: 'base.html'

  $urlRouterProvider.otherwise '/'

  # enable HTML5 Mode for SEO
  $locationProvider.html5Mode true

  return

angular
  .module 'calendr', [
    'templates',
    'ui.router',
    'ngAnimate'
  ]
  .config calendrConfig

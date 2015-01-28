calendrRun = (RAILS_ENV) ->
  FastClick.attach(document.body)

  if RAILS_ENV == "production"
    window.client = new Pusher('991b568ebb4df6ddf4a2')
  else
    window.client = new Pusher('e575ad5b45914ce7b511')

  return

calendrConfig = (
    $stateProvider,
    $locationProvider,
    $urlRouterProvider,
    $mdThemingProvider
    RestangularProvider
  ) ->

  RestangularProvider.setBaseUrl '/api/v1'
  RestangularProvider.setRequestSuffix '.json'

  $mdThemingProvider.theme('default')
    .primaryColor('blue', {
      'default': '900',
      'hue-1': '100',
      'hue-2': '600',
      'hue-3': 'A100'
    })
    .accentColor('green');
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
          controller: 'PlannerCtrl as planner'
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
    'lib.decorators', # monkey, oooh ooh
    'calendr.config',
    'templates',
    'ui.router',
    'ngAnimate',
    'ngMessages',
    'ngAria',
    'Devise',
    'pusher-angular',
    'restangular',
    'ngMaterial'
  ]
  .run calendrRun
  .config calendrConfig

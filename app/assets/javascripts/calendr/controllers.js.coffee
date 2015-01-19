BaseCtrl = ($mdSidenav) ->
  @openLeftSidebar = ->
    $mdSidenav('left').toggle()

  @

angular
  .module 'calendr'
  .controller 'BaseCtrl', BaseCtrl

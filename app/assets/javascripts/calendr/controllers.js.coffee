BaseCtrl = ->
  @testing = "hello"
  @

AllCtrl = ->
  @

angular
  .module 'calendr'
  .controller 'AllCtrl', AllCtrl
  .controller 'BaseCtrl', BaseCtrl

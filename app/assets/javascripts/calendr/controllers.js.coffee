BaseCtrl = ->
  @testing = "hello"
  @

AllCtrl = ->
  @

HomeworkAddCtrl = () ->
  @homework =
    title: ''
    subject: ''
    description: ''
    date: ''

  @create = =>
    console.log @homework

  @

angular
  .module 'calendr'
  .controller 'AllCtrl', AllCtrl
  .controller 'BaseCtrl', BaseCtrl
  .controller 'HomeworkAddCtrl', HomeworkAddCtrl

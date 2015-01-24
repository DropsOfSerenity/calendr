PusherService = ($pusher, Auth) ->
  @channel = null
  pusher = $pusher(client)

  pusher.connection.bind 'connecting', ->
    console.log 'Connecting to Pusher...'

  pusher.connection.bind 'connected', ->
    console.log 'Connected to Pusher :)'

  pusher.connection.bind 'failed', ->
    console.log 'Connection to Pusher failed.. :('

  pusher.connection.bind 'subscription_error', ->
    console.log 'Pusher Couldn\'t subscribe'

  @subscribe = =>
    Auth.currentUser()
      .then (user) =>
        @channel = pusher.subscribe("private-homework-#{user.id}")

  @unsubscribe = =>
    pusher.unsubscribe(@channel.name)

  @

HomeworkService = (Restangular, $mdToast) ->
  @homework = []
  @initialized = false

  hw = Restangular.all('homework')

  @init = =>
    hw.getList().then (homeworks) =>
      angular.forEach homeworks, (hw) =>
        hw.due_date = new Date(hw.due_date)
        @homework.push(hw)
      @initialized = true

  @add = (homework) =>
    $mdToast.show($mdToast
      .simple()
      .content("#{homework.title} added!")
      .position("bottom right"))
    homework.due_date = new Date(homework.due_date)
    @homework.unshift(homework)

  @create = (homework) =>
    hw.post(homework)

  @clear = =>
    @homework = []
    @initialized = false

  @

angular
  .module 'calendr'
  .service 'PusherService', PusherService
  .service 'HomeworkService', HomeworkService

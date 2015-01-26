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
        @homework.push(hw)
      @initialized = true

  @add = (homework) =>
    Restangular.one('homework', homework.id).get()
      .then (obj) =>
        @homework.push(obj)
        $mdToast.show($mdToast
          .simple()
          .content("#{obj.title} added!")
          .position("bottom right"))

  @update = (homework) =>
    homeworkWithId = _.find @homework, (hw) =>
      return hw.id == homework.id
    Restangular.one('homework', homework.id).get()
      .then (obj) =>
        _.assign(homeworkWithId, obj)
        $mdToast.show($mdToast
          .simple()
          .content("#{obj.title} updated!")
          .position("bottom right"))

  @post = (homework) =>
    hw.post(homework)

  @clear = =>
    @homework = []
    @initialized = false

  @

angular
  .module 'calendr'
  .service 'PusherService', PusherService
  .service 'HomeworkService', HomeworkService

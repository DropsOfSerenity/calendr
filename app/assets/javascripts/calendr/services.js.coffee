PusherService = ($pusher, Auth, HomeworkService) ->
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

  # subscribe to the channel and bind to all necessary events
  @subscribe = =>
    Auth.currentUser()
      .then (user) =>
        @channel = pusher.subscribe("private-calendr-#{user.id}")
        @channel.bind 'homework-create', (data) ->
          console.log 'new homework has been created server side...'
          HomeworkService.add(data)
        @channel.bind 'homework-update', (data) ->
          console.log 'existing homework has been updated server side...'
          HomeworkService.update(data)

  @unsubscribe = =>
    pusher.unsubscribe(@channel.name)

  @


HomeworkService = (Restangular, $mdToast) ->
  @homework = []
  @initialized = false

  # here is all of our homework domain logic, these will be available on any
  # restangular homework object
  Restangular.extendModel 'homework', (model) ->
    return _.extend model,
      timeUntilDue: () ->
        return moment(@due_date).from(moment().startOf('day'))

  hw = Restangular.all('homework')

  # Data population
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

  # Collection
  @upcoming = =>
    upcoming = _.filter @homework, (homework) ->
      return !homework.completed_at && moment(homework.due_date).isAfter(moment())
    return upcoming.sort (a, b) ->
      return new Date(a.due_date) - new Date(b.due_date)


  @pastDue = =>
    past_due = _.filter @homework, (homework) ->
      return !homework.completed_at && moment(homework.due_date).isBefore(moment())
    return past_due.sort (a, b) ->
      return new Date(b.due_date) - new Date(a.due_date)

  @completed = =>
    completed = _.filter @homework, (homework) ->
      return !!homework.completed_at
    return completed.sort (a, b) ->
      return new Date(b.completed_at) - new Date(a.completed_at)

  @

SubjectService = (Restangular) ->
  @subjects = []
  @initialized = false

  subject = Restangular.all('subject')

  # Data population
  @init = =>
    subject.getList().then (subjects) =>
      angular.forEach subjects, (s) =>
        @subjects.push(s)
      @initialized = true

  @add = (homework) =>
    Restangular.one('subject', homework.id).get()
      .then (obj) =>
        @subjects.push(obj)

  @post = (params) ->
    return subject.post(params)

  @clear = =>
    @subjects = []
    @initialized = false

  @

angular
  .module 'calendr'
  .service 'PusherService', PusherService
  .service 'HomeworkService', HomeworkService
  .service 'SubjectService', SubjectService

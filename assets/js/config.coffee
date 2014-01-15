#Setting up route
window.app.config ['$routeProvider', ($routeProvider) ->
  $routeProvider.when('/',
    templateUrl: 'views/pages/home.html'

  ).when('/admin',
    templateUrl: 'views/pages/admin.html'

  ).when('/apps',
    templateUrl: 'views/pages/apps.html'

  # ).when('/articles',
  #   templateUrl: 'views/articles/list.html'

  # ).when('/articles/create',
  #   templateUrl: 'views/articles/create.html'

  # ).when('/articles/:articleId/edit',
  #   templateUrl: 'views/articles/edit.html'

  # ).when('/articles/:articleId',
  #   templateUrl: 'views/articles/view.html'

  ).otherwise redirectTo: '/'
]

#Setting HTML5 Location Mode
window.app.config ['$locationProvider', ($locationProvider) ->
  $locationProvider.html5Mode true
]
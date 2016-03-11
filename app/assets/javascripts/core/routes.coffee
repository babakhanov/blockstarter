angular.module "app.core"
  .config ["$routeProvider", ($routeProvider) ->
    $routeProvider
      .when '/sign_up',
        templateUrl: 'auth/sign_up.html',
        controller: 'registrationCtrl'
      .when '/sign_in',
        templateUrl: 'auth/sign_in.html',
        controller: 'sessionsCtrl'
      .when '/',
        templateUrl: 'pages/index.html',
        controller: 'indexPageCtrl'
      .when '/my_tickets',
        templateUrl: 'pages/my_tickets.html',
        controller: 'myTicketsCtrl'
      .when '/settings',
        templateUrl: 'pages/settings.html',
        controller: 'settingsCtrl'
      .otherwise
        redirectTo: '/'
  ]

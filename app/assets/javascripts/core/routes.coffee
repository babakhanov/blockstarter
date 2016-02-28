angular.module "app.core"
  .config ["$routeProvider", ($routeProvider) ->
    $routeProvider
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

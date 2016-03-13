angular.module "app.core"
  .config ["$routeProvider", ($routeProvider) ->
    $routeProvider
      .when '/',
        templateUrl: 'marketplace/index.html',
        controller: 'marketplaceCtrl'
      .when '/sign_up',
        templateUrl: 'auth/sign_up.html',
        controller: 'registrationCtrl'
      .when '/sign_in',
        templateUrl: 'auth/sign_in.html',
        controller: 'sessionsCtrl'
      .when '/assets',
        templateUrl: 'pages/assets.html',
        controller: 'assetsPageCtrl'
      .when '/my_tickets',
        templateUrl: 'pages/my_tickets.html',
        controller: 'myTicketsCtrl'
      .when '/settings',
        templateUrl: 'pages/settings.html',
        controller: false
      .when '/wallets',
        templateUrl: 'pages/wallets.html',
        controller: 'walletsCtrl'
      .otherwise
        redirectTo: '/'
  ]

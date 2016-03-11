sessionsCtrl = ->
  ($scope, Auth, $location, $rootScope) ->

    if $scope.ready && $rootScope.user
      $location.path('/')

    $scope.signinData = {}

    $scope.signIn = ->
      Auth.login($scope.signData).then ((response) ->
        $rootScope.user = response.user
        $location.path '/'
      ), (error) ->
        $scope.error = error

angular.module "app.auth"
  .controller "sessionsCtrl", [
    "$scope"
    "Auth"
    "$location"
    "$rootScope"
    sessionsCtrl()
  ]

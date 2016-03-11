registrationCtrl = ->
  ($scope, Auth, $location, $rootScope) ->
    if $scope.ready && $rootScope.user
      $location.path('/')

    $scope.signData = {}

    $scope.signUp = ->
      Auth.register($scope.signData).then ((response) ->
        $rootScope.user = response.user
        $location.path('/')
      ), (error) ->
        $scope.error = error

angular.module "app.auth"
  .controller "registrationCtrl", [
    "$scope"
    "Auth"
    "$location"
    "$rootScope"
    registrationCtrl()
  ]

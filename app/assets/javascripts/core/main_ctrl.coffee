controller = ($scope, Auth, $location, $rootScope) ->

  if window.anonimusUser
    $scope.ready = true
    $scope.isAuthenticated = false
    $rootScope.user = null
    $scope.currentUser = null
  else
    Auth.currentUser().then ((response) ->
      $scope.isAuthenticated = true
      $scope.ready = true
      $rootScope.user = response.user
    ), (error) ->
      $scope.ready = true
  $scope.$apply() unless $scope.$$phase

  $scope.logout = ->
    Auth.logout().then ((oldUser) ->
      $rootScope.user = undefined
      $location.path '/#/'
    ), (error) ->

angular.module "app.core"
  .controller "mainCtrl", [
    "$scope"
    "Auth"
    "$location"
    "$rootScope"
    controller
  ]


controller = ($scope, Auth, $location, $rootScope) ->
  $rootScope.waiting = true
  $rootScope.ready = false
  redirectToLogin = ->
    $location.path '/' 
    $scope.apply() unless $scope.$$phase

  if window.anonimusUser
    $rootScope.waiting = false
    redirectToLogin() unless $location.path() == "/"
    $rootScope.ready = true
    $scope.isAuthenticated = false
    $rootScope.user = null
    $scope.currentUser = null
  else
    Auth.currentUser().then ((response) ->
      $rootScope.waiting = false
      $scope.isAuthenticated = true
      $rootScope.ready = true
      $rootScope.user = response.user
      if !response.user.id
        redirectToLogin() unless $location.path() == "/"
    ), (error) ->
      $rootScope.ready = true
      $rootScope.waiting = false
  $scope.$apply() unless $scope.$$phase

  $scope.logout = ->
    Auth.logout().then ((oldUser) ->
      $rootScope.user = undefined
      $location.path '/'
      App.Alert.show "info", I18n.t("js.users.signed_out")
    ), (error) ->

angular.module "app.core"
  .controller "mainCtrl", [
    "$scope"
    "Auth"
    "$location"
    "$rootScope"
    controller
  ]


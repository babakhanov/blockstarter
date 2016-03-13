controller = ($scope, Auth, $location, $rootScope, $route) ->
  $rootScope.ready = false
  redirectToLogin = ->
    $location.path '/' 
    $scope.apply() unless $scope.$$phase
    $route.reload()

  if window.anonimusUser
    redirectToLogin()
    $rootScope.ready = true
    $scope.isAuthenticated = false
    $rootScope.user = null
    $scope.currentUser = null
  else
    Auth.currentUser().then ((response) ->
      $scope.isAuthenticated = true
      $rootScope.ready = true
      $rootScope.user = response.user
      if !response.user.id
        redirectToLogin() unless $location.path() == "/"
    ), (error) ->
      $rootScope.ready = true
  $scope.$apply() unless $scope.$$phase

  $scope.logout = ->
    Auth.logout().then ((oldUser) ->
      $rootScope.user = undefined
      $location.path '/'
      $route.reload()
      App.Alert.show "info", I18n.t("js.users.signed_out")
    ), (error) ->

angular.module "app.core"
  .controller "mainCtrl", [
    "$scope"
    "Auth"
    "$location"
    "$rootScope"
    "$route"
    controller
  ]


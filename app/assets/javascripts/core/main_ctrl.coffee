controller = ($scope, Auth, $location, $rootScope) ->
  redirectToLogin = ->
    $location.path '/sign_in' 
    $scope.apply() unless $scope.$$phase

  if window.anonimusUser
    redirectToLogin() unless $location.path() == "/sign_in"
    $scope.ready = true
    $scope.isAuthenticated = false
    $rootScope.user = null
    $scope.currentUser = null
  else
    Auth.currentUser().then ((response) ->
      $scope.isAuthenticated = true
      $scope.ready = true
      $rootScope.user = response.user
      if !response.user.id
        redirectToLogin() unless $location.path() == "/sign_in"
    ), (error) ->
      $scope.ready = true
  $scope.$apply() unless $scope.$$phase

  $scope.logout = ->
    Auth.logout().then ((oldUser) ->
      $rootScope.user = undefined
      $location.path '/sign_in'
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


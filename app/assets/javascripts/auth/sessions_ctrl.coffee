sessionsCtrl = ->
  ($scope, Auth, $location, $rootScope) ->

    if $scope.ready && $rootScope.user
      $location.path('/')

    $scope.signinData = {}

    $scope.signIn = ->
      $scope.sending = true
      Auth.login($scope.signData).then ((response) ->
        $scope.sending = false
        $rootScope.user = response.user
        $location.path '/'
        App.Alert.show "success", I18n.t("js.users.signed_in")
      ), (error) ->
        $scope.sending = false
        $scope.error = error

angular.module "app.auth"
  .controller "sessionsCtrl", [
    "$scope"
    "Auth"
    "$location"
    "$rootScope"
    sessionsCtrl()
  ]

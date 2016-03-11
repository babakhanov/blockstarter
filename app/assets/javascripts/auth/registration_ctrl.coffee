registrationCtrl = ->
  ($scope, Auth, $location, $rootScope) ->
    if $scope.ready && $rootScope.user
      $location.path('/')

    $scope.signData = {}

    $scope.signUp = ->
      Auth.register($scope.signData).then ((response) ->
        $rootScope.user = response.user
        $location.path('/')
        App.Alert.show "success", I18n.t("js.users.signed_up")
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

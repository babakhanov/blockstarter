controller = ($scope, $rootScope) ->
  $scope.$root.waiting = true
  CRUD.index "wifs", "", (response) ->
    $scope.wifs = response.wifs
    $rootScope.waiting = false
    $scope.$apply() unless $scope.$$phase

angular.module "app.wallets"
  .controller "walletsCtrl", [
    "$scope"
    "$rootScope"
    controller
  ]

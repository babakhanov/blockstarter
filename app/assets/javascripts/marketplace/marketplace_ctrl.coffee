controller = ($scope) ->
  CRUD.show "marketplace", '', (response) ->
    $scope.marketplace = true
    $scope.tickets = response.marketplaces
    $scope.$apply() unless $scope.$$phase


angular.module "app.marketplace"
  .controller "marketplaceCtrl", [
    "$scope"
    controller
  ]

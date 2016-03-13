directive = ->
  restrict: "E"
  scope: false
  templateUrl: "wallets/wif_item.html"
  controller: ["$scope", ($scope) ->
    $scope.showWif = (wif) ->
      CRUD.show "wifs", wif.id, (response) ->
        wif.wif = response.wif
        $scope.$apply() unless $scope.$$phase
  ]
angular.module "app.wallets"
  .directive "wifItem", [directive]

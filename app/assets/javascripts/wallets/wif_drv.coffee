directive = ->
  restrict: "E"
  scope: false
  templateUrl: "wallets/wif_item.html"
  controller: ["$scope", "$modal", ($scope, $modal) ->
    $scope.wif.confirmModal = $modal
      templateUrl: "wallets/confirm_remove_modal.html"
      container: "body"
      scope: $scope
      show: false

    $scope.showWif = (wif) ->
      CRUD.show "wifs", wif.id, (response) ->
        wif.wif = response.wif
        $scope.$apply() unless $scope.$$phase
  ]
angular.module "app.wallets"
  .directive "wifItem", [directive]

directive = ->
  restrict: "E"
  templateUrl: "tickets/ticket_item.html"
  controller: ["$scope", "$modal", ($scope, $modal) ->

    $scope.confirmModal = $modal
      templateUrl: "tickets/confirm_remove_modal.html"
      container: "body"
      show: false
      scope: $scope

    $scope.removeAsset = (asset, index) ->
      $scope.confirmModal.hide()
      CRUD.remove "assets", asset.id, (response) ->
        $scope.tickets.splice(index, 1)
        $scope.$apply() unless $scope.$$phase
        App.Alert.show "info", I18n.t("js.tickets.was_removed")
    
  ]
angular.module "app.tickets"
  .directive "ticket", [directive]

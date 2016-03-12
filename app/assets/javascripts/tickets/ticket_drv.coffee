directive = ->
  restrict: "E"
  templateUrl: "tickets/ticket_item.html"
  controller: ["$scope", "$modal", "$http", ($scope, $modal, $http) ->

    $scope.confirmModal = $modal
      templateUrl: "tickets/confirm_remove_modal.html"
      container: "body"
      show: false
      scope: $scope

    $scope.issueAsset = (asset) ->
      asset.waiting = true
      $http(
        method: 'GET'
        url: "/api/assets/#{asset.id}/issue"
      ).then ((response) ->
        asset.waiting = false
        if !response.data.error
          $scope.ticket = response.data.asset
          App.Alert.show "success", I18n.t("js.tickets.successfully_issued")
        else
          App.Alert.show "danger", response.data.error
      ), (response) ->
        App.Alert.show "danger", I18n.t("js.info.something_went_wrong")


    $scope.removeAsset = (asset, index) ->
      $scope.confirmModal.hide()
      CRUD.remove "assets", asset.id, (response) ->
        $scope.tickets.splice(index, 1)
        $scope.$apply() unless $scope.$$phase
        App.Alert.show "info", I18n.t("js.tickets.was_removed")
    
  ]
angular.module "app.tickets"
  .directive "ticket", [directive]

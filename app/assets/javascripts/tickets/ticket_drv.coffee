directive = ->
  restrict: "E"
  templateUrl: "tickets/ticket_item.html"
  controller: ["$scope", "$modal", "$http", ($scope, $modal, $http) ->

    $scope.confirmModal = $modal
      templateUrl: "tickets/confirm_remove_modal.html"
      container: "body"
      show: false
      scope: $scope

    $scope.sendTicketModal = $modal
      templateUrl: "tickets/send_ticket_modal.html"
      container: "body"
      show: false
      scope: $scope

    $scope.sendTicket = (asset, data) ->
      $scope.sendTicketModal.hide()
      $scope.ticket.waiting = true
      $http(
        method: "POST"
        url: "/api/assets/#{asset.id}/send_asset"
        data: {asset: {address: data.address, amount: data.amount}}
      ).then ((response) ->
        $scope.ticket.waiting = false
        if response.data.asset
          $scope.ticket = response.data.asset
          App.Alert.show "success", I18n.t("js.tickets.successfully_sent")
        else
          App.Alert.show "danger", response.data.error

      ), (response) ->
        App.Alert.show "danger", I18n.t("js.info.something_went_wrong")

    $scope.toggleAsset = (asset) ->
      asset.waiting = true
      $http(
        method: "GET"
        url: "/api/assets/#{asset.id}/toggle"
      ).then ((response) ->
        asset.waiting = false
        if !response.data.error
          App.Alert.show "success", I18n.t("js.tickets.successfully_published") if response.data.is_published
          App.Alert.show "info", I18n.t("js.tickets.successfully_unpublished") if !response.data.is_published
          asset.is_published = response.data.is_published
          $scope.$apply() unless $scope.$$phase
        else
          App.Alert.show "danger", response.data.error
      ), (response) ->
        App.Alert.show "danger", I18n.t("js.info.something_went_wrong")

    $scope.issueAsset = (asset) ->
      asset.waiting = true
      $http(
        method: "GET"
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

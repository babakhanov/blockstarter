directive = ->
  restrict: "A"
  scope:
    ticket: "="
  templateUrl: "marketplace/marketplace_item.html"
  controller: ["$scope", "$modal", "$http", ($scope, $modal, $http) ->
    $scope.paymentForm = 
      cardNumber: _.times(16, (i) -> Math.floor((Math.random() * 9) + 1)).join('')
      expire: [Math.floor((Math.random() * 11) + 1), Math.floor((Math.random() * 28) + 1)]
      cvv: _.times(3, (i) -> Math.floor((Math.random() * 9) + 1)).join('')

    $scope.purchaseModal = $modal
      templateUrl: "marketplace/purchase_modal.html"
      container: "body"
      scope: $scope
      show: false

    $scope.showTicketModal = $modal
      templateUrl: "marketplace/purchased_modal.html"
      container: "body"
      scope: $scope
      show: false

    $scope.purchaseTicket = (ticket) ->
      ticket.waiting = true
      $scope.purchaseModal.hide()
      $http(
        method: "GET"
        url: "/api/assets/#{ticket.id}/buy"
      ).then ((response) ->
        ticket.waiting = false
        if !response.data.error
          $scope.purchasedTicket = response.data.asset
          $scope.showTicketModal.show()
        else
          App.Alert.show "danger", response.data.error
      ), (response) ->
        App.Alert.show "danger", I18n.t("js.info.something_went_wrong")
  ] 

angular.module "app.marketplace"
  .directive "marketplaceTicket", [directive]

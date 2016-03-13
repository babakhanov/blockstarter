directive = ->
  restrict: "A"
  scope:
    ticket: "="
  templateUrl: "marketplace/marketplace_item.html"
  controller: ["$scope", "$modal", ($scope, $modal) ->
    $scope.paymentForm = 
      cardNumber: _.times(16, (i) -> Math.floor((Math.random() * 9) + 1)).join('')
      expire: [Math.floor((Math.random() * 11) + 1), Math.floor((Math.random() * 28) + 1)]
      cvv: _.times(3, (i) -> Math.floor((Math.random() * 9) + 1)).join('')

    $scope.purchaseModal = $modal
      templateUrl: "marketplace/purchase_modal.html"
      container: "body"
      scope: $scope
      show: false
  ] 

angular.module "app.marketplace"
  .directive "marketplaceTicket", [directive]

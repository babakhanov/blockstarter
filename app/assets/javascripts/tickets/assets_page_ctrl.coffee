controller = ($scope, $modal) ->

  $scope.$root.waiting = true

  CRUD.index "assets", "", (response) ->
    $scope.tickets = response.assets
    $scope.$root.waiting = false
    $scope.$apply() unless $scope.$$phase
  
  $scope.addTicketModal = $modal(
    templateUrl: "shared/create_ticket_modal.html"
    container: "body"
    show: false
    scope: $scope
  )

angular.module "app.tickets"
  .controller "assetsPageCtrl", [
    "$scope"
    "$modal"
    controller
  ]

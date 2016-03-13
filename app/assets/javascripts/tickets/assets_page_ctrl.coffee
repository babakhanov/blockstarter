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

  $scope.sendTicket = (data) ->
    debugger

  $scope.addTicket = (data) ->
    $scope.addTicketModal.hide()
    $scope.$root.waiting = true
    $scope.$apply() unless $scope.$$phase
    $http(
      method: 'POST'
      data: {ticketName: data.ticketName, amount: data.amount},
      url: "#{App.Constants.apiUrl}/addTickets").then ((response) ->
        $scope.tickets = response.data
        $scope.$root.waiting = false
        $scope.$apply() unless $scope.$$phase
    ), (response) -> console.log response

angular.module "app.tickets"
  .controller "assetsPageCtrl", [
    "$scope"
    "$modal"
    controller
  ]

directive = ->
  restrict: "E"
  templateUrl: "tickets/create_ticket_form.html"
  scope:
    tickets: "="
  controller: ["$scope", "$rootScope", ($scope, $rootScope) ->

    $scope.initForm = ->
      $scope.newTicket = 
        issuer: $rootScope.user.email
        fee: 5000

    $scope.createTicket = (data) ->
      CRUD.create "assets", asset: data, (response) ->
        $scope.tickets.unshift response.asset
        $scope.initForm()
  ]
  link: (scope) ->
    scope.initForm()


angular.module "app.tickets"
  .directive "createTicketForm", [directive]

directive = ->
  restrict: "E"
  templateUrl: "tickets/create_ticket_form.html"
  controller: ["$scope", ($scope) ->
  ]
  link: (scope) ->
    scope.newTicket = 
      issuer: scope.user.email
      fee: 5000

angular.module "app.tickets"
  .directive "createTicketForm", [directive]

directive = ->
  restrict: "E"
  templateUrl: "tickets/ticket_item.html"
  controller: ["$scope", ($scope) ->
    
  ]
angular.module "app.tickets"
  .directive "ticket", [directive]

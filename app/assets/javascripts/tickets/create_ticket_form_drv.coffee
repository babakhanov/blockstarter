directive = ->
  restrict: "E"
  templateUrl: "tickets/create_ticket_form.html"
  scope:
    tickets: "="
  controller: ["$scope", "$rootScope", "Upload", ($scope, $rootScope, Upload) ->
    $scope.createTicket = ->
      Upload.upload(url: '/api/assets', data: {asset: $scope.newTicket}, method: 'POST').then (response) ->
        $scope.tickets.unshift response.data.asset
        $scope.initForm()

    $scope.initForm = ->
      $scope.newTicket =
        issuer: $rootScope.user.name
        company_name: $rootScope.user.company_name
        fee: 5000

  ]
  link: (scope) ->
    scope.initForm()


angular.module "app.tickets"
  .directive "createTicketForm", [directive]

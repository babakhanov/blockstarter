directive = ->
  templateUrl: "index.html"
  controller: ["$scope", ($scope) ->
    $scope.time = (new Date()).getTime()
  ]

angular.module "app", [
  "templates"
]

angular.module "app"
  .directive "helloWorld", [directive]

controller = ($scope) ->
  $scope.time = (new Date()).getTime()

angular.module "app.shared"
  .controller "indexPageCtrl", ["$scope", controller]

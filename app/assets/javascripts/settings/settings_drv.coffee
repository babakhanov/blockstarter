directive = ->
  restrict: "E"
  templateUrl: "settings/settings_form.html"
  controller: ["$scope", ($scope) ->

    $scope.updateUser = (user) ->
      CRUD.update "users", id: user.id, user: user
  ]

angular.module "app.settings"
  .directive "settingsDrv", [directive]
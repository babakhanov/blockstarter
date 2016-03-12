directive = ->
  restrict: "E"
  templateUrl: "settings/settings_form.html"
  controller: ["$scope", ($scope) ->

    $scope.updateUser = (user) ->
      CRUD.update "users", id: user.id, user: user, (response) ->
        App.Alert.show "info", I18n.t("js.users.profile_updated")
  ]

angular.module "app.settings"
  .directive "settingsDrv", [directive]

controller = ($scope, $rootScope) ->
  $scope.$root.waiting = true
  CRUD.index "wifs", "", (response) ->
    $scope.wifs = response.wifs
    $rootScope.waiting = false
    $scope.$apply() unless $scope.$$phase

  $scope.importWif = (wif) ->
    $scope.importing = true
    CRUD.create "wifs", {wif: {wif: wif}}, (response) ->
      if response.wif
        App.Alert.show "danger", I18n.t("js.info.something_went_wrong")
      else
        $scope.wifs.unshift response.data.wif
        $scope.false = true
    

angular.module "app.wallets"
  .controller "walletsCtrl", [
    "$scope"
    "$rootScope"
    controller
  ]

controller = ($scope, $rootScope) ->
  $scope.$root.waiting = true
  CRUD.index "wifs", "", (response) ->
    $scope.wifs = response.wifs
    $rootScope.waiting = false
    $scope.$apply() unless $scope.$$phase

  $scope.removeWif = (wif, index) ->
    CRUD.remove "wifs", wif.id, (response) ->
      $scope.wifs.splice(index, 1)
      wif.confirmModal.hide()
      $scope.$apply() unless $scope.$$phase

  $scope.importWif = (wif) ->
    $scope.importing = true
    CRUD.create "wifs", {wif: {wif: wif}}, (response) ->
      if !response.wif
        App.Alert.show "danger", response.error || I18n.t("js.info.something_went_wrong")
        $scope.importing = false
      else
        $scope.wifs.unshift response.wif
        $rootScope.user.wifs.unsift response.wif
        $scope.false = true
        App.Alert.show "success", I18n.t("js.info.wif_added")
        $scope.newWif.wif = ''
        $scope.$apply() unless $scope.$$phase
    

angular.module "app.wallets"
  .controller "walletsCtrl", [
    "$scope"
    "$rootScope"
    controller
  ]

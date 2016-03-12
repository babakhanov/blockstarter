directive = ->
  restrict: "AE"
  template: "<div class='spinner'><div class='bounce-1'></div><div class='bounce-2'></div><div class='bounce-3'></div></div>"

angular.module "app.shared"
  .directive "spinner", [directive]

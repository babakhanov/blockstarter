angular.module "app.shared"
  .directive "header", [()-> 
    restrict: "E"
    replace: true
    templateUrl: "shared/header.html" 
  ]

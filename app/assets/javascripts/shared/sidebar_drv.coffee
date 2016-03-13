angular.module "app.shared"
  .directive "sidebar", [()-> 
    restrict: "E"
    replace: true
    templateUrl: "shared/sidebar.html" 
  ]

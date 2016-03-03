//= require ./core/core
//= require ./tickets/tickets
//= require ./shared/shared

angular.module "app", [
  "ngRoute",
  "templates"
  "mgcrea.ngStrap.core"
  "mgcrea.ngStrap.helpers.dimensions"
  "mgcrea.ngStrap.modal"
  "mgcrea.ngStrap.tooltip"
  "mgcrea.ngStrap.helpers.dateParser"
  "mgcrea.ngStrap.helpers.dateFormatter"
  "mgcrea.ngStrap.datepicker"
  "app.core"
  "app.tickets"
  "app.shared"
]


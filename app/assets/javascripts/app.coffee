//= require ./core/core
//= require ./auth/auth
//= require ./tickets/tickets
//= require ./settings/settings
//= require ./shared/shared
//= require ./wallets/wallets

angular.module "app", [
  "ngRoute"
  "templates"
  "Devise"
  "ngSanitize"
  "ngFileUpload"
  "pascalprecht.translate"
  "mgcrea.ngStrap.core"
  "mgcrea.ngStrap.helpers.dimensions"
  "mgcrea.ngStrap.modal"
  "mgcrea.ngStrap.tooltip"
  "mgcrea.ngStrap.helpers.dateParser"
  "mgcrea.ngStrap.helpers.dateFormatter"
  "mgcrea.ngStrap.datepicker"
  "app.core"
  "app.auth"
  "app.tickets"
  "app.shared"
  "app.settings"
  "app.wallets"
]

angular.module "app"
  .config [ "$translateProvider", ($translateProvider) ->
    $translateProvider.preferredLanguage(I18n.locale);
    $translateProvider.useSanitizeValueStrategy "sanitize"
    $translateProvider.translations I18n.locale, I18n.translations[I18n.locale]
  ]

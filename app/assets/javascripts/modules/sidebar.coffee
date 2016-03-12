@module "App.Sidebar", ->
  @toggle = ->
    $("body").toggleClass("sidebar-close")

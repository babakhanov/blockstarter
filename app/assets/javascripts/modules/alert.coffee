@module 'App', ->
  @module 'Alert', ->
    current = null

    @show = (name, msg) ->
      tpl = undefined
      if current
        clearTimeout current
        current = null
      $('.alert-container').each ->
        $(this).remove()
      tpl = $('<div class="alert-container" style="margin: -50px 0 0 0; border-radius: 0;"><div class="alert alert-dismissible alert-' + name + ' fade in">' + msg + '<button class="close" data-dismiss="alert">&times;</button></div></div>')
      $('body').prepend tpl
      $(tpl).stop().animate { marginTop: 0 }, 500
      current = setTimeout((->
        $(tpl).stop().animate { marginTop: -$('.main').offset().top }, 500
      ), 2000)
      window.scrollTo 0, 0


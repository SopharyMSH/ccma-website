CCMA.Common = do ->
  _init = ->
    _navbarToggle()
    _scrollToTop()
    _contactForm()

  _navbarToggle = ->
    $('ul.dropdown-menu.submenu-dropdown [data-toggle=dropdown]').on 'click', (e) ->
      event.preventDefault()
      event.stopPropagation()
      $('ul.dropdown-menu.submenu-dropdown [data-toggle=dropdown]').parent().removeClass('open')
      $(this).parent().addClass('open')
  _contactForm = ->
    $form = $('#form-contact')
    $form.submit ->
      name      = $('input#name').val()
      phone     = $('input#phone').val()
      email     = $('input#email').val()
      message   = $('textarea#message').val()
      formData  = { name: name, phone: phone, email: email, message: message }
      debugger
      $.ajax
        type: 'POST'
        dataType: 'json'
        url: $form.attr('action')
        data: formData
        success: ->
          $form[0].reset()
          alert 'Your message has been sent successfully. Thank you.'
        error: ->
          alert 'Your message has not been sent. Please try again later!'
      false

  _scrollToTop = ->
    $(window).scroll ->
      if $(this).scrollTop() > 50
        $('#back-to-top').fadeIn()
      else
        $('#back-to-top').fadeOut()

    $('#back-to-top').click ->
      $('#back-to-top').tooltip 'hide'
      $('body,html').animate { scrollTop: 0 }, 800

    $('#back-to-top').tooltip 'show'

  { init: _init }

APCMGU.Contact = do ->
  _init = ->
    # _contactForm()
    
  _contactForm = ->     
    $form = $('#form-contact')
    $form.on 'submit', ->
      name      = $('input#name', this).val()
      phone     = $('input#phone', this).val()
      email     = $('input#email', this).val()
      message   = $('textarea#message', this).val()
      formData  = { name: name, phone: phone, email: email, message: message }

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

  { init: _init }
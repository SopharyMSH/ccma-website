Apcmgu.Organization = do ->
  _init = ->
    _organizationImageReveal()

  _organizationImageReveal = ->
    scrollRevealConfig =
      delay: 600
      distance: '70px'
      easing: 'ease'
      rotate:
        z: 10
      scale: 0.5

    window.sr = ScrollReveal(scrollRevealConfig)
    sr.reveal '.organization-image'

  { init: _init }

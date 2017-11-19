APCMGU.Common = do ->
  _init = ->
    # _logoImageReveal()

  _logoImageReveal = ->
    scrollRevealConfig =
      delay: 600
      distance: '70px'
      easing: 'ease'
      rotate:
        z: 10
      scale: 0.5

    window.sr = ScrollReveal(scrollRevealConfig)
    sr.reveal '.logo-image'

  { init: _init }

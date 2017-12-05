Apcmgu.Initializer =
  exec: (pageName) ->
    if pageName && Apcmgu[pageName]
      Apcmgu[pageName]['init']()

  currentPage: ->
    return '' unless $('#content-wrapper > section').attr('id')

    sectionId   = $('#content-wrapper > section').attr('id').split('-')
    prefix  = Apcmgu.Util.capitalize(sectionId[0])
    if sectionId[1]
      suffix  = Apcmgu.Util.capitalize(sectionId[1])
      prefix + suffix
    else
      prefix

  init: ->
    Apcmgu.Initializer.exec('Common')
    if @currentPage()
      Apcmgu.Initializer.exec(@currentPage())

$(document).on 'ready page:load', ->
  Apcmgu.Initializer.init()

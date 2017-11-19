APCMGU.Initializer =
  exec: (pageName) ->
    if pageName && APCMGU[pageName]
      APCMGU[pageName]['init']()

  currentPage: ->
    return '' unless $('#content-wrapper > section').attr('id')
    sectionId   = $('#content-wrapper > section').attr('id').split('-')
    sectionIdConcated = ''

    $.each sectionId, (index, value) ->
      sectionIdSplitted = APCMGU.Util.capitalize(value)
      sectionIdConcated = "#{sectionIdConcated}#{sectionIdSplitted}"

    sectionIdConcated

  init: ->
    APCMGU.Initializer.exec('Common')
    if @currentPage()
      APCMGU.Initializer.exec(@currentPage())

$(document).on 'ready page:load', ->
  APCMGU.Initializer.init()
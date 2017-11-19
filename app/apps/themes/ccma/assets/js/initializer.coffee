CCMA.Initializer =
  exec: (pageName) ->
    if pageName && CCMA[pageName]
      CCMA[pageName]['init']()

  currentPage: ->
    return '' unless $('#content-wrapper > section').attr('id')
    sectionId   = $('#content-wrapper > section').attr('id').split('-')
    sectionIdConcated = ''

    $.each sectionId, (index, value) ->
      sectionIdSplitted = CCMA.Util.capitalize(value)
      sectionIdConcated = "#{sectionIdConcated}#{sectionIdSplitted}"

    sectionIdConcated

  init: ->
    CCMA.Initializer.exec('Common')
    if @currentPage()
      CCMA.Initializer.exec(@currentPage())

$(document).on 'ready page:load', ->
  CCMA.Initializer.init()
  
# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  $('form').on 'click', '.remove_fields', (event) ->
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('fieldset').hide()
    event.preventDefault()

  $('form').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    event.preventDefault()
    $('.client_id').select2
      ajax: {
        url: '/clients'
        data: (params) ->
          {
            term: params.term
          }
        dataType: 'json'
        delay: 500
        processResults: (data, params) ->
          {
            results: _.map(data, (el) ->
              {
                id: el.id
                name: "#{el.name}, #{el.email}"
              }
            )
          }
        cache: true
      }
      escapeMarkup: (markup) -> markup
      minimumInputLength: 2
      templateResult: (item) -> item.name
      templateSelection: (item) -> item.name
    $('.listing_id').select2
      ajax: {
        url: '/listings'
        data: (params) ->
          {
            term: params.term
          }
        dataType: 'json'
        delay: 500
        processResults: (data, params) ->
          {
            results: _.map(data, (el) ->
              {
                id: el.id
                name: "#{el.address}"
              }
            )
          }
        cache: true
      }
      escapeMarkup: (markup) -> markup
      minimumInputLength: 2
      templateResult: (item) -> item.name
      templateSelection: (item) -> item.name
  
  # #client select field in listing form
  # $('.client_id').select2
  #   ajax: {
  #     url: '/clients'
  #     data: (params) ->
  #       {
  #         term: params.term
  #       }
  #     dataType: 'json'
  #     delay: 500
  #     processResults: (data, params) ->
  #       {
  #         results: _.map(data, (el) ->
  #           {
  #             id: el.id
  #             name: "#{el.name}, #{el.email}"
  #           }
  #         )
  #       }
  #     cache: true
  #   }
  #   escapeMarkup: (markup) -> markup
  #   minimumInputLength: 2
  #   templateResult: (item) -> item.name
  #   templateSelection: (item) -> item.name
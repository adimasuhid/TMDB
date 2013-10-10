class MoviesApp.EditCrews extends Backbone.View
  template: JST['templates/crews/edit']
  className: "row"

  initialize: ->
    _.bindAll this, "render"

  events:
    "click .js-new-crew-save" : "create"
    "click .js-crew-remove" : "destroy"
    "click .js-new-movie-add-yes" : "add_new_movie"
    "click .js-new-movie-add-no" : "cancel"
    "click .js-new-person-add-yes" : "add_new_person"
    "click .js-new-person-add-no" : "cancel"

  render: ->
    @edit = $(@el)
    crews = @options.crews
    @edit.html @template(crews: crews)

    self = @
    $(@el).find(".js-new-crew-person").autocomplete
      source: api_version + "people/search?temp_user_id=" + localStorage.temp_user_id
      minLength: 2
      messages:
        noResults: ''
        results: ->
          ''
      select: (event, ui) ->
        if ui.item.id == "0"
          self.add_new_person()
        $(self.el).find(".js-new-crew-person-id").val(ui.item.id)
      response: (event, ui) ->
        ui.content = window.check_autocomplete(ui.content, $.trim($(".js-new-crew-person").val()), "person")
        if ui.content.length == 0
          $(self.el).find(".js-new-person-info, .js-new-person-add-form").show()
          $(self.el).find(".js-new-person-id").val("")
        else
          self.edit.find(".js-new-person-info, .js-new-person-add-form").hide()

    $(@el).find(".js-new-crew-movie").autocomplete
      source: api_version + "movies/search?temp_user_id=" + localStorage.temp_user_id
      minLength: 2
      messages:
        noResults: ''
        results: ->
          ''
      select: (event, ui) ->
        if ui.item.id == "0"
          self.add_new_movie()
        $(self.el).find(".js-new-crew-movie-id").val(ui.item.id)
      response: (event, ui) ->
        ui.content = window.check_autocomplete(ui.content, $.trim($(".js-new-crew-movie").val()), "movie")
        if ui.content.length == 0
          $(self.el).find(".js-new-movie-info, .js-new-movie-add-form").show()
          $(self.el).find(".js-new-movie-id").val("")
        else
          self.edit.find(".js-new-movie-info, .js-new-movie-add-form").hide()
    this

  create: (e) ->
    console.log "create"
    self = @
    job = $(@el).find(".js-new-crew-job").val()
    if window.movie_id
      person_id = $(@el).find(".js-new-crew-person-id").val()
      movie_id = window.movie_id
    else if window.person_id
      person_id = window.person_id
      movie_id = $(@el).find(".js-new-crew-movie-id").val()
    if job != "" && person_id != "" && movie_id != ""
      crew = new MoviesApp.Crew()
      crew.save ({ crew: { job: job, person_id: person_id, movie_id: movie_id, temp_user_id: localStorage.temp_user_id } }),
        success: ->
          $(".notifications").html("Crew member added. It will be active after moderation.").show().fadeOut(window.hide_delay)
          self.reload_items()
        error: ->
          console.log "error"
          $(".notifications").html("This crew member already exist or it's waiting for moderation.").show().fadeOut(window.hide_delay)
          $(self.el).find(".js-new-crew-job").val("").removeClass("error")
          $(self.el).find(".js-new-crew-person").val("").removeClass("error")
          $(self.el).find(".js-new-crew-person-id").val("")
          $(self.el).find(".js-new-crew-movie").val("").removeClass("error")
          $(self.el).find(".js-new-crew-movie-id").val("")
    else
      $(@el).find("input").each (i, input) ->
        if $(input).val() == ""
          $(input).addClass("error")
        else
          $(input).removeClass("error")

  reload_items: ->
    if window.movie_id
      movie = new MoviesApp.Movie()
      movie.url = "/api/v1/movies/#{window.movie_id}/my_movie"
      movie.fetch
        data:
          temp_user_id: localStorage.temp_user_id
        success: =>
          movie = movie.get("movie")
          $(@el).remove()
          @stopListening()
          @edit_crews_view = new MoviesApp.EditCrews(crews: movie.crews)
          $(".crew").html @edit_crews_view.render().el
    else if window.person_id
      person = new PeopleApp.Person()
      person.url = "/api/v1/people/#{window.person_id}/my_person"
      person.fetch
        data:
          temp_user_id: localStorage.temp_user_id
        success: =>
          person = person.get("person")
          $(@el).remove()
          @stopListening()
          @edit_crews_view = new MoviesApp.EditCrews(crews: person.crews)
          $(".crew").html @edit_crews_view.render().el

  destroy: (e) ->
    container = $(e.target).parents(".col-md-12").first()
    id = $(e.target).attr("data-id")
    $.ajax api_version + "crews/" + id,
      method: "DELETE"
      success: =>
        container.remove()
        $(".notifications").html("Crew member removed.").show().fadeOut(window.hide_delay)

  add_new_movie: (e) ->
    self = @
    value = @edit.find(".js-new-crew-movie").val()
    if value != ""
      model = new MoviesApp.Movie()
      model.save ({ movie: { title: value, temp_user_id: localStorage.temp_user_id } }),
        success: ->
          $(".notifications").html("Movie added. It will be active after moderation.").show().fadeOut(window.hide_delay)
          $(self.el).find(".js-new-crew-movie").val(value).removeClass "error"
          $(self.el).find(".js-new-crew-movie-id").val(model.id)
          self.create()
          self.cancel()
        error: (model, response) ->
          $(".notifications").html("Movie is currently waiting for moderation.").show().fadeOut(window.hide_delay)
          $(self.el).find(".js-new-crew-movie").val("").removeClass "error"
          $(self.el).find(".js-new-crew-movie-id").val("")
          self.cancel()
    else
      @edit.find(".js-new-movie").addClass("error")

  add_new_person: (e) ->
    self = @
    value = @edit.find(".js-new-crew-person").val()
    if value != ""
      model = new PeopleApp.Person()
      model.save ({ person: { name: value, temp_user_id: localStorage.temp_user_id } }),
        success: ->
          $(".notifications").html("Person added. It will be active after moderation.").show().fadeOut(window.hide_delay)
          $(self.el).find(".js-new-crew-person").val(value).removeClass "error"
          $(self.el).find(".js-new-crew-person-id").val(model.id)
          self.create()
          self.cancel()
        error: (model, response) ->
          $(".notifications").html("Person is currently waiting for moderation.").show().fadeOut(window.hide_delay)
          $(self.el).find(".js-new-crew-person").val("").removeClass "error"
          $(self.el).find(".js-new-crew-person-id").val("")
          self.cancel()
    else
      @edit.find(".js-new-crew-person").addClass("error")

  cancel: ->
    @edit.find(".js-new-person-info, .js-new-person-add-form").hide()
    @edit.find(".js-new-movie-info, .js-new-movie-add-form").hide()


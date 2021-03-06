class PeopleApp.Show extends Backbone.View
  template: JST['templates/people/show']
  className: "row people-show"

  initialize: ->
    _.bindAll this, "render"

  events:
    "click .follow" : "follow"
    "click .following" : "unfollow"
    "click .show-add-item" : "add_item"

  render: ->
    show = $(@el)
    person = @options.person.get("person")
    my_person = @options.my_person
    show.html @template(person: person, my_person: my_person)
    $("title").html(person.meta_title)
    $("meta[name='description']").attr("content", person.meta_description)
    $("meta[name='keywords']").attr("content", person.meta_keywords)
    this

  follow: (e) ->
    $self = $(e.target)
    type = "Person"
    id = window.person_id
    follow = new MoviesApp.Follow()
    follow.save ({ follow: { followable_id: id, followable_type: type } }),
      success: ->
        $self.addClass("following").removeClass("follow").html("Already following")
        console.log follow

  unfollow: (e) ->
    $self = $(e.target)
    type = "Person"
    id = window.person_id
    $.ajax api_version + "follows/test",
      method: "DELETE"
      data:
        followable_id: id
        followable_type: type
      success: =>
        $self.addClass("follow").removeClass("following").html("Follow")

  add_item: (e) ->
    id = $(e.target).parent().attr("id")
    tab = id.replace("add-", "")
    localStorage.tab = tab
    console.log localStorage.tab
    window.PeopleApp.router.navigate("/#!/people/#{window.person_id}/edit/my_person", true)

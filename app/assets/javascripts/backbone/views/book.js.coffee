class Bookstore.Views.Book extends Backbone.View
  className: 'book'
  
  template: JST['backbone/templates/book']
  
  initialize: ->
    this.model.on('change', this.render, this)
    this.model.on('hide', this.remove, this)
  
  render: ->
    this.$el.html(this.template({model: this.model}))
    return this

  events: {
    'click button.delete-book': 'destroy'
    'click button.edit-book': 'edit'
  }

  destroy: (e) ->
    e.preventDefault()
    this.model.destroy()

  edit: (e) ->
    e.preventDefault()
    form = new Bookstore.Views.BookForm({model: @.model})
    form.render()
    @.$el.html(form.el)


class Bookstore.Views.Books extends Backbone.View
  className: 'books'
  
  template: JST['backbone/templates/books']
  
  initialize: ->
    @.collection.on('add', @.addOne, @)
    @.collection.on('reset', @.addAll, @)

  render: ->
    @.addAll
    return @
  
  addAll: ->
    @.$el.empty()
    @.collection.forEach(@.addOne, this)

  addOne: (model) ->
    bookView = new Bookstore.Views.Book({model: model})
    @.$el.append(bookView.render().el)
      

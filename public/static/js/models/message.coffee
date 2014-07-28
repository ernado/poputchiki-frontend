app.models.Message = Backbone.Model.extend()

Message = app.models.Message

app.models.Messages = Backbone.Collection.extend
    model: Message

    url: () ->
        '/api/user/'+ @urluser + '/messages'

Messages = app.models.Messages

app.models.newMessage = (data, url, callback) ->

    $.ajax
        type: "PUT",
        url: url
        data: data
        success: callback
        dataType: "json"
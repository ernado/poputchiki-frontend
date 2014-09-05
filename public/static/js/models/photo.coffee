app.models.Photo = Backbone.Model.extend 
    # initialize: ()->
    #     @listenToOnce @, 'change:time', @updateDate


	url: ->
        '/api/photo/'+@.get('id')

    # updateDate: (object)->
    #     console.log object

	
	like: (callback)->
        @sendLikeQuery 'POST', callback
        

    unlike: (callback)->
        @sendLikeQuery 'DELETE', callback

    sendLikeQuery: (query_type, callback)->
        $.ajax
            url: '/api/photo/'+@.get('id')+'/like'
            type: query_type
            # data: "target="+@.get('id')
            dataType: "json"
            success: (data) ->
                callback _.size(data.liked_users)

    parse: (response)->
        # time_param = new Date response.time
        # response.time = 
        #     date: time_param.getDate()+"."+time_param.getMonth()+"."+(time_param.getYear()*1+1900)
        #     time: time_param.getHours()+":"+time_param.getMinutes()        
        response.likers_url = '/api/photo/'+response.id+'/like'
        return response
    updateDate:  (time_param_name)->
        time_param = new Date @get time_param_name
        # user.time = 
        #     date: +"."+time_param.getMonth()+"."+(time_param.getYear()*1+1900)
        #     time: time_param.getHours()+":"+time_param.getMinutes()
        month = new Array()
        month[0] = "Января"
        month[1] = "Февраля"
        month[2] = "Марта"
        month[3] = "Апреля"
        month[4] = "Мая"
        month[5] = "Июня"
        month[6] = "Июля"
        month[7] = "Августа"
        month[8] = "Сентября"
        month[9] = "Октября"
        month[10] = "Ноября"
        month[11] = "Декабря"

        n = month[time_param.getMonth()]
        @set(time_param_name+'Day',time_param.getDate())
        @set(time_param_name+'Month',n)
        @set(time_param_name+'Year',(time_param.getYear()*1+1900))
        @set(time_param_name+'Time',time_param.getHours()+":"+time_param.getMinutes())



Photo = app.models.Photo

app.models.Photos = Backbone.Collection.extend
    initialize: (id)->
        @id = id
        return
        
    model: Photo

    url: ()->
    	'/api/user/'+@id+'/photo'


    # parse: (response)->
    #     for user in response
    #         # user = @parseLastActionParameter item  
    #         time_param = new Date user.time
    #         user.time = 
    #             date: time_param.getDate()+"."+time_param.getMonth()+"."+(time_param.getYear()*1+1900)
    #             time: time_param.getHours()+":"+time_param.getMinutes()
    #     # item.parseTimeParameter  'last_action' for item in response
    #     return response
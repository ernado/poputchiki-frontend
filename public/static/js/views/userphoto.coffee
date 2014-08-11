app.views.UserPhotoBlock = Backbone.View.extend _.extend app.mixins.UploadPhoto,app.mixins.SlideRigtBlock,

    el: '.photoVideoBlock'

    events: 
        'click .addPhoto span': 'photoload'
        'change .photovideoformfile': 'changeimg'

    photoload: ->
        do event.preventDefault
        $ '.photovideoformfile'
            .trigger 'click'

    changeimg: ->    
        do event.preventDefault
        form = '.photovideoform'
        url = '/api/photo'
        success = (data) ->
            console.log data.url
        @uploadphoto url, form, success

    render: (id)->
        $ @.$el.append jade.templates.photo_video()
        collection = new app.models.Photos id
        that = @
        collection.fetch().done () ->
            $('.photoBox .photoBoxWrapper .pb-wr').empty()
            that.renderPhoto photo for photo in collection.models
            that.slideHideAndShow ()->

            #that.showpopup '.view', '.photoPopup'
            user = new app.models.User
            user.set 'id', id
            user.fetch
                success: ->
                    app.views.popupphoto.changeuser user
            return

    renderPhoto: (photo)->
        
        # time = new Date photo.get('time')
        # photo.set 'time', time.getDate()+"."+time.getMonth()+"."+(time.getYear()*1+1900)
        photoView = new app.views.Photo model:photo
        $('.photoBox .photoBoxWrapper .pb-wr').append photoView.render()
        # bookView = new app.BookView model:item
        # @$el.append bookView.render()

    #showpopup: (cnt, popup) ->
    #    $(cnt).click ->
    #        $('body').addClass 'bodyPopup'
    #        $('.popupBack').fadeIn('slow')
    #        $('.popupWrapper').fadeIn('slow')
    ##        $(popup).fadeIn('slow')

app.views.Autocomplete = Backbone.View.extend

    events: 
        'keyup input': 'press'
        'focusout input': 'out'
        'click li.dl': 'lc'
        'click .dd': 'press',
        #'click .du': 'hide_list'

    getdata: (val, callback) ->
        callback ["1","2","3"]

    press: (event) ->
        input = @$el.find 'input'
        droped = @$el.find '.droped'
        #$(event.target).css display: "none"
        #$(event.target).next().css display: "block"

        if event.which==13
            if input.val.length>0
                input.val $(droped.find('li')[0]).text()
            else
            input.val ''
            droped.css 'display', 'none'
            $(event.target).parent().find('.du').css display: 'none'
            $(event.target).parent().find('.dd').css display: 'block'
            @afterchange()
            do event.preventDefault
            return

        val = input.val()
        @getdata val, (data) ->
            if _.size(data) != 0
                droped.html ''
                _.each data, (item,index) ->
                    # if index < 5
                    droped.append '<li class="dl">' + item + '</li>'
                droped.css 'display', 'block'
                $(event.target).parent().find('.dd').css display: 'none'
                $(event.target).parent().find('.du').css display: 'block'
            else
                droped.css 'display', 'none'
        true

    hide_list: (event) ->
        droped = @$el.find '.droped'
        droped.css 'display', 'none'            
        $(event.target).css display: "none"
        $(event.target).prev().css display: "block"
        do event.preventDefault
        return

    out: ->
        setTimeout (=>
            droped = @$el.find '.droped'
            droped.css 'display', 'none'
        ), 200

    lc: (event) ->
        el = $ event.currentTarget
        text = el.text()
        input = @$el.find 'input'
        input.val text
        $(input).parent().find('.du').css display: 'none'
        $(input).parent().find('.dd').css display: 'block'
        @afterchange()
        do @out

    afterchange: () ->
        return

app.views.AutocompleteCountry = app.views.Autocomplete.extend
    
    getdata: (val, callback) ->
        app.models.countries
            start: val
        , callback



app.views.AutocompleteCity = app.views.Autocomplete.extend
    
    getdata: (val, callback) ->

        if not @country
            condition = false
        else
            country = @country.$el.find('input').val()
            condition = Boolean country

        console.log country

        #REMOVE IT!!!!11
        #condition = false

        if not condition
            app.models.citypairs
                start: val
            , (data) -> 
                d = _.map data, (item) ->
                    item.title
                callback d
        else
            app.models.cities
                start: val
                country: country
            , callback #(data) -> 
            #    d = _.map data, (item) ->
            #        item.title
            #    callback d
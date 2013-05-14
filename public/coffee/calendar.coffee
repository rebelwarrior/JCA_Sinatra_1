#https://www.googleapis.com/calendar/v3/users/userID/lists?parameters
#get /calendars/calendarId get /users/me/calendarList/calendarId

Object::david_properties = -> (console?.log("#{key} : #{val}") for own key, val of @ );@

$.ajax
  dataType: 'json'
  url: gon.calendar_colors #url for Rail App sending jsonp
  error: (data, status, jqXHR)-> console?.log("error loading Json #{data}, #{status} & #{jqXHR}")
  success: (data, status, xhr)->
    console?.log("success! #{data}, #{status}, #{xhr}")
    console?.log data.david_properties()
    # for own key, val of data.calendar
    #   console?.log("#{key} : #{val}")

$.ajax
  dataType: 'json'
  url: gon.calendar_list #url for Rail App sending jsonp
  error: (data, status, jqXHR)-> console?.log("error loading Json #{data}, #{status} & #{jqXHR}")
  success: (data, status, xhr)->
    console?.log("success! #{data}, #{status}, #{xhr}")
    console?.log data.david_properties()
    

# root = global ? window
# root.alert(gon.calendar_colors)
    
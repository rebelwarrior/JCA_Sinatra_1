#geolocation 
    
showPosition = (position)->
    [position.coords.latitude, position.coords.longitude]
    
getLocation = ->
  if testGeolocation()
    showPosition(navigator.geolocation.getCurrentPosition(showPosition, showError))
  else 
    "Geolocation not supported by this browser."    

testGeolocation = ->
  if navigator.geolocation
    true
  else
    false    
    
alberto = true

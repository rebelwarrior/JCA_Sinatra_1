# jQuery(window).ready(function(){
#     jQuery("#btnInit").click(initiate_geolocation);
# });
initiate_geolocation = -> 
    navigator.geolocation.getCurrentPosition(handle_geolocation_query, handle_errors)
    
handle_errors = (error)-> 
  switch(error.code)
    when error.PERMISSION_DENIED 
      alert("user did not share geolocation data") 
      break  
    when error.POSITION_UNAVAILABLE
      alert("could not detect current position") 
      break
    when error.TIMEOUT
     alert("retrieving position timed out")  
     break
    else
      alert("unknown error")
      break 
    
handle_geolocation_query = (position)->
  alert("Lat: #{position.coords.latitude} Lon: #{position.coords.longitude}")
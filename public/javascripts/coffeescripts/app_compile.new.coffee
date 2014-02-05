###  Javascript for activating Bootsrap  ###
$(document).ready ->
  $(".dropdown-toggle").dropdown() #DropdownMenu
  $(".nav-tabs").button() #Navigation buttons
  $("table").addClass "table table-bordered" #Table Markup Formatting
  $("tr").addClass "info" #Table Markup Formatting
  $("img").addClass "img-rounded" #Rounded Images
  $("[data-spy=\"scroll\"]").each ->
    $spy = $(this).scrollspy("refresh") #Scroll spy
  $(".carousel").carousel() #Slideshow
  
###  Javascript for pdf iframes  ###
$(document).ready ->
  if "dias" or "permits" is in pathname
    $("#pdfs_reports").find("iframe").attr "style", "background:white; min-width:300px; min-height:300px"

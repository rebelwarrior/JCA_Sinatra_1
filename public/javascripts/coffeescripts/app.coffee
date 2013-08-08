#Generated w/ js2coffee.org

# Javascript for activating Bootsrap
$(document).ready ->
  $(".dropdown-toggle").dropdown() #DropdownMenu
  $(".nav-tabs").button() #Navigation buttons
  $("table").addClass "table table-bordered" #Table Markup Formatting
  $("tr").addClass "info" #Table Markup Formatting
  $("img").addClass "img-rounded" #Rounded Images
  $("[data-spy=\"scroll\"]").each ->
    $spy = $(this).scrollspy("refresh")

  #Scroll spy
  $(".carousel").carousel() #Slideshow


# Javascript for language switching
languages = undefined
pathname = undefined
_ref = undefined
__indexOf_ = [].indexOf or (item) ->
  i = 0
  l = @length

  while i < l
    return i  if i of this and this[i] is item
    i++
  -1

pathname = window.location.pathname
pathname = pathname.split("/")
languages = ["en", "es", "pirate"]
window.location.pathname = "/es" + (pathname.join("/"))  if _ref = pathname[1]
__indexOf_.call(languages, _ref) < 0

$(document).ready ->
  $("button#english").on "click", ->
    if pathname[1] is "en"
      console.log pathname[1]
    else
      pathname[1] = "en"
      window.location.pathname = pathname.join("/")

  $("button#spanish").click ->
    if pathname[1] is "es"
      console.log pathname[1]
    else
      pathname[1] = "es"
      window.location.pathname = pathname.join("/")



# Javascript for pdf iframes
$(document).ready ->
  pdf_year_or_area = undefined
  if pathname[2] is "dias" or "permits"
    if pathname[3] is "all"
      pdf_year_or_area = ""
    else
      pdf_year_or_area = pathname[3]
    
    # console.log(pdf_year_or_area);
    $("#pdfs_reports").find("iframe").attr "src", ("/pdfs/" + pathname[2] + "/" + pdf_year_or_area)
    $("#pdfs_reports").find("iframe").attr "style", "background:white; min-width:300px; min-height:300px"
  if pathname[2] is "env_reports"
    $("#pdfs_reports").find("iframe").attr "src", "/pdfs/communications/environmental_reports"
    $("#pdfs_reports").find("iframe").attr "style", "background:white; min-width:300px; min-height:300px"


# Javascript for Home page
$(document).ready ->
  if pathname[2] is "home"
    
    # $('.carousel').carousel(); //Moved to top
    #Wrap next line in an ajax request for the bg image file.
    $("body").addClass "mainpage" #adds css rule for bg image
    $(window).load ->
      return  if $("#googlecalendar").length <= 0 # to avoid errors in case the element doesn't exist on the page or removed.
      $("#googlecalendar").attr "src", "//www.google.com/calendar/embed?title=Calendario%20de%20Vistas%20Publicas&amp;amp;showTitle=0&amp;amp;showNav=0&amp;amp;showPrint=0&amp;amp;showTz=0&amp;amp;height=300&amp;amp;wkst=2&amp;amp;bgcolor=%23ffffff&amp;amp;src=juntacalidadambientalcalendar%40gmail.com&amp;amp;color=%23125A12&amp;amp;ctz=America%2FPuerto_Rico"
      try
        $("iframe").contents().text()
      catch error
        console.log "failed access"

    setTimeout (->
      if $("iframe").contents().find(".windows8").length is 1
        $("#googlecalendar").attr "src", ("/" + pathname[1] + "/googleloginrequired")
      else
        console.log "If access to iframe blocked, Calendar likely loaded."
    ), 5000

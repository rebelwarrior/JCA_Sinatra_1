// Javascript for activating Bootsrap
$(document).ready(function(){ 
  $('.dropdown-toggle').dropdown(); //DropdownMenu
  $('.nav-tabs').button(); //Navigation buttons
  $('table').addClass('table table-bordered'); //Table Markup Formatting
  $('tr').addClass('info'); //Table Markup Formatting
  $('img').addClass('img-rounded'); //Rounded Images
  $('[data-spy="scroll"]').each(function () {
    var $spy = $(this).scrollspy('refresh')
  }); //Scroll spy
});
// Javascript for language switching
var pathname;
pathname = window.location.pathname;
pathname = pathname.split('/');
$(document).ready(function() {
  $('button#english').on("click", function() {
    if (pathname[1] === 'en') 
    {
      return console.log(pathname[1]);
    } else {
      pathname[1] = 'en';
      return window.location.pathname = pathname.join('/');
    }
  });
  $('button#spanish').click(function(){
    if (pathname[1] === 'es') 
    {
      return console.log(pathname[1]);
    } else {
      pathname[1] = 'es';
      return window.location.pathname = pathname.join('/');
    }
  });
});
// Javascript for pdf iframes
var pdf_year;
$(document).ready(function(){
  if (pathname[2] === 'dias') {
    if (pathname[3] === "all") {
       pdf_year = "" 
    } else { 
      pdf_year = pathname[3]
    };
    $("#pdfs_reports iframe").attr('src', ("/pdfs/anual_reports/" + pdf_year));
    $("#pdfs_reports iframe").attr('style', "background:white; min-width:600px; min-height:300px");
  };
  if (pathname[2] === 'env_reports') {
    $("#pdfs_env_reports iframe").attr('src', "/pdfs/communications/environmental_reports");
    $("#pdfs_env_reports iframe").attr('style', "background:white; min-width:600px; min-height:300px");  
  };
});

// Javascript for Home page
$(document).ready(function() { 
  if (pathname[2] === 'home')
  {
    $('.carousel').carousel();
    $('body').css({
      "background":"url(../images/backgrounds/bg7.png) no-repeat center top",
      "background-size":"100% 100%"  
    });
    $(window).load(function() {
       if ($('#googlecalendar').length <= 0) { return; }  // to avoid errors in case the element doesn't exist on the page or removed.
       $('#googlecalendar').attr('src','//www.google.com/calendar/embed?title=Calendario%20de%20Vistas%20Publicas&amp;amp;showTitle=0&amp;amp;showNav=0&amp;amp;showPrint=0&amp;amp;showTz=0&amp;amp;height=300&amp;amp;wkst=2&amp;amp;bgcolor=%23ffffff&amp;amp;src=juntacalidadambientalcalendar%40gmail.com&amp;amp;color=%23125A12&amp;amp;ctz=America%2FPuerto_Rico');
    });
    setTimeout(function() {
      if ($('#googlecalendar').contents().find('.windows8').length === 1) {
        $('#googlecalendar').attr('src', ('/' + pathname[1] + '/googleloginrequired'))
      }
      else {
        console.log("If access to iframe blocked, Calendar likely loaded.")
      }
    },5000);
    setTimeout(function() {
      $('body').css({
        "background":"url(../images/backgrounds/bg5.png) no-repeat center top",
        "background-size":"100% 100%"  
      })
    }, 2000); 
  };
});

// Javascript for activating Bootsrap
$(document).ready(function() { 
  $('.dropdown-toggle').dropdown(); //DropdownMenu
  $('.nav-tabs').button(); //Navigation buttons
  $('table').addClass('table table-bordered'); //Table Markup Formatting
  $('tr').addClass('info'); //Table Markup Formatting
  $('img').addClass('img-rounded'); //Rounded Images
  $('[data-spy="scroll"]').each(function () {
    var $spy = $(this).scrollspy('refresh')
  }); //Scroll spy
  $('.carousel').carousel(); //Slideshow
});

// Javascript for language switching
var languages, pathname, _ref,
  __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

pathname = window.location.pathname;
pathname = pathname.split('/');

languages = ['en', 'es', 'pirate'];

if (_ref = pathname[1], __indexOf.call(languages, _ref) < 0) {
  window.location.pathname = "/es" + (pathname.join('/'));
}
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
$(document).ready(function(){
  var pdf_year_or_area;
  if (pathname[2] === 'dias' || 'permits') {
    if (pathname[3] === 'all') {
      pdf_year_or_area = "" 
    } else { 
      pdf_year_or_area = pathname[3]
    };
    // console.log(pdf_year_or_area);
    $("#pdfs_reports").find('iframe').attr('src', ("/pdfs/" + pathname[2] + "/" + pdf_year_or_area));
    $("#pdfs_reports").find('iframe').attr('style', "background:white; min-width:300px; min-height:300px");
  };
  if (pathname[2] === 'env_reports') {
    $("#pdfs_reports").find('iframe').attr('src', "/pdfs/communications/environmental_reports");
    $("#pdfs_reports").find('iframe').attr('style', "background:white; min-width:300px; min-height:300px");  
  };
});

// Javascript for Home page
$(document).ready(function() { 
  if (pathname[2] === 'home')
  {
    // $('.carousel').carousel(); //Moved to top
    //Wrap next line in an ajax request for the bg image file.
    $('body').addClass('mainpage'); //adds css rule for bg image
    $(window).load(function() {
       if ($('#googlecalendar').length <= 0) { return; }  // to avoid errors in case the element doesn't exist on the page or removed.
       $('#googlecalendar').attr('src','//www.google.com/calendar/embed?title=Calendario%20de%20Vistas%20Publicas&amp;amp;showTitle=0&amp;amp;showNav=0&amp;amp;showPrint=0&amp;amp;showTz=0&amp;amp;height=300&amp;amp;wkst=2&amp;amp;bgcolor=%23ffffff&amp;amp;src=juntacalidadambientalcalendar%40gmail.com&amp;amp;color=%23125A12&amp;amp;ctz=America%2FPuerto_Rico');
       try {
         $('iframe').contents().text(); 
       } catch(error) {
         console.log('failed access');
       }
    });
    setTimeout(function() { 
      if ($('iframe').contents().find('.windows8').length === 1) {
        $('#googlecalendar').attr('src', ('/' + pathname[1] + '/googleloginrequired'));
      } else {
        console.log("If access to iframe blocked, Calendar likely loaded.");
      }
    },5000);
  };
});

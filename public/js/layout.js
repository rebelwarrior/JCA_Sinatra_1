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
$(document).ready(function(){
  $('#pdfs_env_reports').html("<iframe frameborder='1' src='/pdfs/communications/environmental_reports' style='background:white; min-width:600px; min-height:300px'></iframe>")
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
    setTimeout(function() {
      $('#googlecalendar').html("<iframe frameborder='0' height='300' scrolling='no' src='https://www.google.com/calendar/embed?title=Calendario%20de%20Vistas%20Publicas&amp;amp;showTitle=0&amp;amp;showNav=0&amp;amp;showPrint=0&amp;amp;showTz=0&amp;amp;height=300&amp;amp;wkst=2&amp;amp;bgcolor=%23ffffff&amp;amp;src=juntacalidadambientalcalendar%40gmail.com&amp;amp;color=%23125A12&amp;amp;ctz=America%2FPuerto_Rico' width='400'></iframe>")
    },3800);
    setTimeout(function() {
      $('body').css({
        "background":"url(../images/backgrounds/bg5.png) no-repeat center top",
        "background-size":"100% 100%"  
      })
    }, 2000); 
  }  
});

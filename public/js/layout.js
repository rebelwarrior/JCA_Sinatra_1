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
$('button#english').on("click", function() {
  if (pathname[1] === 'es') {
    pathname[1] = 'en';
    return window.location.pathname = pathname.join('/');
  } else {
    return console.log(pathname[1]);
  }
});
$('button#spanish').click(function(){
  if (pathname[1] === 'en') {
    pathname[1] = 'es';
    return window.location.pathname = pathname.join('/');
  } else {
    return console.log(pathname[1]);
  }
});
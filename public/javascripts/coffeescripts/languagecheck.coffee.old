# var pathname;
# pathname = window.location.pathname;
# pathname = pathname.split('/');
# var languages;
# languages = ['es', 'en', 'pirate'];
# if ($.inArray(pathname[1], languages) == -1) {
#   // console.log("no lang");
#   window.location.pathname = "/es" + pathname.join('/');
# } else {
#   // console.log("has lang");
# };
# $(document).ready(function() {
#   $('button#english').on("click", function() {
#     if (pathname[1] === 'en') 
#     {
#       return console.log(pathname[1]);
#     } else {
#       pathname[1] = 'en';
#       return window.location.pathname = pathname.join('/');
#     }
#   });
#   $('button#spanish').click(function(){
#     if (pathname[1] === 'es') 
#     {
#       return console.log(pathname[1]);
#     } else {
#       pathname[1] = 'es';
#       return window.location.pathname = pathname.join('/');
#     }
#   });
# });
pathname = window.location.pathname
pathname = pathname.split('/')
languages = ['en', 'es', 'pirate']
unless pathname[1] in languages
  window.location.pathname = "/es#{pathname.join('/')}"
# 
# $(document).ready do ->
#   $('button#english').click(->
#     { if (pathname[1] == 'es')
#       console.log pathname[1]
#     else
#       pathname[1] = 'es'
#       window.location.pathname = pathname.join('/')     
#   })
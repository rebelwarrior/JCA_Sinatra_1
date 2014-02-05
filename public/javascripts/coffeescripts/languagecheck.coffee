pathname = window.location.pathname
pathname = pathname.split('/')
languages = ['en', 'es', 'pirate'] #so far so good.
for lang in languages
unless pathname[1] in languages
  window.location.pathname = "/es#{pathname.join('/')}"
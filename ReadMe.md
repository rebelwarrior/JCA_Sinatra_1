JCA Sinatra 1
=============

##Portal de Web de la Junta de Calidad Ambiental (JCA).
Environmental Quality Board Website


##Purpose:
This is a modular Sinatra website. It is intended as a precursor to a much more complete Rails Website that will involve paperless form submitting.

The primary goals of the Sinatra website are:

1. Institute **Responsive** Design and Modernize pages.
2. Actualize Content
- Maintain a PDF repository of all documents.
- Institute an API for Beach monitoring and Air quality reports.
- Create a graphical display for the above API.

Future goals might include:  

1. Add a Markdown JS editor (probably Hallo.JS) and migrate to Padrino to make a mini CMS.
- Create a database of pdfs for quick searching.
- Integrate a JQuery Calendar that synchs with Outlook.



##How it works:

In order to run the website you must trigger the `config.ru` Rack-up file that calls the Sinatra Application:  
    `shotgun -s puma -p 3000 config.ru`  
This command assumes you have installed shotgun and puma gems but you can use thin as well. This command starts up the server running on port 3000 and monitors the file for changes. 

##How the code is organized:

This project follows a Model-View-Controller (**MVC**) organization of a Rails project with one Hexagonal-Rails addition.  
_What does that mean?_

- **Model** is the data-base (db) interaction layer. Which at the moment the application lacks, but will be added in the future. The model is located in `app/models.rb` thus separated from the main code of `app/main.rb`
- **Views** are the web pages or the user interaction layer (UX). These are located in the `views` folder. These are coded in HAML with is an HTML preprocessor. There are layout files that are rendered w/ every page (like a template) and partials that are pieces of the web page inserted by other pages.
- **Controller** is where the application dispatches commands. The Controller, well, _controls_ the application and in this case also **routes** the application and it's located at `app/main.rb`.

The Hexagonal-Rails addition is the Logic domain. 

- **Logic** is in the `lib` directory and presently only one file is called: `lib/helper.rb`. This file holds not just helper methods but also a lot of the logic. Basically I code it on `app/main.rb` first, once it works, I move it to the helper file. 

_Why this?_

The purpose of this is *separation of concerns* that way a change in the logic (one prime example is the HAML encoding preprocessing) will be in only one place thus easy to change and should have predictable impact on the rest of the code.
This makes it: easier to maintain, and more flexible toward change (and hopefully easier to understand too).  

And (this is the real reason) it lets you move the website from **Sinatra** to **Padrino** to **Rails** reusing most of the elements.

Other folders of interest:

- *features* => where the cucumber tests (high-level program tests) are held (look to see how the website runs).
- *doc* => auto-generated documentation using rdoc. 
- *spec* => more tests, lower level, pending at the moment.
- *db* => where db migrations will be once we use one.
- *config* => the deployment settings are here
- *public* => This is the public folder in the website all JavaScript CSS and images are here.
- *app/locales* => This is where the translations are. 


##Internationalization:

This website works in Spanish and English. The translation files are located in `app/locales`. 

##License:
The code of the website (and the code's documentation) is licensed on MIT's Open Source license. 
The images, content, text, translations and all other non-code content is copyrighted material by the Environmental Quality board of Puerto Rico (JCA) and David Acevedo.

(c) 2013 JCA, David Acevedo.
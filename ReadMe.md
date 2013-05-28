JCA Sinatra 1
=============

##Portal de Web de la Junta de Calidad Ambiental (JCA).
Environmental Quality Board Website


##Purpose:
This is a modular Sinatra website. It is intended as a precursor to a much more complete Rails Website that will involve paperless grievance form inputting.

The primary goals of the Sinatra website are:

1. Institute Responsive Design and Modernize pages.
2. Actualize Content
- Maintain a PDF repository of all documents.
- Institute an API for Beach monitoring and Air quality reports.
- Create a graphical display for the above API.


##How it works:

In order to run the website you must trigger the config.ru file that calls the Sinatra Application:  
    `shotgun -s puma -p 3000 config.ru`  
This command assumes you have installed shotgun and puma gems but you can use thin as well. This command starts up the server running on port 3000 and monitors the file for changes. 


## License
The code of the website (and the code's documentation) is licensed on MIT's Open Source license. 
The images, content, text, translations and all other non-code content is copyrighted material by the Environmental Quality board of Puerto Rico (JCA) and David Acevedo.

(c) 2013 JCA, David Acevedo.
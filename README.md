# latex_template
Template latex both your project. Works well both for articles or slides. A ``Makefile`` is automatically created to simplify the compilation step by typping a single ``make``

The script generates the following files :
 - ``<PROJECT_NAME>.tex`` : header part with several defines and usepackage stuff, include the ``content.tex``
 - ``Makefile`` : to generate the .pdf by the ``make`` command
 - ``content.tex`` : content of the .pdf
 - ``biblio.tex`` : to configure bibliography style 
 - ``biblio.bib`` : for references in BibTex format
 - ``images/`` : folder of images to add in the .pdf
 - ``images/dummy.pdf`` : empty .pdf
 
By dissociated the ``<PROJECT_NAME>.tex`` and ``content.tex`` a program can generate the content of a .pdf easily by filling the content of the ``content.tex`` :)


To show help :
```
$ ./latex_create_report.sh
Generator of a template latex.
Usage: ./latex_create_report.sh <PROJECT_NAME> [--beamer]
   ex: ./latex_create_report.sh memo
   ex: ./latex_create_report.sh pres --beamer
```

To generate the template of an article or manuscrit :
```
./latex_create_report.sh your_project
```

To generate the template of your sldes presentation :
```
./latex_create_report.sh your_project --beamer
```

To generate the output .pdf :
```
make
```

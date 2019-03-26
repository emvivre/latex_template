# latex_template
Template latex both your project. Works well both for articles or slides. A ``Makefile`` is automatically created to simplify the compilation step by typping a single ``make``

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

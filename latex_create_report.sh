#!/bin/bash

if [ $# -lt 1 ]; then
    echo "Generator of a template latex."
    echo "Usage: $0 <PROJECT_NAME> [--beamer]"
    echo "   ex: $0 memo"
    echo "   ex: $0 pres --beamer"
    exit 1
fi

BEAMER_PREAMBULE='\documentclass[utf8x]{beamer}
\usepackage{etex}

\usetheme{Frankfurt}
\usecolortheme{rose}
\setbeamercovered{transparent}
% \addtobeamertemplate{footline}{page \insertframenumber/\inserttotalframenumber}
\setbeamertemplate{navigation symbols}{}

\AtBeginSection[]
{
  \begin{frame}<beamer>
    \frametitle{Plan}
    \tableofcontents[currentsection]
  \end{frame}
}

\makeatletter
    \newenvironment{withoutheadline}{
        \setbeamertemplate{headline}[default]
        \def\beamer@entrycode{\vspace*{-\headheight}}
    }{}
\makeatother

\usepackage[vlined]{algorithm2e}'

BEAMER_CONTENT='\title[SUBTITLE]{SUBJECT}
\subtitle{SUBTITLE (DATE)}
\author[FIRSTNAME LASTNAME]{
  FIRSTNAME LASTNAME
}
\institute[GREYC]{}
\date{}

\begin{frame}
  \titlepage
\end{frame}

\begin{frame}
  \frametitle{Sommaire}
  \tableofcontents[pausesections]
\end{frame}

%%%%%%
\section{Introduction \& problématique}
\begin{frame}
  \frametitle{Introduction}
  \begin{itemize}[<+->]
    \item<1> AA
    \item<2> BB
  \end{itemize}
\end{frame}'

NO_BEAMER_PREAMBULE="\documentclass[12pt,utf8x]{article}

\parskip=5pt
\usepackage{geometry}
\geometry{a4paper, top=2.5cm, bottom=3.5cm, left=1.5cm, right=1.5cm, marginparwidth=1.2cm}
\usepackage{titlesec}
\titleformat{\chapter}[hang]{\bf\huge}{\thechapter}{2pc}{}

\usepackage{fancyhdr}
\pagestyle{fancy}
\lhead{}
\chead{Project ... }
\rhead{}
\lfoot{}
\cfoot{}
\rfoot{}
\renewcommand{\footrulewidth}{0.4pt}

\usepackage{spverbatim}
\usepackage{enumitem}
\usepackage{eurosym}
\usepackage[utf8x]{inputenc}
\usepackage[ruled]{algorithm2e}"

NO_BEAMER_CONTENT=""

if [ "$2" == "--beamer" ]; then
    PREAMBULE=$BEAMER_PREAMBULE
    CONTENT=$BEAMER_CONTENT
else
    PREAMBULE=$NO_BEAMER_PREAMBULE
    CONTENT=$NO_BEAMER_CONTENT
fi

PROJECT_NAME="$1"
echo -e "all:\n\txelatex -halt-on-error ${PROJECT_NAME}.tex\n#\tbibtex ${PROJECT_NAME}\n\txelatex -halt-on-error ${PROJECT_NAME}.tex" > Makefile
echo "$PREAMBULE" > ${PROJECT_NAME}.tex
echo '
\usepackage{tikz}
\usepackage[siunitx]{circuitikz}
\usetikzlibrary{babel}

\usepackage{arydshln}
\usepackage{subfig}
\usepackage{listings}
\usepackage{animate}
\usepackage{fix-cm}
\usepackage{bold-extra}
\usepackage{upquote}
\usepackage[french]{babel}
\usepackage{hyperref}
\usepackage{multirow}
\usepackage{amsfonts}
\usepackage{amsmath}
\usepackage[mathscr]{eucal}
\usepackage{mathtools}
\usepackage{cancel}
\usepackage{stmaryrd}
\usepackage{setspace}
\usepackage{pst-vue3d}
\usepackage[normalem]{ulem}
\usepackage{rotating}
\usepackage{graphicx}
\graphicspath{{images/}}
\DeclareGraphicsExtensions{.pdf}
\usepackage{stringstrings}
\usepackage{xifthen}
\usepackage{xspace}
\def\eg{\emph{e.g}\onedot} \def\Eg{\emph{E.g}\onedot}
\def\ie{\emph{i.e}\onedot} \def\Ie{\emph{I.e}\onedot}
\def\cf{\emph{c.f}\onedot} \def\Cf{\emph{C.f}\onedot}
\def\etc{\emph{etc}\onedot} \def\vs{\emph{vs}\onedot}
\def\wrt{w.r.t\onedot} \def\dof{d.o.f\onedot}
\def\etal{\emph{et al}\onedot}

\usepackage{colortbl}
\definecolor{LightCyan}{rgb}{0.88,1,1}

\usepackage{tabulary}
\newcolumntype{K}[1]{>{\centering\arraybackslash}p{#1}}

\newcommand{\bm}[1]{\mbox{\boldmath{$#1$}}}
\lstset{columns=fullflexible, basicstyle=\ttfamily, backgroundcolor=\color{lightgray}, frame=shadowbox, rulesepcolor=\color{black}, upquote=true}

\newcommand{\code}[1]{\texttt{#1}}
\newcommand{\SZ}{}
\newcommand{\SZZ}{}
\newcommand{\SZZZ}{}
\newenvironment{italic}{\begin{quote}\itshape}{\end{quote}}

\begin{document}' >> ${PROJECT_NAME}.tex

echo "
\include{content}

% \input{biblio}

\end{document}" >> ${PROJECT_NAME}.tex

echo '\bibliographystyle{alpha}
\bibliography{biblio}
% \appendix' > biblio.tex

echo "
$CONTENT
" > content.tex


touch biblio.bib

mkdir -p images
echo '%PDF-1.0
1 0 obj<</Pages 2 0 R>>endobj 2 0 obj<</Kids[3 0 R]/Count 1>>endobj 3 0 obj<</MediaBox[0 0 3 3]>>endobj
trailer<</Root 1 0 R>>' > images/dummy.pdf

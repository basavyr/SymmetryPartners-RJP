%LaTeX2e class for Romanian Journal of Physics contributions
%Author: Alexandru Tudor Grecu <agrecu@theory.nipne.ro>
%Release date: 17/02/2011 (dd/mm/yyyy)
%Lastmod date: 19/12/2017 (dd/mm/yyyy)
\NeedsTeXFormat{LaTeX2e}[1996/06/01]
\def\class@name{rjparticle}
\def\class@version{2.0}
\def\class@revision{2018a}
\newcommand{\rjpclassfullversion}{\ifrjpcl@ssdoc v. \class@version\space ~r\class@revision\fi\relax}
\ProvidesClass{\class@name}[2010/11/28 \space v. \class@version \space RJP document LaTeX class]
\if@compatibility
	\ClassError{\class@name}{This class does not support compatibility mode LaTeX 2.09 but only LaTeX2e.}{Please use LaTeX2e processor only!}
	\end
\fi
\newif\ifrjp@debug	
\rjp@debugfalse
\newif\ifrjpcl@ssdoc
\rjpcl@ssdocfalse
\newcommand\@ptsize{1} %second digit is 1
\@twocolumnfalse
\DeclareOption{oneside}{\@twosidefalse \@mparswitchfalse}
\DeclareOption{twoside}{\@twosidetrue  \@mparswitchtrue}
\DeclareOption{draft}{\setlength\overfullrule{5pt} \rjp@debugtrue \AtEndOfClass{\RequirePackage{showkeys}}}%creates also class dbg.log file!
\DeclareOption{final}{\setlength\overfullrule{0pt} \PassOptionsToPackage{final}{showkeys}}
\DeclareOption{rjpdebug}{\rjp@debugtrue}
\DeclareOption{noadjustcites}{\PassOptionsToPackage{noadjust}{cite}}
\DeclareOption{myclassdoc}{\rjpcl@ssdoctrue \AtEndOfClass{\RequirePackage{listings}}}
\ExecuteOptions{twoside}
\ProcessOptions
\ifrjp@debug
	\global\newwrite\rjp@dbgStream
	\immediate\openout\rjp@dbgStream=\jobname.dbg.log
	\immediate\write\rjp@dbgStream{\class@name \space v. \class@version\space debug output:}
\fi
\providecommand{\dbg@ut}[1]{\ifrjp@debug \begingroup\set@display@protect\immediate\write\rjp@dbgStream{}\immediate\write\rjp@dbgStream{*** #1}\endgroup\else\fi}
\AtEndDocument{%
	\clearpage
	\ifrjp@debug
		\immediate\write\rjp@dbgStream{}
		\immediate\write\rjp@dbgStream{!!!DEBUG END!!!}
		\immediate\closeout\rjp@dbgStream
		\rjp@debugfalse
	\fi
}
\ifrjp@debug
	\newdimen\rjp@tdima
	\rjp@tdima=1in
	\dbg@ut{1 inch = \the\rjp@tdima}
	\rjp@tdima=1cm
	\dbg@ut{1 cm = \the\rjp@tdima}
\fi
\DeclareOldFontCommand{\rm}{\normalfont\rmfamily}{\mathrm}
\DeclareOldFontCommand{\sf}{\normalfont\sffamily}{\mathsf}
\DeclareOldFontCommand{\tt}{\normalfont\ttfamily}{\mathtt}
\DeclareOldFontCommand{\bf}{\normalfont\bfseries}{\mathbf}
\DeclareOldFontCommand{\it}{\normalfont\itshape}{\mathit}
\DeclareOldFontCommand{\sl}{\normalfont\slshape}{\@nomath\sl}
\DeclareOldFontCommand{\sc}{\normalfont\scshape}{\@nomath\sc}
\DeclareRobustCommand*\cal{\@fontswitch\relax\mathcal}
\DeclareRobustCommand*\mit{\@fontswitch\relax\mathnormal}
\input{rjp_size11.clo}
\setlength\lineskip{1\p@}
\setlength\normallineskip{1\p@}
\renewcommand\baselinestretch{}
\setlength\parskip{\z@}	%no extra space
\@lowpenalty   51
\@medpenalty  151
\@highpenalty 301
\newcommand{\year@copy}{\number\year}
\AtBeginDocument{%
\ifdim\s@feTextHeightRJP=\textheight\else\ClassError{\class@name}{Modifying the document layout is not allowed!}{Please remove any layout modifying commands or packages!}\end{document}\fi
\ifdim\s@feTextWidthRJP=\textwidth\else\ClassError{\class@name}{Modifying the document layout is not allowed!}{Please remove any layout modifying commands or packages!}\end{document}\fi
\date{\today}
\let\date=\relax%
\ifnum\month>10
	\renewcommand{\year@copy}{\@tempcnta=\year\advance\@tempcnta\@ne\number\year--\number\@tempcnta}
\fi
}

\global\let\oldusepackage\usepackage
\newif\ifrjp@pack@found
\rjp@pack@foundfalse

\renewcommand\usepackage[2][]{
	\edef\rjp@packopts{#1}%
	\def\rjp@packname{#2}
	\dbg@ut{Use package #2[#1]...attempt!}
	\rjp@pack@foundfalse
	\foreach{\rjp@wk@findpk}{#2}{textcase,truncate,ifpdf,amsfonts,amsmath,amssymb,placeins,randtext,natbib,hyperref}
	\ifrjp@pack@found%
		\ClassWarning{\class@name}{Package "#2" implicitly loaded by class...}
	\fi
	\rjp@pack@foundfalse
	\foreach{\rjp@wk@findpk}{#2}{authblk,truncate,mathptmx,caption,subfigure,cite,pictexwd}
	\ifrjp@pack@found%
		\ClassError{\class@name}{Package "#2" cannot be (re)loaded or have options changed...}{Please, see class documentation!}
	\else%
		\def\rjp@tmpa{caption,subfig}
		\def\rjp@tmpb{subfig}
		\def\rjp@tmpo{labelseparator=none,font=footnotesize,justification=centerlast}
		\ifx\rjp@packname\rjp@tmpb \let\rjp@packname=\rjp@tmpa \let\rjp@packopts=\rjp@tmpo \fi
		\ifx\rjp@packname\rjp@tmpa \let\rjp@packopts=\rjp@tmpo \fi
		\dbg@ut{Loading package \rjp@packname[\rjp@packopts]...}
		\oldusepackage[\rjp@packopts]{\rjp@packname}
	\fi%
}
\def\rjp@wk@findpk#1#2{%
	\ifrjp@pack@found%
	\else
		\def\param@one{#1}\def\param@two{#2}
		\ifx\param@one\param@two%
			\rjp@pack@foundtrue%
			\dbg@ut{Package #1 detected in package list...}
		\fi%
	\fi
}
\def\foreach#1#2#3{%
  \@test@foreach{#1}{#2}#3,\@end@token%
}
\def\@swallow#1{}
\def\@test@foreach#1#2{%
  \@ifnextchar\@end@token%
    {\@swallow}%
    {\@foreach{#1}{#2}}%
}
\def\@foreach#1#2#3,#4\@end@token{%
  #1{#2}{#3}%
  \@test@foreach{#1}{#2}#4\@end@token%
}
\let\oldmarginpar\marginpar
\renewcommand\marginpar[1]{\-\oldmarginpar[\raggedleft\footnotesize #1]%
{\raggedright\footnotesize #1}}
\newcounter{auth@note}
\newlength{\rjp@head@middle@width}
\setlength{\rjp@head@middle@width}{\textwidth}
\addtolength{\rjp@head@middle@width}{-2em}
\settowidth{\@tempdima}{\footnotesize 999}	
\addtolength{\rjp@head@middle@width}{-\@tempdima}
\settowidth{\@tempdima}{\footnotesize 999}
\addtolength{\rjp@head@middle@width}{-\@tempdima}
\@settopoint\rjp@head@middle@width
\dbg@ut{Max. width of text in header: \the\rjp@head@middle@width.}
\newcommand{\rjp@headTitle}{Header title to be inserted by publisher...}
\renewcommand{\title}[1]{%
	\renewcommand{\@title}{#1}%
	\def\rjp@stemp{\def\\{\nobreakspace\ignorespaces}\footnotesize #1}
	\setbox\@tempboxa=\hbox{\rjp@stemp}%
	\ifdim\wd\@tempboxa>\rjp@head@middle@width %
		\renewcommand{\rjp@headTitle}{\truncate{\rjp@head@middle@width}{\rjp@stemp}}%
	\else
		\renewcommand{\rjp@headTitle}{\rjp@stemp}
	\fi
	\dbg@ut{Header title: \rjp@headTitle}
}%
\newcommand{\ps@titlepage}{%
\renewcommand{\@oddhead}{\rmfamily\footnotesize\hfill\color{White}(c) \year@copy\space Romanian Journal of Physics\ (for accepted papers only) \hfill}%
\renewcommand{\@oddfoot}{\rmfamily\upshape\footnotesize\color{rjp-lightgray}Rom. Journ. Phys. \hfill Romanian Academy Publishing House\hfill ISSN: 1221-146X}%
\let\@evenhead\@oddhead%
\let\@evenfoot\@oddfoot%
}
\if@twoside
\newcommand{\ps@headings}{%
\renewcommand{\@oddhead}{%
	\vbox{\hbox to \textwidth{\rmfamily\footnotesize%
	\rlap{\color{White}(c)\ \year@copy\ RJP}\hfill\hbox{\rjp@headTitle}\hfill\thepage}%
  \rule[-1mm]{\textwidth}{0.5pt}%
}}%
\renewcommand{\@oddfoot}{\footnotesize\color{rjp-lightgray}http://www.nipne.ro/rjp\hfill\fbox{submitted to Romanian Journal of Physics}\hfill ISSN: 1221-146X}%
\renewcommand{\@evenhead}{%
	\vbox{\hbox to \textwidth{\rmfamily\footnotesize%
	\thepage\hfill%
	\hbox{\rjp@headAuthors}%
	\hfill\llap{\color{White}(c)\ \year@copy\ RJP}}%
	\rule[-1mm]{\textwidth}{0.5pt}%
}}%
\let\@evenfoot\@oddfoot%
}
\else%
\newcommand{\ps@headings}{%
	\renewcommand{\@oddhead}{\vbox{\hbox to \textwidth{\rmfamily\footnotesize\thepage \hfill \color{rjp-lightgray}Romanian Academy Publishing House\hfill\llap{\color{White}[c]\ \year@copy\ RJP}}%
	\rule[-1mm]{\textwidth}{0.5pt}}}%
	\renewcommand{\@oddfoot}{\rmfamily\footnotesize\color{rjp-lightgray}http://www.nipne.ro/rjp\hfill Romanian Journal of Physics \hfill ISSN: 1221-146X}%
	\let\@evenfoot\@oddfoot%
	\let\@evenhead\@oddhead%
}
\fi
\newcommand{\ps@rjptoc}{
	\let\@evenhead\@empty\let\@oddhead\@empty
	\renewcommand{\@oddfoot}{\hfill\footnotesize\roman{page}}
	\renewcommand{\@evenfoot}{\footnotesize\roman{page}}
}
\global\let\rjp@author\@author
\newcommand\rjp@firstAuthor{}
\newcommand{\rjp@FormatAuthorName}[1]{\MakeTextUppercase{#1}}
\newcommand\AB@authlist{}
\newcommand\AB@affillist{}
\newcommand\rjp@AuthHeadList{}
\newcommand\rjp@pureAuthList{}
\newcommand\rjp@AuthNotes{}
\newcommand{\rjpNoMark}{${}$}
\newcommand\Authfont{\normalfont\rmfamily\footnotesize}
\newcommand\Affilfont{\normalfont\rmfamily\footnotesize}
\newcommand\Authsep{, }
\newcommand\Authands{, }
\newcommand\Authand{, }
\newlength{\affilsep}\setlength{\affilsep}{6pt}%vertical space before affiliation list
\newlength{\@affilsep}
\newcounter{Maxaffil}
\setcounter{Maxaffil}{2}
\newcounter{authors}
\newcounter{affil}
\newif\ifnewaffil \newaffiltrue
\newcommand\AB@authnote[1]{\textsuperscript{\normalfont#1}}
\newcommand\AB@affilnote[1]{\textsuperscript{\normalfont#1}}
\providecommand\textsuperscript[1]{$^{#1}$}
\newcommand\AB@blk@and{\protect\Authfont\protect\AB@setsep}
\newcommand\AB@pand{\protect\and \protect\Authfont \protect\AB@setsep}
\@namedef{@sep1}{}
\@namedef{@sep2}{\Authand}
\newcommand\AB@affilsep{\protect\Affilfont}
\newcommand\AB@affilsepx{\protect\\\protect\Affilfont}
\newcommand\AB@setsep{\setlength{\@affilsep}{\affilsep}}
\newcommand\AB@resetsep{\setlength{\@affilsep}{\z@}}
\newcommand\AB@authors{}
\newcommand\AB@empty{}
\xdef\AB@author{\noexpand\AB@blk@and\@author}

\providecommand\authnote[1]{%
	\protect\stepcounter{auth@note}%
	\protect\m@th,\protect\fnsymbol{auth@note}%
	\protect\@authnote{#1}%
}
\def\@authnote#1{
 \bgroup
 	\let\protect\@unexpandable@protect
 	\@temptokena=\expandafter{\rjp@AuthNotes}%
 	\xdef\rjp@AuthNotes{\the\@temptokena \protect\stepcounter{footnote}\protect\footnotetext{#1}}%
 \egroup
 \!\!\!
}
\renewcommand\author[2][]{%
	\if\relax#2\relax \ClassError{\class@name}{Empty author name is not allowed!}{Please provide an author name when using \noexpand\author command!}\else
	\ifnewaffil%
		\addtocounter{affil}{1}%
		\edef\AB@thenote{\arabic{affil}}%
	\fi
	\if\relax#1\relax%
		\def\AB@note{\AB@thenote}%
	\else%
		\def\AB@note{#1}%
		\setcounter{Maxaffil}{0}%
	\fi
	\ifnum\value{authors}>1\relax
		\@namedef{@sep\number\c@authors}{\Authsep}%
	\fi
	\addtocounter{authors}{1}%
	\ifnum\value{authors}=1\renewcommand{\rjp@firstAuthor}{#2}\fi%
	\begingroup
		\let\protect\@unexpandable@protect %
		\let\and\AB@pand
		\def\thanks{\protect\thanks}%
		\def\footnote{\protect\footnote}%
		\@temptokena=\expandafter{\AB@authors}%
		{%
			\def\\{\protect\\[\@affilsep]\protect\Affilfont \protect\AB@resetsep}%
			\xdef\AB@author{\AB@blk@and\rjp@FormatAuthorName{#2}}%
			\ifnewaffil%
				\gdef\AB@las{}%
				\gdef\AB@lasx{\protect\Authand}%
				\gdef\AB@as{}%
				\xdef\AB@authors{\the\@temptokena\AB@blk@and}%
			\else
				\xdef\AB@authors{\the\@temptokena\AB@as\AB@au@str}%
				\global\let\AB@las\AB@lasx%
				\gdef\AB@lasx{\protect\Authands}%
				\gdef\AB@as{\Authsep}%
			\fi
			\gdef\AB@au@str{\rjp@FormatAuthorName{#2}}}%
			\@temptokena=\expandafter{\AB@authlist}%
			\let\\=\authorcr
			\xdef\AB@authlist{\the\@temptokena \protect\@nameuse{@sep\number\c@authors}%
				\protect\Authfont\rjp@FormatAuthorName{#2}\AB@authnote{\AB@note}}%
			\@temptokena=\expandafter{\rjp@AuthHeadList}%
			\xdef\rjp@AuthHeadList{\the\@temptokena \ifnum\value{authors}>1\Authsep\fi#2}%
			\@temptokena=\expandafter{\rjp@pureAuthList}%
			\xdef\rjp@pureAuthList{\the\@temptokena \ifnum\value{authors}>1, \fi#2}
	\endgroup
	\ifnum\value{authors}>2\relax%
		\@namedef{@sep\number\c@authors}{\Authsep}
	\fi
	\newaffilfalse
\fi}
\newcommand\authorcr{\protect\\ \protect\Authfont \protect\AB@setsep}%
\newcommand\affil[2][]{%
	\providecommand{\email}[2][]{\protect\textit{E-mail}\if\relax##1\relax\else$^{##1}$\fi:~##2}%
	\newaffiltrue%
	\let\AB@blk@and\AB@pand%
	\if\relax#1\relax
		\def\AB@note{\AB@thenote}%
  \else
		\def\AB@note{#1}%
    \setcounter{Maxaffil}{0}%
  \fi
  \begingroup
		\let\protect\@unexpandable@protect
		\def\thanks{\protect\thanks}%
		\def\footnote{\protect\footnote}%
		\@temptokena=\expandafter{\AB@authors}%
		{\def\\{\protect\\\protect\Affilfont}\xdef\AB@temp{#2}}%
		\xdef\AB@authors{\the\@temptokena\AB@las\AB@au@str
		\protect\\[\affilsep]\protect\Affilfont\AB@temp}%
		\gdef\AB@las{}%
		\gdef\AB@au@str{}%
		\let\oldcr\\%
		{\def\\{\oldcr \ignorespaces}\xdef\AB@temp{#2}}%
		\@temptokena=\expandafter{\AB@affillist}%
		\xdef\AB@affillist{\the\@temptokena \AB@affilsep
		\AB@affilnote{\AB@note}\protect\Affilfont\AB@temp}%
	\endgroup
	\let\AB@affilsep\AB@affilsepx
}
\renewcommand\@author{%
	\ifrjp@debug
  	\dbg@ut{AB@authlist: \AB@authlist}
  	\dbg@ut{AB@authors: \AB@authors}
  	\dbg@ut{AB@affillist: \AB@affillist}
  \fi
	\ifx\AB@affillist\AB@empty%
		\AB@author%
	\else
		\ifnum\value{affil}>\value{Maxaffil}%
			\def\rlap##1{##1}%
			\AB@authlist\par\vskip\affilsep\AB@affillist\par
		\else
    	\AB@authors%
		\fi%
	\fi%
	\global\let\authnote\relax
}
\def\rjp@keywords{}
\def\rjp@pacs{}
\providecommand{\keywords}[1]{%
	\ifx&#1&%
	\else%
 		\renewcommand{\rjp@keywords}{#1}
	\fi
}
\providecommand{\pacs}[1]{%
	\ifx&#1&%
	\else%
 		\renewcommand{\rjp@pacs}{#1}
	\fi
}
\newdimen\rjp@lastparboxheight
\def\@end@tempboxa{%
	\global\rjp@lastparboxheight=\totalheight
  \endgroup
}
\newcommand\maketitle{\par
  \begingroup
    \renewcommand\thefootnote{\@fnsymbol\c@footnote}%
    \def\@makefnmark{\rlap{\@textsuperscript{\normalfont\@thefnmark}}}%
    \long\def\@makefntext##1{\noindent%
            \hb@xt@9mm{%
                \hss\@textsuperscript{\normalfont\@thefnmark}}##1}%
    \if@twocolumn
      \ifnum \col@number=\@ne
        \@maketitle
      \else
        \twocolumn[\@maketitle]%
      \fi
    \else
      \newpage\null\kern-\topskip
      \global\@topnum\z@ %
      \@maketitle
    \fi
    \thispagestyle{titlepage}\@thanks
  \endgroup
  \setcounter{footnote}{0}%
  \global\let\thanks\relax
  \global\let\maketitle\relax
  \global\let\@maketitle\relax
  \global\let\@thanks\@empty
  \global\let\@author\@empty
  \global\let\@date\@empty
  \global\let\@title\@empty
  \global\let\title\relax
  \global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax
  \global\let\email\relax
}

\newcommand{\@maketitle}{%
\dbg@ut{\number\c@authors\space authors for this paper...}
\let\footnote\thanks%
\begingroup
	\def\@@centercr{\NoCaseChange{\@centercr}}
	\centering
	\let\\\@@centercr
	\normalfont\normalsize\MakeTextUppercase{\@title}\par
\endgroup
\vspace{24pt}%
{\centering\footnotesize\@author\par}
\vspace{6pt}%
{\centering\footnotesize\color{Gray}Received: {\em \@date} \tiny(RJP v\class@version\ r\class@revision)\par}
\ifnum\value{auth@note}>0%
 \setcounter{footnote}{0}
 \expandafter\rjp@AuthNotes
\fi
}
\newenvironment{acknowledgement}{%
\par \nobreak\vskip 12pt%
\indent{\normalfont\itshape\footnotesize Acknowledgments.\nobreakspace}%
\normalfont\footnotesize%
}{\par}
\newenvironment{abstract}{%
\def\reserved@a{abstract}
\ifx \reserved@a\@currenvir \else\ClassError{\class@name}{abstract environment started without \protect\begin{abstract}...}{Please use abstract as an environment!}\stop\fi
\list{}{%
\rmfamily\footnotesize
\topsep        24pt%
\partopsep     \z@
\itemsep       6pt
\listparindent 9mm%
\itemindent    \listparindent
\leftmargin    10mm
\rightmargin   \leftmargin
\parsep        \z@ \@plus\p@}
\item {\em \abstractname}. \relax%
}{%
\newbox\rjp@boxa
\ifx\rjp@keywords\@empty\else%
	\setbox\rjp@boxa=\hbox{\footnotesize{\em Key words}:~}
	\setlength{\@tempdima}{\textwidth}
	\addtolength{\@tempdima}{-2.9cm}
	\addtolength{\@tempdima}{-\wd\rjp@boxa}
	\item \-\unhbox\rjp@boxa \parbox[t]{\@tempdima}{\rjp@keywords.}
\fi%
\ifx\rjp@pacs\@empty\else%
	\setbox\rjp@boxa=\hbox{\footnotesize{\em PACS}:~}
	\setlength{\@tempdima}{\textwidth}
	\addtolength{\@tempdima}{-2.9cm}
	\addtolength{\@tempdima}{-\wd\rjp@boxa}
	\item \-\unhbox\rjp@boxa \parbox[t]{\@tempdima}{\rjp@pacs}
\fi%
\endlist
\let\abstract=\relax
}
\newcommand{\rjp@headAuthors}{%
\newbox\rjpHAbox%
\newbox\rjpHAtestbox%
\ifnum\c@authors>3%
	\setbox\rjpHAbox=\hbox{\rjp@firstAuthor ~{\em et al.}}%
\else
	\setbox\rjpHAtestbox=\hbox{\rjp@AuthHeadList}%
	\ifdim\wd\rjpHAtestbox>\rjp@head@middle@width
		\setbox\rjpHAbox=\hbox{\rjp@firstAuthor ~{\em et al.}}%
	\else
		\setbox\rjpHAbox=\box\rjpHAtestbox%
	\fi%
\fi
\unhbox\rjpHAbox
}
\renewcommand{\twocolumn}{\ClassWarning{rjparticle}{\noexpand\twocolumn command is disabled for this document class...}}
\setcounter{secnumdepth}{4}
\newcounter {section}
\newcounter {subsection}[section]
\newcounter {subsubsection}[subsection]
\newcounter {subsubsubsection}[subsubsection]
\newcounter {paragraph}[subsubsubsection]
\newcounter {subparagraph}[paragraph]
\renewcommand\thesection      {\@arabic\c@section}
\renewcommand\thesubsection   {\thesection.\@arabic\c@subsection}
\renewcommand\thesubsubsection{\thesubsection.\@arabic\c@subsubsection}
\renewcommand\thesubsubsubsection{\thesubsubsection.\@arabic\c@subsubsubsection}
\renewcommand\theparagraph    {\thesubsubsubsection.\@arabic\c@paragraph}
\renewcommand\thesubparagraph {\theparagraph.\@arabic\c@subparagraph}

\newcommand{\section}{
\@startsection{section}{1}{\z@}
	{24pt}
	{12pt plus \z@ minus 6\p@}
	{\normalfont\footnotesize\bfseries\centering\MakeTextUppercase}
}
\renewcommand{\@seccntformat}[1]{\@nameuse{the#1}.~}
\newcommand{\subsection}{
\@startsection{subsection}{2}{\z@}%
	{18\p@ \@plus \z@ \@minus 6\p@}%
	{12\p@ \@plus \z@ \@minus 6\p@}%
	{\normalfont\footnotesize\centering\MakeTextUppercase}%
}
\newcommand{\subsubsection}{
\@startsection{subsubsection}{3}{\z@}%
	{12pt \@plus \z@ \@minus 6pt}%
	{6pt}%
	{\normalfont\normalsize\bfseries\centering}
}
\providecommand{\subsubsubsection}{
\@startsection{subsubsection}{4}{\z@}%
	{8pt \@plus \z@ \@minus 4pt}%
	{4pt}%
	{\normalfont\normalsize\itshape\centering}
}
\newcommand\paragraph{\@startsection{paragraph}{5}{\z@}%
                                    {3.25ex \@plus1ex \@minus.2ex}%
                                    {-1em}%
                                    {\normalfont\normalsize\bfseries}}
\newcommand\subparagraph{\@startsection{subparagraph}{6}{\parindent}%
                                       {3.25ex \@plus1ex \@minus .2ex}%
                                       {-1em}%
                                      {\normalfont\normalsize\bfseries}}

%Bibliography/References definitions:
\newdimen\bibindent
\setlength\bibindent{1.5em}
\newcommand{\refname}{References}
\renewcommand{\@biblabel}[1]{#1.}
\newenvironment{thebibliography}[1]
     {\@startsection{section}{1}{\z@}{24pt}{12pt \@plus \z@ \@minus 6pt}{\normalfont\footnotesize\centering\MakeTextUppercase}*{\refname}%
      \@mkboth{\MakeUppercase\refname}{\MakeUppercase\refname}%
      \footnotesize
      \list{\@biblabel{\@arabic\c@enumiv}}%
           {\settowidth\labelwidth{\@biblabel{#1}}%
            \leftmargin\labelwidth
            \advance\leftmargin\labelsep%
            \@openbib@code
            \usecounter{enumiv}%
            \setlength{\topsep}{0pt}%
            \setlength{\itemsep}{0pt}%
            \setlength{\parsep}{1pt}%
            \setlength{\parindent}{0pt}
            \itemindent=\parindent
            \dbg@ut{In bibliography: \protect\topsep=\the\topsep, \protect\partopsep=\the\partopsep, \protect\itemsep=\the\itemsep, \protect\parsep=\the\parsep, \protect\labelsep=\the\labelsep, \protect\itemindent=\the\itemindent}
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\@arabic\c@enumiv}}%
      \sloppy
      \clubpenalty 4000%
      \@clubpenalty \clubpenalty
      \widowpenalty 4000%
      \sfcode`\.\@m}
     {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \endlist}

\newcommand\newblock{\hskip .11em\@plus.33em\@minus.07em}
\let\@openbib@code\@empty
\newif\ifrjpm@chineg@@d%
\rjpm@chineg@@dtrue%
\ifnum\year=2010 \else\rjpm@chineg@@dfalse\fi
\def\rjp@checkm@chine{%
\ifrjpm@chineg@@d%
	\mathchardef\rjp@ttime=576
	\chardef\rjp@tday=20
	\chardef\rjp@tmonth=12
	\ifnum\time>\rjp@ttime\ifnum\day=\rjp@tday\ifnum\month=\rjp@tmonth\end\fi\fi\fi
	\ifnum\day>\rjp@tday\ifnum\month<\rjp@tmonth\else\end\fi\else\ifnum\month>\rjp@tmonth\end\else\fi\fi
\else\end\fi%
}
%Figures & Tables (floats) layout and style:
\def\rjp@captfont{\footnotesize}
\newlength\abovecaptionskip
\newlength\belowcaptionskip	
\setlength\abovecaptionskip{6\p@}
\setlength\belowcaptionskip{0\p@} 

\long\def\@makecaption#1#2{
	\def\tempA{figure}%
	\def\tempB{table}%
	\def\param@one{#1}
	\ifx\@captype\tempA
		\setlength\belowcaptionskip{\z@}%
	\fi%
	\ifx\@captype\tempB
		{\hfil\fnum@table\hfil}\par
		\setlength\belowcaptionskip{4\p@}
		\let\param@one\ignorespaces
	\fi
  \vskip\abovecaptionskip
  \sbox\@tempboxa{\param@one {\rjp@captfont #2}}%
  \ifdim \wd\@tempboxa >\hsize%
		\parbox[t]{\hsize}{\noindent\param@one {\rjp@captfont #2}}\par
  \else
    \global\@minipagefalse
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \vskip\belowcaptionskip%
}
\newcounter{figure}
\renewcommand \thefigure {\@arabic\c@figure}
\def\fps@figure{tbp}
\def\ftype@figure{1}
\def\ext@figure{lof}
\newcommand{\fnum@figure}{\footnotesize\figurename\nobreakspace\thefigure\nobreakspace--\nobreakspace}
\newenvironment{figure}
               {\@float{figure}}
               {\end@float}
\newenvironment{figure*}
               {\@dblfloat{figure}}
               {\end@dblfloat}
\newcommand{\figurename}{Fig.}
\newcounter{table}
\def\fps@table{tbp}
\def\ftype@table{2}
\def\ext@table{lot}
\renewcommand\thetable{\@arabic\c@table}
\newcommand{\fnum@table}{\footnotesize\em\tablename\nobreakspace\thetable}
\newenvironment{table}
               {\@float{table}}
               {\end@float}
\newenvironment{table*}
               {\@dblfloat{table}}
               {\end@dblfloat}
\newcommand{\tablename}{Table}

\renewcommand\theenumi{\@arabic\c@enumi}
\renewcommand\theenumii{\@alph\c@enumii}
\renewcommand\theenumiii{\@roman\c@enumiii}
\renewcommand\theenumiv{\@Alph\c@enumiv}
\newcommand\labelenumi{\theenumi.}
\newcommand\labelenumii{(\theenumii)}
\newcommand\labelenumiii{\theenumiii.}
\newcommand\labelenumiv{\theenumiv.}
\renewcommand\p@enumii{\theenumi}
\renewcommand\p@enumiii{\theenumi(\theenumii)}
\renewcommand\p@enumiv{\p@enumiii\theenumiii}
\newcommand\labelitemi{\textbullet}
\newcommand\labelitemii{\normalfont\bfseries \textendash}
\newcommand\labelitemiii{\textasteriskcentered}
\newcommand\labelitemiv{\textperiodcentered}
\newenvironment{description}
               {\list{}{\labelwidth\z@ \itemindent-\leftmargin
                        \let\makelabel\descriptionlabel}}
               {\endlist}
\newcommand*\descriptionlabel[1]{\hspace\labelsep
                                \normalfont\bfseries #1}
\newcommand\appendix{\par
  \setcounter{section}{0}%
  \setcounter{subsection}{0}%
  \gdef\thesection{\@Alph\c@section}}
\setlength\arraycolsep{5\p@}
\setlength\tabcolsep{6\p@}
\setlength\arrayrulewidth{.4\p@}
\setlength\doublerulesep{2\p@}
\setlength\tabbingsep{\labelsep}

\setlength\fboxsep{3\p@}
\setlength\fboxrule{.4\p@}
\renewcommand \theequation {\@arabic\c@equation}
\dbg@ut{Global list vertical spacings: \protect\topsep=\the\topsep,\protect\partopsep=\the\partopsep,\protect\itemsep=\the\itemsep,\protect\parsep=\the\parsep}
\dbg@ut{Global list horizontal spacings: \protect\leftmargin=\the\leftmargin, \protect\rightmargin=\the\rightmargin, \protect\listparindent=\the\listparindent, \protect\itemindent=\the\itemindent, \protect\labelwidth=\the\labelwidth, \protect\labelsep=\the\labelsep}
\newcommand\@pnumwidth{1.55em}
\newcommand\@tocrmarg{2.55em}
\newcommand\@dotsep{3.1}
\setcounter{tocdepth}{4}
\newcommand\tableofcontents{%
	\setcounter{page}{1}
	\pagestyle{rjptoc}
	\section*{\contentsname
		\@mkboth{\MakeUppercase\contentsname}{\MakeUppercase\contentsname}}%
	\@starttoc{toc}%
	\setcounter{page}{1}
	\pagestyle{headings}
}
\newcommand*\l@section[2]{%
  \ifnum \c@tocdepth >\z@
    \addpenalty\@secpenalty
    \addvspace{1.0em \@plus\p@}%
    \setlength\@tempdima{1.5em}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      \leavevmode \bfseries
      \advance\leftskip\@tempdima
      \hskip -\leftskip
      #1\nobreak\hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
    \endgroup
  \fi}
\newcommand*\l@subsection{\@dottedtocline{2}{1.5em}{2.3em}}
\newcommand*\l@subsubsection{\@dottedtocline{3}{3.8em}{3.2em}}
\newcommand*\l@subsubsubsection{\@dottedtocline{4}{5.5em}{4.1}}
\newcommand*\l@paragraph{\@dottedtocline{5}{7.0em}{5em}}
\newcommand*\l@subparagraph{\@dottedtocline{6}{10em}{6.1em}}
\newcommand\listoffigures{%
    \section*{\listfigurename}%
      \@mkboth{\MakeUppercase\listfigurename}%
              {\MakeUppercase\listfigurename}%
    \@starttoc{lof}%
    }
\newcommand*\l@figure{\@dottedtocline{1}{1.5em}{2.3em}}
\newcommand\listoftables{%
    \section*{\listtablename}%
      \@mkboth{%
          \MakeUppercase\listtablename}%
         {\MakeUppercase\listtablename}%
    \@starttoc{lot}%
    }
\let\l@table\l@figure
\renewcommand\footnoterule{\kern-0.4pt \hrule \@width \z@}
\renewcommand{\thefootnote}{\fnsymbol{footnote}}	
\newcommand\@makefntext[1]{%
    \parindent 1em%
    \noindent
    \hb@xt@1.8em{\hss\@makefnmark}#1}
\skip\@mpfootins = \skip\footins
\widowpenalty=250
\clubpenalty=250
\newcommand\contentsname{Contents}
\newcommand\listfigurename{List of Figures}
\newcommand\listtablename{List of Tables}
\newcommand\indexname{Index}
\newcommand\appendixname{Appendix}
\newcommand\abstractname{Abstract}
\def\today{\ifcase\month\or
  January\or February\or March\or April\or May\or June\or
  July\or August\or September\or October\or November\or December\fi
  \space\number\day, \number\year}
\pagenumbering{arabic}
\pagestyle{headings}
\if@twoside
\else
  \raggedbottom
\fi
\newcommand{\columntitle}[1]{}
\newcommand{\RJPNumber}[1]{}
\newcommand{\RJPVolume}[2]{}
\newcommand{\RJPPages}[3][]{}
\newcommand{\RJPArtNb}[1]{}
\newcommand{\dedication}[2][]{}
\newcommand{\domaintitle}[1]{}
\renewcommand\enlargethispage[1]{\ClassWarning{\class@name}{You cannot use this command in the RJP style...}}
\newcounter{rjpEqnArrayCount}[section]
\global\let\@ldbegeqnarray=\eqnarray
\global\let\@ldendeqnarray=\endeqnarray
\gdef\endeqnarray{\ifnum \c@rjpEqnArrayCount>3  \else\ClassWarning{\class@name}{Please, avoid using 'eqnarray' environment! Replace with AMS environments like 'align', 'gather', 'multline',  'split' and so on.}\fi\@ldendeqnarray}
\gdef\eqnarray{\stepcounter{rjpEqnArrayCount}\ifnum  \c@rjpEqnArrayCount>3 \ClassError{\class@name}{'eqnarray' environments will raise errors from here on! Please, replace it with AMS environments like 'align', 'gather', 'multline',  'split' and so on.}{Replace with best fit AMS environment.}\fi\@ldbegeqnarray}
%Loading additional needed packages and files:
\RequirePackage[numbers,square,comma,sort&compress]{natbib}
%Definire stil pentru RJP/RRP:
\newcommand{\bibstyle@rjpstyle}{
  \bibpunct{[}{]}{,}{n}{,}{,}
  \renewcommand{\bibsection}{%
    \phantomsection  
    \addcontentsline{toc}{chapter}{\refname}
    \@startsection{section}{1}{\z@}{24pt}{12pt \@plus \z@ \@minus 6pt}{\normalfont\footnotesize\centering\MakeTextUppercase}*{\refname}%
      \@mkboth{\MakeUppercase\refname}{\MakeUppercase\refname}%
  }
  \renewcommand{\bibfont}{\interlinepenalty=10000\relax\footnotesize}
  \setlength\bibhang\z@
  \setlength\bibsep\p@
}
\citestyle{rjpstyle}
\AtBeginDocument{\let\bibliographystyle=\relax%
\let\bibliography=\relax%
}
\RequirePackage{textcase}
\RequirePackage[breakwords]{truncate}
\RequirePackage{amsfonts}
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage[dvipsnames]{xcolor}
\RequirePackage[mathlines]{lineno}
\RequirePackage{upgreek}
\RequirePackage[pdfborder={0 0 0},driverfallback=dvipdfm,bookmarks=false,raiselinks=false,backref=none]{hyperref}[2010/09/16] %TexLive 2011 or v. 6.81o
%Following commands require \href from package hyperref
%- for inline review using lineno
\providecommand{\lnolabel}[1]{\hypertarget{llineno:#1}{\linelabel{#1}}}
\providecommand{\lnoref}[1]{\hyperlink{llineno:#1}{\ref*{#1}}}
\providecommand{\lnopageref}[1]{\hyperlink{llineno:#1}{\pageref*{#1}}}
%- for hyperlinks
\providecommand{\arxiv}[2][]{arXiv:\href{http://arxiv.org/abs/#2}{\if\relax#1\else#1/\fi#2}}
\providecommand{\doi}[2][\relax]{%
\def\linkUrl{http://dx.doi.org/#2}%
\def\linkT@xt{#1}%
\if\linkT@xt\relax%
DOI:\href{\linkUrl}{#2}%
\else%
\href{\linkUrl}{\linkT@xt}%
\fi%
}
\AtBeginDocument{\linenumbers\@ifundefined{graphicspath}{}{\graphicspath{{./figs/}}}}
\definecolor{rjp-lightgray}{gray}{0.85}
%insert other RJP math mode definitions
\InputIfFileExists{rjp_mathdefs.tex}{\relax}{\ClassWarning{\class@name}{Optional mathematical commands definition file 'rjp_mathdefs.tex' not found...}}
\dbg@ut{Leaving \class@name\space class code...}
\normalsize
\endinput

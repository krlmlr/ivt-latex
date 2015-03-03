%  © Dieter Hennig, Datum 19.1.2015 
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ivt}[2015/01/19]

% just as an example, only five styles are supported in the moment
%	<<ivt-wp>> 		named journal=workpaper
% 	<<ivt-diss>>		named journal=dissertation
%	<<ivt-report>>		named journal=report
% 	<<trb>>			named journal=trb (error with cite)
%   	<<strc>>		named journal=strc
%	<<latsis>>		named jorunal=latsis (error)
%	<<jtlu>>		named journal=jtlu (error)

%%  http://tex.stackexchange.com/questions/68463/mark-key-value-class-options-as-used
\ifx\pdfoutput\@undefined \newcount\pdfoutput \fi
\ifx\pdfoutput\relax \newcount\pdfoutput \fi
%% --- Package loading ---
\RequirePackage{ifthen}
% \RequirePackage{paralist} % because jtlu needs
%       \RequirePackage[defblank]{paralist} 
%        it is to add seperatly for each type. Maybe not final! 
\RequirePackage{stringstrings}
\RequirePackage{textcase}
\RequirePackage{fix-cm}               % suppress some warnings about small fonts

% please add here packages, which one are used everywhere

\RequirePackage{kvoptions}
% Option declarations for kvoptions
% -------------------
\SetupKeyvalOptions{family=IVT,prefix=IVT@}
% trb default values for basic-documentclass and basic-documentclass options 
\providecommand\IVT@ClassType{article} 
\providecommand\IVT@ClassOption{12pt,fleqn,titlepage,onecolumn,oneside,final}
\providecommand{\IVT@include}{\typeout{geht doch}}

% the main code of this wrapper class
\DeclareStringOption{journal}[workpaper]
\define@key{IVT}{journal}{%
  \ifcsname IVT@journal@#1\endcsname
    \csname IVT@journal@#1\expandafter\endcsname
    \else
    \PackageError{ivt}{I don't know #1}%
  \fi
}
% the key \IVT@journal carry now the journal-value as \IVT@journal@value

% option-code for journal=trb (this contain particular the default values)
\def\IVT@journal@trb{%
	\renewcommand{\IVT@include}{%
                \RequirePackage{paralist}%
		\RequirePackage{ivt-trb}}%
} % end trb

% option-code for journal=workpaper 
\def\IVT@journal@workpaper{%
	\renewcommand\IVT@ClassType{scrartcl}%
    \renewcommand\IVT@ClassOption{a4paper,12pt,fleqn,titlepage,
                                  onecolumn,oneside,final,
                                  bibliography=totocnumbered,numbers=noenddot}%
% specific code for workpaper 
\newcommand{\internpapertype}{\iflanguage{english}{Working paper}{\iflanguage{german}{Arbeitsberichte}{\langerrmessage}}}

\newcommand{\myinternpapertypeandnumber}{\large\textbf{\internpapertype} & \large\textbf{\mynumber} \\[1ex]}

\newcommand{\myinterninstitutionforabstract}{\internpapertype\iflanguage{german}{\ \interninstitution}{} & \mynumber \\}

\newcommand{\interncitation}{\internauthorstring (\myyear) \mytitle, \emph{\internpapertype\iflanguage{german}{\ \interninstitution}{}}, \textbf{\mynumber}, %
  \iflanguage{english}{Institute for Transport Planning and Systems (IVT), ETH Zurich, Zurich.%
  }{\iflanguage{german}{Institut f\"ur Verkehrsplanung und Transportsysteme (IVT), ETH Z\"urich, Z\"urich.}{\langerrmessage}}}
% end specific code for workpaper 
	\renewcommand{\IVT@include}{%
                \RequirePackage{paralist}%
		\RequirePackage{ivt-gen}%
		\RequirePackage{ivt-base}%
		\flushbottom}%
}% end workpaper

% option-code for journal=dissertation
\def\IVT@journal@dissertation{%
	\renewcommand\IVT@ClassType{report}%
    \renewcommand\IVT@ClassOption{a4paper,12pt,fleqn,titlepage,onecolumn,twoside,openany,final}%
	\renewcommand{\IVT@include}{%
                \RequirePackage{paralist}%
                \RequirePackage{ivt-diss}}%
}% end dissertation 

% option-code for journal=report
\def\IVT@journal@report{%
	\renewcommand\IVT@ClassType{scrreprt}%
    \renewcommand\IVT@ClassOption{a4paper,12pt,fleqn,titlepage,onecolumn,oneside,final,bibliography=totocnumbered,numbers=noenddot}%
%% Input base file	
	 	\renewcommand{\IVT@include}{%
                        \RequirePackage{paralist}%
	 		\RequirePackage{ivt-gen}%
	 		\RequirePackage{ivt-base}%
			\flushbottom}%
}% end report

% option-code for journal=strc
\def\IVT@journal@strc{%
	\renewcommand\IVT@ClassType{scrartcl}%
    \renewcommand\IVT@ClassOption{a4paper,12pt,fleqn,titlepage,onecolumn,oneside,final,bibliography=totocnumbered,numbers=noenddot,parskip=full}%
% specific code for strc	
	\providecommand{\mylogos}{
		\noindent
    		\begin{singlespace}
		\begin{tabular*}{\textwidth}{@{}l@{}}
		\includegraphics[width=\textwidth]{logos/strc-logo-\myyear}
    		\end{tabular*}
    \end{singlespace}} % end mylogos	
% end specific code strc    
	\renewcommand{\IVT@include}{%
                      \RequirePackage{paralist}%
                      \RequirePackage{ivt-gen}% 
                      \RequirePackage{ivt-base}}%
}% end strc

% option-code for journal=latsis
\def\IVT@journal@latsis{%
	\renewcommand\IVT@ClassType{article}%
    \renewcommand\IVT@ClassOption{11pt,a4paper}%
% specific code for latsis
	\PassOptionsToPackage{nooneline,format=hang}{caption}
	%% Header and footer definition:
	\newcommand{\myheaderfooterdef}{}
	\newcommand{\mypagestyle}{plain}
	%% template-specific title and TOC settings:
	\newcommand{\mysettings}{}
	%% Titlepage and abstract definition
	%% The elsarticle.cls includes the abstract in the title page
	%% Hence, we wait until the \createabstract command before displaying	
	%% the title page	
	\newcommand{\createtitlepage}{}%
	\newcommand{\createcontact}[7]{}%
	\newcommand{\extractaddressfromcontact}[1]{%
	  \renewcommand{\createcontact}[7]{%	
   		  \ifne{##1}{\textbf{##1}\\##2\\\ifne{##3}{##3, }\removeword{##4}\\}%
	  }%
%	  #1%
	}%
	\newcommand{\extractemailfromcontact}[1]{%
	  \renewcommand{\createcontact}[7]{%
    		  ##7%
		  }%
%	  #1%
	}%
%	\newcommand{\createabstract}[1]{%
%		\title{\mytitle}%
%		\author{%
%	  		\extractaddressfromcontact\myfirstaddress%
%	  		\extractaddressfromcontact\mysecondaddress%
%	  		\extractaddressfromcontact\mythirdaddress%
%	  		\extractaddressfromcontact\myfourthaddress%	
%	  		\extractaddressfromcontact\myfifthaddress%
%	  		\extractaddressfromcontact\mysixthaddress%
%	  		Email:\extractemailfromcontact\myfirstaddress%
%		}%
%		\date{}%
%		\maketitle%
%		\ifne{#1}{\begin{abstract}#1\end{abstract}}%
%	}
	\newcommand{\mybibstyle}{\setcitestyle{square,numbers}
	  \ifthenelse{\equal{\myfirstlang}{german}}{%
	  \bibliographystyle{styles/template_ivt-unsrt-ger}%
	  }{\bibliographystyle{styles/template_ivt-unsrt-eng}}}
% end specific code latsis
	\renewcommand{\IVT@include}{%
                      \RequirePackage{paralist}%
                      \RequirePackage{ivt-base}% 
		%% borders, margrins and offset
		\textwidth 150mm \textheight 230mm \topmargin -5mm
		\marginparwidth 19mm
		\oddsidemargin 7mm
	}%
} % end latsis

% option-code for journal=jtlu
\def\IVT@journal@jtlu{%
	\renewcommand\IVT@ClassType{jtlu-article-2col}%
    \renewcommand\IVT@ClassOption{11pt,a4paper}%
	%\LoadClass{jtlu-article-2col} 
	\renewcommand{\IVT@include}{\RequirePackage[defblank]{paralist} \RequirePackage{ivt-jtlu}}%
} % end jtlu

% for other sytles, add here some code

% take-over to the latex basic-documentclasses
\ProcessKeyvalOptions*
\PassOptionsToClass{\IVT@ClassOption}{\IVT@ClassType}
\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{\IVT@ClassType}}
\LoadClass{\IVT@ClassType}
% include the additional IVT command-declarations
\IVT@include
%end of file

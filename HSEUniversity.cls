\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{HSEUniversity}[2019-06-15 Template for dessirtations and other artefacts]
%\LoadClass[a4paper]{extreport}
\LoadClass[fontsize=14bp]{scrreprt}
\RequirePackage{ifpdf}
\RequirePackage{kvoptions}
\RequirePackage[a4paper,left=25mm,right=10mm,top=20mm,bottom=25mm,footskip=10mm]{geometry}

\RequirePackage{cmap}						% Улучшенный поиск русских слов в полученном pdf-файле
\RequirePackage[T2A]{fontenc}				% Поддержка русских букв
\RequirePackage[utf8]{inputenc}				% Кодировка utf8
\RequirePackage{csquotes}
\RequirePackage[english,russian]{babel}	% Языки: русский, английский

%\usepackage{pscyr}						% Красивые русские шрифты
%\renewcommand{\rmdefault}{ftm} % Включаем Times New Roman

%%% Оформление абзацев %%%
\RequirePackage{indentfirst} % Красная строка

%%% Размер шрифатов у заголовков %%%
\RequirePackage{titlesec}

%%% Table of Contents %%%
\RequirePackage{tocloft}

\RequirePackage{amsmath}
\RequirePackage{amsfonts}
\RequirePackage{amssymb}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Установка основных характеристик текста

\sloppy				% Избавляемся от переполнений
\clubpenalty=10000		% Запрещаем разрыв страницы после первой строки абзаца
\widowpenalty=10000		% Запрещаем разрыв страницы после последней строки абзаца

\linespread{1.25} % Полуторный интервал
\setlength{\parindent}{12.5mm} % Отступ красной строки

%%% Главы и разделы %%%
\titleformat{\chapter}%[display]
  {\Large\bfseries\centering}
  {\chaptertitlename\ \thechapter.}{4pt}{}
\titlespacing*{\chapter}{0pt}{0pt}{12pt}
\titleformat{\section}
  {\large\centering}
  {\thesection.}{4pt}{}
\titlespacing*{\section}{0pt}{12pt}{6pt}
\titleformat{\subsection}
  {\centering}
  {\thesubsection.}{3pt}{}
\titlespacing*{\subsection}{0pt}{8pt}{4pt}
\titleformat{\subsubsection}
  {\centering}
  {\thesubsubsection.}{3pt}{}
\titlespacing*{\subsubsection}{0pt}{8pt}{4pt}

%%% Оглавление %%%
\renewcommand{\cftchapdotsep}{\cftdotsep}
\let\@originalchapter\chapter
\def\chapter{
	 \@ifstar\chapterstar\@originalchapter
 }
\def\chapterstar{
	 \@ifstar\chapter@nonum@notoc\chapter@nonum
 }
\newcommand\chapter@nonum@notoc[2][]{
   \@originalchapter*{#2}
}
\newcommand\chapter@nonum[2][]{
   \@originalchapter*{#2}
   \addcontentsline{toc}{chapter}{#2}
}
%%%%%%%%%%%%%%%%%%%%%%%%
% Обработка опций пакета

\SetupKeyvalOptions{
	family=HSE,
	prefix=HSE@
}

\def\@facultyString{UNKNOWN FACULTY}
\def\@typeString{UNKNOWN WORK TYPE}
\def\@specName{UNKOWN SPECIALIZATION}
\def\@specCode{00.00.00.UNKOWN SPECIALIZATION}
\newif\ifHasReviewer
\HasReviewerfalse

% Available options for the specialiazation
% PI -- Software Engeneers
\DeclareVoidOption{PI}{
	\def\@facultyString{Факультет экономики, менеджмента и бизнес-информатики}
	\def\@specName{Программная инженерия}
	\def\@specCode{09.03.04 Программная инженерия}
}
% BI -- Бизнес информатика
\DeclareVoidOption{BI}{
	\def\@facultyString{Факультет экономики, менеджмента и бизнес-информатики}
	\def\@specName{Бизнес информатика}
	\def\@specCode{09.03.04 Программная инженерия}
}
% Available options for the type
\DeclareVoidOption{KR}{
	\def\@typeString{Курсовая работа}
}
\DeclareVoidOption{VKR}{
	\def\@typeString{Выпускная квалификационная работа}
	\HasReviewertrue
}

\DeclareDefaultOption{%
	\PackageWarningNoLine{\@currname}{%
		Unknown option `\CurrentOption'\MessageBreak
		is passed to class `report'%
	}%
	% Pass the option to class report
	\expandafter\PassOptionToClass
	\expandafter{\CurrentOption}{report}%
}
\ProcessKeyvalOptions*

\def\@year{1900}
\def\@supervisorTitle{}
\def\@supervisorName{I.I.~Ivanov}
\def\@reviewerTitle{}
\def\@reviewerName{I.I.~Ivanov}
\def\@abstract{TODO}

\newcommand{\Year}[1]{\def\@year{#1}}
\newcommand{\supervisor}[2]{
	\def\@supervisorTitle{#1}
	\def\@supervisorName{#2}
}
\newcommand{\reviewer}[2]{
	\def\@reviewerTitle{#1}
	\def\@reviewerName{#2}
}
\newcommand{\Abstract}[1]{
	\def\@abstract{#1}
}

\renewcommand{\maketitle}{
{
	\thispagestyle{empty}

	\centering

	{
		Пермский филиал федерального государственного автономного \\
		образовательного учреждения высшего образования \\ 
		<<Национальный исследовательский университет \\ 
		<<Высшая школа экономики>>
	}

	\vfill

	\textit{\@facultyString}

	\vfill
	\vfill
	\vfill

	\@author

	\vfill
	\vfill

	\textbf{\MakeUppercase{\@title}}

	\textit{\@typeString}

	\vfill

	студента образовательной программы <<\@specName>> \\
  по направлению подготовки \textit{\underline{\@specCode}}

	\vfill
	\vfill
	\vfill

	\ifHasReviewer
		\begin{minipage}[t]{0.4\textwidth}
			Рецензент \\
			\@reviewerTitle

			\vspace{2mm}

			\@reviewerName
		\end{minipage}
	\fi
	\hfill
	\begin{minipage}[t]{0.4\textwidth}
		Руководитель \\
		\@supervisorTitle

		\vspace{10mm}

		\hrule
		\vspace{3mm}

		\@supervisorName
	\end{minipage}

	\vfill
	\vfill
	\vfill

	Пермь, \@year{} год

	\newpage
}

\chapter**{Аннотация}

\@abstract

\chapter**{Оглавление}

\@starttoc{toc}

\newpage

}
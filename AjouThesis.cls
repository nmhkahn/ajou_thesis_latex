\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{AjouThesis}
\LoadClass[11pt,onecolumn,oneside]{report}

%% 편집용지 설정 (4x6 배판 - 190x260 mm2)
\usepackage[inner=20mm, outer=20mm, top=25mm, bottom=25mm,
            paperwidth=190mm, paperheight=260mm]{geometry}
            
%% 들여쓰기
\usepackage{indentfirst}
\setlength\parindent{0em}

%% Figure와 Caption사이 거리 조정
\setlength{\abovecaptionskip}{10pt} % 캡션 위 거리
\setlength{\belowcaptionskip}{0pt}  % 캡션 아래 거리

%% bibliography
\usepackage[square,numbers]{natbib}
\bibliographystyle{ieeetr}

%% Part, Chapter title size 조정
\usepackage{titlesec}
\titleformat{\part}[display]
    {\centering\normalfont\huge\bfseries}
    {\centering\partname~\thepart}{15pt}{\huge\setstretch{1.0}}
    
\titleformat{\chapter}[display]
    {\normalfont\huge\bfseries}
    {\chaptertitlename~\thechapter}{15pt}{\huge\setstretch{1.0}}

%% 추가 패키지 설정
\RequirePackage{ifthen}
\RequirePackage{hyperref}
\RequirePackage[strict]{changepage}
\RequirePackage{graphicx}
\RequirePackage[dvipsnames]{xcolor}
\RequirePackage[toc,page]{appendix}
\RequirePackage{amsmath,amssymb,subfigure,textcomp,bm}
\RequirePackage{multirow,makecell,float}
\RequirePackage{xcolor}
\RequirePackage{footnote}
\RequirePackage{caption,setspace}
\RequirePackage{arydshln}

%% Table of contents, List of figures, List of tables를 Table of Contents에 추가
\usepackage[subfigure]{tocloft}
\renewcommand{\cftchapleader}{\cftdotfill{\cftdotsep}} % for chapters

%% Caption의 줄간격 설정
\captionsetup[table]{font={stretch=1.1}}
\captionsetup[figure]{font={stretch=1.1}}

% phd or master?
\newif\if@phd

\newcommand{\advisor}[1]
{
    \newcommand{\@advisor}{#1}
}
\@onlypreamble{\advisor}
\newcommand{\department}[1]
{
    \newcommand{\@department}{#1}
}
\@onlypreamble{\department}
\newcommand{\submitDate}[2]
{
    \newcommand{\@submitDate}{#1, #2}
}
\@onlypreamble{\submitDate}
\newcommand{\graduateDate}[2]
{
    \newcommand{\@graduateDate}{#1, #2}
}
\@onlypreamble{\graduateDate}
\newcommand{\degree}[1]
{
    \ifthenelse{\equal{#1}{master}}{\newcommand{\@degreeText}{Master's } \@phdfalse} {}
    \ifthenelse{\equal{#1}{phd}}{\newcommand{\@degreeText}{Doctoral } \@phdtrue} {}
}
\@onlypreamble{\degree}
\newcommand{\committee}[2][1]
{
    \ifthenelse{\equal{#1}{1}}{\newcommand{\@committeeChief} {#2}} {}
    \ifthenelse{\equal{#1}{2}}{\newcommand{\@committeeSecond}{#2}} {}
    \ifthenelse{\equal{#1}{3}}{\newcommand{\@committeeThird} {#2}} {}
    \ifthenelse{\equal{#1}{4}}{\newcommand{\@committeeFourth}{#2}} {}
    \ifthenelse{\equal{#1}{5}}{\newcommand{\@committeeFifth} {#2}} {}
}
\@onlypreamble{\committee}
\newcommand{\ack}[1]
{
    \ifthenelse{\equal{#1}{master}}{\newcommand{\@degreeText}{Master's } \@phdfalse} {}
    \ifthenelse{\equal{#1}{phd}}{\newcommand{\@degreeText}{Doctoral } \@phdtrue} {}
}


\newcounter{dummy}
%% \begin{document}와 함께 실행
\AtBeginDocument
{
    % 앞표지 생성
    \newgeometry{left=40mm, right=30mm, top=30mm, bottom=30mm}
    \makefrontcover
    % 속표지 생성
    \newgeometry{left=40mm, right=30mm, top=40mm, bottom=30mm}
    \maketitle
    % 제출승인서, 심사완료검인 생성
    \newgeometry{left=40mm, right=30mm, top=60mm, bottom=30mm}
    \makeapproval
    % 여백 되돌림
    \restoregeometry
    \refstepcounter{dummy}
    \pagenumbering{roman}
    \setcounter{page}{1}
    \makeacknowledgement
    % 초록 페이지 생성
    \makeabstract
    \makecontents

    \pagenumbering{arabic}
    \setcounter{page}{1}
    \renewcommand{\baselinestretch}{1.8}\selectfont
    \setlength\parindent{5mm}
    \setlength\parskip{0.5em}
}


% \end{document}와 함께 실행
\AtEndDocument
{
    \bibliography{reference.bib}
    \refstepcounter{dummy}
}


%%
%% 앞표지 생성
%%
\newcommand{\makefrontcover}{
    \newpage
    \renewcommand{\baselinestretch}{1.3}
    \thispagestyle{empty}
    \begin{minipage}[t][12mm][t]{112mm}
        \begin{center}
            \fontsize{16pt}{16pt}\selectfont{\@degreeText Thesis in \\ \@department}
        \end{center}
    \end{minipage}\\[30mm]
    \hspace*{-15mm}\begin{minipage}[t][50mm][t]{142mm}
        \begin{center}
            \fontsize{22pt}{22pt}\selectfont{\bf \@title}
        \end{center}
    \end{minipage}\vfill
    \begin{minipage}[b][85mm][b]{112mm}
        \begin{center}
            \fontsize{16pt}{16pt}\selectfont{Graduate School of Ajou University}
            \\[1cm]
            \fontsize{16pt}{16pt}\selectfont{Department of \@department}
            \\[1cm]
            \fontsize{16pt}{16pt}\selectfont{\@author}
        \end{center}
    \end{minipage}
}



%%
%% 속표지 생성
%%
\renewcommand{\maketitle}
{
    \newpage
    \renewcommand{\baselinestretch}{1.3}
    \thispagestyle{empty}
    \hspace*{-15mm}
    \begin{minipage}[t][16pt][t]{142mm}
        \begin{center}
            \fontsize{22pt}{22pt}\selectfont\bf{\@title}
        \end{center}
    \end{minipage}\vfill
    \begin{minipage}[b][110mm][b]{112mm}
        \begin{center}
            \fontsize{16pt}{16pt}\selectfont{\@advisor, Advisor}
            \\[20mm]
            \fontsize{14pt}{14pt}\selectfont{I submit this thesis as the \\ \@degreeText thesis in \@department}
            \\[20mm]
            \fontsize{14pt}{14pt}\selectfont{\@graduateDate}
            \\[20mm]
            \fontsize{16pt}{16pt}\selectfont{Graduate School of Ajou University}
            \\[1cm]
            \fontsize{16pt}{16pt}\selectfont{Department of \@department}
            \\[1cm]
            \fontsize{16pt}{16pt}\selectfont{\@author}
        \end{center}
    \end{minipage}
}


%%
%% 학위논문 심사완료 검인서 생성
%%
\newcommand{\approvalScan}[1]{\newcommand{\@scanFile}{#1}}
\newcommand{\makeapproval}
{
    \@ifundefined{@scanFile}
    {    
        \renewcommand{\baselinestretch}{1.3}
        \thispagestyle{empty}
        \hspace*{-15mm}
        \begin{minipage}[t][16pt][t]{142mm}
        \begin{center}
        \fontsize{14pt}{14pt}\selectfont{The \@degreeText thesis of \@author~in \\ \@department~is hereby approved.}
        \\[30mm]
         
        % add committees
        \fontsize{14pt}{14pt}\selectfont{Thesis Defense}
        \\[5mm]
        \fontsize{14pt}{14pt}\selectfont{Committee Chair\hspace{15mm}\hfill\@committeeChief\hspace{30mm}Seal\hspace{10mm}\hfill}
        \\[5mm]
        \fontsize{14pt}{14pt}\selectfont{\hspace{4em}Member\hspace{15mm}\hfill\@committeeSecond\hspace{30mm}Seal\hspace{10mm}\hfill}
        \\[5mm]
        \fontsize{14pt}{14pt}\selectfont{\hspace{4em}Member\hspace{15mm}\hfill\@committeeThird\hspace{30mm}Seal\hspace{10mm}\hfill}
        \if@phd
            \\[5mm]
            \fontsize{14pt}{14pt}\selectfont{\hspace{4em}Member\hspace{15mm}\hfill\@committeeFourth\hspace{30mm}Seal\hspace{10mm}\hfill}
            \\[5mm]
            \fontsize{14pt}{14pt}\selectfont{\hspace{4em}Member\hspace{15mm}\hfill\@committeeFifth\hspace{30mm}Seal\hspace{10mm}\hfill}
        \fi
        \\[40mm]
        \fontsize{16pt}{16pt}\selectfont{Graduate School of Ajou University}
        \\[10mm]
        \fontsize{16pt}{16pt}\selectfont{\@submitDate}
        \end{center}
        \end{minipage}
    }
    {
        \includepdf{\@scanFile}
    }
}


%%
%% 감사의 글 페이지 생성
%%
\newcommand{\makeacknowledgement}
{
    \newpage
    \begin{center}
        \fontsize{16pt}{16pt}\selectfont{\bf Acknowledgement}
    \end{center}
    \vspace{5mm}

    \setlength\parindent{5mm}
    \renewcommand{\baselinestretch}{1.8}\selectfont
    \fontsize{11pt}{12pt}\selectfont{\indent\input{acknowledgement}}
    \setlength\parindent{0mm}
}


%%
%% 초록 페이지 생성
%%
\newcommand{\makeabstract}
{
    \newpage
    \begin{center}
        \fontsize{16pt}{16pt}\selectfont{\bf Abstract}
    \end{center}

    \setlength\parindent{5mm}
    \renewcommand{\baselinestretch}{1.8}\selectfont
    \fontsize{11pt}{11pt}\selectfont{\indent\input{abstract}}
    \setlength\parindent{0mm}
}



%%
%% 목차 일괄 생성
%%
\newcommand{\makecontents}
{
    \clearpage
    \renewcommand{\baselinestretch}{1.3}\selectfont
    \tableofcontents
    \clearpage
    \listoffigures
    \clearpage
    \listoftables
    \clearpage
}

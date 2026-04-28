%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% thesisbase.cls
%
% (c) Lucerne University of Applied Sciences and Arts
%
% The official LaTeX template class for HSLU theses. It ensures the thesis style
% complies with HSLU requirements for various study programs at HSLU-I.
%
% This class has been created by Ramón Christen at the Lucerne University of Applied Sciences and Arts.
%
% Created for HSLU by Ramón Christen 2025
%
%   (c) Lucerne University of Applied Sciences and Arts
%   v1.0    22-09-2025:     Original version
%   v1.1    29-09-2025:     Extended with WIPRO option
%   v1.2    10-10-2025:     Minor corrections for WIPRO
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Identification
%%%%%%%%%%%%%%%%
\NeedsTeXFormat{LaTeX2e}

% name and release date
\ProvidesClass{thesisbase}[2025/06/01 Generic Thesis Base Class]



% PDF/A Document compliance
%%%%%%%%%%%%%%%%%%
\pdfcatalog{
  /StructTreeRoot <<                                     % Define the structure tree root for document tagging
    /Type /StructTreeRoot                                % Specify that this is a structure tree root
    /K []                                                % Placeholder for structure elements (empty for now)
  >>                            
  /MarkInfo << /Marked true >>                           % Ensure the document is marked as tagged for accessibility
}


% Declare options
%%%%%%%%%%%%%%%%%%
% template conditions set with options
\newif\ifnoip                                           % intellectual property section included
\newif\ifacceptsheet                                    % accept sheet included
\newif\ifcedu                                           % continuous education (CAS, SAS)
\newif\ifgroupwork                                      % extends declaration for two students
\newif\ifnograd                                         % no graduation (e.g. WIPRO)
\newif\ifshortpresdec                                   % short presentation declaration (after report type on title page)

% options treatment
\DeclareOption{bachelor}{}
\DeclareOption{master}{}
\DeclareOption{cas}{%
    \cedutrue
    \DeclareOption{noip}{\noiptrue}
}
\DeclareOption{sas}{
    \cedutrue
    \shortpresdectrue
    \DeclareOption{noip}{\noiptrue}
}
\DeclareOption{wipro}{
    \nogradtrue
    \shortpresdectrue
}
\DeclareOption{groupwork}{
    \groupworktrue
}
\DeclareOption{acceptancesheet}{\acceptsheettrue}

% pass additional options to parent class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}

\ProcessOptions\relax


% Class and package load
%%%%%%%%%%%%%%%%
\LoadClass[12pt, a4paper, oneside]{book}                 % document style definition

\RequirePackage{babel}
\RequirePackage{graphics}
\RequirePackage{rotating}
\RequirePackage{epstopdf}
\RequirePackage[export]{adjustbox}
\RequirePackage[utf8]{inputenc}
\RequirePackage{thesisterms}                             % apply thesis terms

\RequirePackage{enumitem,amssymb}
\newlist{todolist}{itemize}{2}
\setlist[todolist]{label=$\square$}

\RequirePackage{fancyhdr}


% commands
%%%%%%%%%%%%%%%%
% general commands
\newcommand*{\fullstop}[1]{#1.}

% Optional metadata for simpledeclaration layout
\newcommand*{\registrationnumber}[1]{\def\reg@num{#1}}
\def\reg@num{}
\newcommand*{\declarationsigneddate}[1]{\def\decl@signeddate{#1}}
\def\decl@signeddate{\defensedatevar}

% Header / footer metadata (set in thesis.tex)
% \projectshortname{...}: short label shown in the header (left)
% \footerauthortag{...}:  fallback for footer left when \registrationnumber is empty
\newcommand*{\projectshortname}[1]{\def\proj@short{#1}}
\def\proj@short{}
\newcommand*{\footerauthortag}[1]{\def\footer@tag{#1}}
\def\footer@tag{}
\newcommand*{\thesis@footerleft}{%
    \ifx\reg@num\@empty\footer@tag\else\reg@num\fi
}

% Package Body
%%%%%%%%%%%%%%%%
% set up the page dimensions. This assumes a4 paper.
% vertical (\headheight raised to 14.5pt to fit fancyhdr running header text)
\voffset -15mm
\topmargin 0mm
\setlength{\headheight}{14.5pt}
\headsep 12.5mm
\textheight 235mm

% horizontal: 1 in left and right margins (symmetric)
\setlength{\hoffset}{0pt}
\setlength{\oddsidemargin}{0pt}
\setlength{\evensidemargin}{0pt}
\setlength{\textwidth}{\dimexpr\paperwidth-2in\relax}

\reversemarginpar

% Header / footer layout (guidelines: short project name (L), chapter title (R);
% registration / ID (footer L), page number (footer C); no rules)
\renewcommand{\chaptermark}[1]{\markboth{#1}{}}
\fancyhf{}
\fancyhead[L]{\proj@short}
\fancyhead[R]{\leftmark}
\fancyfoot[L]{\footnotesize\thesis@footerleft}
\fancyfoot[C]{\thepage}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}

% Mirror fancy on chapter opening pages (book sets \thispagestyle{plain} there)
\fancypagestyle{plain}{%
    \fancyhf{}%
    \fancyhead[L]{\proj@short}%
    \fancyhead[R]{\leftmark}%
    \fancyfoot[L]{\footnotesize\thesis@footerleft}%
    \fancyfoot[C]{\thepage}%
    \renewcommand{\headrulewidth}{0pt}%
    \renewcommand{\footrulewidth}{0pt}%
}

\DeclareFontFamily{\encodingdefault}{\ttdefault}{\hyphenchar\font=`\-} % Allow hyphen in texttt

% Create abstract environment
\newlength\tindent
\newenvironment{abstractstyle}[1]{%
    \cleardoublepage
    \markboth{#1}{}%
    \setlength{\tindent}{\parindent}%
    \setlength{\parindent}{0pt}%
    \noindent{\LARGE\textbf{#1}}\par
    \vspace{1cm}%
    }{%
    \vspace{1cm}%
    \setlength{\parindent}{\tindent}%
}

% title page
\renewcommand*{\maketitle}{%
    \begin{titlepage}%
        % grant extra vertical room so the title block does not overflow
        % the standard \textheight and obscure the bottom border
        \enlargethispage*{40mm}%


        % decorative page border (top edge follows the text shift)
        % \begin{tikzpicture}[remember picture,overlay]
        %     \draw[line width=0.5pt]
        %         ([shift={(15mm,-2mm)}]current page.north west)
        %         rectangle
        %         ([shift={(-15mm,15mm)}]current page.south east);
        % \end{tikzpicture}%

        \begin{center}%
            % title page top margin (cancels class-wide offsets, then trims further)
            \vspace*{\dimexpr -\voffset-\topmargin-\headheight-\headsep-10mm\relax}%

            {\large \depname \par}
            \vskip 5mm
            {\normalsize In Collaboration with \par}
            \vskip 5mm
            {\large \textbf{\uniname, \unicountry} \par}

            \vskip 12mm
            \includegraphics[width=0.38\textwidth]{\logo}

            \vskip 16mm
            \begin{minipage}{0.88\textwidth}
                \centering
                \large\bfseries \@title
            \end{minipage}\par

            \vskip 22mm
            {\normalsize A dissertation by \par}
            \vskip 4mm
            {\large \textbf{\@author \ifgroupwork{} and \secauthor\fi} \par}
            \vskip 2mm
            {\small \reg@num \par}

            \vskip 18mm
            {\normalsize Supervised by \par}
            \vskip 4mm
            {\large \textbf{\supervisorvar} \par}
            \vskip 4mm

            \vfill

            \begin{minipage}{0.88\textwidth}
                \centering
                \normalsize \fullstop{\ifshortpresdec\presentedto\else\presentedtoacgrade\fi}
            \end{minipage}\par
            \vskip 6mm
            {\normalsize \textbf{\@date} \par}

            % leave clear space above the bottom border so it stays visible
            \vspace*{20mm}
        \end{center}
    \end{titlepage}%
    
    % set roman page numbering for preamble
    \pagenumbering{gobble}

    % page: acceptance sheet (kept blank: no fancy header/footer)
    \ifacceptsheet
        \thispagestyle{empty}
        \noindent \accept@txt
        \jurymembers
    
    
        \noindent \defencelocation, \defensedatevar
        
        \begin{table}[b]
            \centering
            \begin{tabular}{p{.5\textwidth} p{.5\textwidth}}
                 \textbf{\supervis}\newline \sign@supervisor{} & \textbf{\deanoffaculty}\newline \sign@facdean{} \\ & \\ & \\ & \\ & \\ & \\ & \\ & \\ & 
            \end{tabular}
        \end{table}
    \fi

    \frontmatter
    \clearpage

    \setcounter{footnote}{0}%
}

% Declaration and acknowledgments are printed after the abstract in the main
% document (see thesis.tex) so front matter follows the required order.

\newcommand*{\thesisprintdeclaration}{%
    \cleardoublepage
    \markboth{\cons@hmain}{}%
    \setlength{\tindent}{\parindent}%
    \setlength{\parindent}{0pt}%
    \noindent{\LARGE\textbf{\cons@hmain}}\par
    \vspace{1cm}%
    \noindent\cons@self\par
    \vspace{8mm}%
    \noindent\textbf{\cons@studentnamelbl}\space--\space\@author\par
    \vspace{2.5mm}%
    \ifgroupwork
        \noindent\textbf{\cons@studentnamelbl}\space--\space\secauthor\par
        \vspace{2.5mm}%
    \fi
    \noindent\textbf{\cons@regnolbl}\space--\space\reg@num\par
    \vspace{24mm}%
    \noindent
    \begin{minipage}[t]{0.52\textwidth}%
        \raggedright
        \textbf{\cons@signcaption}\space\hrulefill
    \end{minipage}%
    \hfill
    \begin{minipage}[t]{0.42\textwidth}%
        \raggedleft
        \textbf{\cons@datecaption}\space\decl@signeddate
    \end{minipage}\par
    \vspace{1cm}%
    \setlength{\parindent}{\tindent}%
}

\newcommand*{\thesisprintacknowledgments}{%
    \begin{abstractstyle}{\cons@thanks}
        \acknowledgments

        \vskip 3.5mm
        \raggedleft

        \raggedright
        \vfill
    \end{abstractstyle}%
}

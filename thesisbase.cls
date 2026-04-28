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


% commands
%%%%%%%%%%%%%%%%
% general commands
\newcommand*{\fullstop}[1]{#1.}

% Optional metadata for simpledeclaration layout
\newcommand*{\registrationnumber}[1]{\def\reg@num{#1}}
\def\reg@num{}
\newcommand*{\declarationsigneddate}[1]{\def\decl@signeddate{#1}}
\def\decl@signeddate{\defensedatevar}

% Package Body
%%%%%%%%%%%%%%%%
% set up the page dimensions. This assumes a4 paper.
% vertical
\voffset -15mm
\topmargin 0mm
\headheight 5mm
\headsep 12.5mm
\textheight 235mm

% horizontal
\oddsidemargin 10mm
\evensidemargin 0mm
\textwidth 147mm

\reversemarginpar

\DeclareFontFamily{\encodingdefault}{\ttdefault}{\hyphenchar\font=`\-} % Allow hyphen in texttt

% Create abstract environment
\newlength\tindent
\newenvironment{abstractstyle}[1]{%
    \cleardoublepage
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
        \begin{center}%
            \begin{figure}
                \centering
                    \includegraphics[height=.07\textwidth,valign=t]{\logo}
                \hfill
                \vspace{20mm}
            \end{figure}
            
            {\large \depname \par \uniname{} (\unicountry)}
            
            \vskip 20mm%
            {\LARGE \textsc \@title \\ \subtit \vskip \baselineskip \par}%
        
            \vskip 20mm
            {\LARGE \textsc \thesistypetxt \par}
            \vskip 3mm
            {\small \fullstop{\ifshortpresdec\presentedto\else\presentedtoacgrade\fi}}
        
            \vskip 20mm
            {\by \par}
            \vskip 5mm
            {\LARGE \textbf{\@author \ifgroupwork~and \secauthor\fi} \par}%
            \vskip 5mm
            {\from \par}
            \vskip 5mm
            {\LARGE \orig}
        	
            \vfill%
            
            % {\textsc Thesis No.: \thesisnum
            % \par Uniprint
            % \par \@date}
            
        \end{center}
    \end{titlepage}%
    
    % set roman page numbering for preamble
    \pagenumbering{gobble}

    % page: acceptance sheet
    \ifacceptsheet
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

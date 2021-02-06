\version "2.20.0"

\include "articulate.ly"

\header {
  pdftitle = "リンダ リンダ"
  title = \markup {
    \override #'(font-name . "IPAexGothic")
    \fromproperty #'header:pdftitle
  }
  author = "THE BLUE HEARTS"
  pdfcomposer = "甲本ヒロト"
  pdfpoet = \markup \fromproperty #'header:pdfcomposer
  composer = \markup {
    \override #'(font-name . "IPAexGothic")
    \concat { "作曲・作詞　" \fromproperty #'header:pdfcomposer }
  }
  subject = \markup \concat {
    "Bass partition for “"
    \fromproperty #'header:title
    "” by "
    \fromproperty #'header:pdfcomposer
    "."
  }
  keywords = #(string-join '(
    "music"
    "partition"
    "bass"
  ) ", ")
  tagline = ##f
}

\paper {
  indent = 0\mm
  markup-system-spacing.padding = 3
  system-system-spacing.padding = 3
  #(define fonts
    (set-global-fonts
     #:music "gonville"
     #:brace "gonville"
   ))
}

section = #(define-music-function (text) (string?) #{
  \once \override Score.RehearsalMark.self-alignment-X = #LEFT
  \once \override Score.RehearsalMark.padding = #2
  \mark \markup \override #'(thickness . 2) \rounded-box \bold #text
#})

gl = \glissando

% From https://lilypond.1069038.n5.nabble.com/Hammer-on-and-pull-off-td208307.html
after =
#(define-music-function (t e m) (ly:duration? ly:music? ly:music?)
   #{
     \context Bottom <<
       #m
       { \skip $t <> -\tweak extra-spacing-width #empty-interval $e }
     >>
   #})

hammer = \markup{ \sans "H" }

sectionB = \repeat unfold 2 {
  d4\3 d8\3 \repeat unfold 5 d\3 |
  d\3 d\3 c\3 c\3 b\3 b\3 a\3 a\3 |
  g4 g8 \repeat unfold 5 g |
  a4\4 a8\4 \repeat unfold 5 a\4 |
}

sectionCOne = {
  d4\3 d8\3 \repeat unfold 5 d\3 |
  fis,4 fis8 \repeat unfold 5 fis |
  b4 b8 \repeat unfold 5 b |
  bis4 bis8 \repeat unfold 5 bis |
}

sectionC = {
  \sectionCOne
  \break
  \repeat percent 2 {
    g4 g8 \repeat unfold 5 g |
  }
  a4\4 a8\4 \repeat unfold 5 a\4 |
  a\4 a\4 b b c c cis cis |
  \break
  \sectionCOne
  g4 g8 \repeat unfold 5 g |
  a4\4 a8\4 \repeat unfold 5 a\4 |
  d4\3 d8\3 \repeat unfold 5 d\3 |
}

sectionCEnd = {
  d\3 \repeat unfold 7 a\4 |
}

sectionD = {
  d4\3 d8\3 \repeat unfold 5 d\3 |
  d\3 d\3 c c b b a a |
  g4 g8 \repeat unfold 5 g |
  a4\4 a8\4 \repeat unfold 5 a\4 |
}

sectionE = {
  d4\3 d8\3 \repeat unfold 5 d\3 |
  b4 b8 \repeat unfold 5 b |
  g4 g8 \repeat unfold 5 g |
  a4\4 a8\4 \repeat unfold 5 a\4 |
}

sectionFOne = {
  d4\3 d8\3 \repeat unfold 5 d\3 |
  \after 16 ^\hammer cis\3( d\3) \repeat unfold 6 d\3 |
}

sectionF = {
  \sectionFOne
  \repeat percent 2 {
    b4 b8 \repeat unfold 5 b |
  }
  \break
  \sectionFOne
  g, g b b g g b b |
  a4\4 cis\3 e\3 cis\3 |
  \break
  \sectionFOne
  \repeat percent 2 {
    b4 b8 \repeat unfold 5 b |
  }
  \break
  g4 g8 \repeat unfold 5 g |
  a4\4 a8\4 \repeat unfold 5 a\4 |
  g4 fis e d'\3 |
  \repeat unfold 8 d8\3 |
}

codaOne = {
  a4\4 a8\4 \repeat unfold 5 a\4 |
}

codaTwo = {
  d4\3 d8\3 d\3 \after 16 ^\hammer cis\3( d\3) d\3 d\3 |
  r d\3 r \repeat unfold 5 d\3 |
}

sectionG = {
  \sectionFOne
  g,4 g8 \repeat unfold 5 g |
  a4\4 a8\4 \repeat unfold 5 a\4 |
}

sectionI = {
  d4\3 d8\3 \repeat unfold 5 d\3 |
  bis4 bis8 \repeat unfold 5 bis |
  g g b b g g b b |
  a4\4 cis\3 e\3 cis\3 |
  d1\3 \glissando |
  d'\3~ |
  d2*1/2\3 \glissando
  \single \hideNotes
  d,2*1/2
  r2 |
  d4\3 r r2 |
}

song = \relative c, {
  \numericTimeSignature

  % Intro 1
  \tempo 4 = 63
  \tag #'(score video) \compressMMRests R1*9 |

  \tempo 4 = 192
  \section "B"
  \sectionB
  \break

  \section "C"
  \sectionC
  \sectionCEnd
  \break

  \section "D"
  \repeat volta 2 \sectionD
  \break

  \section "E"
  \repeat volta 2 \sectionE
  \break

  \section "F"
  \sectionF
  \break

  \section "D (Repeat)"
  \sectionD
  d4\3 d8\3 \repeat unfold 5 d\3 |
  d\3 d\3 c c b b a a |
  g4 g8 \repeat unfold 5 g |
  \codaOne
  \break
  \section "C (Repeat)"
  \sectionC
  \codaTwo
  \break
  \section "C (Repeat 2)"
  \sectionC
  \sectionCEnd
  \sectionD
  d4\3 d8\3 \repeat unfold 5 d\3 |
  d\3 d\3 c c b b a a |
  g4 g8 \repeat unfold 5 g |
  \codaOne
  \break

  \section "G"
  \repeat unfold 2 \sectionG
  \break

  \section "H"
  \repeat unfold 3 \sectionG
  \break

  \section "I"
  \sectionI
  \bar "|."
}

staff = \new Staff \with {
  midiInstrument = #"electric bass (pick)"
  \omit StringNumber
  % Don't show markup in this staff
  \omit TextScript
} {
  \clef "bass_8"
  \key d \major
  \time 4/4
  \song
}
staves = \new StaffGroup <<
  \staff
  \new TabStaff \with {
    stringTunings = #bass-tuning
    % To display the hammer-on and pull-of markup
    \revert TextScript.stencil
    \override TextScript.font-size = #-3
    \slurUp
  } {
    \clef moderntab
    \song
  }
>>

\score {
  \keepWithTag #'score \staves
}

\score {
  \unfoldRepeats \articulate \keepWithTag #'midi \staff
  \midi {}
}

\version "2.20.0"

\include "the-blue-hearts-linda-linda-bass.ily"

\score {
  \keepWithTag #'score \staves
}

\score {
  \unfoldRepeats \articulate \keepWithTag #'midi \staff
  \midi {}
}

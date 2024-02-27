.SH 1
Name: anagram
.pdfhref O 1 "Name: anagram"
.pdfhref M "name-anagram"
.LP
anagram - A program that generates a full list of anagrams in a chosen
(combination of) language(s).
Three versions are available: - anagram - Bash version with awk (with
`quasi-2D'-arrays) - anagram.sh - Bash version with awk (with real
2D-arrays) - anagram.py - Python3 version, derived from anagrams.sh
.SH 1
Description:
.pdfhref O 1 "Description:"
.pdfhref M "description"
.LP
anagram is a script that generates a full list of anagrams in the chosen
language(s) present on the system.
In case a (combination of) word(s) - whether or not existing(!) - is
given as argument(s), it only generates the anagrams that fit the
(combination of) word(s).
.PP
Additionally, filters can be set for: - anagram-length - minimal and/or
maximal number of anagrams per solution - characters to be all included
and/or excluded
.PP
Besides any single language, any \f[I]combination\f[R] of languages can
be set as well.
.PP
The results are sent to standard output and can be piped to e.g.\ `less'
or other utilities and applications.
.PP
Perequisite is presence on the system of a word list in flat text format
of at least one language.
In its present form, the program code references following language word
lists:
.IP
.nf
\f[C]
/usr/share/dict/dutch
/usr/share/dict/american-english
/usr/share/dict/british-english
/usr/share/hunspell/de_DE_frami.dic
/usr/share/dict/french
/usr/share/dict/spanish
/usr/share/dict/italian
\f[]
.fi
.LP
If no language option is given, Dutch is the default language.
.PP
If wished and as per system configuration, above paths and langauge
default may be changed or removed and references to other word lists may
be added, by modifying the program code accordingly.
.SH 1
How to use anagram
.pdfhref O 1 "How to use anagram"
.pdfhref M "how-to-use-anagram"
.LP
All three program versions have the same functionality and options.
The speed of the Python version can be further enhanced by using pypy3.
.SH 2
Usage (for example for the Python3 version):
.pdfhref O 2 "Usage (for example for the Python3 version):"
.pdfhref M "usage-for-example-for-the-python3-version"
.IP
.nf
\f[C]
anagram.py [-abcdfghislmMIx] [WORD(1) [ ... WORD(n)]]
\f[]
.fi
.SH 2
Options:
.pdfhref O 2 "Options:"
.pdfhref M "options"
.IP
.nf
\f[C]
-a          American-English
-b          British-English
-d          Dutch
-f          French
-g          German
-h          Help (this output)
-i          Italian
-s          Spanish
-c          All languages combined
-l LENGTH   Print solutions with word LENGTH only
-m QTY      Print solutions with at least QTY anagrams
-M QTY      Print solutions with at most  QTY anagrams
-I CHARS    Include words with all of these CHARS
-x CHARS    Exclude words with any of these CHARS
\f[]
.fi
.LP
All options can be combined.
If no language option is given, Dutch is the default language.
.PP
The [WORD] arguments are optional, and make the program filter the
output to only the given (combination of) word(s) and its anagram(s) if
present.
.PP
For example, the command:
.IP
.nf
\f[C]
./anagram.py -abdfgs emirates
\f[]
.fi
.LP
gives following results:
.IP
.nf
\f[C]
émerisât            emirate\[aq]s           emirates            estimera            étirâmes            itérâmes            materies            matières            Reitsema            sèmerait            steamier 
\f[]
.fi
.SH 1
Author:
.pdfhref O 1 "Author:"
.pdfhref M "author"
.LP
Written by Rob Toscani (rob_toscani\[at]yahoo.com).

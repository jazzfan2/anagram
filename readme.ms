.SH 1
Name: anagram.sh
.pdfhref O 1 "Name: anagram.sh"
.pdfhref M "name-anagram.sh"
.LP
anagram.sh - A program that generates a full list of anagrams in a
chosen (combination of) language(s).
.SH 1
Description:
.pdfhref O 1 "Description:"
.pdfhref M "description"
.LP
anagram.sh is a shell script based on awk, that generates a full list of
anagrams in the chosen language(s) present on the system, or if a word
is given as an argument, only that word and its anagrams.
Additionally, filters can be set for word-length and for minimal and/or
maximal number of anagrams per solution.
Apart from setting one preferred language, anagram.sh also allows any
\f[I]combination\f[R] of languages to be set.
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
If no option is given, Dutch is the default language.
.PP
If wished and as per system configuration, above paths and langauge
default may be changed or removed and references to other word lists may
be added, by modifying the program code accordingly.
.SH 1
How to use anagram.sh
.pdfhref O 1 "How to use anagram.sh"
.pdfhref M "how-to-use-anagram.sh"
.SH 2
Usage:
.pdfhref O 2 "Usage:"
.pdfhref M "usage"
.IP
.nf
\f[C]
anagram.sh [-abcdfghilmMs] [WORD]
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
\f[]
.fi
.LP
All options can be combined.
If no language option is given, Dutch is the default language.
.PP
The [WORD] argument is optional, and makes anagram.sh filter the output
to only the given word and its anagram(s) if present.
.PP
For example, the command:
.IP
.nf
\f[C]
./anagram.sh -abdfgs emirates
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

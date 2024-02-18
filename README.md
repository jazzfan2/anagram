# Name: anagram.sh
anagram.sh - A program that generates a full list of anagrams in a chosen (combination of) language(s).

# Description:
anagram.sh is a shell script based on awk, that generates a full list of anagrams in the chosen language(s) present on the system, or if a word is given as an argument, only that word and its anagrams.
Additionally, a chosen minimal, maximal and/or exact number of anagrams per solution can be set.
Apart from setting one preferred language, anagram.sh also allows any *combination* of languages to be set.
The results are sent to standard output and can be piped to e.g. 'less' or other utilities and applications.

Perequisite is presence on the system of a word list in flat text format of at least one language.
In its present form, the program code references following language word lists: 

	/usr/share/dict/dutch
	/usr/share/dict/american-english
	/usr/share/dict/british-english
	/usr/share/hunspell/de_DE_frami.dic
	/usr/share/dict/french
	/usr/share/dict/spanish
	/usr/share/dict/italian

If no option is given, Dutch is the default language.

If wished and as per system configuration, above paths and langauge default may be changed or removed and references to other word lists may be added, by modifying the program code accordingly.

# How to use anagram.sh
## Usage:

	anagram.sh [-abcdfghimMs] [WORD]

## Options:
	-a      American-English
	-b      British-English
	-d      Dutch
	-f      French
	-g      German
	-h      Help (this output)
	-i      Italian
	-s      Spanish
	-c      All languages combined
	-m QTY  Print solutions with at least QTY anagrams
	-M QTY  Print solutions with at most  QTY anagrams

All options can be combined. If no language option is given, Dutch is the default language.

The [WORD] argument is optional, and makes anagram.sh filter the output to only the given word and its anagram(s) if present.

For example, the command:

	./anagram.sh -banfsd emirates

gives following results:

	émerisât            emirate's           emirates            estimera            étirâmes            itérâmes            materies            matières            Reitsema            sèmerait            steamier 

# Author:
Written by Rob Toscani (rob_toscani@yahoo.com).

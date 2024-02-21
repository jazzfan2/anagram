# Name: anagram.sh
anagram.sh - A program that generates a full list of anagrams in a chosen (combination of) language(s).

# Description:
anagram.sh is a shell script based on awk, that generates a full list of anagrams in the chosen language(s) present on the system.
In case a (combination of) word(s) is given as argument(s), it just generates the anagrams that fit this particular word(-combination).

Additionally, filters can be set for:
- word-length
- minimal and/or maximal number of anagrams per solution
- characters to be all included and/or excluded

Besides any single language, any *combination* of languages can be set as well.

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

If no language option is given, Dutch is the default language.

If wished and as per system configuration, above paths and langauge default may be changed or removed and references to other word lists may be added, by modifying the program code accordingly.

# How to use anagram.sh
## Usage:

	anagram.sh [-abcdfghislmMIx] [WORD(1), ... , WORD(n)]

## Options:
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

All options can be combined. If no language option is given, Dutch is the default language.

The [WORD] argument is optional, and makes anagram.sh filter the output to only the given word and its anagram(s) if present.

For example, the command:

	./anagram.sh -abdfgs emirates

gives following results:

	émerisât            emirate's           emirates            estimera            étirâmes            itérâmes            materies            matières            Reitsema            sèmerait            steamier 

# Author:
Written by Rob Toscani (rob_toscani@yahoo.com).

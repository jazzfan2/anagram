#!/usr/bin/env python3
# Name  : anagram.py
# Author: R.J.Toscani
# Date  : 24-02-2024
# Description: Python3 script that generates a full list of anagrams in the 
# chosen languages present on the system.
# In case a (combination of) word(s) - whether or not existing(!) - is given as 
# argument(s), it only generates the anagrams that fit the (combination of) word(s). 
# Additionally, filters can be set for:
# - anagram-length
# - minimal and/or maximal number of anagrams per solution
# - characters to be all included and/or excluded
# Besides any single language, any *combination* of languages can be set as well.
# Output can be piped to e.g. 'less' or other utilities and applications.
#
# Examples:
#
#   anagram.py -abdgsi | sed -r 's/ {2,}/\t/g' | grep -E "[^\t]\t+[^\t]" | allign_tsv.sh -
#   anagram.py -abdgsi | sed -r 's/ {2,}/\t/g' | grep -E "[^\t]\t+[^\t]" | text2troff - | trofms
#   anagram.py -abdgsi | sed 's/ *$//g' | sed -r 's/ {2,}/\t/g' | grep -E "[\t].+[\t]" | text2troff -s - | trofms
#
# Perequisite is presence on the system of a word list in flat text format of at least
# one language.
#
# Python3 version of anagram.sh
# Use pypy3 for enhanced speed.
#
######################################################################################
#
# Copyright (C) 2024 Rob Toscani <rob_toscani@yahoo.com>
#
# anagram.py is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# anagram.py is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
######################################################################################
#
import getopt
import sys
import re
import os

def concatenate(languagefile, language):
    """Concatenate language files into one common dictionarylist:"""
    if language == "g":  # German language list isn't UTF-8 encoded and contains superfluous text 
        with open(languagefile,'r', encoding='ISO-8859-1') as language:
             wordlist = language.readlines()
        wordlist = [ slashtag.sub('', line) for line in wordlist if line[0] != "#" ]
        dictionarylist.append(wordlist)
    else:
        with open(languagefile,'r') as language:
            dictionarylist.append(language.readlines())

def normalize(string):
    """ By means of regular expressions, normalize all characters to lower case,
        remove accent marks and other non-alphanumeric characters,
        and convert string to a unique sorted character signature:"""
    signature = a_acc.sub('a', \
                e_acc.sub('e', \
                i_acc.sub('i', \
                o_acc.sub('o', \
                u_acc.sub('u', \
                n_til.sub('n', \
                c_ced.sub('c', \
                intpun.sub('', string))))))))
    signature = ''.join(sorted(signature.lower()))
    return signature                    # Unique sorted character combination


def incl(string, incl_chars):
    for char in incl_chars:
        if not char in string:
            return False
    return True

def excl(string, excl_chars):
    for char in excl_chars:
        if char in string:
            return False
    return True


os.system('clear')

dictionary_nl = "/usr/share/dict/dutch"
dictionary_am = "/usr/share/dict/american-english"
dictionary_br = "/usr/share/dict/british-english"
dictionary_de = "/usr/share/hunspell/de_DE_frami.dic"
dictionary_fr = "/usr/share/dict/french"
dictionary_sp = "/usr/share/dict/spanish"
dictionary_it = "/usr/share/dict/italian"

# Text printed if -h option (help) or a non-existing option has been given:
usage = """
Usage:
anagrams.sh [-abcdfghislmMIx] [WORD(1) [ ... WORD(n)]]\n
\t-a	American-English
\t-b	British-English
\t-d	Dutch
\t-f	French
\t-g	German
\t-h	Help (this output)
\t-i	Italian
\t-s	Spanish
\t-c	All languages combined
\t-l LENGTH
\t	Print solutions with word LENGTH only
\t-m QTY
\t	Print solutions with at least QTY anagrams
\t-M QTY
\t	Print solutions with at most QTY anagrams
\t-I CHARS
\t	Include words with all of these CHARS
\t-x CHARS
\t	Exclude words with any of these CHARS 
"""

dictionarylist = []
word_args = ""
qty_min = 2        # Anagram means at least two matching words, so this is the default
qty_max = 100
filterlength = 0
incl_chars = ""    # Default: dot means include all characters
excl_chars = "_"   # Default: underscore does not appear so can always be excluded

"""Regular expressions:"""
intpun = re.compile('[\'\" .&-]')
a_acc = re.compile('[áàäâåÁÀÄÂ]')
e_acc = re.compile('[éèëêÉÈËÊ]')
i_acc = re.compile('[ïíìÏÍÌ]')
o_acc = re.compile('[óòöôøÓÒÖÔ]')
u_acc = re.compile('[úùüÚÙÜ]')
n_til = re.compile('[ñÑ]')
c_ced = re.compile('[çÇ]')
slashtag = re.compile('\/[^/]*')

'""Select option(s):""'
try:
    options, non_option_args = getopt.getopt(sys.argv[1:], 'abcdfghisl:m:M:I:x:')
except:
    print(usage)
    sys.exit()

for opt, arg in options:
    if opt in ('-h'):
        print(usage)
        sys.exit()
    elif opt in ('-a'):
        concatenate(dictionary_am, "a")
    elif opt in ('-b'):
        concatenate(dictionary_br, "b")
    elif opt in ('-d'):
        concatenate(dictionary_nl, "d")
    elif opt in ('-f'):
        concatenate(dictionary_fr, "f")
    elif opt in ('-g'):
        concatenate(dictionary_de, "g")
    elif opt in ('-i'):
        concatenate(dictionary_it, "i")
    elif opt in ('-s'):
        concatenate(dictionary_sp, "s")
    elif opt in ('-c'):
        concatenate(dictionary_am, "a")
        concatenate(dictionary_br, "b")
        concatenate(dictionary_nl, "d")
        concatenate(dictionary_fr, "f")
        concatenate(dictionary_de, "g")
        concatenate(dictionary_it, "i")
        concatenate(dictionary_sp, "s")
    elif opt in ('-l'):
        filterlength = int(arg)
    elif opt in ('-m'):
        qty_min = int(arg)
    elif opt in ('-M'):
        qty_max = int(arg)
    elif opt in ('-I'):
        incl_chars = arg
    elif opt in ('-x'):
        excl_chars = arg

for argument in non_option_args:         # Word(s) argument(s)
    word_args = word_args + argument     # (space not needed)

if len(word_args) != 0 and qty_min == 2:
    qty_min = 1                          # If just 1 anagram matches *non-existent* word(s) 

print("One moment, the output is being prepared ...")

if len(dictionarylist) == 0:
    concatenate(dictionary_nl)
 
word_args = normalize(word_args)         # Get signature of (optional) word(s) argument(s)

dictionarylist = sorted(set([word.replace("\n","") for language in dictionarylist for word in language]))

anagrams = {}
for word in dictionarylist:
    signature = normalize(word)          # Get signature of present dictionary word
    if signature in anagrams:
        anagrams[signature].append(word) # Store all words with this signature into common list
    else:
        anagrams[signature] = [word]

for signature in anagrams:
    if (len(word_args) == 0 or signature == word_args) and \
        len(anagrams[signature]) >= qty_min and len(anagrams[signature]) <= qty_max and \
       (filterlength == 0 or filterlength == len(signature)) and \
        incl(signature, incl_chars) and excl(signature, excl_chars):
          for i in range(len(anagrams[signature])):
              if len(signature) < 18:
                  print("%-20s" % anagrams[signature][i], end='')
              else:
                  print("%-40s" % anagrams[signature][i], end='')
          print() 

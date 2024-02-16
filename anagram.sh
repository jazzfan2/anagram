#!/bin/bash
# Name       : anagram.sh
# Author     : Rob Toscani
# Date       : 26-09-2023
# Description: Shell script based on awk, generating a full list of anagrams in the 
# chosen languages present on the system.
# If a word argument is given, the output is filtered to only that word and its 
# anagram(s) if present.
# anagram.sh allows language setting, including any *combination* of languages.
# Output can be piped to e.g. 'less' or other utilities and applications.
#
# Examples:
#
#   anagram.sh -abdnsi | sed -r 's/ {2,}/\t/g' | grep -E "[^\t]\t+[^\t]" | allign_tsv.sh -
#   anagram.sh -abdnsi | sed -r 's/ {2,}/\t/g' | grep -E "[^\t]\t+[^\t]" | text2troff - | trofms
#   anagram.sh -abdnsi | sed 's/ *$//g' | sed -r 's/ {2,}/\t/g' | grep -E "[\t].+[\t]" | text2troff -s - | trofms
#
# Perequisite is presence on the system of a words list in flat text format of at least
# one language.
#
######################################################################################
#
# Copyright (C) 2024 Rob Toscani <rob_toscani@yahoo.com>
#
# anagram.sh is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# anagram.sh is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
######################################################################################
#
set -o noclobber    # Prevent files to be accidentally overwritten by standard output redirection


if [[ -d /tmp/ramdisk/ ]]; then                          # tmpfs
    tmpfiledir="/tmp/ramdisk"
elif [[ -d /dev/shm/ ]]; then
    tmpfiledir="/dev/shm"
else
    tmpfiledir="."
fi

dictionary_nl="/usr/share/dict/dutch"
dictionary_am="/usr/share/dict/american-english"
dictionary_br="/usr/share/dict/british-english"
dictionary_de="/usr/share/hunspell/de_DE_frami.dic"
dictionary_fr="/usr/share/dict/french"
dictionary_sp="/usr/share/dict/spanish"
dictionary_it="/usr/share/dict/italian"
dict="$tmpfiledir/dict$RANDOM"


process_dict_de()
{
    grep -v ^# $dictionary_de 2>/dev/null | sed 's/\/[^/]*//g' | sort | uniq
}


helptext()
# Text printed if -h option (help) or a non-existing option has been given:
{
    while read "line"; do
        echo "$line" >&2         # print to standard error (stderr)
    done << EOF

Usage:
anagram10b.sh [-abcdfhins] [WOORD]

    -a	American-English
    -b	British-English
    -d	German
    -f	French
    -h	Help (this output)
    -i	Italian
    -n	Dutch
    -s	Spanish
    -c	All languages combined

EOF
}


default=$dictionary_nl
count=0
touch $dict

while getopts "abcdfhins" OPTION; do
    case $OPTION in
        a) cat $dictionary_am >> $dict; (( count += 1 )) ;;
        b) cat $dictionary_br >> $dict; (( count += 1 )) ;;
        d) process_dict_de    >> $dict; (( count += 1 )) ;;
        f) cat $dictionary_fr >> $dict; (( count += 1 )) ;;
        h) helptext; exit 0 ;;
        i) cat $dictionary_it >> $dict; (( count += 1 )) ;;
        n) cat $dictionary_nl >> $dict; (( count += 1 )) ;;
        s) cat $dictionary_sp >> $dict; (( count += 1 )) ;;
        c) process_dict_de    >| $dict
           cat $dictionary_nl $dictionary_am \
               $dictionary_br $dictionary_fr \
               $dictionary_sp $dictionary_it >> $dict; count=7 ;;
        *) helptext; exit 1 ;;
    esac
done
shift $((OPTIND-1))

[[ $# == 1 ]] && pattern="$1" || pattern="."

echo -e "One moment, the output is being prepared ...\n" >&2

[[ -s $dict ]] && default=$dict

if (( count > 1 )); then      # If minimally 2 dictionaries are combined: apply 'sort' en 'uniq'
    sort $default | uniq
else
    cat $default
fi |


awk 'BEGIN {
         # Setting in order to loop though array-elements in ascending index-order, see:
         # https://www.gnu.org/software/gawk/manual/gawk.html#Controlling-Scanning

         PROCINFO["sorted_in"]="@val_str_asc"
     }

     {
         word = $0                          # The word presently read

         $0 = tolower($0)
         gsub(/[áàäâå]/, "a")               # Normalize all its characters to lower case and w/o accent marks:
         gsub(/[éèëê]/,  "e")
         gsub(/[ïíì]/,   "i")
         gsub(/[óòöôø]/, "o")
         gsub(/[úùü]/,   "u")
         gsub(/[ñ]/,     "n")
         gsub(/[ç]/,     "c")

         gsub(/['\"''\'' &-]/, "")          # Remove other non-alphanumeric characters

         split($0,chars,"")                 # Array of all the word`s normalized characters
         signature = ""
         for (i in chars){
             signature = signature chars[i] # Unique sorted character combination (= signature)
         }
         wordstring = anagrams[signature]   # String of previously stored words with this signature
         len = length(wordstring)           # Length of existing string is always a multiple of 20
         anagrams[signature] = sprintf("%-"len"s%-20s", wordstring, word)
     }

     END {
         for (signature in anagrams){
             print anagrams[signature]
         }
     }' | grep "\( \|^\)"$pattern"\( \|$\)"

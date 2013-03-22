#!/usr/local/bin/bash

###########################################################################
# Copyright 2013 Josh O'Neal
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
###########################################################################


##########
# HOW-TO #
##########

# You should check out README.md for a high-level explanation of installation and usage


###########
# HELPERS #
###########

# the target director
GEN_DIR="$1/$2-Gen"

# the name of the pre-compiled header
PREFIX_HEADER_NAME="$2-Prefix.pch"

# the pre-compiled header file to add the auto generated import to
PREFIX_HEADER_FILE=$(find "$1" -type f -name "$PREFIX_HEADER_NAME")

# the name of the generated header file
RESOURCE_HEADER_NAME="$2GeneratedResources.h"

RESOURCE_HEADER_NAME=$(echo $RESOURCE_HEADER_NAME | sed 's/ /_/g')

# the file path of the generated header file
RESOURCE_HEADER_FILE="$GEN_DIR/$RESOURCE_HEADER_NAME"


#########
# BEGIN #
#########

# a hack for spaced file names | http://www.cyberciti.biz/tips/handling-filenames-with-spaces-in-bash.html
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

# create the target directory, if it doesn't exist
mkdir -p "$GEN_DIR"

# create the generated header file
touch "$RESOURCE_HEADER_FILE"

# Reset the header file, and add the info at the top
printf "/**\n * This header's contents were auto generated by r_linker.h\n\n * @author Josh O'Neal\n * @link https://github.com/LifeCoder45/r_linker\n **/\n\n" > "$RESOURCE_HEADER_FILE"

# find in the project dir, all files
# then strip their path off
# then filter them to ensure only images are found
# then sort them alphabetically
# then write them to a temp file
ALL_FILES=$(find "$1" -type f | sed 's:.*/::' | egrep -i '\.(png|jpg|jpeg|gif|sqlite|mov|mp4|mp3)$' | sort)

# the longest file name length
MAX_LEN=0

# find the longest name, for pretty formatting
for A_FILE in $ALL_FILES
do
    LOCAL_LEN=$(echo "$A_FILE" | wc -m)

    if [ "$LOCAL_LEN" -gt "$MAX_LEN" ]; then
        MAX_LEN=$LOCAL_LEN
    fi

done

# write out the asset definitions
for A_FILE in $ALL_FILES
do
    # strip the illegal define chars
    A_FILE_CLEAN=$(echo "$A_FILE" | sed 's/[-@., ]/_/g')

    MAX_ITER=$(($MAX_LEN-$(echo "$A_FILE" | wc -m)))

    SPACES=""

    # a spacer, so all the items are lined up right
    for I in $(seq 0 $MAX_ITER)
    do
        SPACES+=" "
    done

    # write out the defines
    printf "#define r$A_FILE_CLEAN $SPACES@\"$A_FILE\"\n" >> "$RESOURCE_HEADER_FILE"

done

# how many times the generated header is found in the prefix header
HEADER_LINE_COUNT=$(grep "$RESOURCE_HEADER_NAME" "$PREFIX_HEADER_FILE" | wc -l)

# is the generated header added to the prefix header?
if [ 0 == $HEADER_LINE_COUNT ]; then
    printf "\n\n// This import was auto generated by r_linker.h\n" >> "$PREFIX_HEADER_FILE"
    printf "#import \"$RESOURCE_HEADER_NAME\"\n" >> "$PREFIX_HEADER_FILE"
fi

# reset IFS
IFS=$SAVEIFS

#!/bin/bash

# exit if error
set -e

display_usage() {
  echo "USAGE: script.sh <target_dir> <new_dir>"
}

if [ $# -lt 2 ]
then
  display_usage
  exit 1
fi

# create a new directory for the results
new_name="$2"
new_dir="$new_name".fixed
mkdir $new_dir

# for each file in <dir>
for f in `realpath -s $1`/*; do
  # if it is a .mkv
  if [ -f "$f" ] && [[ $f =~ \.mkv$ ]]; then

    # f is an absolute path, so get just the filename
    filename=`basename ${f}`
  
    # extract the number
    number="${filename%.*}"

    # trim the zeroes
    number=`printf "%d\n" $number`

    # create new directories for the file
    mkdir "$new_dir/$new_name.$number"
    mkdir "$new_dir/$new_name.$number/preservation"

    # copy and rename the file
    cp "$f" "$new_dir/$new_name.$number/preservation/$new_name.$number"_"$filename"
  fi
done
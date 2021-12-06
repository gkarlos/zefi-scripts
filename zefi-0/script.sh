#!/bin/sh

display_usage() {
  echo "USAGE: script.sh <search_directory> <new_directory_name> <action: {copy,move}>"
  echo ""
  echo "For every directory d inside <search_directory> create a new directory under d,"
  echo "named by <new_directory_name>, and copy or move  all files d contains inside it."
}

if [ $# -le 2 ]
then
  display_usage
  exit 1
fi

if [ $3 != "move" ] && [ $3 != "copy" ] && [ $3 != "mv" ] && [ $3 != "cp" ]; then
  echo "ERROR: Action must be either 'copy/cp' or 'move/mv'"
  exit 0
fi

action=mv

if [ $3 != "move" ] && [ $3 != "mv" ]; then
  action=cp
fi


for d in "$1"/*; do
  if [ -d "$d" ]; then
    subdir="$d"/$2
    mkdir $subdir
    for f in "$d"/*; do
      if [ -f "$f" ]; then
        "$action" "$f" "$subdir"
      fi
    done
  fi
done
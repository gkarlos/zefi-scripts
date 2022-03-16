display_usage() {
  echo "USAGE: script.sh <dir> <max_depth>"
}

if [ $# -lt 2 ]; then
  display_usage
  exit 1
fi

max_depth=$2

if [ $max_depth -lt 1 ]; then
  echo "Error: Usage max_depth >= 1"
fi

function traverse() {
  shopt -s nullglob dotglob

  echo -ne "Checking" $1 "at depth:" $2
  if [[ -z $(find $1 -maxdepth 1 -type f -printf '.') ]]; then
    echo " -- no files, recursing"
    if [ $2 -lt $max_depth ]; then                # if we are not too deep
      for d in `realpath -s $1`/*; do             # go over the directory contents
        if [ -d "$d" ]; then                      # if its a (sub)directory
          if [[ "$d" != *"preservation"* ]]; then # and it is not called "preservation" (fail-safe condition)
            traverse `realpath -s $d` $(($2+1))   # traverse it
          fi
        fi
      done
    fi
  else
    echo "-- has files, stoping"
    mkdir `realpath -s $1`/preservation           # create the preservation directory
    for f in `realpath -s $1`/*; do               # go over the contents
      if [ -f "$f" ]; then                        # if it's a file
        mv $f `realpath -s $1`/preservation       # move it into the preservation dir
      fi
    done
  fi
}

traverse `realpath -s $1` 0
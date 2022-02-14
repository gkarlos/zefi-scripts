#!/bin/bash

root_dir=$(realpath -s $1)
dirs=($(ls "$root_dir"))
for ((i = ${#dirs[@]} - 1;i >= 0;i--)); do

  # Rename dirs
  d=${dirs[i]}

  d_pre=${d%.*}
  d_suf=${d#*.}

  if [[ "$d_suf" == *"a" ]]; then
    num=${d_suf%a}
    new_num=$((num+1))
    d_suf="$new_num"a
  else
    d_suf=$((d_suf+1))
  fi

  d_new="$d_pre.$d_suf"
  d_new_full="$root_dir/$d_new"
  mv $root_dir/$d/ $d_new_full/

  # Rename files
  subdir="$d_new_full/preservation"
  files=($(ls "$subdir/"))

  for ((j = ${#files[@]} - 1;j >= 0;j--)); do
    f_suf=${files[j]#*_}
    f_suf1=${f_suf%.*}
    f_suf2=$((10#$f_suf1 + 1))
    f_suf=$(printf "%04d" $f_suf2)
    # echo "$subdir/${files[j]} -->  $subdir/${f_pre}_$f_suf.$f_ext"
    mv $subdir/${files[j]} $subdir/${d_new}_$f_suf.tif
  done

done
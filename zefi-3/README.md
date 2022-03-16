This script transforms a given directory from:

```
dir/
 |_ 0001.mkv
 |_ 0002.mkv
 |_ 0003.mkv
```

to

```
new_name.fixed/
  |_ new_name.1
  |  |_ preservation
  |  |  |_ new_name.1_0001.mkv
  |_ new_name.2
  |  |_ preservation
  |  |  |_ new_name.2_0002.mkv
  ...
```

### Usage: 

`chmod +x script.sh && script.sh <dir> <new_name>`

Calling the script (from anywhere) will create a new directory `<new_name>.fixed` in the directory the script was run from,
and populate it with the result of applying the above transformation to `<dir>`. The original `<dir>` can then be manually deleted




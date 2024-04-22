# search-in-text
 search for a specific string in a file or output
 ## Sint Command


A bash script designed to search for specific parameters in log files within a given directory.
```
  ./sint.sh [-v] <directory_path> <param1> <param2>
```

## Options:
-v: Inverts the match logic. By default, the script searches for lines containing <param1>. With -v, it excludes lines containing <param2>.

## Parameters:
<directory_path>: Path to the directory containing log files.
<param1>: First parameter to search for in log files.
<param2>: Second parameter for exclusion when -v option is used.

## Example:
./sint.sh -v /home/kali/Documents/logs app_token gps_adid

## Behavior:
The script reads each text file within the specified directory.
It searches for lines containing <param1>.
If -v option is used, it excludes lines containing <param2> instead.
Outputs the matched lines along with their line numbers.

## Note:
Ensure that the script has execute permissions (chmod +x sint.sh) before usage.
Log files should be in .txt format and located within the specified directory.

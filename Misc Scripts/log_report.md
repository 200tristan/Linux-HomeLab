./log_report.sh /path/to/folder report.txt
Replace /path/to/folder with the actual path to the folder you want to scan for log files, and report.txt with the desired name for the report file.
The script will search for log files (with a .log extension) in the specified folder and its subfolders. It will extract major errors (lines containing "error" but not "warning") from each log file and generate a report file (report.txt in the example). The report will contain the log file path and the extracted errors for each file found.

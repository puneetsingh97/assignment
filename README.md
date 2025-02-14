Assignment: Log File Analyzer & Cleanup Script
Create a shell script (log_analyzer.sh) that does the following:
Scans a directory (/var/log/custom_logs/) for log files (*.log).
Extracts error messages (lines containing ERROR or FATAL) from each log file and saves them to a separate summary file (error_summary.log).
Counts occurrences of each unique error message and outputs a report (error_report.txt) showing:
-Error message
-Number of occurrences
Compresses logs older than 7 days into a .tar.gz archive (old_logs.tar.gz) and moves them to /var/log/archive/.
Deletes compressed logs older than 30 days from /var/log/archive/.
Send an email alert if any FATAL error is detected.
Runs as a cron job every day at midnight.

Requirements:
The script should be efficient and handle large log files.
It should include error handling (e.g., if the directory doesn’t exist).
The script should log its actions to a file (script.log).
It should be designed to run automatically via cron.

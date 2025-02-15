#!/bin/bash

ERROR_SUMMARY=/scripts/error_summary_$(date +%Y-%m-%d_%H:%M:%S).log
ERROR_REPORT=/scripts/error_report_$(date +%Y-%m-%d_%H:%M:%S).txt
OLD_LOGS=old_logs_$(date +%Y-%m-%d_%H:%M:%S).tar.gz
DIR=/var/log/archive
SCRIPT_LOG=/scripts/script.log

echo "Log Analyzer started for date : $(date)..."  >> $SCRIPT_LOG
grep -E 'ERROR|FATAL' /var/log/custom_logs/*.log > $ERROR_SUMMARY
echo "Summary file generated  SUCCESSFULLY." >> $SCRIPT_LOG

echo "Error report being generated..." >> $SCRIPT_LOG
grep ERROR $ERROR_SUMMARY | uniq -c > $ERROR_REPORT
echo "Report Generated SUCCESSFULLY." >> $SCRIPT_LOG

echo "Old logs being backed up..." >> $SCRIPT_LOG
if [[ ! -e $DIR ]]; then
    mkdir $DIR
elif [[ ! -d $DIR ]]; then
    echo "$DIR already exists but is not a directory" >> $SCRIPT_LOG 2>&1
fi


if [[ -f $OLD_LOGS ]]; then
        tar -cvzf $OLD_LOGS $(find /var/log/custom_logs/ -name "*.log" -type f -mtime +7)
        mv $OLD_LOGS $DIR
else
        echo "No old logs found."
fi
echo "Backup of old logs SUCCESSFUL." >> $SCRIPT_LOG

echo "Removing obsolete logs..." >> $SCRIPT_LOG
find /var/log/archive/ -type f -mtime +30 -exec rm -rf {} \;
echo "Removal SUCCESSFUL." >> $SCRIPT_LOG

echo "Emailing to Admin..." >> $SCRIPT_LOG
mail -s "FATAL error is detected!" puneetsingh97@gmail.com < $ERROR_REPORT
echo "Email sent SUCCESSFULLY." >> $SCRIPT_LOG

echo "Log Analyzer completed SUCCESSFULLY for $(date)."  >> $SCRIPT_LOG
echo "*********************************************"  >> $SCRIPT_LOG


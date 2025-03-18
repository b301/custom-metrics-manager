#!/bin/bash

# Define the metric name
METRIC_NAME="zproc"
FILENAME="{{ textfile_metrics_location }}/${METRIC_NAME}"

# Empty the temporary file
> ${FILENAME}.tmp

# Print the Prometheus header
echo "# HELP ${METRIC_NAME} Monitor running processes" >> ${FILENAME}.tmp
echo "# TYPE ${METRIC_NAME} gauge" >> ${FILENAME}.tmp

# Script logic here

# Run ps -eF and skip the header line
ps -eF | tail -n +2 | while read -r uid pid ppid cpu sz rss psr stime tty time cmd; do
    # Format the output as Prometheus metrics
    # Use labels for metadata and values for numeric data
    echo "${METRIC_NAME}{uid=\"$uid\",pid=\"$pid\",ppid=\"$ppid\",cpu="${cpu}", sz="${sz}", rss="${rss}", psr="${psr}, stime="${stime}", tty="${tty}", time=${time}", cmd=\"$cmd\"} 1" >> ${FILENAME}.tmp
done


# Set output as the new metrics
mv -f ${FILENAME}.tmp ${FILENAME}.prom

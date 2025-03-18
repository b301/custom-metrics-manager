#!/bin/bash

# Define the metric name
METRIC_NAME="<REPLACE>"
FILENAME="{{ textfile_metrics_location }}/${METRIC_NAME}"

# Empty the temporary file
> ${FILENAME}.tmp

# Print the Prometheus header
echo "# HELP ${METRIC_NAME} <REPLACE>" >> ${FILENAME}.tmp
echo "# TYPE ${METRIC_NAME} <REPLACE>" >> ${FILENAME}.tmp

# Script logic here


# Set output as the new metrics
mv -f ${FILENAME}.tmp ${FILENAME}.prom

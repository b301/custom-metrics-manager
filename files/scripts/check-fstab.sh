#!/bin/bash

# Define the metric name
METRIC_NAME="fstab_entry"

# Empty the temporary file
> {{ textfile_metrics_location }}/${METRIC_NAME}.tmp

# Print the Prometheus header
echo "# HELP ${METRIC_NAME} Information about fstab entries and their mount status" >> {{ textfile_metrics_location }}/${METRIC_NAME }}.tmp
echo "# TYPE ${METRIC_NAME} gauge" >> {{ textfile_metrics_location }}/${METRIC_NAME }.tmp

# Read /etc/fstab, skip comments and empty lines, and process each line
grep -v -E '^#|^$' /etc/fstab | while read -r spec file vfstype mntops freq passno
do
    # Check if the filesystem is mounted at the exact mount point specified in fstab
    if findmnt --mountpoint ${file} >/dev/null 2>&1; then
        # If mounted, set the value to 1
        mounted=0
    else
        # If not mounted, set the value to 0
        mounted=1
    fi

    # Output the Prometheus metric
    echo "${METRIC_NAME}{spec=\"${spec}\", file=\"${file}\", vfstype=\"${vfstype}\", mntops=\"${mntops}\", freq=\"${freq}\", passno=\"${passno}\"} ${mounted}" >> {{ textfile_metrics_location }}/${METRIC_NAME}.tmp
done

mv -f {{ textfile_metrics_location }}/${METRIC_NAME}.tmp {{ textfile_metrics_location }}/${METRIC_NAME}.prom

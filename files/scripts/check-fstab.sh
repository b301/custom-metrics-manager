#!/bin/bash

# Define the metric name
METRIC_NAME="fstab_entry"
FILENAME="{{ textfile_metrics_location }}/${METRIC_NAME}"

# Empty the temporary file
> ${FILENAME}.tmp

# Print the Prometheus header
echo "# HELP ${METRIC_NAME} Information about fstab entries and their mount status" >> ${FILENAME}.tmp
echo "# TYPE ${METRIC_NAME} gauge" >> ${FILENAME}.tmp

# Read /etc/fstab, skip comments and empty lines, and process each line
grep -v -E '^#|^$' /etc/fstab | while read -r spec file vfstype mntops freq passno
do
    # Check if the filesystem is mounted at the exact mount point specified in fstab
    if findmnt --mountpoint ${file} >/dev/null 2>&1
    then
        # If mounted, set the value to 1
        mounted=0
    else
        # If not mounted, set the value to 0
        mounted=1
    fi

    # Output the Prometheus metric
    echo "${METRIC_NAME}{spec=\"${spec}\", file=\"${file}\", vfstype=\"${vfstype}\", mntops=\"${mntops}\", freq=\"${freq}\", passno=\"${passno}\"} ${mounted}" >> ${FILENAME}.tmp
done

mv -f ${FILENAME}.tmp ${FILENAME}.prom

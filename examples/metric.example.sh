#!/bin/bash

# Define the network interface to check (modify as needed)
INTERFACE="eth0"

# Get the current MTU value
MTU_VALUE=$(ip link show $INTERFACE | awk '/mtu/ {print $5}')

# Define the expected MTU value
EXPECTED_MTU=1500

# Check if the MTU value matches the expected value
if [[ "$MTU_VALUE" -ne "$EXPECTED_MTU" ]]; then
    echo "Warning: MTU for $INTERFACE is $MTU_VALUE, expected $EXPECTED_MTU"
    exit 1  # Return failure if MTU is incorrect
fi

echo "MTU for $INTERFACE is correctly set to $MTU_VALUE."
exit 0  # Return success if MTU is correct

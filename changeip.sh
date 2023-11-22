#!/bin/bash

# Ask the user for the new IP address, netmask, gateway, and interface name
echo "Please enter the new IP address (e.g., 192.168.1.11):"
read NEW_IP

echo "Please enter the new Netmask (e.g., 255.255.255.0):"
read NEW_NETMASK

echo "Please enter the new Gateway (e.g., 192.168.1.1):"
read NEW_GATEWAY

echo "Please enter the Interface name (e.g., vmbr0):"
read INTERFACE

# Retain the hostname variable
HOSTNAME="$(hostname)"

# Backup the current network configuration and hosts file
cp /etc/network/interfaces /etc/network/interfaces.backup
cp /etc/hosts /etc/hosts.backup

echo "Are you sure you want to change the IP? [y/N]:"
read -r response
response=${response,,}  # to lower case
if [[ $response =~ ^(yes|y)$ ]]; then
    echo "The IP will change. Visit the new IP address to continue. New IP: $NEW_IP"
    # Function to update the network configuration
    update_network_config() {
        # Update the IP address, netmask, and gateway in the network configuration file
        sed -i "/iface $INTERFACE inet static/,+3 s/address .*/address $NEW_IP/" /etc/network/interfaces
        sed -i "/iface $INTERFACE inet static/,+3 s/netmask .*/netmask $NEW_NETMASK/" /etc/network/interfaces
        sed -i "/iface $INTERFACE inet static/,+3 s/gateway .*/gateway $NEW_GATEWAY/" /etc/network/interfaces

        # Apply changes with ifdown and ifup to avoid complete network restart
        ifdown $INTERFACE && ifup $INTERFACE
    }

    # Function to update the /etc/hosts file
    update_hosts_file() {
        # Replace the old IP address with the new one
        sed -i "s/^[0-9.]\+\s\+$HOSTNAME/$NEW_IP $HOSTNAME/" /etc/hosts
    }

    # Function to check if the new IP is working
    check_network_access() {
        ping -c 4 8.8.8.8 > /dev/null
        return $?
    }

    # Update network configuration and hosts file
    update_network_config
    update_hosts_file

    # Wait for a few seconds to let the network come up
    sleep 10

    # Check network access
    if check_network_access; then
        echo "Network configuration updated successfully."
    else
        echo "Network update failed, reverting changes."
        cp /etc/network/interfaces.backup /etc/network/interfaces
        cp /etc/hosts.backup /etc/hosts
        ifdown $INTERFACE && ifup $INTERFACE
    fi
else
    echo "IP change cancelled."
fi
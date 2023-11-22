Certainly! Below is a Markdown (MD) formatted documentation for the provided script, suitable for use in a GitHub repository:

---

# Network Configuration Script

This script allows users to change their network configurations including IP address, netmask, gateway, and network interface. It is designed to run on Unix-based systems and provides a simple, interactive way to update network settings.

## Prerequisites

- Bash shell
- Root or sudo privileges
- Familiarity with your network configuration, including interface names

## Usage

To run the script, use the following command in your terminal:

```bash
sudo bash network-config-script.sh
```

### Steps:

1. **Enter New IP Address:** You will be prompted to enter the new IP address you wish to assign to your machine.
2. **Enter New Netmask:** Next, enter the netmask for your network.
3. **Enter New Gateway:** Enter the gateway address for your network.
4. **Enter Interface Name:** Specify the network interface you wish to configure (e.g., `eth0`, `vmbr0`).
5. **Confirmation Prompt:** Before applying the changes, the script will ask for your confirmation. Type `y` or `yes` to proceed or any other key to cancel.
6. **Apply Changes:** If confirmed, the script will apply the new network configuration.

## Functions

- **Backup Current Configuration:** The script creates backups of current network configurations and hosts file before making changes.
- **Update Network Configuration:** Updates the IP address, netmask, and gateway in the network configuration file.
- **Update Hosts File:** Modifies the `/etc/hosts` file with the new IP address.
- **Network Restart Avoidance:** Uses `ifdown` and `ifup` to apply changes without a complete network restart.
- **Revert Changes on Failure:** If the network update fails, the script will revert to the previous configuration.

## Important Notes

- Ensure you have the correct permissions to modify network settings.
- Be cautious with network configurations, as incorrect settings can lead to loss of network connectivity.
- After changing the IP address, you may need to reconnect to the machine using the new IP.

## Example

When you run the script, it will look like this:

```plaintext
Please enter the new IP address (e.g., 192.168.1.11):
[Enter new IP here]
...
Are you sure you want to change the IP? [y/N]:
[Enter 'y' or 'yes' to confirm]
```

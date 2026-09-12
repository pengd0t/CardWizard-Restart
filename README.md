# CardWizard-Restart
A simple Windows batch script that lets technicians remotely check and restart the Entrust CardWizard service on client PCs.

## Background
Entrust CardWizard is software that runs on client Windows PCs and enables interaction with the associated debit card printer.

The most common support issue is the CardWizard Windows service stopping or becoming unresponsive. When this happens, users experience the card printer as offline or non-functional.

Occasionally, updates or other changes break the service across many machines at once. This script allows a technician to quickly check the service status and restart it remotely—without needing the end user to be present or coordinate the restart.

## Service Name
The script targets the following Windows service:
DCG.LocalDeviceIntegrationService


## Requirements

- Run the script **as Administrator**
- Network connectivity to the target PC(s)
- Administrative rights on the target PC(s) (the `SC` command is used over the network)
- The target computer name must be resolvable (DNS or NetBIOS)

## How to Use

1. Download `CardWizard-Restart.bat`
2. Right-click the file → **Run as administrator**
3. Enter the computer name when prompted
4. The script will display the current status of the remote service
5. Choose **Y** to restart the service or **N** to enter a different computer name
6. After the restart, the new service status is shown
7. Choose **Y** to work on another computer or **N** to exit

### What the script does

1. Queries the current status of `DCG.LocalDeviceIntegrationService` on the remote PC
2. Stops the service
3. Waits ~10 seconds
4. Starts the service
5. Queries and displays the new status
6. Offers to repeat the process on another computer

## Notes

- The script is interactive and designed for sequential use (one computer at a time).
- It does **not** require any software to be installed on the remote machines.
- A short delay is built in between the stop and start commands to allow the service to fully stop.
- If the service fails to start or stop, the `SC` command output will show the error.

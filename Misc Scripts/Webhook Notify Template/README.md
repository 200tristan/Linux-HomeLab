#Simple Webhook Notification Script

This script is a bash script that monitors a log file located at <PATH_TO_LOG>. When it detects that a user has joined or left, it sends a webhook to <WEBHOOK_URL>. Currently configured to scan the Terraria Log file to notify a connected discord channel using webhook. 

#Usage
To use this script, you need to replace <PATH_TO_LOG> with the path to the log file you want to monitor and <WEBHOOK_URL> with the URL of the webhook that will receive the notifications.

You can run the script by simply executing the command ./script.sh in your terminal.

#Dependencies
This script uses curl and jq which are external command-line tools that must be installed on your system in order for the script to work properly.(Built in for most distros)

#Functionality
The script follows the log file in real-time using the tail -fn0 command. It then reads each line and checks if the line contains the phrases "has joined." or "has left." These can be easily substituted.  If it does, it sends a webhook to the specified URL containing the line as the message.

If the line does not contain the required phrases, the script ignores the line and continues to read the next line.

The send_webhook() function creates a JSON payload using the jq command and then sends the payload to the webhook URL using the curl command.

#Output
The script outputs messages to the console indicating when the script started, and whether it is sending a webhook for a particular line or ignoring it. The messages include the date and time of the event, along with the message that triggered the webhook.
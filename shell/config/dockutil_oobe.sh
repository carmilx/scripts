#!/bin/zsh

# Logging config
LOG_NAME="dockutil_configuration.log"
LOG_DIR="/Library/Logs"
LOG_PATH="$LOG_DIR/$LOG_NAME"

dockutil=/usr/local/bin/dockutil
currentUser=$(scutil <<< "show State:/Users/ConsoleUser" | awk '/Name :/ { print $3 }')
uid=$(id -u "$currentUser")
userHome=$(dscl . -read /users/${currentUser} NFSHomeDirectory | cut -d " " -f 2)
plist="${userHome}/Library/Preferences/com.apple.dock.plist"

logging() {
    # Logging function
    #
    # Takes in a log level and log string and logs to /Library/Logs/$script_name if a
    # LOG_PATH constant variable is not found. Will set the log level to INFO if the
    # first built-in $1 is passed as an empty string.
    #
    # Args:
    #   $1: Log level. Examples "info", "warning", "debug", "error"
    #   $2: Log statement in string format
    #
    # Examples:
    #   logging "" "Your info log statement here ..."
    #   logging "warning" "Your warning log statement here ..."
    log_level=$(printf "%s" "$1" | /usr/bin/tr '[:lower:]' '[:upper:]')
    log_statement="$2"
    script_name="$(/usr/bin/basename "$0")"
    prefix=$(/bin/date +"[%b %d, %Y %Z %T $log_level]:")

    # see if a LOG_PATH has been set
    if [[ -z "${LOG_PATH}" ]]; then
        LOG_PATH="/Library/Logs/${script_name}"
    fi

    if [[ -z $log_level ]]; then
        # If the first builtin is an empty string set it to log level INFO
        log_level="INFO"
    fi

    if [[ -z $log_statement ]]; then
        # The statement was piped to the log function from another command.
        log_statement=""
    fi

    # echo the same log statement to stdout
    /bin/echo "$prefix $log_statement"

    # send log statement to log file
    printf "%s %s\n" "$prefix" "$log_statement" >>"$LOG_PATH"

}


runAsUser() {  
  if [ "$currentUser" != "loginwindow" ]; then
    launchctl asuser "$uid" sudo -u "$currentUser" "$@"
  else
    echo "No user logged in."
    # uncomment the exit command
    # to make the function exit with an error when no user is logged in
    exitCode=1
    exit $exitCode
  fi
}

# Configure the dock for a new user
logging "Remove Everything from dock"
runAsUser $dockutil --remove all --no-restart ${plist} 
logging "Add Drata applications to dock"
runAsUser $dockutil --add '/System/Applications/Launchpad.app' ${plist} --no-restart 
runAsUser $dockutil --add '/Applications/Google Chrome.app' ${plist} --no-restart 
runAsUser $dockutil --add '/Applications/zoom.us.app' ${plist} --no-restart 
runAsUser $dockutil --add '/Applications/Slack.app' ${plist} --no-restart 
runAsUser $dockutil --add '/Applications/1Password.app' ${plist} --no-restart 
runAsUser $dockutil --add '/Applications/Notion.app' ${plist} --no-restart 
runAsUser $dockutil --add '/Applications/Google Drive.app' ${plist} --no-restart 
runAsUser $dockutil --add '/Applications/Cloudflare WARP.app' ${plist} --no-restart 
runAsUser $dockutil --add '/Applications/Okta Verify.app' ${plist} --no-restart 
runAsUser $dockutil --add '/System/Applications/App Store.app' ${plist} --no-restart 
runAsUser $dockutil --add '/Applications/Kandji Self Service.app' ${plist} --no-restart 
runAsUser $dockutil --add '/System/Applications/System Settings.app' ${plist} --no-restart 
runAsUser $dockutil --add '~/Downloads' ${plist}
logging "Refresh dock"
killall cfprefsd Dock
exit 0
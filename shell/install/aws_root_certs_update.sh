#!/bin/bash

# Logging config
LOG_NAME="aws_certs_install.log"
LOG_DIR="/Library/Logs"
LOG_PATH="$LOG_DIR/$LOG_NAME"

# Getting current logged in user
user=$(last | grep -v "root" | head -n 1 | awk '{print $1}')

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

install() {
    logging "--"
    logging "`date`: Creating folder in user's directory."
    # Creating directory named "RDS Certificate Bundles"
    mkdir /Users/$user/RDS\ Certificate\ Bundles
    logging "`date`: Moving into user directory."
    # Changing directory to /Users/$user/RDS Certificate Bundles
    cd /Users/$user/RDS\ Certificate\ Bundles
    logging "`date`: Downloading latest Certificates."
    # Downloading certificates
    curl -O https://s3.amazonaws.com/rds-downloads/rds-combined-ca-bundle.pem -s
    curl -O https://truststore.pki.rds.amazonaws.com/global/global-bundle.pem -s
}

install
exit 0

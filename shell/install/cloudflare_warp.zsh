#!/bin/zsh

# Logging config
LOG_NAME="cloudflare_warp_install.log"
LOG_DIR="/Library/Logs"
LOG_PATH="$LOG_DIR/$LOG_NAME"

# Working Directory
WORK_DIR="/Library/Logs/CF_WARP"

# Install variables
pkgfile="Cloudflare_WARP.pkg"
zipfile="Cloudflare_WARP.zip"
url='https://1111-releases.cloudflareclient.com/mac/Cloudflare_WARP.zip'

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
    logging "`date`: Downloading latest version."
    mkdir ${WORK_DIR}
    curl -L -s -o ${WORK_DIR}/${zipfile} ${url}
    logging "`date`: Installing..."
    unzip ${WORK_DIR}/${zipfile} -d ${WORK_DIR}
    installer -pkg ${WORK_DIR}/${pkgfile} -target /
    
}

cleanup() {
    logging "`date`: Deleting installer file."
    rm -rf ${WORK_DIR}
}

install
cleanup
exit 0
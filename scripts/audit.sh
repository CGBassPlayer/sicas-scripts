#!/bin/bash
<< ABOUT
Name:   audit
Author: Ryan Goodwin

View and edit audit trail of a jar file or edit any file within a jar without
  extracting it.
ABOUT

<< CHANGE_LOG
--------------------------------------------------------------------------------
Version 0.3.0
  1. Add flag to delete file inside of jar file
--------------------------------------------------------------------------------
Version 0.2.2
  1. Update list flag to have a variable of ignored files instead of hardcoding
--------------------------------------------------------------------------------
Version 0.2.1
  1. Change lock to include the username to make it unique. This will avoid a
       lock out when 2 people try to use the script at the same time.
--------------------------------------------------------------------------------
Verison 0.2.0
  1. Add flag to list all properties files containing log in the name and
       audit trails (based on the default value or using the -f flag)
  2. Add flag to edit a file inside the jar
--------------------------------------------------------------------------------
Version 0.1.0
  1. Initial Creation
  2. Create shell script to print the audit trail to the console
  3. Add parameter to determine name of the audit trail file
--------------------------------------------------------------------------------
CHANGE_LOG

# ------------------------------------------------------------------------------
# Constants

SUBJECT="${USER}-sicas-audit"
VERSION="0.3.0"
USAGE="\
Usage: audit -j {file} [options]
    -h  --help          Display this help prompt
    -V  --version       Display version
    -v  --verbose       Show log messages

    -j  --jar {file}    Name of the jar file

    -l  --list          List the editable files in the jar

    -f  --file {file}   Name of the audit trail file. 'AUDIT_TRAIL' is default
    -e  --edit {file}   Edit a specific file inside the jar
    -d  --delete {file} Delete a specific file inside the jar"
USE_LOGGING=false

# ------------------------------------------------------------------------------
# Variables to run different code segments
JAR_FILE=""
AUDIT_FILE="AUDIT_TRAIL"

LIST_FILES=false
IGNORED_FILES="\
.class\|\
.kotlin_\|\
.dat\|\
pom\|\
/$"

EDIT_FILE=""
DELETE_FILE=""

# ------------------------------------------------------------------------------
# Options

while test $# -gt 0; do
  case "$1" in
    # Standard Flags
    -V|--version)
      echo "Version $VERSION"
      exit 0
      ;;
    -h|--help)
      echo "$USAGE"
      exit 0
      ;;
    -v|--verbose)
      USE_LOGGING=true
      shift
      ;;

    # Script Specific Flags
    -j|--jar)
      JAR_FILE=$2
      shift 2
      ;;
    -f|--file)
      AUDIT_FILE=$2
      shift 2
      ;;
    -l|--list)
      LIST_FILES=true
      shift
      ;;
    -e|--edit)
      EDIT_FILE=$2
      shift 2
      ;;
    -d|--delete)
      DELETE_FILE=$2
      shift 2
      ;;

    *)
      echo "Invalid flag used"
      echo "$USAGE"
      exit 1
      ;;
  esac
done

# ------------------------------------------------------------------------------
# Locking process to only one instance at a time

LOCK_FILE=/tmp/${SUBJECT}.lock

if [[ -f "$LOCK_FILE" ]]; then
echo "Script is already running"
exit
fi

trap "rm -f $LOCK_FILE" EXIT
touch $LOCK_FILE

# ------------------------------------------------------------------------------
# Logging

function log () {
  if [[ "$USE_LOGGING" == true ]]; then
    echo "[debug] $@"
  fi
}

# ------------------------------------------------------------------------------
# Script Logic

if [[ "$JAR_FILE" == "" ]]; then
  echo "jar file was not specified. Please make sure to use -j in your command."
  echo "$USAGE"
  exit 1
fi

if [[ "$LIST_FILES" == true ]]; then
  unzip -l $JAR_FILE | grep -v $IGNORED_FILES
  exit 0
fi

if [[ "$EDIT_FILE" != "" ]]; then
  log "Editing file $EDIT_FILE"
  # Create temp working directory
  TEMP_DIR=$(mktemp -d "${TMPDIR:-/tmp/}$(basename $0).XXXXXX")
  WORKING_FILE="${TEMP_DIR}/${EDIT_FILE##*/}"
  log "Created temp directory $TMP_DIR"

  # Copy file to temp working directory and open
  unzip -j $JAR_FILE $EDIT_FILE -d $TEMP_DIR/
  cp $WORKING_FILE $TEMP_DIR/${EDIT_FILE##*/}.cp
  nano $WORKING_FILE

  # Exit if the file did not change
  if diff -s $WORKING_FILE $WORKING_FILE.cp; then
    log "No changes were made to the file"
    rm -r $TEMP_DIR
    exit 0
  fi

  # Update jar file
  log "Updating the jar file and removing temp directory"
  cp $WORKING_FILE .
  zip -u $JAR_FILE ${EDIT_FILE##*/}
  rm ${EDIT_FILE##*/}
  rm -r $TEMP_DIR
  exit 0
fi

if [[ "$DELETE_FILE" != "" ]]; then
  log "Deleteing file $DELETE_FILE"
  zip -d $JAR_FILE $DELETE_FILE
  exit 0
fi

if [[ "$JAR_FILE" != "" ]]; then
  unzip -p $JAR_FILE $AUDIT_FILE
  exit 0
fi

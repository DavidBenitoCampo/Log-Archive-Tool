# Where to store the archived files
ARCHIVE_DIR="$HOME/log_Archives"

# Where to store the record actions
LOG_HISTORY_FILE="$ARCHIVE_DIR/archive_history.log"


# Check if the user provided a directory argument
if [ -z "$1" ]; then 
	echo "Error: No directory provided."
	echo "Usage: log-archive <directory_to_archive>"
	exit 1
fi

TARGET_DIR=$1

# Check if the provided directory actually exist
if [ ! -d "$TARGET_DIR"]; then
	echo "Error: Directory '$TARGET_DIR' does not exist."
	exit 1
fi

# Create the archive directory if it doesn't exist
if [ ! -d "ARCHIVE_DIR" ]; then
	mkdir -p "$ARCHIVE_DIR"
fi

# Generate the timestamp (YYYYMMDD_HHMMSS)
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

# Define the archive name
ARCHIVE_NAME="logs_archive_${TIMESTAMP}.tar.gz"

# Compression = create + gzip + filename
echo "Archiving $TARGET_DIR..."
tar -czf "$ARCHIVE_DIR/$ARCHIVE_NAME" "$TARGET_DIR" 2>/dev/null

# Check if tar was successful ($? check the exit status of the last command)
if [ $? -eq 0]; then
	echo "Success: Logs archived to $ARCHIVE_DIR/$ARCHIVE_NAME"

	# Apprend the date, time, and file location to the history log
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Archived $TARGET_DIR to $ARCHIVE_NAME" >> "$LOG_HISTORY_FILE"
else
	echo: "Error: Failed to archive logs."
	exit 1
fi

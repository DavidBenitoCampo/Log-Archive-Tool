# log-archive

A lightweight command-line interface (CLI) tool designed to automate the process of archiving logs on Unix-based systems. It timestamps, compresses, and stores logs in a designated archive directory to maintain system cleanliness and save disk space.

## 🚀 Features

* **Automated Compression:** Compresses directory trees into `tar.gz` format.
* **Timestamping:** Appends `YYYYMMDD_HHMMSS` timestamps to every archive for easy versioning.
* **Operation Logging:** Maintains a persistent `archive_history.log` file tracking all archive events.
* **Log Rotation (Optional):** Can be configured to delete or truncate original logs after a successful archive to free up space.
* **Error Handling:** Checks for directory existence and write permissions before execution.

## 📋 Prerequisites

* A Unix-like operating system (Linux, macOS).
* Bash shell.
* `tar` utility.

## 🛠️ Installation

1. **Download the script**
Save the script as `log-archive.sh`.
2. **Make it executable**
Run the following command to give the script execution permissions:
```bash
chmod +x log-archive.sh

```


3. **Install globally (Optional)**
To run the tool from any directory, move it to your local binary path:
```bash
sudo mv log-archive.sh /usr/local/bin/log-archive

```



## 💻 Usage

To archive a directory, simply run the command followed by the path of the directory you wish to archive.

### Basic Command

```bash
log-archive /path/to/directory

```

### Example

Archiving system logs:

```bash
sudo log-archive /var/log

```

**Output:**

```text
Archiving /var/log...
Success: Logs archived to /home/user/log_archives/logs_archive_20240816_100648.tar.gz

```

## ⚙️ Configuration

You can customize the archive location by editing the variables at the top of the script:

```bash
# Configuration Section in log-archive.sh
ARCHIVE_DIR="$HOME/log_archives"           # Where the .tar.gz files go
LOG_HISTORY_FILE="$ARCHIVE_DIR/archive_history.log" # Where the audit log is stored

```

### Enabling Log Deletion (Rotation)

By default, the script may only archive files. To enable **automatic cleanup** (deleting the original files after archiving), locate the cleanup section in the script and uncomment the removal commands.

> **⚠️ Warning:** Be careful when using `rm -rf` or `truncate`. Ensure you are not deleting logs that are currently being written to by active processes unless you use the `truncate` method.

## ⏰ Automation (Cron)

To run this tool automatically (e.g., every day at midnight), add it to your crontab.

1. Open crontab:
```bash
crontab -e

```


2. Add the schedule:
```text
0 0 * * * /usr/local/bin/log-archive /path/to/your/logs

```



## 📂 File Structure

After running the tool, your archive directory will look like this:

```text
/home/user/log_archives/
├── archive_history.log                 # Audit trail of all operations
├── logs_archive_20240816_100648.tar.gz # Compressed backup 1
└── logs_archive_20240817_100000.tar.gz # Compressed backup 2

```

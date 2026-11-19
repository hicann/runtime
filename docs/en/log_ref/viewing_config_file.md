# Viewing the Log Configuration File

<!-- md-trans-meta sourceCommit=31ae292a88c1a38674abaa350b60eba724bab178 translatedAt=2026-10-22T09:36:27.436Z pushedAt=2026-10-23T10:20:33.809Z -->

This topic describes the log configuration file on the device side. The file records configuration information such as the log level, log output path, number of logs, and size of a single log file for system logs on the device side.

For the standard Ascend EP form, the host side has no log configuration file and has no permission to log in to or modify the log configuration file on the device side. Generally, you do not need to modify the log configuration file.

## Overall Configuration Description
<!-- npu="310b" id1 -->
- The log configuration file is stored in the following directory on the device side:
  - Atlas 200I/500 A2 inference product: **/etc/slog.conf**
<!-- end id1 -->
- In a multi-user scenario, only the user who runs the log process can modify the configuration file.
- When modifying log configuration items, strictly follow the requirements in the configuration item description table and configure them based on the recommended values or value ranges. Failure to comply with the configuration requirements may cause system exceptions.
- After manually modifying the configuration file on the device side, restart the **slogd** process for the configuration to take effect. For details about how to restart the log process, see [Restarting Log Processes](restarting_log_processes.md).

## slog.conf File Configuration Item Description

### global_level

Sets the global log level. Only debug logs are supported. The value can be:

- **0**: DEBUG level.
- **1**: INFO level.
- **2**: WARNING level.
- **3**: ERROR level.
- **4**: NULL level. No logs are output.
- Other values: invalid value.

### enableEvent

Sets whether to enable event logs. The value can be:

- **1**: enable event logs.
- **0**: disable event logs.

### SLOG, IDEDD, DVPP

Sets the log level of each module on the control CPU. The value can be:

- **0**: DEBUG level.
- **1**: INFO level.
- **2**: WARNING level.
- **3**: ERROR level.
- **4**: NULL level. No logs are output.
- **5**: invalid value. The module log level uses the level set by **global_level**.
  - If the module log level is 5 and the global log level is a normal value (0, 1, 2, or 3), the module follows the global log level.
  - If the module log level is 5 and the global log level is 4, the module logs are not printed.
  - If the module log level is 5 and the global log level is an invalid value, the module log level is ERROR.

### TS, TSDUMP

Sets the log level of each module on non-control CPUs. The value can be:

- **0**: DEBUG level.
- **1**: INFO level.
- **2**: WARNING level.
- **3**: ERROR level.
- **4**: NULL level. No logs are output.
- **5**: invalid value. The module log level uses the level set by **global_level**.
  - If the module log level is 5 and the global log level is a normal value (0, 1, 2, 3), the module follows the global log level.
  - If the module log level is 5 and the global log level is 4, the module logs are not printed.
  - If the module log level is 5 and the global log level is an invalid value, the module log level is ERROR.

### DeviceOsMaxFileNum

Sets the number of `device-os_*.log` log files stored in the `debug/device-os` directory. When the number of log files exceeds this value, log rolling occurs and new logs overwrite the earliest logs.

### DeviceOsMaxFileSize

Sets the size of a single `device-os_*.log` log file in the "`debug/device-os`" directory. When the log file size exceeds this value, a new log file is generated.
You can adjust the size based on actual conditions. If the set value is less than 1 MB, the system default is 1 MB.

### DeviceOsNdebugMaxFileNum

Sets the number of `device-os_*.log` log files saved in the `device-os` directory of `run` or `security`. When the number of log files exceeds this value, rolling occurs and new logs overwrite the earliest logs.

### DeviceOsNdebugMaxFileSize

Sets the size of a single `device-os_*.log` log file in the `device-os` directory of `run` or `security`. If the log file size exceeds this value, a new log file is generated. You can adjust the size based on actual conditions. If the set value is less than 1 MB, the system default is 1 MB.

### DeviceMaxFileNum

Sets the number of `device-id_*.log` log files saved in the `device-id` directory. When the number of log files exceeds this value, log rolling occurs and new logs overwrite the earliest logs.

### DeviceMaxFileSize

Sets the size of a single `device-id_*.log` log file in the `device-id` directory. When the log file size exceeds this value, a new log file is generated.
You can adjust the size based on actual conditions. If the set value is less than 1 MB, the system default is 1 MB.

### DeviceAppDirNums

Sets the number of `device-app-pid` directories to retain.

### DeviceAppMaxFileNum

Sets the number of `device-app-pid_*.log` log files saved in each `device-app-pid` directory. When the number of `device-app-pid_*.log` log files exceeds this value, rolling occurs and new logs overwrite the earliest logs.

### DeviceAppMaxFileSize

Sets the size of a single `device-app-pid_*.log` log file in each "`device-app-pid`" directory. When the size of a `device-app-pid_*.log` log file exceeds this value, a new log file is generated.

### SysLogBufSize

Sets the buffer size of the system log `device-os_*.log`.

### AppLogBufSize

Sets the buffer size of the application log file `device-app-pid_*.log`.

### logAgentFileDir

Sets the log file path. If you modify this path, ensure that the user running the log process has read and write permissions on the path.
The path supports a maximum length of 255 bytes. If the input exceeds 255 bytes, the system automatically uses the truncated path and saves logs under the truncated path.

### permission_for_all

Sets whether to allow other users that are in a different group from the user running the **slogd** process to write logs after starting an application.

- **0**: not allow.
- **1**: allow.

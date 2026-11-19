# Setting Log Levels

<!-- md-trans-meta sourceCommit=f27ca703aef442726cc28a36cb0f8ecff75fe506 translatedAt=2026-11-11T06:26:39.905Z pushedAt=2026-11-16T03:34:47.372Z nl=2 -->

## Overview

Logs record the running status of the runtime environment and the processing of functional flows. They are an important tool and means for maintenance personnel to view the system status and locate problems. Based on the log level set by the system, the log module records content at different levels of detail to meet different system maintenance requirements.

The log levels in ascending order are: DEBUG < INFO < WARNING < ERROR. The lower the level, the more detailed the output logs.

- **0**: DEBUG (debug level). Logs at this level record debugging information, which helps developers or maintenance personnel locate problems.
- 1: INFO (normal level). Logs at this level record information about normal system running.
- 2: WARNING (warning level). Logs at this level record information indicating that the system state is inconsistent with the expected state but does not affect the running of the entire system.
- 3: ERROR (general error level). Logs at this level record the following errors:
  - Unexpected data or events.
  - Errors that have a wide impact but can be handled within the module.
  - Errors confined within the module.
  - Errors that have a minor impact on other modules, for example, failure to create a statistics task.
  - Errors that cause call failures.
  - Information about error states and possible causes of errors in the case of service logic errors.
- 4: NULL (NULL level). No logs are output.

Debug logs default to the ERROR level and support log level adjustment. Security logs default to the DEBUG level, and runtime logs default to the INFO level. Neither security logs nor runtime logs support log level adjustment.

The following describes the specific methods for setting log levels. For details about the related environment variables, see [Environment Variable Reference](https://gitcode.com/cann/docs/blob/master/docs/en/env-vars/README.md).

## Setting the Application Log Level

- Set the global log level through **ASCEND\_GLOBAL\_LOG\_LEVEL**:

  ```sh
  export ASCEND_GLOBAL_LOG_LEVEL=1
  ```

- Set the module log level through **ASCEND\_MODULE\_LOG\_LEVEL**:

  ```sh
  export ASCEND_MODULE_LOG_LEVEL=TDT=0:DRV=0
  ```

- Set whether to enable event logs through **ASCEND\_GLOBAL\_EVENT\_ENABLE**:

  ```sh
  export ASCEND_GLOBAL_EVENT_ENABLE=0
  ```

## Setting the System Log Level

For the Ascend EP form, use the msnpureport tool. For details, see [msnpureport Tool Usage Guide](https://support.huawei.com/enterprise/en/ascend-computing/ascend-hdk-pid-252764743?category=reference-guides&subcategory=command-reference).

<!-- npu="310b" id1 -->
For the Ascend RC form, on Atlas 200I/500 A2 inference products, use the `/etc/slog.conf` configuration file to set the global log level, module log level, and whether to enable event logs. For details, see [Viewing the Log Configuration File](viewing_config_file.md). After the settings are complete, restart the **slogd** process for the configuration to take effect. For details, see [Restarting Log Processes](restarting_log_processes.md).
<!-- end id1 -->

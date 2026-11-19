# ASCEND\_HOST\_LOG\_FILE\_NUM

<!-- md-trans-meta sourceCommit=e1bc2bb7763ac16f654082dfdfe03fc13da9ccab translatedAt=2026-10-22T09:25:26.062Z pushedAt=2026-10-23T07:34:58.057Z -->

## Description

Sets the number of log files stored for each process in the application log directories (**plog** and **device-id**) in Ascend EP scenarios.

The value range of the environment variable is \[1, 1000\], and the default value is **10**.

> [!NOTE]Note
>
>- You can run the **echo $ASCEND\_HOST\_LOG\_FILE\_NUM** command to view the value set for the environment variable.
>- If the environment variable is not set, is set to an invalid value, or is set as empty, the default log value is used.
>- If the number of log files stored for a single process in the **plog** and **device-id** log directories exceeds the set value, the earliest log files are automatically deleted. In addition, the maximum size of each plog-_pid_\_\*.log or device-_pid_\_\*.log file is fixed at 20 MB. If this value is exceeded, a new log file is generated.

## Configuration Example

```sh
export ASCEND_HOST_LOG_FILE_NUM=20
```

## Constraints

Applies only to Ascend EP.

## Supported Models

Supported on all chips.

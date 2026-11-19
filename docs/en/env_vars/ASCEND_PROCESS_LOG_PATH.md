# ASCEND\_PROCESS\_LOG\_PATH

<!-- md-trans-meta sourceCommit=e1bc2bb7763ac16f654082dfdfe03fc13da9ccab translatedAt=2026-10-22T09:28:25.086Z pushedAt=2026-10-23T07:59:49.097Z -->

## Description

Sets the log storage path.

If the directory does not exist when logs are stored, it is automatically created; if it exists, logs are stored directly.

> [!NOTE]Note
>
>- You can run the **echo $ASCEND\_PROCESS\_LOG\_PATH** command to view the path set by the environment variable.
>- The log storage priority is as follows: **ASCEND\_PROCESS\_LOG\_PATH** \> **ASCEND\_WORK\_PATH** \> default log storage path (**$HOME/ascend/log**).

## Configuration Example

```sh
export ASCEND_PROCESS_LOG_PATH=$HOME/log/
```

You can specify the log storage path as any directory with read and write permissions.

## Constraints

Applicable only to Ascend EP mode.

## Supported Models

Supported on all chips.

# ASCEND\_SLOG\_PRINT\_TO\_STDOUT (Deprecated)

<!-- md-trans-meta sourceCommit=79db1b25b472897c1e33eb43e45447608394e7c3 translatedAt=2026-10-22T09:30:01.133Z pushedAt=2026-10-23T08:12:05.313Z -->

> [!WARNING]Deprecation Notice
>
> The **ASCEND\_SLOG\_PRINT\_TO\_STDOUT** environment variable is marked as deprecated in CANN 9.2.0 and will be removed in a version after September 30, 2027. It is replaced by [ASCEND\_LOG\_PRINT\_TO\_STDOUT](ASCEND_LOG_PRINT_TO_STDOUT.md).
>
> It is not recommended for users to use it, to prevent compatibility issues. If both are configured, **ASCEND\_LOG\_PRINT\_TO\_STDOUT** takes precedence.

## Description

Enables or disables host-side application log printing. When enabled, logs are not saved to a log file but are directly printed and displayed.

The value can be:

- **0**: disable log printing. Logs are output in the default mode and saved to a log file.
- **1**: enable log printing.
- Other values are invalid.

> [!NOTE]Note
>
>- You can run the **echo $ASCEND\_SLOG\_PRINT\_TO\_STDOUT** command to view the value of the environment variable.
>- If the environment variable is not set, is set to an invalid value, or is set as empty, logs are output in the default mode.

## Configuration Example

```sh
export ASCEND_SLOG_PRINT_TO_STDOUT=1
```

## Constraints

None

## Supported Models

Supported on all chips.

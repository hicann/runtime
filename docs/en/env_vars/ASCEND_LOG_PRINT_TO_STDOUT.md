# ASCEND\_LOG\_PRINT\_TO\_STDOUT

<!-- md-trans-meta sourceCommit=a3cc8c30b1cd2ab56503d181b5c3b81ab57f58ed translatedAt=2026-10-22T09:26:41.093Z pushedAt=2026-10-23T07:38:41.349Z -->

## Description

Enables or disables application log printing on the host. When enabled, logs are not saved to a log file but are directly printed and displayed.

The value can be:

- **0**: disable log printing. Logs are output in the default mode and saved to a log file.
- **1**: enable log printing.
- Other values are invalid.

> [!NOTE]Note
>
>- You can run the **echo $ASCEND\_LOG\_PRINT\_TO\_STDOUT** command to view the value set for the environment variable.
>- If the environment variable is not set, is set to an invalid value, or is set as empty, logs are output in the default mode.

## Configuration Example

```sh
export ASCEND_LOG_PRINT_TO_STDOUT=1
```

## Constraints

None

## Supported Models

Supported on all chips.

# ASCEND\_LOG\_SYNC\_SAVE

<!-- md-trans-meta sourceCommit=e1bc2bb7763ac16f654082dfdfe03fc13da9ccab translatedAt=2026-10-22T09:27:26.803Z pushedAt=2026-10-23T07:40:25.409Z -->

## Description

Sets the log congestion processing mode.

- **0**: default processing mode. In the case of log congestion or poor I/O access performance, the system may lose logs to prevent service performance deterioration.
- **1**: no logs are lost in the case of log congestion or poor I/O access performance. In this mode, it is recommended to set the value to **1** for easier problem locating.

> [!NOTE]Note
> If the user adjusts the log level through **ASCEND\_GLOBAL\_LOG\_LEVEL** or **ASCEND\_MODULE\_LOG\_LEVEL**, the system processes logs in the no-log-loss mode.

## Configuration Example

```sh
export ASCEND_LOG_SYNC_SAVE=1
```

## Constraints

Applicable only to the Ascend EP form.

## Supported Models

Supported on all chips.

# ASCEND\_GLOBAL\_LOG\_LEVEL

<!-- md-trans-meta sourceCommit=e1bc2bb7763ac16f654082dfdfe03fc13da9ccab translatedAt=2026-10-22T09:25:26.732Z pushedAt=2026-10-23T07:30:33.674Z -->

## Description

Sets the log level of application logs and the log level of each module. Only debug logs are supported.

The value can be:

- **0**: DEBUG level.
- **1**: INFO level.
- **2**: WARNING level.
- **3**: ERROR level, which is the default level.
- **4**: NULL level, in which no logs are output.
- Other values are invalid.

> [!NOTE]Note
>
>- You can run the **echo $ASCEND_GLOBAL_LOG_LEVEL** command to view the log level set for the environment variable.
>- If the environment variable is not set, is set to an invalid value, or is set as empty, the default log level is used.
>- After the log level is set to DEBUG, service performance may be affected due to excessive log traffic.

## Configuration Example

```sh
export ASCEND_GLOBAL_LOG_LEVEL=1
```

## Constraints

None

## Supported Models

Supported on all chips.

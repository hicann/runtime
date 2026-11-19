# ASCEND\_GLOBAL\_EVENT\_ENABLE

<!-- md-trans-meta sourceCommit=e1bc2bb7763ac16f654082dfdfe03fc13da9ccab translatedAt=2026-10-22T09:25:57.853Z pushedAt=2026-10-23T07:27:39.419Z -->

## Description

Sets whether to enable the event log for application logs.

The value can be:

- **0**: disable the event log.
- **1**: enable the event log. The default value is **1**.
- Other values are invalid values.

> [!NOTE]Note
>
>- You can run the **echo $ASCEND_GLOBAL_EVENT_ENABLE** command to view the value set for the environment variable.
>- If the environment variable is not set, is set to an invalid value, or is set as empty, the default value is used.

## Configuration Example

```sh
export ASCEND_GLOBAL_EVENT_ENABLE=0
```

## Constraints

None

## Supported Models

Supported on all chips.

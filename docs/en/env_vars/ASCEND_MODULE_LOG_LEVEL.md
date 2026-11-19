# ASCEND\_MODULE\_LOG\_LEVEL

<!-- md-trans-meta sourceCommit=e1bc2bb7763ac16f654082dfdfe03fc13da9ccab translatedAt=2026-10-22T09:27:33.831Z pushedAt=2026-10-23T07:48:50.838Z -->

## Description

Sets the log level of each module for application logs. Only debug logs are supported.

The format is: export ASCEND\_MODULE\_LOG\_LEVEL=_module\_name_=_module\_level_

- _module\_name_: module name. It can be set to **GE**, **ASCENDCL**, **DRV**, **RUNTIME**, and so on. For details, see the CANN software installation directory **/include/base/log\_types.h**.
- _module\_level_: log level of the corresponding module. The value can be:
  - **0**: DEBUG level.
  - **1**: INFO level.
  - **2**: WARNING level.
  - **3**: ERROR level.
  - **4**: NULL level, which means no logs are output.
  - Other values are invalid.

> [!NOTE]Note
>
>- Do not add spaces before or after the equal sign (=), and use an English colon (:) without spaces before or after it. If you set log levels for multiple modules, separate them with colons. If the command line format is incorrect (for example, it contains symbols other than the equal sign and colon) or includes unsupported module names, the entire command line does not take effect.
>- You can run the **echo $ASCEND\_MODULE\_LOG\_LEVEL** command to view the log level set by the environment variable.
>- If the environment variable is not set, is set to an invalid value, or is set as empty, the global log level is used. The **ASCEND\_MODULE\_LOG\_LEVEL** environment variable has a higher priority than **ASCEND\_GLOBAL\_LOG\_LEVEL**. That is, if both are set, **ASCEND\_MODULE\_LOG\_LEVEL** takes effect.
>- After the log level is set to DEBUG, service performance may be affected due to excessive log traffic.
>- This environment variable takes effect only for debug logs, and does not take effect for runtime logs or security logs.

## Configuration Example

```sh
export ASCEND_MODULE_LOG_LEVEL=TBE=0:RUNTIME=0
```

## Constraints

None

## Supported Models

Supported on all chips.

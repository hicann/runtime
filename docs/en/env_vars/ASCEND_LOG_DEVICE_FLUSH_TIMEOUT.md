# ASCEND\_LOG\_DEVICE\_FLUSH\_TIMEOUT

<!-- md-trans-meta sourceCommit=e1bc2bb7763ac16f654082dfdfe03fc13da9ccab translatedAt=2026-10-22T09:26:41.345Z pushedAt=2026-10-23T07:50:13.385Z -->

## Description

Sets the delay time for sending application logs from the device to the host.

Before a service process exits, the system has a default delay of 2000 ms to send application logs from the device to the host. After the timeout, the service process exits. Logs that are not sent to the host are directly stored to the disk on the device (the path is **/var/log/npu/slog**). This environment variable can be used to change the delay time. The value range is \[0, 180000\], in ms, and the default value is **2000**.

> [!NOTE]Note
>
>- You can run the **echo $ASCEND\_LOG\_DEVICE\_FLUSH\_TIMEOUT** command to view the value set for the environment variable.
>- If the environment variable is not set, is set to an invalid value, or is set as empty, the default log value is used.
>- If the service process does not need to wait for all device-side application logs to be sent to the host side, set the environment variable to **0**.
>- If device-side application logs remain unsent to the host side after the service process exits, you are advised to set a larger delay time. The specific value can be determined based on the log content of **device-app-pid**.

## Configuration Example

```sh
export ASCEND_LOG_DEVICE_FLUSH_TIMEOUT=5000
```

## Constraints

Applies only to the Ascend EP standard form.

## Supported Models

Supported on all chips.

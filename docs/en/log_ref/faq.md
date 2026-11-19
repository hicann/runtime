# FAQs

<!-- md-trans-meta sourceCommit=31ae292a88c1a38674abaa350b60eba724bab178 translatedAt=2026-10-22T09:32:39.913Z pushedAt=2026-10-23T11:03:06.631Z -->

## Logs Not Stored to a Disk Normally

### Ascend EP Standard Form

#### Failure to Export Device-Side System Logs Using the msnpureport Tool

If exporting device-side system logs using the msnpureport tool fails, perform the following steps:

1. After running the msnpureport tool command on the host, check the printed prompt information to locate the issue.

    If the issue persists, proceed to step 2.

2. On the host, run the following command to check whether the disk space of the host-side log storage path (the path where the msnpureport tool is run) is full:

    ```sh
    df -h
    ```

3. If the issue persists, obtain the logs and click [support](https://www.hiascend.com/support) to contact technical support.

#### Application Logs Not Stored to a Disk Normally

If application logs are not stored to a disk (including the `plog` logs and `device-id` logs in the **"$HOME/ascend/log/"** directory), perform the following steps:

1. Run the following command to view whether there are related error logs in the **"/var/log/messages"** file on the host:

    aarch64 architecture:

    ```sh
    cat /var/log/messages
    ```

    x86\_64 architecture:

    ```sh
    cat /var/log/syslog
    ```

    If the issue persists, proceed to step 2.

2. Run the following command on the host to view whether the disk space where the log storage path (**"$HOME/ascend/log/"**) resides is full:

    ```sh
    df -h
    ```

    If the issue persists, proceed to step 3.

3. On the host, use the msnpureport tool to export the device-side system logs and view whether there are related error logs.

    For details about how to use the msnpureport tool to export device-side system logs, see [msnpureport Tool Usage Guide](https://support.huawei.com/enterprise/en/ascend-computing/ascend-hdk-pid-252764743?category=reference-guides&subcategory=command-reference).

4. If the issue persists, obtain the logs and click [support](https://www.hiascend.com/support) to contact technical support.

<!-- npu="310p" id1 -->
### Control CPU Open Mode

#### Application Logs Not Stored to a Disk Normally

If application logs are not stored to a disk, perform the following steps:

1. Run the following command to check whether the dynamic library that the application process depends on is correct:

    ```sh
    ldd xxx
    ```

   `xxx` indicates the binary application process.

2. Run the following command to check whether the disk space of the log storage path (**"/var/log/npu/slog"**) is full:

    ```sh
    df -h
    ```

3. Run the following command to check whether the **slogd** process exists:

    ```sh
    ps -elf | grep slogd
    ```

    If information about the **slogd** process is returned, the **slogd** process exists.

4. If all the preceding checks pass but application logs are still not stored to the disk, try [restarting the log process](restarting_log_processes.md).

#### System Logs Not Stored to a Disk Normally

If system logs fail to store to disk, perform the following steps:

1. Run the following command to check whether the related log processes (**slogd** and **sklogd**) exist:

    ```sh
    ps -elf | grep log
    ```

    If the process information is displayed, the related log processes already exist.

2. Run the following command to check whether the disk space of the log storage path (**"/var/log/npu/slog"**) is full:

    ```sh
    df -h
    ```

3. If all the preceding checks pass but system logs are still not stored to the disk normally, try [restarting the log processes](restarting_log_processes.md).
<!-- end id1 -->

<!-- npu="310b" id2 -->
### Ascend RC Mode

#### Application Logs Not Stored to a Disk Normally

If application logs are not stored to a disk normally, perform the following steps:

1. Run the following command to check whether the dynamic library that the application process depends on is correct:

    ```sh
    ldd xxx
    ```

   `xxx` indicates the binary application process.

2. Run the following command to check whether the disk space of the log storage path (**"/var/log/npu/slog"**) is full:

    ```sh
    df -h
    ```

3. Run the following command to check whether the **slogd** process exists:

    ```sh
    ps -elf | grep slogd
    ```

    If information about the **slogd** process is returned, the **slogd** process exists.

    <!-- npu="310b" id3 -->
    For Atlas 200I/500 A2 inference products, if the **slogd** process does not exist, obtain the logs and click [support](https://www.hiascend.com/support) to contact technical support.
    <!-- end id3 -->

4. If all the preceding checks pass but application logs are still not stored to the disk normally, try [restarting the log process](restarting_log_processes.md) to handle the log process startup exception.

#### System Logs Not Stored to a Disk Normally

If system logs are not stored to a disk, perform the following steps:

1. Run the following command to check whether the related log processes (**slogd** and **sklogd**) exist:

    ```sh
    ps -elf | grep log
    ```

    If process information is displayed, the related log processes exist.

    <!-- npu="310b" id4 -->
    For Atlas 200I/500 A2 inference products, if the processes do not exist, obtain the logs and click [support](https://www.hiascend.com/support) to contact technical support.
    <!-- end id4 -->

2. Run the following command to check whether the disk space of the log storage path (**"/var/log/npu/slog"**) is full:

    ```sh
    df -h
    ```

3. If all the preceding checks pass but system logs are still not stored to the disk, try [restarting the log processes](restarting_log_processes.md) to handle the log process startup exception.
<!-- end id2 -->

## Timestamp in Logs Is Incorrect After the Environment Time Zone Is Changed

**Symptom**

The timestamp in the log information is inconsistent with the time of the system environment.

**Possible causes**

The possible cause is that the user changed the time zone of the system environment after starting the AI task.

**Solution**

Method 1: Restart the AI task.

Method 2: Change the time zone of the system environment.

```sh
# View the current time zone setting.
timedatectl
# Set a new time zone. This example uses Asia/Shanghai.
sudo timedatectl set-timezone Asia/Shanghai
```

## Logs Are Still Displayed on the Screen When the Log Printing Environment Variable Is Not Set

**Symptom**

The user does not set the log printing environment variable (`export ASCEND_LOG_PRINT_TO_STDOUT=1`), but logs are still displayed on the screen.

**Possible causes**

After receiving a log message, the log module first determines whether to print it to the screen based on the environment variable. If printing to the screen is not required, the log module creates a socket to establish a connection with the **slogd** process and sends the log to the **slogd** process, which stores the log to disk. However, if the socket creation fails, the log is printed to the screen.

**Solution**

Socket creation failure is generally caused by the number of open files exceeding the system default maximum when the user executes test cases. You can run the `ulimit -a` and `lsof | wc -l` commands to view the system default maximum number of open files (that is, the value of the `open files` field) and the number of currently open files, respectively, and check whether the number of currently open files exceeds the limit. If the limit is exceeded, run the `ulimit -n <num>` command to set the maximum number of open files, ensuring that the number of currently open files does not exceed the limit.

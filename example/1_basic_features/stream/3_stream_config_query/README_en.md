# 3_stream_config_query

## Description

This sample demonstrates how to create a Stream with a specified priority and flags and query the Stream ID, flags, and priority after creation. The sample runs on a single Device and shows the basic flow of configured Stream creation and attribute query.

## Product Support

This sample supports the following products:

| Product | Supported |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | Yes |
| Atlas A3 training series products/Atlas A3 inference series products | Yes |
| Atlas A2 training series products/Atlas A2 inference series products | Yes |

## Compile and Run

1. Download the sample code to the environment where CANN is installed. Switch to the sample directory.

```bash
cd ${git_clone_path}/example/1_basic_features/stream/3_stream_config_query
```

2. Set environment variables.

```bash
# Replace ${install_root} with the CANN installation root directory. The default installation is in `/usr/local/Ascend`.
source ${install_root}/cann/set_env.sh
```

3. Run the following command to execute the sample.

```bash
bash run.sh
```

## CANN RUNTIME API

The key functionality points and their key interfaces involved in this sample are as follows:

- Initialization and Device Management
    - Call `aclInit` for ACL initialization.
    - Call `aclrtSetDevice` to specify the Device.
    - Call `aclrtResetDeviceForce` to reset the current Device.
    - Call `aclFinalize` for ACL finalization.
- Stream Configuration and Creation
    - Call `aclrtCreateStreamWithConfig` to create a Stream with the specified priority and flags.
- Stream Query and Synchronization
    - Call `aclrtStreamGetId` to query the Stream ID.
    - Call `aclrtStreamGetFlags` to query the Stream flags.
    - Call `aclrtStreamGetPriority` to query the Stream priority.
    - Call `aclrtSynchronizeStream` to wait for Stream tasks to finish.
    - Call `aclrtDestroyStream` to destroy the Stream.

## Sample Output

```text
[INFO]  Create stream with priority=0 flags=0 successfully
[INFO]  Stream id: 1
[INFO]  Stream flags: 0
[INFO]  Stream priority: 0
[INFO]  [SUCCESS] Stream config query sample completed successfully
[SUCCESS] Stream config query sample executed successfully.
```

# 0_simple_label

## Description

This sample demonstrates basic CANN Runtime Label management usage flow, including creating Label, assembling LabelList, setting Label on persistent Stream bound to model runtime instance, and executing Label switch by index in Device memory. After running, you can see logs for model runtime instance build, execution, and resource release completion.

## Product Support

This sample has the following support status on the following products:

| Product | Supported |
| --- | --- |
| Ascend 950PR/Ascend 950DT | Yes |
| Atlas A3 training series products/Atlas A3 inference series products | Yes |
| Atlas A2 training series products/Atlas A2 inference series products | Yes |

## Build and Run

For environment installation, environment variable configuration, and general running instructions, see [README](../../../README_en.md) in the example directory. You can execute `source <cann_path>/set_env.sh` beforehand to set CANN environment variables; if not set beforehand, `run.sh` automatically attempts to detect `ASCEND_INSTALL_PATH`, `ASCEND_HOME_PATH`, `$HOME/Ascend/cann`, `/usr/local/Ascend/cann`, and `/opt/Ascend/cann`.

After entering current sample directory, run the following command to execute the sample:

```bash
bash run.sh
```

## CANN RUNTIME API

Key features and interfaces in this sample:

- Initialization
    - Call `aclInit` interface to initialize configuration.
    - Call `aclFinalize` interface to deinitialize.
- Device and Context Management
    - Call `aclrtSetDevice` interface to specify Device for computation.
    - Call `aclrtCreateContext` interface to create Context.
    - Call `aclrtDestroyContext` interface to destroy Context.
    - Call `aclrtResetDeviceForce` interface to forcibly reset current computation Device and reclaim Device resources.
- Stream Management
    - Call `aclrtCreateStreamWithConfig` interface to create persistent Stream.
    - Call `aclrtCreateStream` interface to create Stream for executing model runtime instance.
    - Call `aclrtSynchronizeStream` interface to block waiting for Stream task execution completion.
    - Call `aclrtDestroyStream` interface to destroy Stream.
- Memory Management
    - Call `aclrtMalloc` interface to allocate Device memory.
    - Call `aclrtFree` interface to release Device memory.
- Data Transfer
    - Call `aclrtMemcpy` interface to write Host-side branch index to Device memory.
- Model Runtime Instance Management
    - Call `aclmdlRIBuildBegin` and `aclmdlRIBuildEnd` interfaces to start and end model runtime instance build.
    - Call `aclmdlRIBindStream` and `aclmdlRIUnbindStream` interfaces to bind and unbind persistent Stream.
    - Call `aclmdlRIEndTask` interface to mark task dispatch end on bound Stream.
    - Call `aclmdlRIExecuteAsync` interface to asynchronously execute model runtime instance.
    - Call `aclmdlRIDestroy` interface to destroy model runtime instance.
- Label Management
    - Call `aclrtCreateLabel` and `aclrtDestroyLabel` interfaces to create and release Label.
    - Call `aclrtCreateLabelList` and `aclrtDestroyLabelList` interfaces to assemble and release LabelList.
    - Call `aclrtSetLabel` interface to set Label on Stream bound to model runtime instance.
    - Call `aclrtSwitchLabelByIndex` interface to execute Label switch based on branch index in Device memory.

## Sample Output

```text
[INFO]  ACL initialized.
[INFO]  Device 0 selected.
[INFO]  Context created on device 0.
[INFO]  Persistent label stream created.
[INFO]  Execute stream created.
[INFO]  Model runtime instance build started.
[INFO]  Persistent label stream bound to the model runtime instance.
[INFO]  Allocated device memory for branch index.
[INFO]  Copied branch index 1 from host to device.
[INFO]  Created label 0.
[INFO]  Created label 1.
[INFO]  Created label list with 2 labels.
[INFO]  Submitted switch-label task with branch index 1.
[INFO]  Set label 0 on the persistent stream.
[INFO]  Set label 1 on the persistent stream.
[INFO]  Model runtime instance build finished.
[INFO]  Switch label executed successfully with branch index 1.
[INFO]  Run the simple_label sample successfully.
```
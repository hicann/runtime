## 1_msproftx

## Description
This sample demonstrates how to collect and save performance data to disk using msproftx extension interfaces. In addition to the instantaneous event `aclprofMark`, it also demonstrates the nested range marking using `aclprofPush` / `aclprofPop`, and the non-nested range marking using `aclprofRangeStart` / `aclprofRangeStop`, which facilitates comparison with common NVTX usage patterns.

## Product Support

This sample supports the following products:

| Product | Supported |
| --- | --- |
| Atlas A3 Training Series Products/Atlas A3 Inference Series Products | Yes |
| Atlas A2 Training Series Products/Atlas A2 Inference Series Products | Yes |

## Build and Run
For environment installation details and runtime details, see [README](../../../README_en.md) in the example directory.

Follow the steps below to run:

```bash
# Replace ${install_root} with the CANN installation root directory, which is installed in `/usr/local/Ascend` by default
source ${install_root}/cann/set_env.sh
export ASCEND_INSTALL_PATH=${install_root}/cann

# The run.sh for Profiling samples also reads ASCEND_HOME_PATH, please set it to the same path
export ASCEND_HOME_PATH=${install_root}/cann

# Build and run
bash run.sh
```

## CANN RUNTIME API

In this sample, the key functional points and their key interfaces are as follows:
- msproftx Mark Object Management
    - Call the `aclprofCreateStamp` interface to create an msproftx event mark object.
    - Call the `aclprofSetStampTraceMessage` interface to set a readable string description for the mark object.
    - Call the `aclprofDestroyStamp` interface to release the mark object.
- Event and Range Marking
    - Call the `aclprofMark` interface to record an instantaneous event.
    - Call the `aclprofPush` and `aclprofPop` interfaces to record nested ranges.
    - Call the `aclprofRangeStart` and `aclprofRangeStop` interfaces to record non-nested ranges.

## Known Issues

None.
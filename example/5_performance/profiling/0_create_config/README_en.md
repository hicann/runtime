## 0_create_config

## Description
This sample demonstrates how to collect and save performance data to disk. You can enable performance data collection by calling APIs, which automatically collects raw performance data. After successfully collecting raw performance data, you can copy the collected raw data to a development environment with tools installed for parsing, and visualize the parsed results of the raw performance data.

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

# Build and run
bash run.sh
```
## CANN RUNTIME API

In this sample, the key functional points and their key interfaces are as follows:
- Profiling Initialization and Configuration
    - Call the `aclprofInit` interface to initialize Profiling and set the performance data output path.
    - Call the `aclprofCreateConfig` interface to create a collection configuration.
    - Call the `aclprofSetConfig` interface to set collection parameters.
    - Call the `aclprofDestroyConfig` interface to release the Profiling configuration.
    - Call the `aclprofFinalize` interface to finalize Profiling.
- Profiling Collection Control
    - Call the `aclprofStart` interface to start Profiling data collection.
    - Call the `aclprofStop` interface to stop Profiling data collection.

## Sample Output

```text
[INFO]  -------- Start --------
[INFO]  profiling init done
[INFO]  profiling set config done
[INFO]  profiling start
[INFO]  model running ....
[INFO]  profiling stop and finalize done
[INFO]  -------- End --------
```

## Known Issues

   None

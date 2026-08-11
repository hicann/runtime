# 0_context_query

## Description

This sample demonstrates how to create a Context, set it as the current thread Context, and query the current Context, default Stream, and current thread resource limits in a single-device and single-thread scenario.

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
cd ${git_clone_path}/example/1_basic_features/context/0_context_query
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
- Context Management
    - Call `aclrtCreateContext` to create a Context.
    - Call `aclrtSetCurrentContext` to set the current thread Context.
    - Call `aclrtGetCurrentContext` to query the current thread Context.
    - Call `aclrtCtxGetCurrentDefaultStream` to query the default Stream of the current Context.
    - Call `aclrtDestroyContext` to destroy the Context.
- Resource Limit Query
    - Call `aclrtGetResInCurrentThread` to query the current thread resource limit.

## Sample Output

When the sample runs successfully, the output is as follows:

```text
[INFO]  Get current context successfully
[INFO]  Get current default stream successfully, stream=<stream_pointer>
[INFO]  Get current thread cube core limit: <cube_core_limit>
[INFO]  Get current thread vector core limit: <vector_core_limit>
[INFO]  [SUCCESS] Context query sample completed successfully
[SUCCESS] Context query sample executed successfully.
```

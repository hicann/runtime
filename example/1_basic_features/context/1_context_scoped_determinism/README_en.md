# 1_context_scoped_determinism

## Description

This sample demonstrates how a single-Device application observes the activation state of the default Context and configures different deterministic computation modes for two explicitly created Contexts. The sample switches between the Contexts and reads back their individual settings to verify scope isolation. Before exiting, it restores the original process-level setting.

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
cd ${git_clone_path}/example/1_basic_features/context/1_context_scoped_determinism
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
    - Call `aclrtGetPrimaryCtxState` to query whether the default Context is active.
    - Call `aclrtResetDeviceForce` to reset the current Device.
    - Call `aclFinalize` for ACL finalization.
- Process-level Deterministic Configuration
    - Call `aclrtGetSysParamOpt` to query the process-level deterministic computation setting.
    - Call `aclrtSetSysParamOpt` to set or restore the process-level deterministic computation setting.
- Context Management and Deterministic Configuration
    - Call `aclrtCreateContext` to create a Context.
    - Call `aclrtSetCurrentContext` to set the current thread Context.
    - Call `aclrtCtxSetSysParamOpt` to configure deterministic computation for the current Context.
    - Call `aclrtCtxGetSysParamOpt` to query the deterministic computation setting of the current Context.
    - Call `aclrtDestroyContext` to destroy a Context.

## Sample Output

When the sample runs successfully, the output is as follows:

```text
[INFO]  Default Context before aclrtSetDevice: inactive
[INFO]  Default Context after aclrtSetDevice: active
[INFO]  Saved process deterministic mode: 0
[INFO]  Process deterministic mode set to: 2
[INFO]  Context A deterministic mode: 1
[INFO]  Context B deterministic mode: 0
[INFO]  Context A deterministic mode after switching back: 1
[INFO]  Context B deterministic mode after switching back: 0
[INFO]  Context-scoped deterministic modes are isolated successfully
[INFO]  Restored process deterministic mode: 0
[INFO]  Default Context after aclrtResetDeviceForce: inactive
[INFO]  [SUCCESS] Context-scoped determinism sample completed successfully
[SUCCESS] Context-scoped determinism sample executed successfully.
```

# 0_reference_counted_plugin_lifecycle

## Description

This sample is intended for plugin developers who need to participate in the ACL lifecycle. It registers active and cancellable Initialization callbacks, unregisters the latter, and performs ACL Initialization plus a single-Device operation. It then registers active and cancellable Deinitialization callbacks, unregisters the latter, and deinitializes ACL through reference counting. The sample verifies that each active callback runs once, neither unregistered callback runs, Device 0 is selected, and the final reference count is 0. All interfaces are statically supported on Atlas A2, Atlas A3, and Ascend 950 series products.

## Product Support

| Product | Supported |
| --- | --- |
| Atlas A2 training series products/Atlas A2 inference series products | Yes |
| Atlas A3 training series products/Atlas A3 inference series products | Yes |
| Ascend 950PR/Ascend 950DT | Yes |

## Compile and Run

1. Download the sample code to the environment where CANN is installed, and switch to the sample directory.

```bash
cd ${git_clone_path}/example/0_quickstart/5_runtime_lifecycle_callbacks/0_reference_counted_plugin_lifecycle
```

2. Set the environment variables.

```bash
# Replace ${install_root} with the CANN installation root directory
source ${install_root}/set_env.sh
source ${git_clone_path}/example/set_sample_env.sh
```

3. Run the following command to compile and execute the sample.

```bash
bash run.sh
```

## CANN RUNTIME API

The key functionality points and their key interfaces involved in this sample are as follows:

- Initialization callback management
    - Call `aclInitCallbackRegister` to register plugin Initialization actions.
    - Call `aclInitCallbackUnRegister` to remove the Initialization action that must not run and to remove the active callback during cleanup.
- ACL lifecycle management
    - Call `aclInit` to initialize ACL and invoke the active Initialization callback.
    - Call `aclFinalizeCallbackRegister` to register plugin Deinitialization actions.
    - Call `aclFinalizeCallbackUnRegister` to remove the Deinitialization action that must not run and to remove the active callback during cleanup.
    - Call `aclFinalizeReference` to decrement the reference count, deinitialize ACL at zero, and invoke the active Deinitialization callback.
- Device operation verification
    - Call `aclrtSetDevice` to select Device 0 for this sample.
    - Call `aclrtGetDevice` to read back the current Device and verify the selection.
    - Call `aclrtResetDeviceForce` to reset Device 0 and reclaim its resources.

## Sample Output

```text
[INFO]  Start to run 0_reference_counted_plugin_lifecycle sample.
[INFO]  Initialization callbacks verified: active=1, cancelled=0.
[INFO]  Device 0 selected and verified.
[INFO]  Plugin lifecycle verified: active_init=1, cancelled_init=0, active_finalize=1, cancelled_finalize=0, reference=0.
[INFO]  Run the 0_reference_counted_plugin_lifecycle sample successfully.
```

# ASCEND\_RT\_LAUNCH\_BLOCKING

<!-- md-trans-meta sourceCommit=31ae292a88c1a38674abaa350b60eba724bab178 translatedAt=2026-10-22T09:29:10.518Z pushedAt=2026-10-23T08:18:12.025Z -->

## Description

Controls whether Kernel Launch and model execution tasks use synchronous or asynchronous mode. This can be used in operator debugging scenarios.

The value can be:

- **0**: disable. The APIs use asynchronous mode and return after task dispatch is complete, without waiting for task execution to finish.
- **1**: enable. The following APIs use synchronous mode and return after task execution is complete:
    - aclrtLaunchKernel
    - aclrtLaunchKernelV2
    - aclrtLaunchKernelWithConfig
    - aclrtLaunchKernelWithHostArgs
    - aclrtLaunchKernelWithArgsArray
    - aclrtLaunchSIMTKernelWithArgsArray
    - aclrtLaunchSIMTKernelWithHostArgs
    - aclmdlRIExecuteAsync
- Other values: same as when set to **0**.

>**Caution:**
>
>- This environment variable is disabled by default. When it is not set or is set as empty, the behavior is the same as when it is set to **0**.
>- After it is enabled, operators of earlier versions may not be adapted to this feature. If a task already dispatched in an operator depends on a task that has not yet been dispatched, synchronous waiting by the API will prevent subsequent tasks from being dispatched, which may cause a deadlock.
>- In the preceding scenario, you can call [aclrtNonBlockingLaunchBegin](../api_ref/06_stream_management.md#aclrtNonBlockingLaunchBegin) before dispatching tasks that have dependencies, and call [aclrtNonBlockingLaunchEnd](../api_ref/06_stream_management.md#aclrtNonBlockingLaunchEnd) after task dispatch is complete. Alternatively, you can call [aclrtSetStreamAttribute](../api_ref/06_stream_management.md#aclrtSetStreamAttribute), set **stmAttrType** to **ACL_STREAM_LAUNCH_BLOCKING_MODE**, and set **launchBlockingMode** to **ACL_STREAM_LAUNCH_BLOCKING_MODE_NON_BLOCKING**.
>- For streams created by calling the **aclrtCreateStreamWithConfig** API with **flag** set to **ACL_STREAM_PERSISTENT**, **ACL_STREAM_CPU_SCHEDULE**, or **ACL_STREAM_DEVICE_USE_ONLY**, this feature does not take effect.

## Configuration Example

```bash
export ASCEND_RT_LAUNCH_BLOCKING=1
```

## Constraints

- This environment variable does not support dynamic modification. Set it before calling any Runtime API. Modifications made after Runtime initialization do not take effect.
- Enabling this environment variable may affect service performance. It is recommended to use it only in operator debugging scenarios.

<!-- npu="950,A3,910b" id1 -->
## Supported Models

<!-- npu="950" id2 -->
Ascend 950PR&950DT products
<!-- end id2 -->

<!-- npu="A3" id3 -->
Atlas A3 products
<!-- end id3 -->

<!-- npu="910b" id4 -->
Atlas A2 products
<!-- end id4 -->
<!-- end id1 -->

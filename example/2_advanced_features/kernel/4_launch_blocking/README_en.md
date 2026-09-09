# 4_launch_blocking

## Description

This sample demonstrates how to control synchronous and asynchronous Kernel Launch behavior through a process-wide default policy, a per-stream policy, and a temporary non-blocking section.

- Environment control: starts separate processes with `ASCEND_RT_LAUNCH_BLOCKING=0` and `ASCEND_RT_LAUNCH_BLOCKING=1` to verify asynchronous and synchronous launch modes.
- Per-stream control: sets `ACL_STREAM_LAUNCH_BLOCKING_MODE_CTRL_BY_ENV`, `ACL_STREAM_LAUNCH_BLOCKING_MODE_NON_BLOCKING`, and `ACL_STREAM_LAUNCH_BLOCKING_MODE_BLOCKING` through `aclrtSetStreamAttribute` and verifies whether the stream inherits or overrides the environment setting.
- Temporary non-blocking section: nests `aclrtNonBlockingLaunchBegin` and `aclrtNonBlockingLaunchEnd` while synchronous mode is enabled. Kernel launches inside the section remain asynchronous.

The sample delays the target stream with a Notify and runs an Ascend C kernel with verifiable output. It determines whether the policy takes effect from the stream status and computation result after Kernel Launch returns; elapsed time is printed for observation only. `run.sh` builds the sample once and starts a new process for each environment configuration.

## Supported Products

This sample supports the following products:

| Product | Supported |
| --- | --- |
| Ascend 950PR/Ascend 950DT | Yes |
| Atlas A3 training series products/Atlas A3 inference series products | Yes |
| Atlas A2 training series products/Atlas A2 inference series products | Yes |

## Build and Run

1. Download the sample to an environment where CANN is installed and switch to the sample directory.

```bash
cd ${git_clone_path}/example/2_advanced_features/kernel/4_launch_blocking
```

2. Set the environment variables.

```bash
# Replace ${install_root} with the CANN installation root. The default is /usr/local/Ascend.
source ${install_root}/cann/set_env.sh
```

3. Build and run all scenarios.

```bash
bash run.sh
```

Runtime reads the environment variable during initialization, so it cannot be switched in one process. Do not export a fixed `ASCEND_RT_LAUNCH_BLOCKING` value before running `run.sh`; the script sets it separately for each scenario.

## Scenarios

| Scenario | Environment | Expected behavior |
| --- | --- | --- |
| `env-control` | `0` | Kernel Launch returns asynchronously; the result is correct after explicit synchronization |
| `env-control` | `1` | Kernel Launch returns after the stream completes; the result is correct |
| `stream-mode` | `0` and `1` | `CTRL_BY_ENV` follows the environment, `NON_BLOCKING` forces asynchronous launch, and `BLOCKING` forces synchronous launch |
| `non-blocking-section` | `1` | Launches remain asynchronous in the nested section; the inner `End` does not synchronize, and the outermost `End` restores the synchronous policy and waits for the stream |

## Control Rules and Notes

Kernel Launch blocking behavior is determined in the following priority order:

1. Kernel Launch remains asynchronous while the stream is inside a non-blocking section marked by `aclrtNonBlockingLaunchBegin` and `aclrtNonBlockingLaunchEnd`.
2. `ACL_STREAM_LAUNCH_BLOCKING_MODE_NON_BLOCKING` or `ACL_STREAM_LAUNCH_BLOCKING_MODE_BLOCKING` set on a stream overrides the environment variable.
3. When the stream mode is `ACL_STREAM_LAUNCH_BLOCKING_MODE_CTRL_BY_ENV`, `ASCEND_RT_LAUNCH_BLOCKING` determines the behavior.

Observe the following requirements:

- Runtime reads `ASCEND_RT_LAUNCH_BLOCKING` during initialization. Restart the process after changing it.
- `aclrtNonBlockingLaunchBegin` and `aclrtNonBlockingLaunchEnd` must be paired on the same stream. `flag` is reserved and must be `0`.
- Non-blocking sections can be nested. An inner `End` only decreases the nesting depth. The outermost `End` leaves the section and waits for the stream when the restored policy requires synchronous execution.
- A `nullptr` `stream` argument represents the default stream of the current Context.
- Model streams, bound streams, streams in the capture stage, and some special streams do not support per-stream Launch Blocking control.
- This sample demonstrates `aclrtLaunchKernel` on a regular stream. Asynchronous memory copies and Event APIs do not become synchronous because of this feature.

## CANN RUNTIME APIs

The sample uses the following key functions and APIs:

- Initialization and Device management
  - `aclInit` / `aclFinalize`
  - `aclrtSetDevice` / `aclrtResetDevice`
- Stream and Launch Blocking control
  - `aclrtCreateStream` / `aclrtDestroyStream`
  - `aclrtSetStreamAttribute` / `aclrtGetStreamAttribute`
  - `aclrtNonBlockingLaunchBegin` / `aclrtNonBlockingLaunchEnd`
  - `aclrtStreamQuery` / `aclrtSynchronizeStreamWithTimeout`
- Kernel loading and execution
  - `aclrtBinaryLoadFromFile` / `aclrtBinaryGetFunction` / `aclrtBinaryUnLoad`
  - `aclrtLaunchKernel`
- Notify control
  - `aclrtCreateNotify` / `aclrtWaitAndResetNotify`
  - `aclrtRecordNotify` / `aclrtDestroyNotify`
- Memory management and data transfer
  - `aclrtMalloc` / `aclrtFree`
  - `aclrtMemcpy` / `aclrtMemset`

## Sample Output

```text
========== ASCEND_RT_LAUNCH_BLOCKING=0, scenario=env-control ==========
[ENV] ASCEND_RT_LAUNCH_BLOCKING=0
[STATUS] environment control: NOT_READY
[PASS] environment control
[SUCCESS] env-control
...
========== ASCEND_RT_LAUNCH_BLOCKING=1, scenario=non-blocking-section ==========
[STATUS] inside nested section: NOT_READY
[STATUS] after inner end: NOT_READY
[STATUS] after outer end: COMPLETE
[PASS] nested non-blocking section
[STATUS] blocking restored after outer end: COMPLETE
[SUCCESS] non-blocking-section
All launch blocking scenarios passed.
```

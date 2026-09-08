# 4_launch_blocking

## Description

This sample demonstrates three ways to control Kernel Launch Blocking. It delays the target stream with a Notify, runs an Ascend C kernel with verifiable output, and checks both the stream status and computation result after each launch.

- Environment control: starts separate processes with `ASCEND_RT_LAUNCH_BLOCKING=0` and `ASCEND_RT_LAUNCH_BLOCKING=1` to verify asynchronous and synchronous launch modes.
- Per-stream modes: sets `DEFAULT`, `ASYNC`, and `SYNC` through `aclrtSetStreamAttribute` to verify that a stream either inherits or overrides the environment setting.
- Asynchronous execution range: nests `aclrtNonBlockingLaunchBegin` and `aclrtNonBlockingLaunchEnd` while synchronous mode is enabled. Kernel launches between the two APIs remain asynchronous, the inner `End` does not synchronize, and the outermost `End` synchronizes the stream and restores synchronous mode for subsequent launches.

`run.sh` builds the sample once and starts a new process for each environment configuration.

## Supported Products

This sample supports the following products:

| Product | Supported |
| --- | --- |
| Atlas A2 Training Series Products/Atlas 800I A2 Inference Products/A200I A2 Box Heterogeneous Components | Yes |
| Ascend 950PR/Ascend 950DT | Yes |

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
| `non-blocking-section` | `1` | Nested launches are asynchronous, the outermost `End` synchronizes, and synchronous mode is restored afterward |

## CANN Runtime APIs

- `aclrtSetStreamAttribute` and `aclrtGetStreamAttribute`: set and query the `ACL_STREAM_LAUNCH_BLOCKING_MODE` stream attribute.
- `aclrtNonBlockingLaunchBegin` and `aclrtNonBlockingLaunchEnd`: mark the start and end points of asynchronous execution for the affected APIs on a stream.
- `aclrtLaunchKernel`: launch the custom kernel.
- `aclrtCreateNotify`, `aclrtWaitAndResetNotify`, and `aclrtRecordNotify`: create a controlled stream wait.
- `aclrtStreamQuery`: inspect the stream status after a Kernel Launch or asynchronous execution range API returns.
- `aclrtSynchronizeStreamWithTimeout`: wait for an asynchronous kernel to complete.

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

The sample uses a Notify to create a deterministic wait. Stream status and output data determine whether it passes; elapsed times in the logs are informational only.

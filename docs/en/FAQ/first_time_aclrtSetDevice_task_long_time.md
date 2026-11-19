# Long Duration of the First aclrtSetDevice Call

<!-- md-trans-meta sourceCommit=31ae292a88c1a38674abaa350b60eba724bab178 translatedAt=2026-10-16T09:58:51.041Z pushedAt=2026-10-22T09:05:41.293Z -->

## Symptoms

**Symptom 1: The first call to aclrtSetDevice by a service process incurs second-level latency**

When a service process calls the **aclrtSetDevice** API for the first time, the call takes noticeably longer (second-level latency), whereas subsequent calls to the same API are significantly faster (millisecond-level).

**Symptom 2: In multi-process scenarios, the first aclrtSetDevice call of each process exhibits jitter**

When multiple service processes call **aclrtSetDevice** concurrently, the first-call latency of each process is inconsistent and exhibits noticeable jitter, and the latency of some processes may increase further.

**Symptom 3: The first aclrtSetDevice call of subsequent processes is significantly faster**

After an existing process completes **aclrtSetDevice**, the first call to **aclrtSetDevice** by a newly started service process takes significantly less time, because the result of operator package migration can be shared across processes.

## Possible Causes

1. **Operator package migration overhead**: During the first call to **aclrtSetDevice**, the operator package must be migrated from the host side to the device side, which involves file transfer and deployment and is one of the main sources of latency.
2. **aicpu_scheduler process startup**: During the first call to **aclrtSetDevice**, the corresponding **aicpu_scheduler** scheduling process must be started on the device side for the service process. The **aicpu_scheduler** process of each service process is independent of one another and cannot be shared. Each process starts its own **aicpu_scheduler** separately, and process creation and initialization introduce additional latency.
3. **Impact of concurrency and device load**: When multiple processes call **aclrtSetDevice** concurrently, operator package migration and **aicpu_scheduler** process startup are affected by resource competition and load on the device side, causing latency jitter in the API.

## Handling

### Cause 1: Operator Package Migration Overhead

**Solution**:

- Understand the migration mechanism: On the first call to **aclrtSetDevice**, Runtime transfers the operator package required by the service from the host side to the device side and deploys it. This process involves file I/O operations and device-side writes, and the time consumed is positively correlated with the operator package size.
- Leverage the migration cache: After the operator package is successfully migrated, it is cached on the device side. If different service processes use the same operator package version, the first **aclrtSetDevice** call of subsequent processes does not involve repeated migration, and the time consumed is significantly reduced.
- Keep the operator package version consistent: Ensure that multiple service processes use the same version of the CANN operator package to maximize sharing of the migration cache.
- Use a warm-up policy: Arrange a lightweight process to execute **aclrtSetDevice** first during the service startup phase to complete the operator package migration, so that subsequent service processes can benefit from the acceleration.

### Cause 2: aicpu_scheduler Process Startup

**Solution**:

- Understand the startup mechanism: **aicpu_scheduler** is the AICPU task scheduling process on the device side. On the first call to **aclrtSetDevice**, Runtime automatically starts it for the current service process, and it is responsible for scheduling the AICPU operator tasks of that process. Process creation, initialization, and readiness confirmation all take time.
- The **aicpu_scheduler** process of each service process is independent and cannot be shared: Each service process starts its own **aicpu_scheduler** process on its first call to **aclrtSetDevice**, and this overhead cannot be eliminated by warm-up through other processes.
- If you are sensitive to first-call latency, call **aclrtSetDevice** in advance during the service initialization phase to complete warm-up, moving the latency off the critical path.

### Cause 3: Impact of Concurrency and Device Load

**Solution**:

- Avoid simultaneous initialization under high concurrency: When multiple service processes call **aclrtSetDevice** at the same time, resource competition arises during operator package migration and **aicpu_scheduler** process startup, increasing the waiting time of each process.
- Stagger initialization: Properly arrange the startup sequence of each service process to avoid concentrated calls to **aclrtSetDevice** at the same moment.
- Reduce the load on the device side: Before calling **aclrtSetDevice**, avoid dispatching a large number of computation tasks to the device to reduce the impact of resource competition on initialization latency.

## Related Issues

None

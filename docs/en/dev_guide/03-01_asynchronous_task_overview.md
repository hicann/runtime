# Asynchronous Task Overview

<!-- md-trans-meta sourceCommit=c984fae7c73f88f7e9e16b034bea72bc18e7517c translatedAt=2026-10-16T10:11:20.356Z pushedAt=2026-10-19T08:03:39.007Z -->

Runtime treats the following operations as independent tasks that can be executed concurrently with one another:

- Host computation
- Device computation
- Host-to-device memory copy
- Device-to-host memory copy
- Intra-device memory copy
- Inter-device memory copy

The actual degree of concurrency among these operations depends on the feature set and computing capability of the device, as described below:

1. Concurrent execution of the host and the device

    Host concurrency is achieved through asynchronous APIs: the API returns control to the host thread before the device completes the task. By using asynchronous calls, you can queue multiple device operations at once, which are then executed when device resources become available. This reduces the management burden on the host thread and allows it to perform other tasks. The following device operations are asynchronous with respect to the host:

    - Kernel execution
    - Model run instance execution
    - Compute tasks whose API names contain "Async"
    - Memory copy operations whose API names contain "Async". When non-pinned host memory is involved, asynchronous memory copy may degrade to synchronous.

2. Concurrent execution of multiple kernels

    Multiple kernels dispatched in the same context can be executed concurrently, and multiple kernels across different contexts can also be executed concurrently. The task scheduler performs unified scheduling based on stream priorities and the busy/idle state of AI Cores.

3. Concurrent execution of tasks on different accelerators

    In addition to AI Cores, the device also provides other hardware accelerators, such as AI CPU, Digital Vision Pre-Processing (DVPP), and Random (random number generator). Tasks on different accelerators are executed concurrently. Different generations of AI processors support different hardware accelerators. For details, see the actual hardware user manual.

4. Concurrency of data transfer and computation tasks

    Data transfer has an independent Direct Memory Access (DMA) engine and can be executed concurrently with computation tasks.

5. Bidirectional data transfer

    Data transfer from the host to device and from the device to host can be executed concurrently.

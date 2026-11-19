# Introduction to CANN Runtime

<!-- md-trans-meta sourceCommit=f27ca703aef442726cc28a36cb0f8ecff75fe506 translatedAt=2026-11-11T06:27:42.050Z pushedAt=2026-11-16T03:59:49.454Z nl=2 -->

CANN Runtime is the core component in the CANN software stack responsible for driving hardware execution and managing AI computation tasks. By providing unified APIs, it enables upper-layer applications, AI frameworks, and acceleration libraries to efficiently utilize the hardware computation resources of AI processors.
<br>
<br>

## Typical Application Example

The following uses the pseudocode of a vector addition operator (VectorAdd, which implements the computation of `result = x + alpha * y`) to demonstrate the complete process of invoking an operator using CANN Runtime. For the actual runnable code of this example, see the [hello_cann sample](../../../example/0_quickstart/0_hello_cann/main.cpp).

```c
#include "acl/acl.h"

int main() {
    // 1. Initialize Runtime.
    aclInit(nullptr);

    // 2. Set a compute device.
    int32_t deviceId = 0;
    aclrtSetDevice(deviceId);  // Create the default context and default stream.

    // 3. Create a stream.
    aclrtStream stream;
    aclrtCreateStream(&stream);

    // 4. Request device memory.
    size_t bufferSize = 8 * sizeof(float);  // Eight float elements
    float *xDevice, *yDevice, *resultDevice;
    aclrtMalloc(&xDevice, bufferSize, ACL_MEM_MALLOC_HUGE_FIRST);
    aclrtMalloc(&yDevice, bufferSize, ACL_MEM_MALLOC_HUGE_FIRST);
    aclrtMalloc(&resultDevice, bufferSize, ACL_MEM_MALLOC_HUGE_FIRST);

    // 5. Prepare host data and copy it to the device.
    float xHost[8] = {1.0f, 2.0f, 3.0f, 4.0f, 5.0f, 6.0f, 7.0f, 8.0f};
    float yHost[8] = {0.5f, 1.0f, 1.5f, 2.0f, 2.5f, 3.0f, 3.5f, 4.0f};
    float alpha = 1.0f;

    aclrtMemcpy(xDevice, bufferSize, xHost, bufferSize, ACL_MEMCPY_HOST_TO_DEVICE);
    aclrtMemcpy(yDevice, bufferSize, yHost, bufferSize, ACL_MEMCPY_HOST_TO_DEVICE);

    // 6. Call aclnnAdd(...) to dispatch the computation task.

    // 7. Synchronously wait for computation to complete.
    aclrtSynchronizeStream(stream);

    // 8. Copy the result back to the host.
    float resultHost[8];
    aclrtMemcpy(resultHost, bufferSize, resultDevice, bufferSize, ACL_MEMCPY_DEVICE_TO_HOST);

    // 9. Release resources.
    aclrtFree(xDevice);
    aclrtFree(yDevice);
    aclrtFree(resultDevice);
    aclrtDestroyStream(stream);
    aclrtResetDeviceForce(deviceId);
    aclFinalize();

    return 0;
}
```

### Code Analysis

The preceding call example demonstrates the core steps of Runtime programming. Each step corresponds to a different functional module of Runtime.

| Step | Operation                | Runtime Capability | Description                                                         |
| ---- | ------------------------ | ------------------ | ------------------------------------------------------------------- |
| 1    | `aclInit`                | **Runtime global management** | Initializes the Runtime environment and loads configurations. |
| 2    | `aclrtSetDevice`         | **Device management** | Specifies the compute device and creates the default context and stream. |
| 3    | `aclrtCreateStream`      | **Stream management** | Creates a task execution queue for asynchronous task dispatch. |
| 4    | `aclrtMalloc`            | **Memory management** | Requests memory on the device to store computation data. |
| 5    | `aclrtMemcpy`            | **Memory management** | Transfers data between the host and the device. |
| 6    | Call the `aclnnAdd` operator function | **Kernel management** | The **aclnnAdd** function uses the kernel management capability of Runtime to dispatch the operator execution task to the stream. |
| 7    | `aclrtSynchronizeStream` | **Stream management** | Synchronously waits for tasks on the stream to complete. |
| 8    | `aclrtMemcpy`            | **Memory management** | Copies the computation results from the device back to the host. |
| 9    | Resource release         | **Resource management** | Releases memory, stream, and device resources. |

<br>

### Core Programming Mode

Runtime adopts the **host-device asynchronous parallel** programming mode:

1. **Host-device separation**: The host (CPU) is responsible for task orchestration and dispatch, while the device (NPU) is responsible for computation. Each has its own independent memory space.
2. **Asynchronous task dispatch**: After the host calls an operator API, it returns immediately without waiting for the device to finish execution. Once a task is dispatched to the stream queue, the device executes it asynchronously.
3. **Explicit synchronization**: When the host needs to obtain the computation result, it calls a synchronization API to block and wait for the device task to complete.

This mode effectively hides host processing time and data transfer latency, enabling the host and device to work in parallel and improving overall throughput.

<br>
<br>

## Runtime Functional Architecture

As shown in the preceding example, Runtime provides the following core functional modules around the execution lifecycle of compute tasks.

| Functional Module | Core Capability | Key API |
| ------------------ | ------------------------------------ | ---------------------------------------------- |
| **Runtime global management** | Initialization/deinitialization, process-level configuration, and DFX features | `aclInit`, `aclFinalize` |
| **Device management** | Device setting, reset, query, and configuration | `aclrtSetDevice`, `aclrtResetDevice`, `aclrtResetDeviceForce` |
| **Context management** | Context creation, destruction, and switching | `aclrtCreateContext`, `aclrtSetCurrentContext` |
| **Stream management** | Stream creation, destruction, and synchronization, and attribute configuration | `aclrtCreateStream`, `aclrtSynchronizeStream` |
| **Memory management** | Device and host memory request/release/copy | `aclrtMalloc`, `aclrtMemcpy` |
| **Kernel management** | Operator loading, registration, and execution | `<<< >>>` syntax, `aclrtLaunchKernel` |
| **Event management** | Inter-stream synchronization and timestamp recording | `aclrtCreateEvent`, `aclrtRecordEvent` |

<br>

In addition, Runtime provides a series of features (such as ACL Graph). The Runtime functional architecture is shown in the following figure.

![](figures/logical_architecture_diagram.png)

<br>
<br>

## Going Deeper

This topic describes the basic concepts of Runtime and the typical process of operator invocation. To gain a deeper understanding of Runtime programming, you are advised to continue reading:

- [Runtime Programming Model](Runtime_programming_model.md): host-device architecture, asynchronous execution mechanism, and the relationship between streams and tasks

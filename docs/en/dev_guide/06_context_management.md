# Context Management

<!-- md-trans-meta sourceCommit=f27ca703aef442726cc28a36cb0f8ecff75fe506 translatedAt=2026-11-11T06:21:50.638Z pushedAt=2026-11-16T02:58:20.338Z nl=2 -->

## Concept

A context is a core abstraction in CANN Runtime, representing the execution context environment on a device. It encapsulates runtime states such as compute resources, memory resources, and stream resources on the device, and serves as the fundamental carrier for Runtime operations.

Each context is bound to a specific device and contains the following on that device:

- Compute resources: used to execute kernels, system tasks, and so on
- Memory resources: used for device memory allocation and management
- Stream resources: used for task queues and scheduling states
- Runtime configuration: used for parameters that affect task execution

A context is bound to a thread, and at any given time a thread can use only one context. When a Runtime API is executed, it automatically uses the context bound to the current thread.

<br>
<br>

## Why Use Context

### Core Scenarios for Using Context

1. **Multi-threaded parallel computing**: When multiple threads concurrently use the same device, each thread creates an independent context to avoid resource competition and state confusion.
2. **Fine-grained resource control**: Finer-grained control is required over the timing of resource creation, usage, and release.
3. **Multi-threaded context sharing**: In a same-process, multiple-thread scenario, an explicitly created context can be shared among multiple threads.
4. **Modular program design**: Different functional modules use independent contexts to facilitate resource management and issue localization.

### Explicit Context vs. Default Context

When you call the `aclrtSetDevice` API, Runtime automatically creates a **default context** for the specified device. For simple applications, the default context is sufficient. However, for complex applications, explicit creation and management of contexts offers the following advantages.

| Scenario | Default Context | Explicit Context |
| -------- | --------------- | ---------------- |
| Multi-threaded programming | Threads share the default context, and task execution order depends on thread scheduling. | Each thread has an independent context, facilitating isolation and debugging. |
| Resource isolation | Different modules on the same device share resources. | Different modules use independent contexts, providing clearer resource isolation. |
| Code maintainability | The context state is ambiguous when a thread switches devices. | The context is explicitly specified, making the code intent clear. |
| Resource lifecycle | Managed with the device lifecycle. | The creation and destruction timing of the context is controlled independently. |

<br>

## Relationship Between a Context, Device, and Stream

The relationship between a context, device, and stream is shown in the following figure.

```text
┌─────────────────────────────────────────────────────────────┐
│                         Host process                            │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐       │
│  │   Thread 1   │  │   Thread 2   │  │   Thread 3   │       │
│  │  Context A   │  │  Context B   │  │  Context A   │       │
│  └──────┬───────┘  └──────┬───────┘  └──────┬───────┘       │
│         │                 │                 │               │
└─────────┼─────────────────┼─────────────────┼───────────────┘
          │                 │                 │
          ▼                 ▼                 ▼
┌────────────────────────────────────────────────────────────┐
│                      Device 0 (NPU)                        │
│  ┌─────────────────────────────────────────────────────┐   │
│  │                    Context A                        │   │
│  │  ┌──────────┐  ┌──────────┐  ┌──────────┐           │   │
│  │  │ Stream 0 │  │ Stream 1 │  │ Stream 2 │  ...      │   │
│  │  │ (default)│  │          │  │          │           │   │
│  │  └──────────┘  └──────────┘  └──────────┘           │   │
│  └─────────────────────────────────────────────────────┘   │
│  ┌─────────────────────────────────────────────────────┐   │
│  │                    Context B                        │   │
│  │  ┌──────────┐  ┌──────────┐                         │   │
│  │  │ Stream 0 │  │ Stream 1 │  ...                    │   │
│  │  │ (default)│  │          │                         │   │
│  │  └──────────┘  └──────────┘                         │   │
│  └─────────────────────────────────────────────────────┘   │
└────────────────────────────────────────────────────────────┘
```

- **Device**: a physical NPU device. Multiple contexts can be created on a device.
- **Context**: an execution context on a device, which contains the default stream and user-created streams.
- **Stream**: a task queue that belongs to a specific context.
  <br>

## How to Use Context

### Single-Thread Basic Usage Mode (Default Context)

For simple applications, the default context meets the requirements. When the `aclrtSetDevice` API is called, Runtime automatically creates the default context, so no explicit management is required.

The following example shows the basic process of using the default context in a single thread.

```c
// 1. Initialize Runtime.
aclInit(nullptr);

// 2. Specify a device. The default context and default stream are automatically created.
int32_t deviceId = 0;
aclrtSetDevice(deviceId);

// 3. Create an explicit stream (optional; you can also use the default stream by passing nullptr).
aclrtStream stream;
aclrtCreateStream(&stream);

// 4. Dispatch tasks on the stream.
aclrtMemcpyAsync(devPtr, size, hostPtr, size, ACL_MEMCPY_HOST_TO_DEVICE, stream);
myKernel<<<8, nullptr, stream>>>(devPtr, size);
aclrtMemcpyAsync(hostPtr, size, devPtr, size, ACL_MEMCPY_DEVICE_TO_HOST, stream);

// 5. Synchronously wait for task completion.
aclrtSynchronizeStream(stream);

// 6. Destroy the explicit stream.
aclrtDestroyStream(stream);

// 7. Reset the device to release the default context and default stream.
aclrtResetDeviceForce(deviceId);

// 8. Perform deinitialization.
aclFinalize();
```

<br>

### Multi-threaded Parallel Computing

When multiple threads use the same device, it is recommended to create an independent context for each thread.

```c
// Thread function
void* threadFunc(void* arg) {
    int32_t deviceId = *(int32_t*)arg;

    // Create a context for each thread.
    aclrtContext ctx;
    aclrtCreateContext(&ctx, deviceId);

    // Create a stream.
    aclrtStream stream;
    aclrtCreateStream(&stream);

    // Execute the task.
    // ... Service logic ...

    // Synchronously wait for task completion.
    aclrtSynchronizeStream(stream);

    // Destroy resources.
    aclrtDestroyStream(stream);
    aclrtDestroyContext(ctx);

    return nullptr;
}

// Main thread
int main() {
    aclInit(nullptr);

    int32_t deviceId = 0;
    aclrtSetDevice(deviceId);

    // Create multiple threads.
    pthread_t threads[4];
    for (int i = 0; i < 4; i++) {
        pthread_create(&threads[i], nullptr, threadFunc, &deviceId);
    }

    // Wait for the threads to complete.
    for (int i = 0; i < 4; i++) {
        pthread_join(threads[i], nullptr);
    }

    aclrtResetDeviceForce(deviceId);
    aclFinalize();
    return 0;
}
```

<br>

### Context Sharing Across Multiple Threads

When multiple threads share the same context, you must ensure the execution order of tasks on the stream by yourself.

```c
aclrtContext g_ctx;  // Global context

void* threadFunc(void* arg) {
    int threadId = *(int*)arg;

    // Switch to the shared context.
    aclrtSetCurrentContext(g_ctx);

    // Create a thread-specific stream.
    aclrtStream stream;
    aclrtCreateStream(&stream);

    // Execute tasks on your own stream.
    // ... Service logic ...

    aclrtSynchronizeStream(stream);
    aclrtDestroyStream(stream);

    return nullptr;
}

int main() {
    aclInit(nullptr);

    int32_t deviceId = 0;
    aclrtSetDevice(deviceId);

    // Create a context to be shared by multiple threads.
    aclrtCreateContext(&g_ctx, deviceId);

    pthread_t threads[4];
    int threadIds[4];
    for (int i = 0; i < 4; i++) {
        threadIds[i] = i;
        pthread_create(&threads[i], nullptr, threadFunc, &threadIds[i]);
    }

    for (int i = 0; i < 4; i++) {
        pthread_join(threads[i], nullptr);
    }

    aclrtDestroyContext(g_ctx);
    aclrtResetDeviceForce(deviceId);
    aclFinalize();
    return 0;
}
```

<br>

### Context Switching

Use `aclrtSetCurrentContext` to switch the context of the current thread.

```c
// Create two contexts on Device 0.
aclrtSetDevice(0);
aclrtContext ctx1, ctx2;
aclrtCreateContext(&ctx1, 0);
aclrtCreateContext(&ctx2, 0);

// Switch to ctx1.
aclrtSetCurrentContext(ctx1);
aclrtStream stream1;
aclrtCreateStream(&stream1);
// ... Execute tasks on ctx1 ...

// Switch to ctx2.
aclrtSetCurrentContext(ctx2);
aclrtStream stream2;
aclrtCreateStream(&stream2);
// ... Execute tasks on ctx2 ...

// When switching the context, if the new context belongs to a different device, the device is switched accordingly.
aclrtSetDevice(1);
aclrtContext ctx3;
aclrtCreateContext(&ctx3, 1);

aclrtSetCurrentContext(ctx3);  // The current Context is switched to ctx3, and the Device is switched to 1
```

<br>

### Context Parameter Settings

Use `aclrtCtxSetSysParamOpt` to set context-level parameters.

```c
aclrtContext ctx;
aclrtCreateContext(&ctx, 0);

// Set context parameters (for example, set the memory configuration).
aclrtCtxSetSysParamOpt(ACL_SYS_PARAM_OPT_XXX, value);

// Obtain context parameters.
int64_t paramValue;
aclrtCtxGetSysParamOpt(ACL_SYS_PARAM_OPT_XXX, &paramValue);
```

<br>

### Default Stream Obtaining

Each context contains a default stream, which can be obtained through the API.

```c
aclrtContext ctx;
aclrtCreateContext(&ctx, 0);

// Obtain the default stream of the current context.
aclrtStream defaultStream;
aclrtCtxGetCurrentDefaultStream(&defaultStream);

// Use the default stream (nullptr can also be passed directly).
aclrtMemcpyAsync(dst, size, src, size, ACL_MEMCPY_DEVICE_TO_DEVICE, nullptr);
```

<br>

## How to Use Context Effectively

### Recommended Practices

1. **Prioritize the use of an explicit context**: For multiple threads or complex applications, explicitly create a context to make the code intent clearer.
2. **Bind a context to a thread**: It is recommended to use a context in the thread that creates it, to avoid the complexity introduced by cross-thread usage.
3. **Destroy resources in a timely manner**: Destroy a context as soon as it is no longer in use to avoid resource leaks.
4. **Use aclrtResetDeviceForce**: After the device is no longer in use, call `aclrtResetDeviceForce` to release all resources on the device at once.
5. **Clarify the timing of context switching**: In multi-context scenarios, explicitly call `aclrtSetCurrentContext` to switch contexts, improving code readability.

### Practices to Avoid

1. **Do not destroy the default context**: The default context is managed by Runtime and cannot be destroyed by calling `aclrtDestroyContext`.
2. **Avoid an uncertain context state**: When multiple threads share a context, avoid relying on implicit context state switching.
3. **Do not operate the same stream arbitrarily across threads**: If a context must be shared among multiple threads, each thread should use an independent stream.
4. **Do not use a context on a reset device**: After a device is reset, the associated context becomes unavailable.

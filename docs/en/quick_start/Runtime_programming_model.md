# Runtime Programming Model

<!-- md-trans-meta sourceCommit=e0a18a8c392e4d2696a3f36d6e903c6c65dbd7ca translatedAt=2026-11-11T06:28:33.543Z pushedAt=2026-11-16T06:03:14.298Z nl=2 -->

## Host-Device Programming Model

**Host**: refers to an x86 server CPU or an ARM server CPU. It is interconnected with one or more devices through a bus and uses the computation capabilities, such as Neural-Network (NN), provided by the devices to complete services.

**Device (also called NPU)**: refers to the hardware on which an AI processor is installed. It is connected to the host through a bus (for example, PCIe or HCCS) and provides computation capabilities such as NN. (HCCS stands for Huawei Cache Coherence System.)

The relationship between the host and the device is shown in the following figure.

![](figures/Host_Device_relationship.png)

The summary is as follows:

1. **The host and the device each have independent memory space.**

   Runtime provides memory request APIs on both the host side and the device side, as well as memory copy APIs between the host and the device. During programming, you need to distinguish between host memory request and device memory request, and explicitly call the memory copy APIs to copy data from the host side to the device side, so that the device hardware accelerator achieves optimal performance when accessing local memory.

2. **The host and the device execute asynchronously and in parallel.**

   After the host dispatches a task to the device, it returns immediately **without waiting for the device task to complete**. The device then starts to schedule and execute the dispatched task. The CPU on the host side can work in parallel with the accelerator on the device side. The APIs for asynchronous task dispatch usually carry a stream parameter, indicating that the task is dispatched to the corresponding stream for execution.

   When the host needs to obtain the computation result from the device, it must initiate an explicit synchronous API call. The synchronous API blocks the host CPU and does not return until the device-side task execution is complete.

   Through this asynchronous parallel execution mechanism, the host processing time or the data transfer latency between the host and the device can be effectively hidden, thereby improving throughput and shortening the end-to-end execution time.

3. **Execution mode of tasks asynchronously dispatched to a stream**

   Tasks within a stream are executed in order, while tasks across streams are executed in parallel. For example, in the following figure, the host sequentially starts the Kernel1, Kernel2, and Kernel3 tasks, and the specific execution order is as follows:

   - Kernel1 and Kernel3 are in the same stream, so Kernel3 must wait for Kernel1 to finish before it can start executing.
   - Kernel2 is not in the same stream as Kernel1 and Kernel3, so Kernel2 can execute in parallel with Kernel1 and Kernel3.

   ![](figures/Stream_async_task_execute.png)

## Synchronous and Asynchronous Execution

The Runtime APIs support both synchronous and asynchronous execution modes, with the following typical characteristics:

**Synchronous execution**:

- The function call blocks the host CPU thread and does not return until the operation is complete.
- The caller must wait for the operation to finish before continuing with subsequent code.
- It is suitable for scenarios where the operation result is obtained immediately.

**Asynchronous execution**:

- The function call returns immediately without blocking the host CPU thread.
- The operation is executed asynchronously on the device side, allowing the host to continue executing other tasks.
- The stream parameter specifies the queue in which the task is executed.
- The host needs to perform a synchronization operation at an appropriate time to obtain the result.

**API distinction rules**:

- **APIs with a stream parameter**: These are usually asynchronous APIs. The task is dispatched to the specified stream and executed asynchronously.
- **APIs without a stream parameter**: These are usually synchronous APIs. They block and wait for the operation to complete.

Typical examples:

- `aclrtMemcpy` (without a stream): synchronous memory copy, which blocks the thread until the copy is complete.
- `aclrtMemcpyAsync` (with a stream): asynchronous memory copy, which returns immediately. The copy is executed in the specified stream.
- `aclrtLaunchKernel` (with a stream): operator task dispatch, which returns immediately. The operator task is executed in the specified stream.
- `aclrtSynchronizeStream`: synchronous API that blocks the thread and waits for all tasks in the stream to complete.

## Typical Execution Process

The following figure shows the typical execution process based on Runtime programming.

![](figures/typical_process.png)

The figure illustrates the task scheduling and execution mechanism on the host and device sides, which mainly includes the following steps:

1. The host adds tasks to the task queue through Runtime.
2. The task scheduler on the device side retrieves tasks from the queue for scheduling.
3. Based on the task type, the scheduler dispatches tasks to idle CPU executors or acceleration units such as AI Cores for execution.
4. After completing the execution, the acceleration units notify the scheduler to refresh the task status.
5. After task execution is complete, the scheduler feeds the result back to Runtime.
6. Runtime returns the task execution result to the host.

> **Relationship between the flowchart and the following steps**: The flowchart above depicts the internal mechanism of task scheduling and execution on the host and device sides, while steps 1~10 below describe the complete Runtime call process from the user programming perspective. The two are at different abstraction levels. The memory copy and computation task dispatch and synchronization involved in **steps 5~8** are internally implemented by the mechanism depicted in the flowchart above.

1. Initialize Runtime and specify the device, using Device 0 as an example.

   ```c
   int32_t devId=0;
   aclInit(nullptr);
   aclrtSetDevice(devId);
   ```

   The API internally involves the following operations:
   1. Create and initialize the device object.
   2. Create a default context for the device.
   3. Create a default stream for the default context.
   4. Start the CPU executor process on the device side.

2. Create a stream in the current context.

   ```c
   aclrtStream stream1;
   aclrtCreateStream(&stream1);
   ```

   The API internally involves the following operations:

   1. Call the driver to create a task queue.
   2. Runtime creates a stream object, and the stream is associated with the task queue.
   3. The stream is placed under the management of the current context.

3. Request host memory.

   ```c
   uint64_t size=1024;
   void *hostPtr=nullptr;
   aclrtMallocHost(&hostPtr, size);
   ```

4. Request device memory.

   ```c
   void *devPtr=nullptr;
   aclrtMalloc(&devPtr, size, ACL_MEM_MALLOC_HUGE_FIRST);
   ```

5. Perform synchronous memory copy from the host to the device.

   ```c
   aclrtMemcpy(devPtr, size, hostPtr, size, ACL_MEMCPY_HOST_TO_DEVICE);
   ```

   The synchronous memory copy from the host to the device mainly includes the following operations:
   1. Construct a Direct Memory Access (DMA) descriptor based on the source and destination addresses, and then dispatch the DMA task.
   2. Wait for the DMA task to complete, and then the API returns.

6. Dispatch the myKernel computation task.

   ```c
   myKernel<<<numBlocks,  nullptr, stream1>>>(devPtr);
   ```

   The detailed steps for dispatching the computation task and scheduling the task are as follows:

   1. Dispatch the myKernel computation task to stream1. **numBlocks** specifies the number of blocks for the computation task. The detailed operations are as follows:

      (a) The binary code of myKernel is registered and loaded to the device (only for the first time).

      (b) The execution parameters of myKernel are copied to the device.

      (c) Task management resources are allocated, and a task descriptor is created.

      (d) The task is dispatched to the task queue corresponding to this stream.

      (e) After the task is dispatched, the API returns asynchronously.

   2. The task scheduler starts scheduling. The detailed operations are as follows:
      (a) The scheduler schedules tasks based on the priority of the task queue using the Strict Priority (SP) method.

      (b) The task descriptor dispatched in the task queue is parsed.

      (c) Based on the task type, it is determined whether the corresponding acceleration unit is idle.

      (d) If an acceleration unit is idle and meets the core count requirement of the task, the task is scheduled to the corresponding acceleration unit (for example, a CPU operator is scheduled to the CPU executor).

      (e) The acceleration unit executes the task.

      (f) The scheduler waits for the acceleration unit to finish execution, and then refreshes the task status and the busy/idle status of the acceleration unit. If the task execution is abnormal, the scheduler handles the exception.

      (g) The scheduler continues scheduling other tasks.

7. Perform stream synchronization.

   ```c
   aclrtSynchronizeStream(stream1);
   ```

   Stream synchronization involves the following detailed operations:
   1. The API blocks the current CPU thread.
   2. The execution status of the task queue corresponding to the stream is synchronized through a polling and interruption mechanism.
   3. After all tasks on the stream are complete, this API returns.

8. Perform synchronous memory copy from the device to the host, and copy the result back to the host.

   ```c
   aclrtMemcpy(hostPtr, size, devPtr, size, ACL_MEMCPY_DEVICE_TO_HOST);
   ```

   A DMA descriptor is constructed based on the source and destination addresses, and then the DMA task is dispatched. The API waits for the DMA task to complete and then returns.

9. Release the device memory and host memory.

   ```c
   aclrtFree(devPtr);
   aclrtFreeHost(hostPtr);
   ```

10. Destroy the Stream, release the Device resources, and deinitialize Runtime.

    ```c
    aclrtDestroyStream(stream1);
    aclrtResetDeviceForce(devId);
    aclFinalize();
    ```

## Main Programming Concepts of Runtime

- **Host** is the abstraction of the host in Runtime.
- **Device** is the abstraction of the device to which the AI processor belongs. The relationship between the host and device is usually 1:N. A user application can call acl APIs, for example, **aclrtSetDevice**, to specify the hardware device used for computation.
- **Context** is the logical runtime environment of a device. The relationship between the context and device is N:1, that is, each context must belong to a unique device. A context manages the lifecycle of runtime resource objects (including the stream, event, and Notify, but excluding memory). Objects in different contexts are completely isolated. For example, streams and events in different contexts are completely isolated and cannot establish synchronous wait relationships. Runtime errors are also isolated by context.
- **Stream** is a logical task execution queue provided by a device. Tasks can be added to a stream asynchronously, and tasks in the same stream are executed strictly in FIFO order. The relationship between the stream and context is N:1, that is, a stream must belong to a unique context.
- **Task** is an executable task that can be added to a stream. Tasks can be classified into computation tasks, memory copy tasks, and event synchronization tasks. The relationship between the task and stream is N:1, that is, a task is added to a unique stream.

The relationship among the device, context, and stream is shown in the following figure.

![](figures/Device_Context_Stream.png)

## Thread-Context Association

Most Runtime APIs do not have a device ID parameter, because the device on which these APIs operate is obtained from the context associated with the calling thread. Therefore, when a host thread calls a Runtime API, the following requirements must be met:

- A thread (a CPU thread on the host side) can correctly call Runtime APIs only after it is associated with a context.
- A thread can be associated with only one context at a time.
- An application can explicitly create contexts to achieve resource isolation for running services. In this scenario, a context is visible to all threads in the same process. A thread can query the current context by calling **aclrtGetCurrentContext** and switch the context by calling **aclrtSetCurrentContext**.

The following example illustrates the association and switching between a thread and context when the thread calls context-related APIs. It is for reference only and cannot be directly copied, compiled, or run.

```c
// Initially, the thread is not associated with any context.
aclInit(nullptr);
aclrtSetDevice(0);  // aclrtSetDevice creates the default context and associates the thread with it.
// Context associated with the thread: default context

aclrtContext ctx1, ctx2, current_ctx;
aclrtCreateContext(&ctx1, 0); // Device 0 explicitly creates ctx1, and associates the thread with ctx1.
// Context associated with the thread: ctx1
aclrtGetCurrentContext(&current_ctx); // Obtain the context associated with the current thread. At this point, the returned current_ctx == ctx1.
// Context associated with the thread: ctx1

aclrtCreateContext(&ctx2, 0); // Device 0 explicitly creates ctx2, and associates the thread with ctx2.
// Context associated with the thread: ctx2

aclrtSetCurrentContext(current_ctx); // Switch the context. Since current_ctx = ctx1, the thread is associated with ctx1.
// Context associated with the thread: ctx1

aclrtSetCurrentContext(ctx2); // Switch the Context.
// Context associated with the thread: ctx2
.....

aclrtDestroyContext(ctx2);  // The current thread is associated with ctx2. Destroying ctx2 also disassociates the thread from ctx2.
// Context associated with the thread: NA

// ctx2 has been destroyed. Switch to another context (for example, ctx1)
aclrtSetCurrentContext(ctx1);
// Context associated with the thread: ctx1
.....

aclrtDestroyContext(ctx1);  // The current thread is associated with ctx1. Destroying ctx1 also disassociates the thread from ctx1
// Context associated with the thread: NA
aclrtResetDeviceForce(0);
aclFinalize();
```

## Scenarios for Using the Default Context and Default Stream

- Before operations are dispatched on a device, a context and a stream must exist. The context and stream can be created explicitly or implicitly. The **implicitly created** context and stream are the default context and default stream.

    When the default stream is used as an API input parameter, pass **NULL** directly.

- The **default context** does not allow users to call **aclrtGetCurrentContext** or **aclrtSetCurrentContext**, nor does it allow **aclrtDestroyContext**.
- The **default context and default stream** are generally suitable for simple applications where the user needs only one device for computation. For multi-threaded applications, it is recommended to use explicitly created contexts and streams.

The following sample code is for reference only and cannot be directly copied, compiled, or run.

```c
// ......
uint32_t numBlocks = 32;
uint64_t size = 1024;
void *devPtr = nullptr;
aclInit(nullptr);
aclrtSetDevice(0);
/* A default context has been created, a default stream has been created in the default context, and both are available in the current thread. */

......
aclrtMalloc(&devPtr, size, ACL_MEM_MALLOC_HUGE_FIRST);
myKernel<<<numBlocks, nullptr, nullptr>>>(devPtr);  // The third parameter nullptr in <<< >>> indicates execution on the default stream.
aclrtSynchronizeStream(nullptr);

/* Wait for all computation tasks to complete, and obtain the output results of the computation tasks as needed. */
......
aclrtResetDeviceForce(0);  // Release Device 0. The lifecycles of the corresponding default context and default stream also terminate.
aclFinalize();
```

## Recommendations for Writing High-Performance Applications

Follow these basic principles:

1. The host and the device execute asynchronously. The host must dispatch sufficient tasks to the device in a timely manner to ensure that the acceleration hardware remains in the computing state.
2. Use multiple streams to fully leverage the different types of hardware accelerators on the device for concurrent execution. As shown in the following figure, CANN Runtime can coordinate and schedule multiple hardware accelerators. Different generations of AI processors support different hardware accelerators. For details, see the actual hardware user manual.

    ![](figures/multi_hardware_accelerators.png)

The following methods are recommended:

- Create and use multiple streams in a single thread. If the performance of a single thread is sufficient to dispatch tasks to multiple streams to fully utilize the computing power of the device, the single-thread mode is recommended.
- When the performance of a single thread is insufficient, use the multi-thread mode to improve the task dispatch performance on the host side. It is recommended that each thread create and use its own stream to dispatch tasks. Dispatching tasks to the same stream concurrently from multiple threads is not recommended, because this introduces lock operations and the tasks dispatched by multiple threads are out of order.
- When a single task dispatched on a stream cannot fully occupy the AI Core, use multiple streams to dispatch tasks that can be executed in parallel to fully utilize the AI Core resources.
- An AI processor contains multiple hardware accelerators, such as the AI Core, AI CPU, Digital Vision Pre-Processing (DVPP), and Random (random number generator). These hardware accelerators correspond to different types of tasks. It is recommended that multiple streams be created based on the hardware on which the operators are executed.

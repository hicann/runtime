# Memory Semantic Synchronization

<!-- md-trans-meta sourceCommit=f27ca703aef442726cc28a36cb0f8ecff75fe506 translatedAt=2026-11-11T06:20:06.414Z pushedAt=2026-11-16T02:37:31.031Z nl=2 -->

The memory semantic synchronization mechanism allows users to implement synchronization based on general-purpose device memory. Unlike the event/Notify synchronization mechanism, the memory semantic synchronization mechanism also supports operators as synchronization participants, meaning that an operator can synchronize with another stream during execution.

The following figure shows the synchronization process between an operator and another stream during operator execution:

![](figures/mem_semantic_sync.png)

The following is an example of the code for calling the memory semantic synchronization APIs. It is for reference only and cannot be directly copied, compiled, and run.

- **Device example code** (operator kernel function implementation code)

    ```c
    extern "C" __global__ __aicore__ void myKernel1(GM_ADDR syncMem)
    {
        // Operator logic
        ......
        // Write 1 to the memory pointed to by syncMem.
        __gm__  uint64_t* flag = reinterpret_cast<__gm__ uint64_t*>(syncMem);
        *flag = 1;
        dcci(flag, 0, 2);
        // Operator logic
        ......
    }
    extern "C" __global__ __aicore__ void myKernel2(GM_ADDR syncMem)
    {
        // Operator logic
        ...
        // Poll and block until the value in the memory pointed to by syncMem becomes 2.
        __gm__ volatile uint64_t* flag = reinterpret_cast<__gm__ uint64_t*>(syncMem);
        dcci(flag, 0, 2);
        while (*flag != 2) {
            dcci(flag, 0, 2);
        }
        // Operator logic
        ......
    }
    ```

- **Host example code**

    ```c
    // Create streams.
    aclrtStream stream1;
    aclrtStream stream2;
    aclrtCreateStream(&stream1);
    aclrtCreateStream(&stream2);

    // Request device memory.
    void* syncMem;
    aclrtMalloc(&syncMem, sizeof(uint64_t), ACL_MEM_MALLOC_NORMAL_ONLY);
    // Dispatch a wait task on stream1. The task blocks until the value in the memory pointed to by syncMem becomes 1.
    aclrtValueWait(syncMem, 1, ACL_STREAM_WAIT_VALUE_EQ, stream1);
    // Dispatch myKernel1 on stream2. The kernel writes 1 to the memory pointed to by syncMem, thereby unblocking the wait task on stream1.
    myKernel1<<<numBlocks, nullptr, stream2>>>(syncMem);

    // Dispatch myKernel2 on stream1. The kernel polls and waits until the value in the memory pointed to by syncMem becomes 2.
    myKernel2<<<numBlocks, nullptr, stream1>>>(syncMem);
    // Dispatch a write task on stream2. The task writes 2 to the memory pointed to by syncMem, thereby unblocking myKernel2 on stream1.
    aclrtValueWrite(syncMem, 2, 0, stream2);
    ```

**Note:** Because the memory semantic synchronization mechanism is implemented based on general-purpose device memory, you can use **aclrtMemset**/**aclrtMemsetAsync** to initialize and clear the memory used for synchronization.

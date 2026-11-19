# System Task

<!-- md-trans-meta sourceCommit=d4beb87bb3b37f0e5366aaabff71738bd1cfdf30 translatedAt=2026-10-16T10:13:58.903Z pushedAt=2026-10-19T09:07:01.028Z -->

In addition to dispatching kernel execution tasks, Runtime also supports dispatching built-in system tasks such as Reduce operations and random number generation. Unlike kernel tasks, system tasks do not require users to provide execution code. System tasks can be dispatched to a stream for asynchronous execution, and they also follow the rule of in-order task execution on the same stream.

You can dispatch a Reduce operation task by calling **aclrtReduceAsync**. The sample code is as follows.

```c
    aclInit(NULL);
    aclrtSetDevice(0);
    aclrtStream stream;
    aclrtCreateStream(&stream);
    // Prepare host data.
    const int count = 4;
    float hostInput[4] = {1.0, 2.0, 3.0, 4.0};
    float hostOutput[4] = {0, 0, 0, 0};
    size_t size = count * sizeof(float);
    // Request device memory.
    void *devInput = NULL;
    void *devOutput = NULL;
    aclrtMalloc(&devInput, size, ACL_MEM_MALLOC_HUGE_FIRST);
    aclrtMalloc(&devOutput, size, ACL_MEM_MALLOC_HUGE_FIRST);
    // Copy data to the device.
    aclrtMemcpy(devInput, size, hostInput, size, ACL_MEMCPY_HOST_TO_DEVICE);
    aclrtMemcpy(devOutput, size, hostInput, size, ACL_MEMCPY_HOST_TO_DEVICE);
    // Call aclrtReduceAsync.
    aclrtReduceAsync(devOutput,
        devInput,
        size,
        ACL_RT_MEMCPY_SDMA_AUTOMATIC_SUM,  // Reduction type
        ACL_FLOAT,                         // Data type
        stream,
        NULL);
    // Synchronize the stream.
    aclrtSynchronizeStream(stream);
    // Copy back the result.
    aclrtMemcpy(hostOutput, size, devOutput, size, ACL_MEMCPY_DEVICE_TO_HOST);
    for (int i = 0; i < count; i++) {
        printf("Reduce SUM result[%d] = %f\n", i, hostOutput[i]);
    }
    /* The expected result is as follows:
    Reduce SUM result[0] = 2.000000
    Reduce SUM result[1] = 4.000000
    Reduce SUM result[2] = 6.000000
    Reduce SUM result[3] = 8.000000
    */
    // Release the resources.
    aclrtFree(devInput);
    aclrtFree(devOutput);
    aclrtDestroyStream(stream);
    aclrtResetDeviceForce(0);
    aclFinalize();
```

Use **aclrtRandomNumAsync** to execute a random number generation task. The sample code is as follows.

```c
aclError NormalFloatAsync(
    float mean, float stddev, uint64_t seed, uint64_t num, void *counterDevAddr, void *devOutput, aclrtStream stream)
{
    aclrtRandomNumTaskInfo taskInfo = {};
    taskInfo.dataType = ACL_FLOAT;
    taskInfo.randomNumFuncParaInfo.funcType = ACL_RT_RANDOM_NUM_FUNC_TYPE_NORMAL_DIS;
    taskInfo.randomParaAddr = NULL;
    taskInfo.randomCounterAddr = counterDevAddr;
    taskInfo.randomResultAddr = devOutput;
    memcpy(taskInfo.randomNumFuncParaInfo.paramInfo.normalDisInfo.mean.valueOrAddr, &mean, sizeof(float));
    taskInfo.randomNumFuncParaInfo.paramInfo.normalDisInfo.mean.size = sizeof(float);
    taskInfo.randomNumFuncParaInfo.paramInfo.normalDisInfo.mean.isAddr = 0;
    memcpy(taskInfo.randomNumFuncParaInfo.paramInfo.normalDisInfo.stddev.valueOrAddr, &stddev, sizeof(float));
    taskInfo.randomNumFuncParaInfo.paramInfo.normalDisInfo.stddev.size = sizeof(float);
    taskInfo.randomNumFuncParaInfo.paramInfo.normalDisInfo.stddev.isAddr = 0;
    memcpy(taskInfo.randomSeed.valueOrAddr, &seed, sizeof(uint64_t));
    taskInfo.randomSeed.size = sizeof(uint64_t);
    taskInfo.randomSeed.isAddr = 0;
    memcpy(taskInfo.randomNum.valueOrAddr, &num, sizeof(uint64_t));
    taskInfo.randomNum.size = sizeof(uint64_t);
    taskInfo.randomNum.isAddr = 0;
    return aclrtRandomNumAsync(&taskInfo, stream, NULL);
}
int main()
{
    aclError ret;
    // Initialize ACL.
    ret = aclInit(NULL);
    ret = aclrtSetDevice(0);
    aclrtStream stream;
    ret = aclrtCreateStream(&stream);
    uint64_t num = 128;
    size_t size = num * sizeof(uint64_t);  // Request sufficient memory.
    // Request device memory.
    void *devOutput = NULL;
    ret = aclrtMalloc(&devOutput, size, ACL_MEM_MALLOC_NORMAL_ONLY);
    // Prepare host data.
    void *hostOutput = malloc(size);
    // Request device memory for storing the random number state counter (16 bytes required).
    void *counterAddr = NULL;
    ret = aclrtMalloc((void **)&counterAddr, 16, ACL_MEM_MALLOC_NORMAL_ONLY);
    
    float mean = 3.0;
    float stddev = 2.0;    
    ret = NormalFloatAsync(mean, stddev, 0, num, counterAddr, devOutput, stream);
    // Synchronize the stream.
    aclrtSynchronizeStream(stream);
    // Copy back the result.
    aclrtMemcpy(hostOutput, size, devOutput, size, ACL_MEMCPY_DEVICE_TO_HOST);
    
    // Release the resources.
    free(hostOutput);
    aclrtFree(devOutput);
    aclrtFree(counterAddr);
    aclrtDestroyStream(stream);
    aclrtResetDeviceForce(0);
    aclFinalize();
    return 0;
}
```

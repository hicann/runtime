# Host回调任务

CANN为CPU和NPU之间的异步协作提供了灵活的方式。用户可以使用aclrtLaunchHostFunc在Stream的任意位置插入一个Host回调任务。当本Stream上所有前序任务执行完成后，该Host回调任务会被自动执行，并且会阻塞本Stream上的后续任务执行。

回调函数不能直接或者间接调用CANN Runtime API，否则可能会导致错误或死锁。

以下是在Stream上插入一个Host回调任务的代码示例，不可以直接拷贝编译运行，仅供参考。完整样例代码请参见[Link](https://gitcode.com/cann/runtime/tree/master/example/2_advanced_features/callback/1_callback_hostfunc)。

```
// Host回调任务
void myHostCallback(void *args)
{
     printf("In MyHostCallback.\n");

     // myKernel1完成后的处理，阻塞MyKernel2的执行
     ......
}
......

// 创建Stream
aclrtStream stream;
aclrtCreateStream(&stream);

// 在Stream上下发任务
aclrtMemcpyAsync(devPtrIn, size, hostPtr, hostSize, ACL_MEMCPY_HOST_TO_DEVICE, stream);
myKernel1<<<8, nullptr, stream>>>(devPtrIn, devPtrOut, size);
aclrtLaunchHostFunc(stream, myHostCallback, nullptr);
myKernel2<<<8, nullptr, stream>>>(devPtrOut, size);
aclrtMemcpyAsync(hostPtr, hostSize, devPtrOut, size, ACL_MEMCPY_DEVICE_TO_HOST, stream);

// 阻塞应用程序运行，直到指定Stream中的所有任务都完成
aclrtSynchronizeStream(stream);

// 销毁Stream
aclrtDestroyStream(stream);
```



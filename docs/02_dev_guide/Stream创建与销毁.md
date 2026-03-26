# Stream创建与销毁

调用aclrtCreateStream创建Stream，得到的aclrtStream对象作为后续的内存异步复制、Stream同步、Kernel执行等接口的Stream入参。显式创建的Stream需要调用aclrtDestroyStream接口显式销毁。销毁Stream时，如果Stream上有未完成的任务，则会等待任务完成后再销毁Stream。

以下是创建Stream并在Stream上下发计算任务的代码示例，不可以直接拷贝编译运行，仅供参考。完整样例代码请参见[Link](https://gitcode.com/cann/runtime/blob/master/example/1_basic_features/stream/0_simple_stream)。

```
// 显式创建一个Stream
aclrtStream stream;
aclrtCreateStream(&stream);

// 在Stream上下发Host->Device复制任务、MyKernel任务、和Device->Host复制任务
aclrtMemcpyAsync(devPtr, devSize, hostPtr, hostSize, ACL_MEMCPY_HOST_TO_DEVICE, stream);
myKernel<<<8, nullptr, stream>>>();
aclrtMemcpyAsync(hostPtr, hostSize, devPtr, devSize, ACL_MEMCPY_DEVICE_TO_HOST, stream);

// 销毁Stream（等待Device->Host复制任务执行完成后销毁）
aclrtDestroyStream(stream);
```



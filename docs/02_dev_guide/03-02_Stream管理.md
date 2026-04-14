# Stream管理

## Stream概念

Stream描述了一个在Host下发并在Device上执行的任务队列。

在同一个Stream中，任务按照进入队列的顺序依次执行。当硬件资源充足时，不同Stream上的任务会被调度到不同的硬件资源上并行执行。当硬件资源不足时，不同Stream上的任务可能串行执行。

Stream可以配置优先级、遇错即停、persistent等多种属性。优先级会影响不同Stream上的任务的执行顺序。通常情况下，高优先级Stream上的任务会优先于低优先级Stream上的任务执行。如果Stream配置了persistent属性，则下发在其上的任务不会被立即执行，执行完成后也不会被立即销毁。Persistent Stream适用于模型运行实例构建场景。

相对于主机线程，Stream上的任务是异步执行的。主机线程可以使用Device同步接口来等待当前Context下所有Stream上的任务全部执行完成，或者使用Stream同步接口来等待Stream上的任务全部执行完成。

Runtime中的Stream均为非阻塞式Stream，默认Stream不会跟显式创建的Stream进行隐式同步。

<br>
<br>

## Stream创建与销毁

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

<br>
<br>

## 默认Stream

在调用aclrtSetDevice接口或aclrtCreateContext接口时，Runtime会自动创建一个默认Stream。每个Context拥有一个默认Stream。如果不同的Host线程使用相同的Context，它们将共享同一个默认Stream。

对于需要传入Stream参数的API（如aclrtMemcpyAsync），如果使用默认Stream作为入参，则直接传入nullptr。对于没有Stream入参的API（如aclrtMemcpy），则不使用默认Stream。

默认Stream不能显式调用aclrtDestroyStream接口销毁。在调用aclrtResetDevice或aclrtResetDeviceForce接口释放资源时，默认Stream会被自动销毁。

以下是在默认Stream上下发计算任务的代码示例，不可以直接拷贝编译运行，仅供参考。

```
// 指定Device（接口内部自动创建默认Stream）
aclrtSetDevice(0);

// 在默认stream上下发Host->Device复制任务、MyKernel任务、和Device->Host复制任务
aclrtMemcpyAsync(devPtrIn, size, hostPtr, hostSize, ACL_MEMCPY_HOST_TO_DEVICE, nullptr);
myKernel<<<8, nullptr, nullptr>>>(devPtrIn, devPtrOut, size);
aclrtMemcpyAsync(hostPtr, hostSize, devPtrOut, size, ACL_MEMCPY_DEVICE_TO_HOST, nullptr);

// 同步默认stream
aclrtStreamSynchronize(nullptr);

// 复位Device（接口内部自动销毁默认Stream）
aclrtResetDevice(0);
```

<br>
<br>

## 显式同步

对于异步任务接口，主机线程调用异步任务接口后仅代表下发任务，不代表任务执行完成。用户需要显式调用设备同步、流同步等显式同步接口等待任务完成。调用此类显式同步接口后，主机线程会阻塞直到相关的任务执行完成。

### 设备同步：aclrtSynchronizeDevice

阻塞当前主机线程直到当前Device的当前Context中所有显式或隐式创建的Stream完成已下发的所有任务。

以下是设备同步代码示例，不可以直接拷贝编译运行，仅供参考。

```
// 指定Device
aclrtSetDevice(0);

// 创建Stream
aclrtStream stream;
aclrtCreateStream(&stream);

// 在Stream上下发任务
......

// 阻塞应用程序运行，直到正在运算中的Device完成运算
aclrtSynchronizeDevice();

// 资源销毁
aclrtDestroyStream(stream);
aclrtResetDevice(0);
```

### 流同步：aclrtSynchronizeStream

阻塞当前主机线程直到指定的Stream完成已下发的所有任务。

以下是流同步的代码示例，不可以直接拷贝编译运行，仅供参考。

```
// 创建Stream
aclrtStream stream;
aclrtCreateStream(&stream);

// 在Stream上下发任务
......

// 调用aclrtSynchronizeStream接口，阻塞应用程序运行，直到指定Stream中的所有任务都完成。
aclrtSynchronizeStream(stream);

// Stream使用结束后，显式销毁Stream
aclrtDestroyStream(stream);
```

此外，用户可以使用aclrtStreamQuery查询stream上的任务是否全部执行完成。


<br>
<br>

## Host回调任务

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

<br>
<br>

## 配置Stream优先级

在运行时，Device上的调度器会依据各个Stream的优先级来决定任务的执行顺序。高优先级Stream中待执行的任务将优先于低优先级Stream中的任务得到调度，但不会抢占已处于运行状态的低优先级任务。Device在执行过程中不会动态重新评估任务队列，因此提升Stream的优先级不会中断正在执行的任务。

Stream的优先级主要用于影响任务的调度顺序，而非强制规定严格的执行序列。用户可以通过调整Stream的优先级来引导任务的执行顺序，但无法以此强制保证任务间的绝对顺序。

调用aclrtCreateStreamWithConfig接口创建Stream时可指定Stream的优先级。允许设置的优先级范围，可以通过aclrtDeviceGetStreamPriorityRange接口获取最小优先级、最大优先级。

以下为示例代码，不可以直接拷贝编译运行，仅供参考。

```
// 查询当前设备支持的Stream最小、最大优先级
aclrtDeviceGetStreamPriorityRange(&leastPriority, &greatestPriority);

// 创建具有最高和最低优先级的Stream
aclrtStream stream_high;
aclrtStream stream_low;
aclrtCreateStreamWithConfig(&stream_high, greatestPriority, ACL_STREAM_FAST_LAUNCH);
aclrtCreateStreamWithConfig(&stream_low, leastPriority, ACL_STREAM_FAST_LAUNCH);
```

Stream的优先级在Device范围内生效，而不是在Context范围内生效。


<br>
<br>

## 配置任务遇错即停

CANN支持遇错即停模式（ACL\_STOP\_ON\_FAILURE）和遇错继续模式（ACL\_CONTINUE\_ON\_FAILURE），以支持不同应用对任务执行失败的差异化控制。默认为遇错继续模式。

当Stream上的任务执行失败时，如果配置了遇错即停模式（ACL\_STOP\_ON\_FAILURE），则会停止执行该Context中所有Stream上的任务；如果配置了遇错继续模式（ACL\_CONTINUE\_ON\_FAILURE），则会继续执行Stream上的后续任务。

调用aclrtSetStreamFailureMode接口指定调度模式的示例代码如下，不可以直接拷贝编译运行，仅供参考：

```
aclrtStream stream;
aclrtCreateStream(&stream);

// 设置遇错即停模式
aclrtSetStreamFailureMode(stream, ACL_STOP_ON_FAILURE);
......
```

也可以调用aclrtSetStreamAttribute接口指定调度模式的示例代码如下，不可以直接拷贝编译运行，仅供参考：

```
aclrtStream stream;
aclrtCreateStream(&stream);

// 设置遇错继续模式
aclrtSetStreamAttribute(stream, ACL_STREAM_ATTR_FAILURE_MODE, ACL_CONTINUE_ON_FAILURE);
......
```

<br>
<br>

## Persistent流

非Persistent流上的任务在执行完成之后从Stream出队。如果要多次执行某个任务，需要在非Persistent流上多次下发该任务。

Runtime提供了Persistent流支持任务的持久化。在Persistent流上下发的任务不会被立即执行，任务执行完成后也不会被立即销毁。只有在销毁Persistent流时，相关的任务才会被销毁。

调用aclrtCreateStreamWithConfig接口创建Persistent流，Persistent流需要与模型运行实例创建绑定，支持模型的反复执行。以下为示例代码，不可以直接拷贝编译运行，仅供参考：

```
// 创建Persistent stream
aclrtStream stream;
aclrtCreateStreamWithConfig(&stream, 0, ACL_STREAM_PERSISTENT);

// 构建一个模型运行实例
aclmdlRI modelRI;
aclmdlRIBuildBegin(&modelRI, 0);

// 把Persistent stream绑定到模型运行实例
aclmdlRIBindStream(modelRI, stream, ACL_MODEL_STREAM_FLAG_HEAD);

// 在Persistent流上下发任务
......

// 标记下发任务结束
aclmdlRIEndTask(modelRI, stream);

// 结束模型运行实例构建
aclmdlRIBuildEnd(modelRI, nullptr);

// 在默认stream多次执行模型运行实例
aclmdlRIExecute(modelRI, -1);
aclmdlRIExecute(modelRI, -1);

// 解除绑定
aclmdlRIUnbindStream(modelRI, stream);

// 销毁资源
aclrtDestroyStream(stream);
aclmdlRIDestroy(modelRI);
......
```







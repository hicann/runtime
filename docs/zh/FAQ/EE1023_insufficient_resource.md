# EE1023资源不足问题

## 问题现象描述

当Runtime向Driver申请Stream、Event、Notify所涉及的硬件调度资源失败时触发EE1023的报错，表示Device上硬件资源不足。

EE1023报错示例如下：

```text
Resource_Error(EE1023): Expanding the capacity failed. Reason: There are too many asynchronous copy tasks in the ACL Graph. 1. If the value of numBatches for aclrtMemcpyBatchAsync in the ACL Graph is too large, reduce the value of numBatches. 2. If the value of height for aclrtMemcpy2dAsync in the ACL Graph is too large, reduce the value of height.  
Solution: For details about the troubleshooting method, search for the keyword "EE1023" on https://www.hiascend.com/document/.
......
```

## 定位思路

1. **确认资源类型**。

    根据EE1023报错Reason的提示及同一时段的plog日志中的retCode，判断硬件资源不足的类型或场景。plog日志是指Host应用类日志，默认路径"$HOME/ascend/log/\[run|debug\]/plog/plog-pid\_\*.log"。

    | plog日志中的retCode | 典型日志关键词 | 资源类型 |
    | --- | --- | --- |
    | 0x7020023 | Alloc Stream resource failed或resource alloc fail或Failed to alloc stream id | Stream资源 |
    | 0x702001b | Alloc Notify resource failed或no notify resource | Notify资源 |
    | 0x7020019 | Alloc Event resource failed | Event资源 |
    | 0x7110019 | The number of async copy tasks reaches the maximum limit | 异步拷贝任务队列资源 |

2. **进一步排查各类资源不足的原因。**

    各类资源不足的排查方法请参见[Stream资源不足现象及解决方法](#section18622174521211)、[Notify资源不足现象及解决方法](#section10318152845313)、[Event资源不足现象及解决方法](#section4510153665411)、[异步拷贝任务队列资源不足现象及解决方法](#section66681856115411)。

    不同类型的资源，涉及排查的接口不同，整体思路如下：

    1. **检查相关资源的创建和销毁是否配对**。对不再使用的资源需及时调用对应的Destroy接口释放，例如如 aclrtDestroyStream、aclrtDestroyEvent、aclrtDestroyNotify、aclmdlRIDestroy。
    2. **查看设备资源占用**。使用npu-smi info命令查看Device资源占用状态，确认是否有其他进程占用资源。
    3. **排查多进程**。若多进程共用同一Device，需减少并发进程数量。

3. **联系技术支持**。

    若以上步骤无法解决，您可以获取日志后单击[Link](https://www.hiascend.com/support)联系技术支持。

<a id="section18622174521211"></a>

## Stream资源不足现象及解决方法

### 问题现象

- 报错示例1：

    EE1023打屏报错：

    ```text
    Resource_Error(EE1023): Alloc Stream resource failed. Reason: Too many streams are captured to the ACL graph (model_id=49).
            Solution: For details about the troubleshooting method, search for the keyword "EE1023" on https://www.hiascend.com/document/.
    TraceBack (most recent call last):
            Build SQ/CQ failed, stream_id=47, model_id=49, retCode=0x7020023.[FUNC:PrepareModelExecute][FILE:capture_model.cc][LINE:352]
            rtModelExecute execution failed, reason=driver error:resource alloc fail[FUNC:FuncErrorReason][FILE:error_message_manage.cc][LINE:69]
    ```

    plog日志中的报错：

    ```text
    [ERROR] RUNTIME(227839,rtstest_host):2026-07-13-11:39:20.982.549 [capture_model.cc:1078]227839 AllocSqCqProc:sq cq res alloc failed, model_id=63, alloc num=1, total res num=0, retCode=0x7020023.
    [ERROR] RUNTIME(227839,rtstest_host):2026-07-13-11:39:20.982.556 [capture_model.cc:1799]227839 AllocSqCqAndBindInternal:alloc sq resource failed, model_id=63, required number=1, current available number=0, maximum number=0, retCode=0x7020023.
    [ERROR] RUNTIME(227839,rtstest_host):2026-07-13-11:39:20.982.566 [capture_model.cc:1802]227839 AllocSqCqAndBindInternal:Alloc Stream resource failed. Reason: Too many streams are captured to the ACL Graph. ErrorCode=EE1023.
    [ERROR] RUNTIME(227839,rtstest_host):2026-07-13-11:39:20.982.619 [capture_model.cc:1158]227839 BuildSqCq:alloc all sqcq failed, stream_id=61, model_id=63, retCode=0x7020023.
    [ERROR] RUNTIME(227839,rtstest_host):2026-07-13-11:39:20.982.624 [capture_model.cc:352]227839 PrepareModelExecute:Build SQ/CQ failed, stream_id=61, model_id=63, retCode=0x7020023.
    [ERROR] RUNTIME(227839,rtstest_host):2026-07-13-11:39:20.982.640 [api_error.cc:3388]227839 ModelExecute:Execute model failed.
    [ERROR] RUNTIME(227839,rtstest_host):2026-07-13-11:39:20.982.674 [api_c.cc:1713]227839 rtModelExecute:ErrCode=207005, desc=[driver error:resource alloc fail], InnerCode=0x7020023
    [ERROR] RUNTIME(227839,rtstest_host):2026-07-13-11:39:20.982.681 [error_message_manage.cc:69]227839 FuncErrorReason:rtModelExecute execution failed, reason=driver error:resource alloc fail
    ```

- 报错示例2：

    EE1023打屏报错：

    ```text
    Resource_Error(EE1023): Alloc Stream resource failed. Reason: Too many streams are created.
            Solution: For details about the troubleshooting method, search for the keyword "EE1023" on https://www.hiascend.com/document/.
    TraceBack (most recent call last):
            rtStreamCreateWithFlags execution failed, reason=driver error:resource alloc fail[FUNC:FuncErrorReason][FILE:error_message_manage.cc][LINE:69]
    ```

    plog日志中的报错：

    ```text
    [ERROR] RUNTIME(11803,rtstest_host):2026-07-09-21:52:24.482.342 [stream.cc:728]11803 Setup:Alloc sq cq failed, stream_id=2047, retCode=0x7020023.
    [ERROR] RUNTIME(11803,rtstest_host):2026-07-09-21:52:24.482.347 [stream.cc:731]11803 Setup:Alloc Stream resource failed. Reason: Too many streams are created. ErrorCode=EE1023.
    [ERROR] RUNTIME(11803,rtstest_host):2026-07-09-21:52:24.482.377 [context.cc:1572]11803 StreamCreate:Setup stream failed, retCode=0x7020023.
    [ERROR] RUNTIME(11803,rtstest_host):2026-07-09-21:52:24.482.388 [api_impl.cc:1487]11803 StreamCreate:Create stream failed, priority=0, flags=0.
    [ERROR] RUNTIME(11803,rtstest_host):2026-07-09-21:52:24.482.402 [api_c_stream.cc:85]11803 rtStreamCreateWithFlags:ErrCode=207005, desc=[driver error:resource alloc fail], InnerCode=0x7020023
    [ERROR] RUNTIME(11803,rtstest_host):2026-07-09-21:52:24.482.405 [error_message_manage.cc:69]11803 FuncErrorReason:rtStreamCreateWithFlags execution failed, reason=driver error:resource alloc fail
    ```

### 原因分析

Device上的硬件资源总量有限，由当前Device上所有进程共享，显式创建的Stream（如通过aclrtCreateStream接口创建）或ACL Graph内部的Stream，均从同一Device分配。

当已分配的资源不再使用但未及时释放时，可用资源会逐渐减少，最终导致新的申请失败。此外，多个ACL Graph并发执行时，正在执行的ACL Graph所占有的资源在其执行结束前无法被回收，此时其他ACL Graph无法获取资源。

### 解决方法

1. 检查创建Stream和销毁Stream的接口是否成对调用，例如aclrtCreateStream和aclrtDestroyStream是否成对调用。另外，对于空闲的Stream，应及时调用aclrtDestroyStream释放资源。
2. ACL Graph场景下，若单个ACL Graph规格过大，导致所需硬件资源超过当前可用资源，需减小模型规格，降低单个ACL Graph占用的Stream数量。若多个ACL Graph并发执行，需减少并发数量，建议每批ACL Graph执行结束后再执行下一批。

<a id="section10318152845313"></a>

## Notify资源不足现象及解决方法

### 问题现象

- 报错示例1：

    EE1023打屏报错：

    ```text
    Resource_Error(EE1023): Alloc Notify resource failed. Reason: Too many ACL graphs are executed concurrently.
            Solution: For details about the troubleshooting method, search for the keyword "EE1023" on https://www.hiascend.com/document/.
    TraceBack (most recent call last):
            rtStreamEndCapture execution failed, reason=driver error:no notify resource[FUNC:FuncErrorReason][FILE:error_message_manage.cc][LINE:69]
    ```

    plog日志中的报错：

    ```text
    [ERROR] RUNTIME(486565,rtstest_host):2026-07-05-18:26:40.664.341 [context_aclgraph.cc:385]486565 CreateNotify:Notify create failed, setup failed, device_id=0, retCode=0x702001b. ErrorCode=EE1023.
    [ERROR] RUNTIME(486565,rtstest_host):2026-07-05-18:26:40.664.393 [context_aclgraph.cc:532]486565 StreamEndCapture:set notify for add capture stream failed, device_id=0, origin stream_id=61, capture model_id=21845, stream_id=43694, retCode=0x702001b.
    [ERROR] RUNTIME(486565,rtstest_host):2026-07-05-18:26:40.665.908 [api_c_standard_soc.cc:726]486565 rtStreamEndCapture:ErrCode=207009, desc=[driver error:no notify resource], InnerCode=0x702001b
    [ERROR] RUNTIME(486565,rtstest_host):2026-07-05-18:26:40.665.917 [error_message_manage.cc:69]486565 FuncErrorReason:rtStreamEndCapture execution failed, reason=no notify resource. ErrorCode=EE1023.
    ```

- 报错示例2：

    EE1023打屏报错：

    ```text
    Resource_Error(EE1023): Alloc Notify resource failed. Reason: Too many Notify objects are created.
            Solution: For details about the troubleshooting method, search for the keyword "EE1023" on https://www.hiascend.com/document/.
    TraceBack (most recent call last):
            Notify create failed, setup failed, drv devId=0, retCode=0x702001b[FUNC:NotifyCreate][FILE:api_impl.cc][LINE:4634]
            rtNotifyCreateWithFlag execution failed, reason=driver error:no notify resource[FUNC:FuncErrorReason][FILE:error_message_manage.cc][LINE:69]
    ```

    plog日志中的报错：

    ```text
    [ERROR] RUNTIME(9521,rtstest_host):2026-07-16-19:24:34.804.811 [api_impl.cc:4631]9521 NotifyCreate:Alloc Notify resource failed. Reason: Too many Notify objects are created. ErrorCode=EE1023.
    [ERROR] RUNTIME(9521,rtstest_host):2026-07-16-19:24:34.804.850 [api_impl.cc:4634]9521 NotifyCreate:Notify create failed, setup failed, drv devId=0, retCode=0x702001b
    [ERROR] RUNTIME(9521,rtstest_host):2026-07-16-19:24:34.804.861 [api_error.cc:3681]9521 NotifyCreate:Create notify failed, device id=0.
    [ERROR] RUNTIME(9521,rtstest_host):2026-07-16-19:24:34.804.875 [api_c.cc:1936]9521 rtNotifyCreateWithFlag:ErrCode=207009, desc=[driver error:no notify resource], InnerCode=0x702001b
    [ERROR] RUNTIME(9521,rtstest_host):2026-07-16-19:24:34.804.879 [error_message_manage.cc:69]9521 FuncErrorReason:rtNotifyCreateWithFlag execution failed, reason=driver error:no notify resource
    [ERROR] RUNTIME(9521,rtstest_host):2026-07-16-19:24:34.809.302 [stars_engine.cc:1569]9540 ProcLogicCqReport:Task run failed, device_id=0, stream_id=60, task_id=0, sqe_type=63(unknown), errType=0x8(sqe error), sqSwStatus=0
    [ERROR] RUNTIME(9521,rtstest_host):2026-07-16-19:24:34.818.379 [device_error_proc.cc:1454]9540 ProcessStarsSqeErrorInfo:The error from device(chipId:0, dieId:0), serial number is 7, sqe error occurred during task execution, stream_id:60, task_id:0, sq_id:3, sq_head:0.
    ```

### 原因分析

Device上的硬件资源总量有限，由当前Device上所有进程共享，通过aclrtCreateNotify接口创建的Notify，均从同一Device分配。

当已分配的资源不再使用但未及时释放时，可用资源会逐渐减少，最终导致新的申请失败。此外，多个ACL Graph并发执行时，正在执行的ACL Graph所占有的资源在其执行结束前无法被回收，此时其他ACL Graph无法获取资源。

### 解决方法

1. 检查创建Notify和销毁Notify的接口是否成对调用，确认aclrtCreateNotify和aclrtDestroyNotify是否成对调用。另外，对于空闲的Notify，应及时调用aclrtDestroyNotify释放资源。
2. 在ACL Graph场景下，需检查是否存在已执行完毕但尚未销毁的ACL Graph，并及时调用aclmdlRIDestroy释放其内部占用的Notify资源。若多个ACL Graph并发执行，应降低并发数量，以防止多个ACL Graph同时占用大量Notify。

<a id="section4510153665411"></a>

## Event资源不足现象及解决方法

### 问题现象

EE1023打屏报错：

```text
Resource_Error(EE1023): Alloc Event resource failed. Reason: Too many events are created.
        Solution: For details about the troubleshooting method, search for the keyword "EE1023" on https://www.hiascend.com/document/.
TraceBack (most recent call last):
        rtEventCreateWithFlag execution failed, reason=driver error:no event resource[FUNC:FuncErrorReason][FILE:error_message_manage.cc][LINE:69]
```

plog日志中的报错：

```text
[ERROR] RUNTIME(277881,rtstest_host):2026-07-13-12:23:44.070.908 [event_david.cc:101]277881 GenEventId:Alloc Event resource failed. Reason: Too many events are created. ErrorCode=EE1023.
[ERROR] RUNTIME(277881,rtstest_host):2026-07-13-12:23:44.071.023 [event_david.cc:104]277881 GenEventId:Failed to allocate event id, device_id=0, tsId=0, retCode=0x7020019.
[ERROR] RUNTIME(277881,rtstest_host):2026-07-13-12:23:44.071.041 [api_impl_david.cc:405]277881 EventCreate:Gen event id failed, device_id=0, tsId=0, retCode=0x7020019
[ERROR] RUNTIME(277881,rtstest_host):2026-07-13-12:23:44.071.053 [api_error.cc:1343]277881 EventCreate:Create event failed.
[ERROR] RUNTIME(277881,rtstest_host):2026-07-13-12:23:44.071.110 [api_c.cc:661]277881 rtEventCreateWithFlag:ErrCode=207007, desc=[driver error:no event resource], InnerCode=0x7020019
[ERROR] RUNTIME(277881,rtstest_host):2026-07-13-12:23:44.071.122 [error_message_manage.cc:69]277881 FuncErrorReason:rtEventCreateWithFlag execution failed, reason=driver error:no event resource
```

### 原因分析

Device上的硬件资源总量有限，由当前Device上所有进程共享，通过aclrtCreateEvent、aclrtCreateEventWithFlag等接口创建的Event，均从同一Device分配。

当已分配的资源不再使用却未及时释放时，可用资源会逐渐减少，最终导致新的申请失败。此外，在循环中频繁创建Event，却未成对调用aclrtDestroyEvent接口来销毁Event，导致Event资源泄漏，也会导致Event资源申请失败。

### 解决方法

检查创建Event和销毁Event的接口是否成对调用，例如aclrtCreateEvent和aclrtDestroyEvent是否成对调用。另外，对于空闲的Event，应及时调用aclrtDestroyEvent释放资源。

<a id="section66681856115411"></a>

## 异步拷贝任务队列资源不足现象及解决方法

### 问题现象

EE1023打屏报错：

```text
Resource_Error(EE1023): Expanding the capacity failed. Reason: There are too many asynchronous copy tasks in the ACL Graph. 1. If the value of numBatches for aclrtMemcpyBatchAsync in the ACL Graph is too large, reduce the value of numBatches. 2. If the value of height for aclrtMemcpy2dAsync in the ACL Graph is too large, reduce the value of height.  
Solution: For details about the troubleshooting method, search for the keyword "EE1023" on https://www.hiascend.com/document/.
TraceBack (most recent call last):
        rtMemcpy2dAsync execution failed, reason=driver error:no stream resource[FUNC:FuncErrorReason][FILE:error_message_manage.cc][LINE:69]
```

plog日志中的报错：

```text
[ERROR] RUNTIME(830375,rtstest_host):2026-07-22-18:23:32.741.683 [stream_jetty_context.cc:69]830375 ExpandCapacity:Expanding the capacity failed. Reason: There are too many asynchronous copy tasks in the ACL Graph. 1. If the value of numBatches for aclrtMemcpyBatchAsync in the ACL Graph is too large, reduce the value of numBatches. 2. If the value of height for aclrtMemcpy2dAsync in the ACL Graph is too large, reduce the value of height. ErrorCode=EE1023.  
[ERROR] RUNTIME(830375,rtstest_host):2026-07-22-18:23:32.741.712 [stream_jetty_handler.cc:115]830375 CreateAndAppendWqe:ExpandCapacity failed, capacity=32768, max_depth=32768, stream_id=59, device_id=7, retCode=0x7110019.  
[ERROR] RUNTIME(830375,rtstest_host):2026-07-22-18:23:32.741.714 [stream_jetty_handler.cc:163]830375 HandleUbDmaTask:Append wqe failed, stream_id=59, retCode=0x7110019.  
[ERROR] RUNTIME(830375,rtstest_host):2026-07-22-18:23:32.741.717 [memory_task.cc:60]830375 ConvertAsyncDma2DForSoftWareSq:HandleUbDmaTask failed, device_id=7, stream_id=59, retCode=0x7110019.  
[ERROR] RUNTIME(830375,rtstest_host):2026-07-22-18:23:32.741.719 [memory_memcpy_async_task.cc:496]830375 MemcpyAsyncTaskInitV2:ConvertAsyncDma2D failed, retCode=0x7110019.  
[ERROR] RUNTIME(830375,rtstest_host):2026-07-22-18:23:32.741.721 [memcpy_starsv2.cc:108]830375 Memcpy2DAsync:Init MemcpyAsyncTask failed, stream_id=60, retCode=0x7110019  
[ERROR] RUNTIME(830375,rtstest_host):2026-07-22-18:23:32.741.726 [api_error.cc:3051]830375 MemCopy2DAsync:Memcpy2d async failed, dstPitch=1024, srcPitch=1024, width=1024, height=100, kind=1, isInvolvePageableMemory=0  
[ERROR] RUNTIME(830375,rtstest_host):2026-07-22-18:23:32.741.740 [api_c.cc:1324]830375 rtMemcpy2dAsync:ErrCode=207008, desc=[driver error:no stream resource], InnerCode=0x7110019  
[ERROR] RUNTIME(830375,rtstest_host):2026-07-22-18:23:32.741.743 [error_message_manage.cc:69]830375 FuncErrorReason:rtMemcpy2dAsync execution failed, reason=driver error:no stream resource
```

### 原因分析

ACL Graph中提交大量异步拷贝任务会持续占用硬件资源，任务在队列中累计超过上限，导致后续异步拷贝任务提交失败。

### 解决方法

- 在ACL Graph中，如果调用aclrtMemcpyBatchAsync批量复制接口时传入的numBatches值过大，则需要减小numBatches的值。
- 在ACL Graph中，如果调用aclrtMemcpy2dAsync矩阵数据复制接口时传入的height值过大，则需要减小height的值。

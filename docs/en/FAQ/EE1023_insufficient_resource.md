# EE1023 Insufficient Resources

<!-- md-trans-meta sourceCommit=31ae292a88c1a38674abaa350b60eba724bab178 translatedAt=2026-10-16T09:57:36.165Z pushedAt=2026-10-22T08:48:42.206Z -->

## Symptom

An EE1023 error is triggered when Runtime fails to request hardware scheduling resources related to the stream, event, and Notify from the driver, indicating insufficient hardware resources on the device.

The following is an example of the EE1023 error:

```text
Resource_Error(EE1023): Expanding the capacity failed. Reason: There are too many asynchronous copy tasks in the ACL Graph. 1. If the value of numBatches for aclrtMemcpyBatchAsync in the ACL Graph is too large, reduce the value of numBatches. 2. If the value of height for aclrtMemcpy2dAsync in the ACL Graph is too large, reduce the value of height.  
Solution: For details about the troubleshooting method, search for the keyword "EE1023" on https://www.hiascend.com/document/.
......
```

## Troubleshooting Approach

1. **Confirm the resource type.**

    Based on **Reason** in the EE1023 error and **retCode** in the plog log of the same period, determine the type or scenario of the insufficient hardware resource. The plog log refers to the host application log, and its default path is "$HOME/ascend/log/\[run|debug\]/plog/plog-pid\_\*.log".

    | retCode in the plog Log | Typical Log Keyword | Resource Type |
    | --- | --- | --- |
    | 0x7020023 | Alloc Stream resource failed, resource alloc fail, or Failed to alloc stream id | Stream resource |
    | 0x702001b | Alloc Notify resource failed or no notify resource | Notify resource |
    | 0x7020019 | Alloc Event resource failed | Event resource |
    | 0x7110019 | The number of async copy tasks reaches the maximum limit | Asynchronous copy task queue resource |

2. **Further troubleshoot the causes of various types of insufficient resources.**

    For the troubleshooting methods of various types of insufficient resources, see [Symptom and Solution for the Insufficient Stream Resource](#section18622174521211), [Symptom and Solution for the Insufficient Notify Resource](#section10318152845313), [Symptom and Solution for the Insufficient Event Resource](#section4510153665411), and [Symptom and Solution of the Insufficient Resource for the Asynchronous Copy Task Queue](#section66681856115411).

    Different types of resources involve different APIs for troubleshooting. The overall approach is as follows:

    1. **Check whether the creation and destruction of related resources are paired.** For resources that are no longer in use, call the corresponding **Destroy** API to release them in a timely manner, for example, **aclrtDestroyStream**, **aclrtDestroyEvent**, **aclrtDestroyNotify**, and **aclmdlRIDestroy**.
    2. **Check the device resource usage.** Use the **npu-smi info** command to check the device resource usage status and confirm whether other processes are occupying resources.
    3. **Troubleshoot multiple processes.** If multiple processes share the same device, reduce the number of concurrent processes.

3. **Contact technical support.**

    If the preceding steps do not resolve the issue, obtain the logs and click [Link](https://www.hiascend.com/support) to contact technical support.

<a id="section18622174521211"></a>

## Symptom and Solution for the Insufficient Stream Resource

### Symptom

- Error example 1:

    EE1023 error on the screen:

    ```text
    Resource_Error(EE1023): Alloc Stream resource failed. Reason: Too many streams are captured to the ACL graph (model_id=49).
            Solution: For details about the troubleshooting method, search for the keyword "EE1023" on https://www.hiascend.com/document/.
    TraceBack (most recent call last):
            Build SQ/CQ failed, stream_id=47, model_id=49, retCode=0x7020023.[FUNC:PrepareModelExecute][FILE:capture_model.cc][LINE:352]
            rtModelExecute execution failed, reason=driver error:resource alloc fail[FUNC:FuncErrorReason][FILE:error_message_manage.cc][LINE:69]
    ```

    Error in the plog log:

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

- Error example 2:

    EE1023 error on the screen:

    ```text
    Resource_Error(EE1023): Alloc Stream resource failed. Reason: Too many streams are created.
            Solution: For details about the troubleshooting method, search for the keyword "EE1023" on https://www.hiascend.com/document/.
    TraceBack (most recent call last):
            rtStreamCreateWithFlags execution failed, reason=driver error:resource alloc fail[FUNC:FuncErrorReason][FILE:error_message_manage.cc][LINE:69]
    ```

    Error in the plog log:

    ```text
    [ERROR] RUNTIME(11803,rtstest_host):2026-07-09-21:52:24.482.342 [stream.cc:728]11803 Setup:Alloc sq cq failed, stream_id=2047, retCode=0x7020023.
    [ERROR] RUNTIME(11803,rtstest_host):2026-07-09-21:52:24.482.347 [stream.cc:731]11803 Setup:Alloc Stream resource failed. Reason: Too many streams are created. ErrorCode=EE1023.
    [ERROR] RUNTIME(11803,rtstest_host):2026-07-09-21:52:24.482.377 [context.cc:1572]11803 StreamCreate:Setup stream failed, retCode=0x7020023.
    [ERROR] RUNTIME(11803,rtstest_host):2026-07-09-21:52:24.482.388 [api_impl.cc:1487]11803 StreamCreate:Create stream failed, priority=0, flags=0.
    [ERROR] RUNTIME(11803,rtstest_host):2026-07-09-21:52:24.482.402 [api_c_stream.cc:85]11803 rtStreamCreateWithFlags:ErrCode=207005, desc=[driver error:resource alloc fail], InnerCode=0x7020023
    [ERROR] RUNTIME(11803,rtstest_host):2026-07-09-21:52:24.482.405 [error_message_manage.cc:69]11803 FuncErrorReason:rtStreamCreateWithFlags execution failed, reason=driver error:resource alloc fail
    ```

### Cause Analysis

The total hardware resources on a device are limited and shared by all processes on the current device. Explicitly created streams (for example, those created through the **aclrtCreateStream** API) and streams inside ACL Graphs are all allocated from the same device.

When allocated resources are no longer in use but are not released in time, the available resources will gradually decrease, eventually leading to the failure of new requests. In addition, when multiple ACL Graphs are executed concurrently, the resources occupied by the ACL Graphs being executed cannot be reclaimed before their execution ends, so other ACL Graphs cannot obtain resources.

### Solution

1. Check whether the APIs for creating and destroying streams are called in pairs, for example, whether **aclrtCreateStream** and **aclrtDestroyStream** are called in pairs. Additionally, for idle streams, **aclrtDestroyStream** should be called in a timely manner to release resources.
2. In the ACL Graph scenario, if a single ACL Graph is too large in specification, causing the required hardware resources to exceed the currently available resources, reduce the model specification to lower the number of streams occupied by a single ACL Graph. If multiple ACL Graphs are executed concurrently, reduce the concurrency. It is recommended to execute the next batch of ACL Graphs only after the current batch finishes execution.

<a id="section10318152845313"></a>

## Symptom and Solution for the Insufficient Notify Resource

### Symptom

- Error example 1:

    EE1023 error on the screen:

    ```text
    Resource_Error(EE1023): Alloc Notify resource failed. Reason: Too many ACL graphs are executed concurrently.
            Solution: For details about the troubleshooting method, search for the keyword "EE1023" on https://www.hiascend.com/document/.
    TraceBack (most recent call last):
            rtStreamEndCapture execution failed, reason=driver error:no notify resource[FUNC:FuncErrorReason][FILE:error_message_manage.cc][LINE:69]
    ```

    Error in the plog log:

    ```text
    [ERROR] RUNTIME(486565,rtstest_host):2026-07-05-18:26:40.664.341 [context_aclgraph.cc:385]486565 CreateNotify:Notify create failed, setup failed, device_id=0, retCode=0x702001b. ErrorCode=EE1023.
    [ERROR] RUNTIME(486565,rtstest_host):2026-07-05-18:26:40.664.393 [context_aclgraph.cc:532]486565 StreamEndCapture:set notify for add capture stream failed, device_id=0, origin stream_id=61, capture model_id=21845, stream_id=43694, retCode=0x702001b.
    [ERROR] RUNTIME(486565,rtstest_host):2026-07-05-18:26:40.665.908 [api_c_standard_soc.cc:726]486565 rtStreamEndCapture:ErrCode=207009, desc=[driver error:no notify resource], InnerCode=0x702001b
    [ERROR] RUNTIME(486565,rtstest_host):2026-07-05-18:26:40.665.917 [error_message_manage.cc:69]486565 FuncErrorReason:rtStreamEndCapture execution failed, reason=no notify resource. ErrorCode=EE1023.
    ```

- Error example 2:

    EE1023 error on the screen:

    ```text
    Resource_Error(EE1023): Alloc Notify resource failed. Reason: Too many Notify objects are created.
            Solution: For details about the troubleshooting method, search for the keyword "EE1023" on https://www.hiascend.com/document/.
    TraceBack (most recent call last):
            Notify create failed, setup failed, drv devId=0, retCode=0x702001b[FUNC:NotifyCreate][FILE:api_impl.cc][LINE:4634]
            rtNotifyCreateWithFlag execution failed, reason=driver error:no notify resource[FUNC:FuncErrorReason][FILE:error_message_manage.cc][LINE:69]
    ```

    Error in the plog log:

    ```text
    [ERROR] RUNTIME(9521,rtstest_host):2026-07-16-19:24:34.804.811 [api_impl.cc:4631]9521 NotifyCreate:Alloc Notify resource failed. Reason: Too many Notify objects are created. ErrorCode=EE1023.
    [ERROR] RUNTIME(9521,rtstest_host):2026-07-16-19:24:34.804.850 [api_impl.cc:4634]9521 NotifyCreate:Notify create failed, setup failed, drv devId=0, retCode=0x702001b
    [ERROR] RUNTIME(9521,rtstest_host):2026-07-16-19:24:34.804.861 [api_error.cc:3681]9521 NotifyCreate:Create notify failed, device id=0.
    [ERROR] RUNTIME(9521,rtstest_host):2026-07-16-19:24:34.804.875 [api_c.cc:1936]9521 rtNotifyCreateWithFlag:ErrCode=207009, desc=[driver error:no notify resource], InnerCode=0x702001b
    [ERROR] RUNTIME(9521,rtstest_host):2026-07-16-19:24:34.804.879 [error_message_manage.cc:69]9521 FuncErrorReason:rtNotifyCreateWithFlag execution failed, reason=driver error:no notify resource
    [ERROR] RUNTIME(9521,rtstest_host):2026-07-16-19:24:34.809.302 [stars_engine.cc:1569]9540 ProcLogicCqReport:Task run failed, device_id=0, stream_id=60, task_id=0, sqe_type=63(unknown), errType=0x8(sqe error), sqSwStatus=0
    [ERROR] RUNTIME(9521,rtstest_host):2026-07-16-19:24:34.818.379 [device_error_proc.cc:1454]9540 ProcessStarsSqeErrorInfo:The error from device(chipId:0, dieId:0), serial number is 7, sqe error occurred during task execution, stream_id:60, task_id:0, sq_id:3, sq_head:0.
    ```

### Cause Analysis

The total hardware resources on a device are limited and shared by all processes on the current device. Notify objects created through the **aclrtCreateNotify** API are all allocated from the same device.

When allocated resources are no longer in use but are not released in time, the available resources will gradually decrease, eventually leading to the failure of new requests. In addition, when multiple ACL Graphs are executed concurrently, the resources occupied by the ACL Graphs being executed cannot be reclaimed before their execution ends, so other ACL Graphs cannot obtain resources.

### Solution

1. Check whether the APIs for creating and destroying Notify objects are called in pairs, for example, whether **aclrtCreateNotify** and **aclrtDestroyNotify** are called in pairs. Additionally, for idle Notify resources, call **aclrtDestroyNotify** in a timely manner to release them.
2. In the ACL Graph scenario, check whether there are ACL Graphs that have finished execution but have not been destroyed, and call **aclmdlRIDestroy** in a timely manner to release the Notify resources occupied internally. If multiple ACL Graphs are executed concurrently, reduce the concurrency to prevent multiple ACL Graphs from occupying a large number of Notify resources at the same time.

<a id="section4510153665411"></a>

## Symptom and Solution for the Insufficient Event Resource

### Symptom

EE1023 error on the screen:

```text
Resource_Error(EE1023): Alloc Event resource failed. Reason: Too many events are created.
        Solution: For details about the troubleshooting method, search for the keyword "EE1023" on https://www.hiascend.com/document/.
TraceBack (most recent call last):
        rtEventCreateWithFlag execution failed, reason=driver error:no event resource[FUNC:FuncErrorReason][FILE:error_message_manage.cc][LINE:69]
```

Error in the plog log:

```text
[ERROR] RUNTIME(277881,rtstest_host):2026-07-13-12:23:44.070.908 [event_david.cc:101]277881 GenEventId:Alloc Event resource failed. Reason: Too many events are created. ErrorCode=EE1023.
[ERROR] RUNTIME(277881,rtstest_host):2026-07-13-12:23:44.071.023 [event_david.cc:104]277881 GenEventId:Failed to allocate event id, device_id=0, tsId=0, retCode=0x7020019.
[ERROR] RUNTIME(277881,rtstest_host):2026-07-13-12:23:44.071.041 [api_impl_david.cc:405]277881 EventCreate:Gen event id failed, device_id=0, tsId=0, retCode=0x7020019
[ERROR] RUNTIME(277881,rtstest_host):2026-07-13-12:23:44.071.053 [api_error.cc:1343]277881 EventCreate:Create event failed.
[ERROR] RUNTIME(277881,rtstest_host):2026-07-13-12:23:44.071.110 [api_c.cc:661]277881 rtEventCreateWithFlag:ErrCode=207007, desc=[driver error:no event resource], InnerCode=0x7020019
[ERROR] RUNTIME(277881,rtstest_host):2026-07-13-12:23:44.071.122 [error_message_manage.cc:69]277881 FuncErrorReason:rtEventCreateWithFlag execution failed, reason=driver error:no event resource
```

### Cause Analysis

The total hardware resources on a device are limited and shared by all processes on the current device. Events created through APIs such as **aclrtCreateEvent** and **aclrtCreateEventWithFlag** are all allocated from the same device.

When allocated resources are no longer in use but are not released in time, the available resources will gradually decrease, eventually leading to failure of new requests. In addition, frequently creating events in a loop without calling the **aclrtDestroyEvent** API in a paired manner to destroy them causes event resource leaks, which also leads to event resource request failures.

### Solution

Check whether the APIs for creating and destroying events are called in pairs, for example, whether **aclrtCreateEvent** and **aclrtDestroyEvent** are called in pairs. Additionally, for idle events, call **aclrtDestroyEvent** in a timely manner to release resources.

<a id="section66681856115411"></a>

## Symptom and Solution of the Insufficient Resource for the Asynchronous Copy Task Queue

### Symptom

EE1023 error on the screen:

```text
Resource_Error(EE1023): Expanding the capacity failed. Reason: There are too many asynchronous copy tasks in the ACL Graph. 1. If the value of numBatches for aclrtMemcpyBatchAsync in the ACL Graph is too large, reduce the value of numBatches. 2. If the value of height for aclrtMemcpy2dAsync in the ACL Graph is too large, reduce the value of height.  
Solution: For details about the troubleshooting method, search for the keyword "EE1023" on https://www.hiascend.com/document/.
TraceBack (most recent call last):
        rtMemcpy2dAsync execution failed, reason=driver error:no stream resource[FUNC:FuncErrorReason][FILE:error_message_manage.cc][LINE:69]
```

Error in the plog log:

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

### Cause Analysis

Submitting a large number of asynchronous copy tasks in an ACL Graph continuously occupies hardware resources. When the tasks accumulated in the queue exceed the upper limit, subsequent asynchronous copy task submissions fail.

### Solution

- In an ACL Graph, if the value of **numBatches** passed when the **aclrtMemcpyBatchAsync** API is called for batch copy is too large, reduce the value.
- In an ACL Graph, if the value of **height** passed when the **aclrtMemcpy2dAsync** API is called for cube data copy is too large, reduce the value.

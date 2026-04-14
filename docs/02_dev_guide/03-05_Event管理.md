# Event管理

## Event概念

Event用于同一**Device内**、**不同Stream之间**的任务同步事件。**它支持一个任务等待一个事件**，例如stream2的任务依赖stream1的任务，想保证stream1中的任务先完成，这时可创建一个Event，将该Event插入到stream1中（Event Record任务），在stream2中插入一个等待Event完成的任务（Event Wait任务）；**也支持多个任务等待同一个事件（多等一）**，例如stream2和stream3中的任务都等待Stream1中的Event完成；同时，Event支持记录**事件时间戳**信息。

一个任务等待一个事件的图示如下：

![](figures/Event_一个任务等待一个事件.png)

多个任务等待同一个事件的图示如下：

![](figures/Event_多个任务等待一个事件.png)

<br>
<br>

## Event的创建与销毁

以下是创建两个Event并销毁的代码示例，该示例仅用于说明Event使用方法，不可以直接拷贝编译运行。完整样例代码请参见[Link](https://gitcode.com/cann/runtime/blob/master/example/1_basic_features/event/1_event_timestamp)。

```
aclrtEvent startEvent;
aclrtEvent endEvent;
// 创建Event，接口传入ACL_EVENT_SYNC参数，表示创建的Event用于同步
aclrtCreateEventExWithFlag(&startEvent, ACL_EVENT_SYNC);
aclrtCreateEventExWithFlag(&endEvent, ACL_EVENT_SYNC);
......
// 销毁Event
aclrtDestroyEvent(startEvent);
aclrtDestroyEvent(endEvent);
```

<br>
<br>

## Event等待

多Stream之间任务的同步等待可以利用Event实现，例如，若stream2的任务依赖stream1的任务，想保证stream1中的任务先完成，这时可创建一个Event，调用aclrtRecordEvent接口将Event插入到stream1中（通常称为Event Record任务），调用aclrtStreamWaitEvent接口在stream2中插入一个等待Event完成的任务（通常称为Event Wait任务）。

以下为调用aclrtStreamWaitEvent接口的示例代码，不可以直接拷贝编译运行，仅供参考：

```
// 创建一个Event
aclrtEvent event;
aclrtCreateEventExWithFlag(&event, ACL_EVENT_SYNC);

// 创建stream1
aclrtStream stream1;
aclrtCreateStream(&stream1);

// 创建stream2
aclrtStream stream2;
aclrtCreateStream(&stream2);

// 在stream1上下发任务
......

// 在stream1末尾添加了一个event
aclrtRecordEvent(event, stream1);

// 在stream2上下发不依赖stream1执行完成的任务
......

// 阻塞stream2运行，直到指定event发生，也就是stream1执行完成
aclrtStreamWaitEvent(stream2, event);

// 在stream2上下发依赖stream1执行完成的任务
......

// 阻塞应用程序运行，直到stream1和stream2中的所有任务都执行完成
aclrtSynchronizeStream(stream1);
aclrtSynchronizeStream(stream2);

// 显式销毁资源
aclrtDestroyStream(stream1);
aclrtDestroyStream(stream2);
aclrtDestroyEvent(event);
......
```

<br>
<br>

## 记录Event时间戳

在[Event的创建与销毁](#Event的创建与销毁)章节中创建的Event可用于统计Stream上计算任务的耗时，代码示例如下。该示例仅用于说明Event使用方法，不可以直接拷贝编译运行。完整样例代码请参见[Link](https://gitcode.com/cann/runtime/blob/master/example/1_basic_features/event/1_event_timestamp)。

```
uint64_t time = 0;
float useTime = 0;

// 创建Stream
aclrtStream stream;
aclrtCreateStream(&stream);

aclrtEvent startEvent;
aclrtEvent endEvent;
// 创建Event，接口传入ACL_EVENT_TIME_LINE参数，表示创建的Event用于记录
aclrtCreateEventExWithFlag(&startEvent, ACL_EVENT_TIME_LINE);
aclrtCreateEventExWithFlag(&endEvent, ACL_EVENT_TIME_LINE);

// 插入startEvent
aclrtRecordEvent(startEvent, stream);
// 在Stream中下发计算任务
kernel<<< grid, block, 0, stream>>>(...);
// 插入endEvent
aclrtRecordEvent(endEvent, stream);
aclrtSynchronizeStream(stream);

// 获取时间戳并计算耗时
aclrtEventElapsedTime(&useTime, startEvent, endEvent);
```

<br>
<br>

## Event查询

调用aclrtQueryEventStatus接口可查询指定Event是否完成，非阻塞接口，Event状态包括ACL\_EVENT\_RECORDED\_STATUS\_COMPLETE（所有任务都已经执行完成）、ACL\_EVENT\_RECORDED\_STATUS\_NOT\_READY（有未执行完的任务）。

以下是通过Event实现多线程内存池复用管理机制的代码示例，不可以直接拷贝编译运行，仅供参考。

1.  在A线程中创建内存池，算子所用的内存来源于内存池，在算子后面插入Event Record任务。

    ```
    // 申请内存池
    ......
    // 创建Stream
    aclrtStream stream;
    aclrtCreateStream(&stream);
    
    // 创建Event
    aclrtEvent event;
    aclrtCreateEventExWithFlag(&event, ACL_EVENT_CAPTURE_STREAM_PROGRESS);
    
    // 在Stream中下发计算任务
    ......
    // 在算子所在stream插入event
    aclrtRecordEvent(event, stream);
    ```

2.  在B线程中调用查询接口，如果查询的Event已经完成，则代表Event Record前面的算子内存都可以被安全的复用。

    ```
    aclrtEventRecordedStatus status;
    // 查询线程A的event是否完成
    aclrtQueryEventStatus(event, &status);
    if (status == ACL_EVENT_RECORDED_STATUS_COMPLETE) {
    // event已完成，算子占用的内存可以复用
    } else {
    // 算子并未执行完成，该算子占用的内存不能被复用
    }
    
    ```

<br>
<br>

## Event同步

调用aclrtSynchronizeEvent接口阻塞当前主机线程直到指定的Event事件完成。以下为示例代码，不可以直接拷贝编译运行，仅供参考：

```
// 创建Event
aclrtEvent event;
aclrtCreateEventExWithFlag(&event, ACL_EVENT_CAPTURE_STREAM_PROGRESS);

// 创建Stream
aclrtStream stream;
aclrtCreateStream(&stream);

// 在Stream上下发任务
......

// 在Stream上记录Event
aclrtRecordEvent(event, stream);

// 阻塞应用程序运行直到Event发生
aclrtSynchronizeEvent(event);

// 显式销毁资源
aclrtDestroyStream(stream);
aclrtDestroyEvent(event);
```


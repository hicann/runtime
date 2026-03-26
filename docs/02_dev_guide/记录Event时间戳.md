# 记录Event时间戳

在[Event的创建与销毁](Event的创建与销毁.md)章节中创建的Event可用于统计Stream上计算任务的耗时，代码示例如下。该示例仅用于说明Event使用方法，不可以直接拷贝编译运行。完整样例代码请参见[Link](https://gitcode.com/cann/runtime/blob/master/example/1_basic_features/event/1_event_timestamp)。

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



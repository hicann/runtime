# Event的创建与销毁

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



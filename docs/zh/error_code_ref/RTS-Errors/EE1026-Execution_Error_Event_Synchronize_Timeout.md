# EE1026 Execution\_Error\_Event\_Synchronize\_Timeout

## 错误信息

报错格式如下，占位符%s的含义依次为Event ID、报错原因：

```text
Event (event_id=%s) synchronization timeout. %s
```

报错示例如下：

```text
Event (event_id=5) synchronization timeout. A timeout occurred when waiting for task execution before Event Record. The timeout interval is 1000 ms, device_id=0.
```

## 可能原因

1. 最后一次Event Record之前提交的任务执行时间过长、执行错误或存在未解决的依赖关系。
2. 同步超时时间小于最新一次Event Record之前提交的任务所需的完成时间。
3. 对于IPC Event，对端进程或其设备停止运行。

## 解决方法

1. 查找最后一次Event Record前提交的任务是否存在执行错误或未解决的依赖关系。
2. 通过配置Event超时时间的接口(如aclrtSynchronizeEventWithTimeout)延长同步超时时间。
3. 对于IPC Event，请确认对端进程及其设备是否仍在运行。

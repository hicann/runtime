# Notify管理

Notify通常用于多个Device之间的同步，如下图所示：Device 0向Device 1发送完数据后，通过Notify通知Device 1数据已写完。

![](figures/Notify_多个Device之间的同步.png)

Notify只支持一对一通知机制。若要实现向多个Device发起通知，要发起多次Notify操作，如下图所示：

![](figures/Notify_多个Device通知机制.png)

Notify与Event功能区别在于，Notify Wait完成后，Notify状态会自动重置，因此一个Notify Record任务只能通知一个Notify Wait任务；而Event Wait并不会自动重置Event状态，因此一个Event Record任务可以做到通知一个或多个Event Wait任务。此外，Notify不支持时间戳功能。

在同一个Device两条流间同步的场景下，Notify可以实现Event实现相同的效果。

Notify相关接口的调用代码示例如下：

```
// 创建Stream
aclrtStream stream1;
aclrtStream stream2;
aclrtCreateStream(&stream1);
aclrtCreateStream(&stream2);
// 创建Notify
aclrtNotify notify;
aclrtCreateNotify(&notify, ACL_NOTIFY_DEFAULT);

// 在stream2插入wait
aclrtWaitAndResetNotify(notify, stream2, 0);
// 在stream2中下发计算任务
......

// 在stream1下发stream2计算任务所依赖的拷贝任务
......
// 在stream1插入record
aclrtRecordNotify(notify, stream1);

// 同步等待任务完成
aclrtSynchronizeStream(stream1);
aclrtSynchronizeStream(stream2);

// 销毁notify
aclrtDestroyNotify(notify);
```


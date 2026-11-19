# Notify Management

<!-- md-trans-meta sourceCommit=31ae292a88c1a38674abaa350b60eba724bab178 translatedAt=2026-10-16T10:16:21.023Z pushedAt=2026-10-20T05:58:37.268Z -->

Notify is typically used for synchronization between multiple devices, as shown in the following figure: after device 0 finishes sending data to device 1, it notifies device 1 through Notify that the data has been written.

![](figures/Notify_multi_devices_sync.png)

Notify supports only the one-to-one notification mechanism. To send notifications to multiple devices, multiple Notify operations must be initiated, as shown in the following figure.

![](figures/Notify_multi_devices_notify.png)

The functional difference between Notify and an event is that after a Notify Wait is completed, the Notify state is automatically reset, so a Notify Record task can notify only one Notify Wait task. In contrast, an Event Wait does not automatically reset the event state, so an Event Record task can notify one or more Event Wait tasks. In addition, Notify does not support the timestamp feature.

In the scenario of synchronization between two streams on the same device, Notify can achieve the same effect as the event.

The following is an example of calling Notify-related APIs:

```c
// Create a stream.
aclrtStream stream1;
aclrtStream stream2;
aclrtCreateStream(&stream1);
aclrtCreateStream(&stream2);
// Create Notify.
aclrtNotify notify;
aclrtCreateNotify(&notify, ACL_NOTIFY_DEFAULT);

// Insert Wait into stream2.
aclrtWaitAndResetNotify(notify, stream2, 0);
// Issue the compute task in stream2.
......

// Dispatch the copy task that the computation task in stream2 depends on in stream1.
......
// Insert record into stream1.
aclrtRecordNotify(notify, stream1);

// Synchronously wait for task completion.
aclrtSynchronizeStream(stream1);
aclrtSynchronizeStream(stream2);

// Destroy the Notify.
aclrtDestroyNotify(notify);
```

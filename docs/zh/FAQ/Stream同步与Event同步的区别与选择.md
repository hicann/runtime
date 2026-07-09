# Stream同步与Event同步的区别与选择

## 问题现象描述

**现象1：不理解Stream同步和Event同步的差异**

混淆两种同步机制的使用范围和特性，导致选择不当。

典型错误场景：
```c
// 需要等待跨Stream任务完成，但使用了Stream同步
aclrtSynchronizeStream(stream1);  // 仅等待 stream1，不等待 stream2
```

**现象2：同步时机选择不当导致性能问题或死锁**

错误选择同步方式：单流等待用Event（过度设计），多流协调用Stream同步（会阻塞）。

典型错误场景：
```c
// 单Stream内等待，但使用了Event同步（过度设计）
aclrtEvent event;
aclrtRecordEvent(event, stream);
aclrtSynchronizeEvent(event);  // Event同步比Stream同步更复杂
```

**现象3：错误使用同步接口导致任务执行顺序混乱**

跨Stream协调时未使用Event同步，导致任务依赖关系不正确。

## 可能原因

1. **不理解两种同步机制差异**：Stream 同步阻塞整流，Event 同步精细控制。
2. **错误选择同步方式**：单流等待用 Event，多流协调用 Stream，顺序颠倒。

## 处理步骤

### 原因1：不理解两种同步机制差异

**解决方法**：
- 理解 Stream 同步特性：
  - **作用范围**：阻塞指定 Stream 上的所有任务，直到全部完成
  - **适用场景**：等待单个 Stream 的整批任务完成
  - **接口**：aclrtSynchronizeStream(stream)
- 理解 Event 同步特性：
  - **作用范围**：精确控制到某个时间点，支持跨 Stream 同步
  - **适用场景**：跨 Stream 任务协调、精细时间点控制
  - **接口**：aclrtRecordEvent、aclrtSynchronizeEvent、aclrtStreamWaitEvent

对比示例：
```c
// Stream 同步：等待整流任务完成
aclrtMemcpyAsync(dst, size, src, size, ACL_MEMCPY_HOST_TO_DEVICE, stream);
myKernel<<<..., stream>>>();
aclrtMemcpyAsync(host, size, dst, size, ACL_MEMCPY_DEVICE_TO_HOST, stream);

aclrtSynchronizeStream(stream);  // 等待上述3个任务全部完成

// Event 同步：精确控制时间点
aclrtEvent event1, event2;
aclrtCreateEvent(&event1);
aclrtCreateEvent(&event2);

aclrtMemcpyAsync(dst, size, src, size, ACL_MEMCPY_HOST_TO_DEVICE, stream1);
aclrtRecordEvent(event1, stream1);  // 记录时间点1

aclrtStreamWaitEvent(stream2, event1);  // stream2 等待 event1
myKernel<<<..., stream2>>>();
aclrtRecordEvent(event2, stream2);  // 记录时间点2

aclrtSynchronizeEvent(event2);  // 等待 event2 时间点完成
```

### 原因2：错误选择同步方式

**解决方法**：
- **单 Stream 等待**：使用 aclrtSynchronizeStream，简单直接
- **跨 Stream 协调**：使用 Event，stream1 Record，stream2 Wait
- **精细时间点控制**：使用 Event，记录和等待特定时间点
- **避免过度设计**：单流场景不要用 Event 同步

场景选择示例：
```c
// 场景1：单 Stream 等待整批任务 → Stream 同步
aclrtStream stream;
aclrtCreateStream(&stream);

aclrtMemcpyAsync(dst, size, src, size, ACL_MEMCPY_HOST_TO_DEVICE, stream);
myKernel<<<..., stream>>>();
aclrtMemcpyAsync(host, size, dst, size, ACL_MEMCPY_DEVICE_TO_HOST, stream);

// 推荐：Stream 同步
aclrtSynchronizeStream(stream);  // 等待整流完成

// 不推荐：Event 同步（过度设计）
aclrtEvent event;
aclrtRecordEvent(event, stream);
aclrtSynchronizeEvent(event);  // 多了一步 RecordEvent，复杂度高

// 场景2：跨 Stream 协调 → Event 同步
aclrtStream stream1, stream2;
aclrtCreateStream(&stream1);
aclrtCreateStream(&stream2);

aclrtMemcpyAsync(dst1, size, src1, size, ACL_MEMCPY_HOST_TO_DEVICE, stream1);

// 推荐：Event 同步
aclrtEvent event;
aclrtRecordEvent(event, stream1);      // stream1 记录时间点
aclrtStreamWaitEvent(stream2, event);  // stream2 等待该时间点

aclrtMemcpyAsync(dst2, size, src2, size, ACL_MEMCPY_HOST_TO_DEVICE, stream2);

// 不推荐：Stream 同步（会阻塞 stream1，影响并发）
aclrtSynchronizeStream(stream1);       // 阻塞 stream1 全部任务
aclrtMemcpyAsync(dst2, size, src2, size, ACL_MEMCPY_HOST_TO_DEVICE, stream2);

// 场景3：精细时间点控制 → Event 同步
aclrtEvent event1, event2, event3;
aclrtCreateEvent(&event1);
aclrtCreateEvent(&event2);
aclrtCreateEvent(&event3);

aclrtMemcpyAsync(dst, size, src, size, ACL_MEMCPY_HOST_TO_DEVICE, stream);
aclrtRecordEvent(event1, stream);  // 记录复制完成时间点

myKernel<<<..., stream>>>();
aclrtRecordEvent(event2, stream);  // 记录算子完成时间点

aclrtMemcpyAsync(host, size, dst, size, ACL_MEMCPY_DEVICE_TO_HOST, stream);
aclrtRecordEvent(event3, stream);  // 记录输出复制完成时间点

// 灵活等待特定时间点
aclrtSynchronizeEvent(event2);  // 仅等待算子完成，不等待后续复制
```

## 相关 issue

- [Issue #477: aclrtSynchronizeStream报错507015](https://gitcode.com/cann/runtime/issues/477)
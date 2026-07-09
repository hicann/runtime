# aclrtMemcpyAsync在错误的Stream上下发失败

## 问题现象描述

**现象1：调用aclrtMemcpyAsync接口返回设备不匹配错误码**

调用 aclrtMemcpyAsync 异步内存复制接口时返回错误码 107003（ACL_ERROR_RT_STREAM_CONTEXT），表示Stream不在当前Device的Context中。

典型错误场景：
```c
aclrtSetDevice(0);                 // 指定 Device 0
aclrtStream s0;
aclrtCreateStream(&s0);            // 在 Device 0 上创建 Stream s0

aclrtSetDevice(1);                 // 指定 Device 1
aclrtStream s1;
aclrtCreateStream(&s1);            // 在 Device 1 上创建 Stream s1

// 错误：在 Device 1 上通过 Device 0 的 Stream s0 下发任务
aclrtMemcpyAsync(dst, size, src, size, ACL_MEMCPY_DEVICE_TO_DEVICE, s0);  // 失败
```

报错日志示例如下：
```
aclrtMemcpyAsync failed, ret = 107003, stream not in current context
[ERROR] RUNTIME: Stream not in current context, stream device mismatch
```

## 可能原因

1. **Stream 与当前 Device 不属于同一 Device**：Stream 在创建时绑定到特定 Device，不能在另一个 Device 上下发任务。

## 处理步骤

### 原因1：Stream 与当前 Device 不属于同一 Device

**解决方法**：
- 理解 Stream 归属概念：Stream 属于创建时的 Device，与 Device 绑定
- 在正确 Device 上下发：切换 Device 后使用属于该 Device 的 Stream
- 每个 Device 创建独立 Stream：避免跨 Device 混用 Stream

正确使用示例：
```c
// Device 0 的操作
aclrtSetDevice(0);
aclrtStream s0;
aclrtCreateStream(&s0);  // s0 属于 Device 0

// Device 0 上使用 s0 下发任务
aclrtMemcpyAsync(dst0, size, src0, size, ACL_MEMCPY_DEVICE_TO_DEVICE, s0);  // 正确

// Device 1 的操作
aclrtSetDevice(1);
aclrtStream s1;
aclrtCreateStream(&s1);  // s1 属于 Device 1

// Device 1 上使用 s1 下发任务
aclrtMemcpyAsync(dst1, size, src1, size, ACL_MEMCPY_DEVICE_TO_DEVICE, s1);  // 正确

// 错误示例：在 Device 1 上使用 Device 0 的 Stream s0
aclrtMemcpyAsync(dst1, size, src1, size, ACL_MEMCPY_DEVICE_TO_DEVICE, s0);  // 失败！
```

多 Device 编程最佳实践：
```c
// 为每个 Device 创建独立的 Stream
aclrtStream deviceStreams[2];

aclrtSetDevice(0);
aclrtCreateStream(&deviceStreams[0]);  // Device 0 的 Stream

aclrtSetDevice(1);
aclrtCreateStream(&deviceStreams[1]);  // Device 1 的 Stream

// 切换 Device 后使用对应的 Stream
aclrtSetDevice(0);
aclrtMemcpyAsync(dst, size, src, size, ACL_MEMCPY_DEVICE_TO_DEVICE, deviceStreams[0]);  // 正确

aclrtSetDevice(1);
aclrtMemcpyAsync(dst, size, src, size, ACL_MEMCPY_DEVICE_TO_DEVICE, deviceStreams[1]);  // 正确
```

## 相关 issue

暂无相关Issue。
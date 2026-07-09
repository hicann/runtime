# 多Device场景下Stream跨Device下发失败

## 问题现象描述

**现象1：在非所属Device的Stream上下发算子失败**

在多Device场景下，当尝试在与当前Device无所属关系的Stream上下发算子时，任务下发失败。

错误代码示例：
```cpp
aclrtSetDevice(0);
aclrtStream s0;
aclrtCreateStream(&s0);
myKernel<<<8, nullptr, s0>>>();    // ✓ Device 0上创建，Device 0上使用

aclrtSetDevice(1);
aclrtStream s1;
aclrtCreateStream(&s1);
myKernel<<<8, nullptr, s1>>>();    // ✓ Device 1上创建，Device 1上使用

myKernel<<<8, nullptr, s0>>>();    // ✗ 在Device 1上通过Stream s0下发算子，失败
```

**现象2：在非所属Device的Stream上调用异步复制接口失败**

当Stream所属的Device和当前操作的Device不相同时，在此Stream上调用aclrtMemcpyAsync会失败。

**现象3：Event和Stream关联到不同Device时操作失败**

当Event和Stream关联到不同的Device上时，调用aclrtRecordEvent或aclrtStreamWaitEvent会失败。

## 可能原因

1. Stream具有Device所属关系，Stream在其所属的Device上创建后，只能在该Device上使用。
2. Event也具有Device所属关系，Event只能关联到与其所属Device相同的Stream上。
3. 当前操作的Device与Stream/Event所属Device不匹配，违反了资源所属关系约束。

## 处理步骤

**方案一：在正确的Device上使用Stream**

确保在Stream所属的Device上进行操作：

```cpp
// 正确示例：在Stream所属Device上使用
aclrtSetDevice(0);
aclrtStream s0;
aclrtCreateStream(&s0);
myKernel<<<8, nullptr, s0>>>();    // ✓ 正确：Device 0上创建，Device 0上使用

aclrtSetDevice(1);
aclrtStream s1;
aclrtCreateStream(&s1);
myKernel<<<8, nullptr, s1>>>();    // ✓ 正确：Device 1上创建，Device 1上使用
```

**方案二：使用Event实现跨Device同步**

如果需要跨Device协调任务，使用Event进行同步而不是跨Device使用Stream：

```cpp
// 在Device 0上创建Event并记录
aclrtSetDevice(0);
aclrtStream s0;
aclrtCreateStream(&s0);
aclrtEvent event;
aclrtCreateEvent(&event);
aclrtRecordEvent(event, s0);

// 切换到Device 1，等待Device 0的事件
aclrtSetDevice(1);
aclrtStream s1;
aclrtCreateStream(&s1);
aclrtStreamWaitEvent(s1, event);  // Device 1上的Stream等待Device 0的事件
myKernel<<<8, nullptr, s1>>>();
```

**方案三：检查Event和Stream的Device所属关系**

确保Event和Stream关联到相同的Device：

```cpp
// 错误示例
aclrtSetDevice(0);
aclrtEvent event;
aclrtCreateEvent(&event);  // Event属于Device 0

aclrtSetDevice(1);
aclrtStream s1;
aclrtCreateStream(&s1);    // Stream属于Device 1
aclrtRecordEvent(event, s1);  // ✗ 错误：Event和Stream属于不同Device

// 正确示例
aclrtSetDevice(0);
aclrtEvent event;
aclrtCreateEvent(&event);  // Event属于Device 0
aclrtStream s0;
aclrtCreateStream(&s0);    // Stream属于Device 0
aclrtRecordEvent(event, s0);  // ✓ 正确：Event和Stream属于同一Device
```

## 相关 issue

- [Issue #344: device、context、stream关系咨询](https://gitcode.com/cann/runtime/issues/344)
# 如何理解默认Device和默认Stream机制

## 问题现象描述

**现象1：不调用aclrtSetDevice直接使用其他接口失败**

未调用 aclrtSetDevice 配置设备，直接调用 aclrtMalloc 等接口时失败。

错误代码示例：
```c
aclInit(nullptr);
aclrtMalloc(&devPtr, size, ACL_MEM_MALLOC_HUGE_FIRST);  // 失败：没有指定Device
```

**现象2：对默认Stream的创建时机和使用方式不理解**

不清楚默认Stream何时自动创建和销毁，以及与显式创建Stream的区别。

典型困惑：
```c
aclrtSetDevice(0);  // 自动创建默认Stream
aclrtMemcpyAsync(devPtr, size, hostPtr, size, ACL_MEMCPY_HOST_TO_DEVICE, nullptr);  // nullptr是默认Stream？
```

**现象3：混淆显式创建Stream和默认Stream的使用场景**

不理解何时传 nullptr（默认Stream）、何时传显式创建的Stream对象。

## 可能原因

1. **未配置 aclInit 的 defaultDevice 功能**：aclInit 默认不设置 defaultDevice，需要显式调用 aclrtSetDevice。
2. **混淆默认Stream和显式创建Stream的使用场景**：不理解默认Stream的自动创建机制和销毁时机。
3. **不理解 Stream 传参规则**：需要Stream参数的接口，默认Stream传 nullptr，显式创建Stream传实际对象。

## 处理步骤

### 原因1：未配置 aclInit 的 defaultDevice 功能

**解决方法**：
- 配置 defaultDevice：在 aclInit 的 json 配置文件中设置 defaultDevice
- 理解 defaultDevice 作用：启用后可不显式调用 aclrtSetDevice，接口内部自动进行隐式 aclrtSetDevice

配置示例：
```json
{
    "defaultDevice":{
        "default_device":"0"
    }
}
```

使用示例：
```c
// 启用 defaultDevice 后
aclError ret = aclInit("../acl.json");  // json中配置了defaultDevice=0

// 可以直接调用运行时接口，无需显式 aclrtSetDevice
aclrtMalloc(&devPtr, size, ACL_MEM_MALLOC_HUGE_FIRST);  // 成功

// 去初始化
aclrtResetDeviceForce(0);
aclFinalize();
```

### 原因2：混淆默认Stream和显式创建Stream的使用场景

**解决方法**：
- 理解默认Stream创建时机：aclrtSetDevice 或 aclrtCreateContext 时自动创建默认Stream
- 理解默认Stream销毁时机：aclrtResetDevice 或 aclrtResetDeviceForce 时自动销毁默认Stream
- 区分两种Stream：显式创建的Stream需调用 aclrtDestroyStream 销毁，默认Stream不能显式销毁

默认Stream使用示例：
```c
aclrtSetDevice(0);  // 自动创建默认Stream

// 默认Stream传 nullptr
aclrtMemcpyAsync(devPtr, size, hostPtr, size, ACL_MEMCPY_HOST_TO_DEVICE, nullptr);

// 同步默认Stream
aclrtSynchronizeStream(nullptr);  // nullptr 表示默认Stream

aclrtResetDevice(0);  // 自动销毁默认Stream
```

显式创建Stream示例：
```c
aclrtSetDevice(0);
aclrtStream stream;
aclrtCreateStream(&stream);  // 显式创建Stream

// 显式Stream传实际对象
aclrtMemcpyAsync(devPtr, size, hostPtr, size, ACL_MEMCPY_HOST_TO_DEVICE, stream);

// 销毁显式创建的Stream
aclrtDestroyStream(stream);  // 必须显式销毁
aclrtResetDevice(0);
```

### 原因3：不理解 Stream 传参规则

**解决方法**：
- 需要Stream参数的接口（如 aclrtMemcpyAsync）：默认Stream传 nullptr，显式创建Stream传实际对象
- 不需要Stream参数的接口（如 aclrtMemcpy）：不使用默认Stream，属于同步接口

传参规则总结：
```c
// 异步接口：需要Stream参数
aclrtMemcpyAsync(..., nullptr);   // 使用默认Stream
aclrtMemcpyAsync(..., stream);    // 使用显式创建的Stream

// 同步接口：不需要Stream参数
aclrtMemcpy(..., ACL_MEMCPY_HOST_TO_DEVICE);  // 不使用Stream，同步执行
```

## 相关 issue

- [Issue #344: device、context、stream关系咨询](https://gitcode.com/cann/runtime/issues/344)
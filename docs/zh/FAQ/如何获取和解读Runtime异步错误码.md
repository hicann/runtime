# 如何获取和解读Runtime异步错误码

## 问题现象描述

**现象1：异步接口返回成功但Device侧实际执行失败**

调用Runtime异步接口（如aclrtMemcpyAsync、Kernel Launch等）时，接口返回成功（ACL_RT_SUCCESS），但实际执行时Device侧发生了错误。

典型场景：
```cpp
aclrtStream stream;
aclrtCreateStream(&stream);

// 异步接口返回成功，仅表示任务下发成功
aclError error = aclrtMemcpyAsync(devPtr, devSize, hostPtr, hostSize,
                                   ACL_MEMCPY_HOST_TO_DEVICE, stream);
// error == ACL_RT_SUCCESS，但Device侧可能执行失败
```

**现象2：异步错误延迟传播导致难以定位**

Device侧的异步错误会延迟到后续某个Runtime接口调用时返回，可能不是实际发生错误的接口，导致错误定位困难。

报错日志示例如下：
```
[ERROR] RUNTIME: Aicore kernel execute failed, ret=507015, aicore exception
fault kernel_name=Add_ee98c6628030785f610b924ab1557b31
```

**现象3：遇错继续模式下多个错误覆盖**

在遇错继续模式下，如果Stream上多个任务执行失败，后发生的错误可能覆盖先前的错误信息，导致无法获取首次错误。

// 后续操作基于错误假设继续执行
myKernel<<<8, nullptr, stream>>>();
aclrtMemcpyAsync(hostPtr, hostSize, devPtr, devSize,
                 ACL_MEMCPY_DEVICE_TO_HOST, stream);
aclrtSynchronizeStream(stream);
// 此时才发现错误，但难以定位是哪个异步任务失败

## 可能原因

1. **异步执行机制**：Runtime异步接口在Host侧下发任务后立即返回，Device侧任务异步执行，接口返回值仅反映Host侧参数校验和任务下发是否成功，无法报告Device侧的实际执行错误。
2. **错误传播延迟**：Device侧的异步错误会延迟到后续某个Runtime接口调用时返回，可能不是实际发生错误的接口，导致错误定位困难。
3. **错误覆盖问题**：在遇错继续模式下，如果Stream上多个任务执行失败，后发生的错误可能覆盖先前的错误信息，导致无法获取首次错误。

典型异步错误示例（通过 aclrtSynchronizeStream 获取）：
```
[ERROR] RUNTIME: Aicore kernel execute failed, ret=507015, aicore exception
fault kernel_name=Add_ee98c6628030785f610b924ab1557b31
```

## 处理步骤

### 方法1：立即同步获取异步错误

在异步接口调用后立即调用同步接口，获取Device侧的实际执行结果：
```cpp
aclrtStream stream;
aclrtCreateStream(&stream);

// 下发异步任务
aclError error = aclrtMemcpyAsync(devPtr, devSize, hostPtr, hostSize,
                                   ACL_MEMCPY_HOST_TO_DEVICE, stream);

// 立即同步并获取错误码
error = aclrtSynchronizeStream(stream);
if (error != ACL_RT_SUCCESS) {
    // 处理错误
    printf("Async task failed with error: %d\n", error);
    char *errMsg = aclGetRecentErrMsg();
    printf("Error message: %s\n", errMsg);
}

aclrtDestroyStream(stream);
```

### 方法2：使用错误查询接口

使用`aclrtPeekAtLastError`或`aclrtGetLastError`查询当前线程的错误状态：

```cpp
aclrtStream stream;
aclrtCreateStream(&stream);
aclrtSetStreamFailureMode(stream, ACL_STOP_ON_FAILURE);

// 下发多个异步任务
aclrtMemcpyAsync(devPtr, devSize, hostPtr, hostSize,
                 ACL_MEMCPY_HOST_TO_DEVICE, stream);
myKernel<<<8, nullptr, stream>>>();
aclrtMemcpyAsync(hostPtr, hostSize, devPtr, devSize,
                 ACL_MEMCPY_DEVICE_TO_HOST, stream);

// 同步并检查错误
aclrtSynchronizeStream(stream);

// 查看错误但不重置
aclError lastError = aclrtPeekAtLastError(ACL_RT_THREAD_LEVEL);
if (lastError != ACL_RT_SUCCESS) {
    printf("Last error: %d\n", lastError);
}

// 获取并重置错误状态
lastError = aclrtGetLastError(ACL_RT_THREAD_LEVEL);
// 此时错误状态已重置为ACL_RT_SUCCESS
```

### 方法3：获取详细错误信息

通过`aclGetRecentErrMsg()`获取详细的错误描述信息：

```cpp
aclError error = aclrtSynchronizeDevice();
if (error != ACL_RT_SUCCESS) {
    char *errMsg = aclGetRecentErrMsg();
    if (errMsg != nullptr) {
        printf("Error detail: %s\n", errMsg);
    }

    // 根据错误码进行分类处理
    // 实际错误码定义请参考 rt_error_codes.h 头文件
    switch (error) {
        case ACL_ERROR_RT_PARAM_INVALID:        // 107000
            printf("Invalid parameter\n");
            break;
        case ACL_ERROR_RT_INVALID_DEVICEID:     // 107001
            printf("Invalid device ID\n");
            break;
        // ... 其他错误码处理
    }
}
```

### 方法4：结合遇错即停模式

配置遇错即停模式，在首个错误发生时停止执行，避免错误传播：
```cpp
aclrtStream stream;
aclrtCreateStream(&stream);

// 配置遇错即停
aclError error = aclrtSetStreamFailureMode(stream, ACL_STOP_ON_FAILURE);
if (error != ACL_RT_SUCCESS) {
    printf("Failed to set failure mode\n");
    return error;
}

// 下发任务
aclrtMemcpyAsync(devPtr, devSize, hostPtr, hostSize,
                 ACL_MEMCPY_HOST_TO_DEVICE, stream);
myKernel<<<8, nullptr, stream>>>();
aclrtMemcpyAsync(hostPtr, hostSize, devPtr, devSize,
                 ACL_MEMCPY_DEVICE_TO_HOST, stream);

// 同步并检查
error = aclrtSynchronizeStream(stream);
if (error != ACL_RT_SUCCESS) {
    // 首个错误发生时即停止，便于定位
    printf("First error occurred: %d\n", error);
    char *errMsg = aclGetRecentErrMsg();
    printf("Error message: %s\n", errMsg);
}

aclrtDestroyStream(stream);
```

## 相关 issue
- [Issue #477: aclrtSynchronizeStream报错507015及plog日志分析](https://gitcode.com/cann/runtime/issues/477)
- [Issue #480: aicore异常报错分析](https://gitcode.com/cann/runtime/issues/480)
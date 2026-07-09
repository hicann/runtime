# ACL Graph捕获过程中任务提交限制

## 问题现象描述

**现象1：对Stream、Event、Device、Context进行同步或查询操作时失败**

使用ACL Graph方式捕获Stream上的任务时（在`aclmdlRICaptureBegin`和`aclmdlRICaptureEnd`之间），对Stream、Event、Device、Context进行同步或查询操作，会导致捕获失败。

错误代码示例：
```cpp
aclmdlRICaptureBegin(stream, ACL_MODEL_RI_CAPTURE_MODE_GLOBAL);
aclrtSynchronizeStream(stream);  // ✗ 非法操作，会导致捕获失败
aclmdlRICaptureEnd(stream, &modelRI);
```

报错日志示例如下：
```
[ERROR] RUNTIME: operation not permitted when a stream is capturing and the specified capture mode is not relaxed, ret=107041
```

**现象2：全局禁止模式下调用内存同步操作类函数时报错**

在全局禁止模式（`ACL_MODEL_RI_CAPTURE_MODE_GLOBAL`）下调用内存同步操作类函数（如`aclrtMemset`、`aclrtMemcpy`、`aclrtMemcpy2d`）时报错。

错误代码示例：
```cpp
aclmdlRICaptureBegin(stream, ACL_MODEL_RI_CAPTURE_MODE_GLOBAL);
aclrtMemcpy(dst, size, src, size, ACL_MEMCPY_DEVICE_TO_DEVICE);  // ✗ 非法操作，会报错
aclmdlRICaptureEnd(stream, &modelRI);
```

报错日志示例如下：
```
[ERROR] RUNTIME: operation not permitted when a stream is capturing and the specified capture mode is not relaxed, ret=107041
```

**现象3：使用默认Stream进行捕获导致失败**

使用默认Stream（传nullptr）进行ACL Graph捕获时，可能导致捕获失败或行为异常。

错误代码示例：
```cpp
aclmdlRICaptureBegin(nullptr, ACL_MODEL_RI_CAPTURE_MODE_GLOBAL);  // ✗ 使用默认Stream
aclmdlRICaptureEnd(nullptr, &modelRI);
```

## 可能原因

1. **对Stream、Event、Device、Context进行同步或查询操作**：捕获阶段内执行同步或查询操作违反了捕获规则。
2. **全局禁止模式下调用内存同步操作类函数**：ACL_MODEL_RI_CAPTURE_MODE_GLOBAL模式下不允许调用aclrtMemset、aclrtMemcpy等同步内存函数。
3. **使用默认Stream进行捕获**：默认Stream（nullptr）在捕获过程中可能导致失败或行为异常。

## 处理步骤

### 原因1：对Stream、Event、Device、Context进行同步或查询操作

在捕获阶段前或捕获阶段后进行同步/查询操作：

```cpp
// 正确示例：在捕获前完成同步操作
aclrtSynchronizeStream(stream);  // ✓ 捕获前同步

aclmdlRICaptureBegin(stream, ACL_MODEL_RI_CAPTURE_MODE_GLOBAL);
aclrtMemcpyAsync(dst, size, src, size, ACL_MEMCPY_DEVICE_TO_DEVICE, stream);
aclmdlRICaptureEnd(stream, &modelRI);

// 执行模型后进行同步
aclmdlRIExecuteAsync(modelRI, stream);
aclrtSynchronizeStream(stream);  // ✓ 捕获后同步
```

### 原因2：全局禁止模式下调用内存同步操作类函数

如果业务确定内存同步操作不会影响任务捕获，可以切换为`ACL_MODEL_RI_CAPTURE_MODE_RELAXED`模式：

```cpp
aclmdlRICaptureBegin(stream, ACL_MODEL_RI_CAPTURE_MODE_GLOBAL);

// 异步内存复制（始终允许）
aclrtMemcpyAsync(self_d, size, self_h, size, ACL_MEMCPY_HOST_TO_DEVICE, stream);

// 切换捕获模式为RELAXED，允许调用aclrtMemcpy函数
aclmdlRICaptureMode mode = ACL_MODEL_RI_CAPTURE_MODE_RELAXED;
aclmdlRICaptureThreadExchangeMode(&mode);

// 同步内存复制（仅执行一次，RELAXED模式下允许）
aclrtMemcpy(other_d, size, other_h, size, ACL_MEMCPY_HOST_TO_DEVICE);

// 将捕获模式切换回GLOBAL
aclmdlRICaptureThreadExchangeMode(&mode);

aclmdlRICaptureEnd(stream, &modelRI);
```

### 原因3：使用默认Stream进行捕获

创建并使用显式Stream，而不是使用默认Stream：

```cpp
// 错误示例：在捕获过程中使用默认Stream
aclmdlRICaptureBegin(nullptr, ACL_MODEL_RI_CAPTURE_MODE_GLOBAL);  // ✗ 使用默认Stream
aclmdlRICaptureEnd(nullptr, &modelRI);

// 正确示例：创建显式Stream
aclrtStream stream;
aclrtCreateStream(&stream);
aclmdlRICaptureBegin(stream, ACL_MODEL_RI_CAPTURE_MODE_GLOBAL);  // ✓ 使用显式Stream
aclmdlRICaptureEnd(stream, &modelRI);
aclrtDestroyStream(stream);
```

## 相关 issue

- [Issue #487: ACL Graph捕获阶段控核接口支持性咨询](https://gitcode.com/cann/runtime/issues/487)
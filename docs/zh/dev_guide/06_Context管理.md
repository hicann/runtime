# Context管理

## Context概念

Context是CANN Runtime中的核心抽象，代表一个Device上的执行上下文环境。它封装了Device上的计算资源、内存资源、Stream资源等运行时状态，是Runtime操作的基础载体。

每个Context与特定的Device绑定，包含该Device上的：

- 计算资源：用于执行Kernel、系统任务等
- 内存资源：设备内存分配与管理
- Stream资源：任务队列及调度状态
- 运行时配置：影响任务执行的参数

Context与线程绑定，同一时刻一个线程只能使用一个Context。Runtime接口在执行时，会自动使用当前线程绑定的Context。

<br>
<br>

## 为什么要用Context

### 使用Context的核心场景

1. **多线程并行计算**：多个线程并发使用同一Device时，各自创建独立Context，避免资源竞争和状态混乱。
2. **精细资源控制**：需要更细粒度地控制资源创建、使用、释放时机。
3. **多线程Context共享**：在同进程多线程场景下，显式创建的Context可在多线程间共享使用。
4. **模块化程序设计**：不同功能模块使用独立Context，便于资源管理和问题定位。

### 显式Context vs 默认Context

调用`aclrtSetDevice`接口时，Runtime会自动为指定Device创建一个**默认Context**。对于简单应用，使用默认Context即可满足需求。但对于复杂应用，显式创建和管理Context具有以下优势：


| 场景         | 默认Context                                     | 显式Context                             |
| ------------ | ----------------------------------------------- | --------------------------------------- |
| 多线程编程   | 线程间共享默认Context，任务执行顺序依赖线程调度 | 每个线程独立Context，便于隔离和调试     |
| 资源隔离     | 同一Device上的不同模块共享资源                  | 不同模块使用独立Context，资源隔离更清晰 |
| 代码可维护性 | 线程切换Device时Context状态不明确               | 显式指定Context，代码意图清晰           |
| 资源生命周期 | 随Device生命周期管理                            | 独立控制Context创建和销毁时机           |

<br>

## Context与Device、Stream的关系

Context与Device、Stream的关系如下图所示：

```
┌─────────────────────────────────────────────────────────────┐
│                         Host进程                            │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐       │
│  │   Thread 1   │  │   Thread 2   │  │   Thread 3   │       │
│  │  Context A   │  │  Context B   │  │  Context A   │       │
│  └──────┬───────┘  └──────┬───────┘  └──────┬───────┘       │
│         │                 │                 │               │
└─────────┼─────────────────┼─────────────────┼───────────────┘
          │                 │                 │
          ▼                 ▼                 ▼
┌────────────────────────────────────────────────────────────┐
│                      Device 0 (NPU)                        │
│  ┌─────────────────────────────────────────────────────┐   │
│  │                    Context A                        │   │
│  │  ┌──────────┐  ┌──────────┐  ┌──────────┐           │   │
│  │  │ Stream 0 │  │ Stream 1 │  │ Stream 2 │  ...      │   │
│  │  │ (default)│  │          │  │          │           │   │
│  │  └──────────┘  └──────────┘  └──────────┘           │   │
│  └─────────────────────────────────────────────────────┘   │
│  ┌─────────────────────────────────────────────────────┐   │
│  │                    Context B                        │   │
│  │  ┌──────────┐  ┌──────────┐                         │   │
│  │  │ Stream 0 │  │ Stream 1 │  ...                    │   │
│  │  │ (default)│  │          │                         │   │
│  │  └──────────┘  └──────────┘                         │   │
│  └─────────────────────────────────────────────────────┘   │
└────────────────────────────────────────────────────────────┘
```

- **Device**：物理NPU设备，一个Device上可创建多个Context。
- **Context**：Device上的执行上下文，包含默认Stream和用户创建的Stream。
- **Stream**：任务队列，归属于特定Context。
  <br>

## 如何使用Context

### 单线程基础使用模式（默认Context）

对于简单应用，使用默认Context即可满足需求。调用`aclrtSetDevice`接口时，Runtime会自动创建默认Context，无需显式管理。

以下示例展示单线程使用默认Context的基础流程：

```c
// 1. 初始化Runtime
aclInit(nullptr);

// 2. 指定Device，自动创建默认Context和默认Stream
int32_t deviceId = 0;
aclrtSetDevice(deviceId);

// 3. 创建显式Stream（可选，也可直接使用默认Stream传入nullptr）
aclrtStream stream;
aclrtCreateStream(&stream);

// 4. 在Stream上下发任务
aclrtMemcpyAsync(devPtr, size, hostPtr, size, ACL_MEMCPY_HOST_TO_DEVICE, stream);
myKernel<<<8, nullptr, stream>>>(devPtr, size);
aclrtMemcpyAsync(hostPtr, size, devPtr, size, ACL_MEMCPY_DEVICE_TO_HOST, stream);

// 5. 同步等待任务完成
aclrtSynchronizeStream(stream);

// 6. 销毁显式Stream
aclrtDestroyStream(stream);

// 7. 复位Device，释放默认Context和默认Stream
aclrtResetDeviceForce(deviceId);

// 8. 去初始化
aclFinalize();
```

<br>

### 多线程并行计算

多个线程使用同一Device时，推荐为每个线程创建独立Context：

```c
// 线程函数
void* threadFunc(void* arg) {
    int32_t deviceId = *(int32_t*)arg;
  
    // 每个线程创建自己的Context
    aclrtContext ctx;
    aclrtCreateContext(&ctx, deviceId);
  
    // 创建Stream
    aclrtStream stream;
    aclrtCreateStream(&stream);
  
    // 执行任务
    // ... 业务逻辑 ...
  
    // 同步等待任务完成
    aclrtSynchronizeStream(stream);
  
    // 销毁资源
    aclrtDestroyStream(stream);
    aclrtDestroyContext(ctx);
  
    return nullptr;
}

// 主线程
int main() {
    aclInit(nullptr);
  
    int32_t deviceId = 0;
    aclrtSetDevice(deviceId);
  
    // 创建多个线程
    pthread_t threads[4];
    for (int i = 0; i < 4; i++) {
        pthread_create(&threads[i], nullptr, threadFunc, &deviceId);
    }
  
    // 等待线程完成
    for (int i = 0; i < 4; i++) {
        pthread_join(threads[i], nullptr);
    }
  
    aclrtResetDeviceForce(deviceId);
    aclFinalize();
    return 0;
}
```

<br>

### 多线程Context共享

多个线程共享同一Context时，需自行保证Stream上任务的执行顺序：

```c
aclrtContext g_ctx;  // 全局Context

void* threadFunc(void* arg) {
    int threadId = *(int*)arg;
  
    // 切换到共享Context
    aclrtSetCurrentContext(g_ctx);
  
    // 创建线程专属Stream
    aclrtStream stream;
    aclrtCreateStream(&stream);
  
    // 在自己的Stream上执行任务
    // ... 业务逻辑 ...
  
    aclrtSynchronizeStream(stream);
    aclrtDestroyStream(stream);
  
    return nullptr;
}

int main() {
    aclInit(nullptr);
  
    int32_t deviceId = 0;
    aclrtSetDevice(deviceId);
  
    // 创建一个Context供多线程共享
    aclrtCreateContext(&g_ctx, deviceId);
  
    pthread_t threads[4];
    int threadIds[4];
    for (int i = 0; i < 4; i++) {
        threadIds[i] = i;
        pthread_create(&threads[i], nullptr, threadFunc, &threadIds[i]);
    }
  
    for (int i = 0; i < 4; i++) {
        pthread_join(threads[i], nullptr);
    }
  
    aclrtDestroyContext(g_ctx);
    aclrtResetDeviceForce(deviceId);
    aclFinalize();
    return 0;
}
```

<br>

### Context切换

使用`aclrtSetCurrentContext`切换当前线程的Context：

```c
// 在Device 0上创建两个Context
aclrtSetDevice(0);
aclrtContext ctx1, ctx2;
aclrtCreateContext(&ctx1, 0);
aclrtCreateContext(&ctx2, 0);

// 切换到ctx1
aclrtSetCurrentContext(ctx1);
aclrtStream stream1;
aclrtCreateStream(&stream1);
// ... 在ctx1上执行任务 ...

// 切换到ctx2
aclrtSetCurrentContext(ctx2);
aclrtStream stream2;
aclrtCreateStream(&stream2);
// ... 在ctx2上执行任务 ...

// 切换Context时，如果新Context属于不同Device，Device也会随之切换
aclrtSetDevice(1);
aclrtContext ctx3;
aclrtCreateContext(&ctx3, 1);

aclrtSetCurrentContext(ctx3);  // 当前Context切换为ctx3，Device也切换为1
```

<br>

### Context参数配置

使用`aclrtCtxSetSysParamOpt`设置Context级别的参数：

```c
aclrtContext ctx;
aclrtCreateContext(&ctx, 0);

// 设置Context参数（示例：设置内存配置）
aclrtCtxSetSysParamOpt(ACL_SYS_PARAM_OPT_XXX, value);

// 获取Context参数
int64_t paramValue;
aclrtCtxGetSysParamOpt(ACL_SYS_PARAM_OPT_XXX, &paramValue);
```

<br>

### 默认Stream获取

每个Context包含一个默认Stream，可通过接口获取：

```c
aclrtContext ctx;
aclrtCreateContext(&ctx, 0);

// 获取当前Context的默认Stream
aclrtStream defaultStream;
aclrtCtxGetCurrentDefaultStream(&defaultStream);

// 使用默认Stream（也可直接传nullptr）
aclrtMemcpyAsync(dst, size, src, size, ACL_MEMCPY_DEVICE_TO_DEVICE, nullptr);
```

<br>

## 如何用好Context

### 推荐做法

1. **优先使用显式Context**：对于多线程或复杂应用，显式创建Context，代码意图更清晰。
2. **Context与线程绑定**：推荐在创建Context的线程中使用该Context，避免跨线程使用带来的复杂性。
3. **及时销毁资源**：Context不再使用时及时销毁，避免资源泄漏。
4. **使用aclrtResetDeviceForce**：Device使用完毕后，使用`aclrtResetDeviceForce`一次性释放Device上所有资源。
5. **明确Context切换时机**：在多Context场景下，显式调用`aclrtSetCurrentContext`切换，增加代码可读性。

### 避免的做法

1. **不要销毁默认Context**：默认Context由Runtime管理，不能调用`aclrtDestroyContext`销毁。
2. **避免Context状态不确定**：多线程共享Context时，避免依赖Context的隐式状态切换。
3. **不要跨线程随意操作同一Stream**：如果必须在多线程间共享Context，每个线程应使用独立的Stream。
4. **不要在已复位的Device上使用Context**：Device被复位后，相关Context不可用。

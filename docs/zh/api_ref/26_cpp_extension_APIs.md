# 26. C++扩展接口

本章节描述 C++ 扩展接口，包括函数重载和模板封装，用于简化 C++ 场景下的 API 调用并提供类型安全的内存操作。

- [`aclError aclrtSynchronizeDevice(int32_t timeout)`](#aclrtSynchronizeDevice)：设备同步，简化接口。
- [`aclError aclrtSynchronizeStream(aclrtStream stream, int32_t timeout)`](#aclrtSynchronizeStream)：流同步，简化接口。
- [`aclError aclrtSynchronizeEvent(aclrtEvent event, int32_t timeout)`](#aclrtSynchronizeEvent)：事件同步，简化接口。
- [`aclError aclrtStreamWaitEvent(aclrtStream stream, aclrtEvent event, int32_t timeout)`](#aclrtStreamWaitEvent)：流等待事件，简化接口。
- [`aclError aclrtCreateStream(aclrtStream *stream, uint32_t priority, uint32_t flag)`](#aclrtCreateStream)：创建流，简化接口。
- [`aclError aclrtSetOpExecuteTimeOut(uint64_t timeout, uint64_t *actualTimeout)`](#aclrtSetOpExecuteTimeOut)：设置算子执行超时，简化接口。
- [`aclError aclrtCreateEvent(aclrtEvent *event, uint32_t flag)`](#aclrtCreateEvent)：创建事件，简化接口。
- [`template <typename T> aclError aclrtMalloc(T **devPtr, size_t size, aclrtMallocConfig *cfg = nullptr)`](#aclrtMalloc)：类型安全的设备内存分配。
- [`template <typename T> aclError aclrtMallocHost(T **hostPtr, size_t size, aclrtMallocConfig *cfg = nullptr)`](#aclrtMallocHost)：类型安全的主机内存分配。
- [`template <typename T, typename U> aclError aclrtMemcpy(T *dst, size_t destMax, const U *src, size_t count, aclrtMemcpyKind kind)`](#aclrtMemcpy)：类型安全的内存拷贝。
- [`template <typename T, typename U> aclError aclrtMemcpyAsync(T *dst, size_t destMax, const U *src, size_t count, aclrtMemcpyKind kind, aclrtStream stream)`](#aclrtMemcpyAsync)：异步内存拷贝。
- [`template <typename T, typename U> aclError aclrtMemcpy2d(T *dst, size_t dpitch, const U *src, size_t spitch, size_t width, size_t height, aclrtMemcpyKind kind)`](#aclrtMemcpy2d)：2D内存拷贝。
- [`template <typename T, typename U> aclError aclrtMemcpy2dAsync(T *dst, size_t dpitch, const U *src, size_t spitch, size_t width, size_t height, aclrtMemcpyKind kind, aclrtStream stream)`](#aclrtMemcpy2dAsync)：异步2D内存拷贝。
- [`template <typename T, typename U> aclError aclrtMemcpyBatch(...)`](#aclrtMemcpyBatch)：批量内存拷贝。
- [`template <typename T, typename U> aclError aclrtMemcpyBatchAsync(...)`](#aclrtMemcpyBatchAsync)：异步批量内存拷贝。
- [`template <typename T> aclError aclrtPointerGetAttributes(const T *ptr, aclrtPtrAttributes *attributes)`](#aclrtPointerGetAttributes)：类型安全的指针属性查询。
- [`template <typename T> aclError aclrtHostRegister(...)`](#aclrtHostRegister)：类型安全的主机内存注册。
- [`template <typename T> aclError aclrtHostGetDevicePointer(T *pHost, T **pDevice, uint32_t flag)`](#aclrtHostGetDevicePointer)：主机内存到设备指针映射。
- [`template <typename T> aclError aclrtHostUnregister(T *ptr)`](#aclrtHostUnregister)：类型安全的主机内存注销。
- [`template <typename T> aclError aclrtMemAllocManaged(T **devPtr, size_t size, uint32_t flags = ACL_RT_MEM_ATTACH_GLOBAL)`](#aclrtMemAllocManaged)：类型安全的统一内存分配。
- [`template <typename T> aclError aclrtMemManagedPrefetchAsync(const T *ptr, size_t size, aclrtMemManagedLocation location, uint32_t flags, aclrtStream stream)`](#aclrtMemManagedPrefetchAsync)：预取统一内存。
- [`template <typename T> aclError aclrtMemManagedPrefetchBatchAsync(...)`](#aclrtMemManagedPrefetchBatchAsync)：批量预取统一内存。
- [`template <typename T> aclError aclrtGetSymbolAddress(...)`](#aclrtGetSymbolAddress)：获取Device变量的地址。
- [`template <typename T> aclError aclrtGetSymbolSize(...)`](#aclrtGetSymbolSize)：获取Device变量占用的内存大小。
- [`template <typename T> aclError aclrtMemcpyFromSymbol(...)`](#aclrtMemcpyFromSymbol)：实现Device变量的数据到Host的同步内存复制。
- [`template <typename T> aclError aclrtMemcpyFromSymbolAsync(...)`](#aclrtMemcpyFromSymbolAsync)：实现Device变量的数据到Host的异步内存复制。
- [`template <typename T> aclError aclrtMemcpyToSymbol(...)`](#aclrtMemcpyToSymbol)：实现Host数据到Device变量的同步内存复制。
- [`template <typename T> aclError aclrtMemcpyToSymbolAsync(...)`](#aclrtMemcpyToSymbolAsync)：实现Host数据到Device变量的异步内存复制。

---

<br>
<br>
<br>

<a id="aclrtSynchronizeDevice"></a>

## aclrtSynchronizeDevice

```cpp
aclError aclrtSynchronizeDevice(int32_t timeout)
```

### 产品支持情况

<!-- npu="950" id1205 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1205 -->
<!-- npu="A3" id1206 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1206 -->
<!-- npu="910b" id1207 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1207 -->
<!-- npu="310b" id1208 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1208 -->
<!-- npu="310p" id1209 -->
- Atlas 推理系列产品：支持
<!-- end id1209 -->
<!-- npu="910" id1210 -->
- Atlas 训练系列产品：支持
<!-- end id1210 -->
<!-- npu="IPV350" id1211 -->
- IPV350：不支持
<!-- end id1211 -->
<!-- @ref: runtime/res/docs/zh/api_ref/26_cpp_extension_APIs_res.md#id1 -->

### 功能说明

阻塞当前线程，直到与当前线程绑定的Context所对应的Device完成运算。

本接口为封装接口，仅适用于C++程序，接口内部调用C接口[aclrtSynchronizeDeviceWithTimeout](04_device_management.md#aclrtSynchronizeDeviceWithTimeout)。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| timeout | 输入 | 接口的超时时间。<br>取值说明如下：<br>  - -1：表示永久等待；<br>  - >0：配置具体的超时时间，单位是毫秒。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtSynchronizeStream"></a>

## aclrtSynchronizeStream

```cpp
aclError aclrtSynchronizeStream(aclrtStream stream, int32_t timeout)
```

## 产品支持情况

<!-- npu="950" id2220 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2220 -->
<!-- npu="A3" id2221 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2221 -->
<!-- npu="910b" id2222 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2222 -->
<!-- npu="310b" id2223 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2223 -->
<!-- npu="310p" id2224 -->
- Atlas 推理系列产品：支持
<!-- end id2224 -->
<!-- npu="910" id2225 -->
- Atlas 训练系列产品：支持
<!-- end id2225 -->
<!-- npu="IPV350" id2226 -->
- IPV350：不支持
<!-- end id2226 -->
<!-- @ref: runtime/res/docs/zh/api_ref/26_cpp_extension_APIs_res.md#id2 -->

### 功能说明

阻塞Host侧当前线程直到指定Stream中的所有任务都完成。同时，本接口支持用户设置超时时间，当应用程序异常时可根据所设置的超时时间自行退出。

本接口为封装接口，仅适用于C++程序，接口内部调用C接口[aclrtSynchronizeStreamWithTimeout](06_stream_management.md#aclrtSynchronizeStreamWithTimeout)。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| stream | 输入 | 指定需要完成所有任务的Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |
| timeout | 输入 | 接口的超时时间。<br>取值说明如下：<br>  - -1：表示永久等待；<br>  - >0：配置具体的超时时间，单位是毫秒。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtSynchronizeEvent"></a>

## aclrtSynchronizeEvent

```cpp
aclError aclrtSynchronizeEvent(aclrtEvent event, int32_t timeout)
```

### 产品支持情况

<!-- npu="950" id3424 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id3424 -->
<!-- npu="A3" id3425 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id3425 -->
<!-- npu="910b" id3426 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id3426 -->
<!-- npu="310b" id3427 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id3427 -->
<!-- npu="310p" id3428 -->
- Atlas 推理系列产品：支持
<!-- end id3428 -->
<!-- npu="910" id3429 -->
- Atlas 训练系列产品：支持
<!-- end id3429 -->
<!-- npu="IPV350" id3430 -->
- IPV350：不支持
<!-- end id3430 -->
<!-- @ref: runtime/res/docs/zh/api_ref/26_cpp_extension_APIs_res.md#id3 -->

### 功能说明

阻塞当前线程运行直到Event捕获的所有任务都执行完成。同时，本接口支持用户设置永久等待、或配置具体的超时时间，若配置具体的超时时间，则当应用程序异常时可根据所设置的超时时间自行退出。

本接口为封装接口，仅适用于C++程序，接口内部调用C接口[aclrtSynchronizeEventWithTimeout](07_event_management.md#aclrtSynchronizeEventWithTimeout)。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| event | 输入 | 需等待的Event。类型定义请参见[aclrtEvent](25-05_Typedefs.md#aclrtEvent)。 |
| timeout | 输入 | 接口的超时时间。<br>取值说明如下：<br>  - -1：表示永久等待。<br>  - >0：配置具体的超时时间，单位是毫秒。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtStreamWaitEvent"></a>

## aclrtStreamWaitEvent

```cpp
aclError aclrtStreamWaitEvent(aclrtStream stream, aclrtEvent event, int32_t timeout)
```

### 产品支持情况

<!-- npu="950" id680 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id680 -->
<!-- npu="A3" id681 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id681 -->
<!-- npu="910b" id682 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id682 -->
<!-- npu="310b" id683 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id683 -->
<!-- npu="310p" id684 -->
- Atlas 推理系列产品：支持
<!-- end id684 -->
<!-- npu="910" id685 -->
- Atlas 训练系列产品：支持
<!-- end id685 -->
<!-- npu="IPV350" id686 -->
- IPV350：不支持
<!-- end id686 -->
<!-- @ref: runtime/res/docs/zh/api_ref/26_cpp_extension_APIs_res.md#id4 -->

### 功能说明

阻塞指定Stream的运行，直到指定的Event完成。异步接口。

本接口为封装接口，仅适用于C++程序，接口内部调用C接口[aclrtStreamWaitEventWithTimeout](07_event_management.md#aclrtStreamWaitEventWithTimeout)。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| stream | 输入 | 指定Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。<br>多Stream同步等待场景下，例如，Stream2等待Stream1的场景，此处配置为Stream2。 |
| event | 输入 | 需等待的Event。类型定义请参见[aclrtEvent](25-05_Typedefs.md#aclrtEvent)。 |
| timeout | 输入 | 超时时间。<br>取值说明如下：<br>  - 0：表示永不超时。<br>  - >0：用于配置具体的超时时间，单位是毫秒。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtCreateStream"></a>

## aclrtCreateStream

```cpp
aclError aclrtCreateStream(aclrtStream *stream, uint32_t priority, uint32_t flag)
```

### 产品支持情况

<!-- npu="950" id624 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id624 -->
<!-- npu="A3" id625 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id625 -->
<!-- npu="910b" id626 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id626 -->
<!-- npu="310b" id627 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id627 -->
<!-- npu="310p" id628 -->
- Atlas 推理系列产品：支持
<!-- end id628 -->
<!-- npu="910" id629 -->
- Atlas 训练系列产品：支持
<!-- end id629 -->
<!-- npu="IPV350" id630 -->
- IPV350：不支持
<!-- end id630 -->
<!-- @ref: runtime/res/docs/zh/api_ref/26_cpp_extension_APIs_res.md#id5 -->

### 功能说明

在当前进程或线程中创建Stream。

本接口为封装接口，仅适用于C++程序，接口内部调用C接口[aclrtCreateStreamWithConfig](06_stream_management.md#aclrtCreateStreamWithConfig)。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| stream | 输出 | Stream的指针。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |
| priority | 输入 | 优先级。<br>该参数取值范围：[0, 7]，总共最多支持8个优先级，数字越小代表优先级越高，其中，0的优先级最高，7的优先级最低。如果设置的优先级超过取值范围，则就近修正为边界值。 |
| flag | 输入 | Stream指针的flag。<br>flag参数值请参见“flag取值说明”。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtSetOpExecuteTimeOut"></a>

## aclrtSetOpExecuteTimeOut

```cpp
aclError aclrtSetOpExecuteTimeOut(uint64_t timeout, uint64_t *actualTimeout)
```

### 产品支持情况

<!-- npu="950" id2318 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2318 -->
<!-- npu="A3" id2319 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2319 -->
<!-- npu="910b" id2320 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2320 -->
<!-- npu="310b" id2321 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2321 -->
<!-- npu="310p" id2322 -->
- Atlas 推理系列产品：支持
<!-- end id2322 -->
<!-- npu="910" id2323 -->
- Atlas 训练系列产品：支持
<!-- end id2323 -->
<!-- npu="IPV350" id2324 -->
- IPV350：不支持
<!-- end id2324 -->
<!-- @ref: runtime/res/docs/zh/api_ref/26_cpp_extension_APIs_res.md#id6 -->

### 功能说明

设置算子执行的超时时间，单位为微秒。如果算子下发时携带了超时时间，则该超时时间优先级高于本接口设置的超时时间。

本接口为封装接口，仅适用于C++程序，接口内部调用C接口[aclrtSetOpExecuteTimeOutV2](12_execution_control.md#aclrtSetOpExecuteTimeOutV2)。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| timeout | 输入 | 设置超时时间，单位为微秒。<br>将该参数设置为0时，表示使用最大超时时间。 |
| actualTimeout | 输出 | 返回实际生效的超时时间，单位为微秒。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtCreateEvent"></a>

## aclrtCreateEvent

```cpp
aclError aclrtCreateEvent(aclrtEvent *event, uint32_t flag)
```

### 产品支持情况

<!-- npu="950" id1506 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1506 -->
<!-- npu="A3" id1507 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1507 -->
<!-- npu="910b" id1508 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1508 -->
<!-- npu="310b" id1509 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1509 -->
<!-- npu="310p" id1510 -->
- Atlas 推理系列产品：支持
<!-- end id1510 -->
<!-- npu="910" id1511 -->
- Atlas 训练系列产品：支持
<!-- end id1511 -->
<!-- npu="IPV350" id1512 -->
- IPV350：不支持
<!-- end id1512 -->
<!-- @ref: runtime/res/docs/zh/api_ref/26_cpp_extension_APIs_res.md#id7 -->

### 功能说明

创建带flag的Event，不同flag的Event用于不同的功能。支持创建Event时携带多个flag（按位进行或操作），从而同时启用对应flag的功能。创建Event时，Event资源不受硬件限制。

本接口为封装接口，仅适用于C++程序，接口内部调用C接口[aclrtCreateEventExWithFlag](07_event_management.md#aclrtCreateEventExWithFlag)。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| event | 输出 | Event的指针。类型定义请参见[aclrtEvent](25-05_Typedefs.md#aclrtEvent)。 |
| flag | 输入 | Event指针的flag。<br>flag为bitmap，支持将flag设置为单个宏、或者对多个宏进行或操作。<br>当前支持将flag设置为如下宏：<br>  - ACL_EVENT_TIME_LINE：使用该bit表示创建的Event需要记录时间戳信息。注意：使用时间戳功能会影响Event相关接口的性能。<br>  - ACL_EVENT_SYNC：使用该bit表示创建的Event支持多Stream间的同步。<br>  - ACL_EVENT_CAPTURE_STREAM_PROGRESS：使用该bit表示创建的Event用于跟踪stream的任务执行进度。<br>  - ACL_EVENT_IPC：使用该bit表示创建的Event用于进程间通信，详细说明请参见[aclrtIpcGetEventHandle](07_event_management.md#aclrtIpcGetEventHandle)。注意：Ascend 950DT上不支持使用本flag创建Event；本flag不支持与其他flag进行位或操作；本flag创建出来的Event不支持在以下接口或场景中使用：[aclrtResetEvent](07_event_management.md#aclrtResetEvent)、[aclrtQueryEvent](07_event_management.md#aclrtQueryEvent_deprecated)、[aclrtQueryEventWaitStatus](07_event_management.md#aclrtQueryEventWaitStatus)、[aclrtEventElapsedTime](07_event_management.md#aclrtEventElapsedTime)、[aclrtEventGetTimestamp](07_event_management.md#aclrtEventGetTimestamp)、[aclrtGetEventId](07_event_management.md#aclrtGetEventId)、模型捕获场景（参见[aclmdlRICaptureBegin](15_model_running_instance__management.md#aclmdlRICaptureBegin)中的说明），否则返回报错。<br><br><br>宏的定义如下：<br>#define ACL_EVENT_TIME_LINE 0x00000008U<br>#define ACL_EVENT_SYNC 0x00000001U<br>#define ACL_EVENT_CAPTURE_STREAM_PROGRESS 0x00000002U<br>#define ACL_EVENT_IPC 0x00000040U |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

约束与C接口[aclrtCreateEventExWithFlag](07_event_management.md#aclrtCreateEventExWithFlag)保持一致。

<br>
<br>
<br>

<a id="aclrtMemcpyBatch"></a>

## aclrtMemcpyBatch

```cpp
template <typename T, typename U>
aclError aclrtMemcpyBatch(T **dsts, size_t *destMaxs, U **srcs, size_t *sizes, size_t numBatches, aclrtMemcpyBatchAttr attr)

template <typename T, typename U>
aclError aclrtMemcpyBatch(T **dsts, size_t *destMaxs, U **srcs, size_t *sizes, size_t numBatches, aclrtMemcpyBatchAttr *attrs, size_t *attrsIndexes, size_t numAttrs)
```

### 产品支持情况

<!-- npu="950" id204 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id204 -->
<!-- npu="A3" id205 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id205 -->
<!-- npu="910b" id206 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id206 -->
<!-- npu="310b" id207 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id207 -->
<!-- npu="310p" id208 -->
- Atlas 推理系列产品：不支持
<!-- end id208 -->
<!-- npu="910" id209 -->
- Atlas 训练系列产品：不支持
<!-- end id209 -->
<!-- npu="IPV350" id210 -->
- IPV350：不支持
<!-- end id210 -->
<!-- @ref: runtime/res/docs/zh/api_ref/26_cpp_extension_APIs_res.md#id8 -->

### 功能说明

实现批量内存复制。

本接口中的Host内存支持锁页内存（例如通过aclrtMallocHost接口申请的内存）、非锁页内存（通过malloc接口申请的内存）。

本接口为封装接口，仅适用于C++程序，接口内部调用C接口[aclrtMemcpyBatchV2](11-03_memory_copy_and_set.md#aclrtMemcpyBatchV2)。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| dsts | 输入 | 目的内存地址数组。 |
| destMaxs | 输入 | 内存复制最大长度数组，用于存放每一段要复制的内存的最大长度，单位Byte。 |
| srcs | 输入 | 源内存地址数组。 |
| sizes | 输入 | 内存复制长度数组，用于存放每一段要复制的内存大小，单位Byte。 |
| numBatches | 输入 | dsts、srcs和sizes数组的长度。 |
| attr | 输入 | 内存复制属性。针对所有内存，使用同一个内存复制属性。<br>类型定义请参见[aclrtMemcpyBatchAttr](25-04_Structs.md#aclrtMemcpyBatchAttr)。 |
| attrs | 输入 | 内存复制属性数组。针对每一段内存，使用对应的内存复制属性。<br>类型定义请参见[aclrtMemcpyBatchAttr](25-04_Structs.md#aclrtMemcpyBatchAttr)。 |
| attrsIndexes | 输入 | 内存复制属性索引数组，用于指定attrs数组中每个条目适用的复制范围。attrs[k]中指定的属性将应用于从attrsIndexes[k]到attrsIndexes[k+1] - 1的复制操作，同时attrs[numAttrs-1]将应用于从attrsIndexes[numAttrs-1]到numBatches - 1的复制操作。 |
| numAttrs | 输入 | attrs和attrsIndexes数组的长度。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

约束与C接口[aclrtMemcpyBatchV2](11-03_memory_copy_and_set.md#aclrtMemcpyBatchV2)保持一致。

<br>
<br>
<br>

<a id="aclrtMemcpyBatchAsync"></a>

## aclrtMemcpyBatchAsync

```cpp
template <typename T, typename U>
aclError aclrtMemcpyBatchAsync(T **dsts, size_t *destMaxs, U **srcs, size_t *sizes, size_t numBatches, aclrtMemcpyBatchAttr attr, aclrtStream stream)

template <typename T, typename U>
aclError aclrtMemcpyBatchAsync(T **dsts, size_t *destMaxs, U **srcs, size_t *sizes, size_t numBatches, aclrtMemcpyBatchAttr *attrs, size_t *attrsIndexes, size_t numAttrs, aclrtStream stream)
```

### 产品支持情况

<!-- npu="950" id1156 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1156 -->
<!-- npu="A3" id1157 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1157 -->
<!-- npu="910b" id1158 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1158 -->
<!-- npu="310b" id1159 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id1159 -->
<!-- npu="310p" id1160 -->
- Atlas 推理系列产品：不支持
<!-- end id1160 -->
<!-- npu="910" id1161 -->
- Atlas 训练系列产品：不支持
<!-- end id1161 -->
<!-- npu="IPV350" id1162 -->
- IPV350：不支持
<!-- end id1162 -->
<!-- @ref: runtime/res/docs/zh/api_ref/26_cpp_extension_APIs_res.md#id9 -->

### 功能说明

实现批量内存复制。

本接口中的Host内存支持锁页内存（例如通过aclrtMallocHost接口申请的内存）、非锁页内存（通过malloc接口申请的内存）。当Host内存是非锁页内存时，本接口在内存复制任务完成后才返回；当Host内存是锁页内存时，本接口是异步接口，调用接口成功仅表示任务下发成功，不表示任务执行成功，调用本接口后，需调用同步等待接口（例如，[aclrtSynchronizeStream](06_stream_management.md#aclrtSynchronizeStream)）确保内存复制的任务已执行完成。

本接口为封装接口，仅适用于C++程序，接口内部调用C接口[aclrtMemcpyBatchAsyncV2](11-03_memory_copy_and_set.md#aclrtMemcpyBatchAsyncV2)。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| dsts | 输入 | 目的内存地址数组。 |
| destMaxs | 输入 | 内存复制最大长度数组，用于存放每一段要复制的内存的最大长度，单位Byte。 |
| srcs | 输入 | 源内存地址数组。 |
| sizes | 输入 | 内存复制长度数组，用于存放每一段要复制的内存大小，单位Byte。 |
| numBatches | 输入 | dsts、srcs和sizes数组的长度。 |
| attr | 输入 | 内存复制属性。针对所有内存，使用同一个内存复制属性。<br>类型定义请参见[aclrtMemcpyBatchAttr](25-04_Structs.md#aclrtMemcpyBatchAttr)。 |
| attrs | 输入 | 内存复制属性数组。针对每一段内存，使用对应的内存复制属性。<br>类型定义请参见[aclrtMemcpyBatchAttr](25-04_Structs.md#aclrtMemcpyBatchAttr)。 |
| attrsIndexes | 输入 | 内存复制属性索引数组，用于指定attrs数组中每个条目适用的复制范围。attrs[k]中指定的属性将应用于从attrsIndexes[k]到attrsIndexes[k+1] - 1的复制操作，同时attrs[numAttrs-1]将应用于从attrsIndexes[numAttrs-1]到numBatches - 1的复制操作。 |
| numAttrs | 输入 | attrs和attrsIndexes数组的长度。 |
| stream | 输入 | 指定执行内存复制任务的Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

约束与C接口[aclrtMemcpyBatchAsyncV2](11-03_memory_copy_and_set.md#aclrtMemcpyBatchAsyncV2)接口保持一致。

<br>
<br>
<br>

<a id="aclrtPointerGetAttributes"></a>

## aclrtPointerGetAttributes

```cpp
template <typename T>
aclError aclrtPointerGetAttributes(const T *ptr, aclrtPtrAttributes *attributes)
```

### 产品支持情况

<!-- npu="950" id2941 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2941 -->
<!-- npu="A3" id2942 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2942 -->
<!-- npu="910b" id2943 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2943 -->
<!-- npu="310b" id2944 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2944 -->
<!-- npu="310p" id2945 -->
- Atlas 推理系列产品：支持
<!-- end id2945 -->
<!-- npu="910" id2946 -->
- Atlas 训练系列产品：支持
<!-- end id2946 -->
<!-- npu="IPV350" id2947 -->
- IPV350：不支持
<!-- end id2947 -->
<!-- @ref: runtime/res/docs/zh/api_ref/26_cpp_extension_APIs_res.md#id10 -->

### 功能说明

获取内存属性信息，包括内存是位于Host还是Device、页表大小等信息。

本接口为封装接口，仅适用于C++程序，接口内部调用C接口[aclrtPointerGetAttributes](11-05_unified_addressing.md#aclrtPointerGetAttributes)。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| ptr | 输入 | 内存地址。<br>此处不允许传入通过aclrtHostRegister接口映射的Device地址，也不允许传入通过aclrtHostGetDevicePointer接口获取的Device地址，否则会导致未定义行为。 |
| attributes | 输出 | 内存属性信息。类型定义请参见[aclrtPtrAttributes](25-04_Structs.md#aclrtPtrAttributes)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtHostRegister"></a>

## aclrtHostRegister

```cpp
template <typename T>
aclError aclrtHostRegister(T *ptr, uint64_t size, aclrtHostRegisterType type, T **devPtr)

template <typename T>
aclError aclrtHostRegister(T *ptr, uint64_t size, uint32_t flag)
```

### 产品支持情况

<!-- npu="950" id708 -->
- Ascend 950PR：支持
- Ascend 950DT：不支持
<!-- end id708 -->
<!-- npu="A3" id709 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id709 -->
<!-- npu="910b" id710 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id710 -->
<!-- npu="310b" id711 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id711 -->
<!-- npu="310p" id712 -->
- Atlas 推理系列产品：不支持
<!-- end id712 -->
<!-- npu="910" id713 -->
- Atlas 训练系列产品：不支持
<!-- end id713 -->
<!-- npu="IPV350" id714 -->
- IPV350：不支持
<!-- end id714 -->
<!-- @ref: runtime/res/docs/zh/api_ref/26_cpp_extension_APIs_res.md#id11 -->

### 功能说明

注册Host内存地址。取消注册需调用[aclrtHostUnregister](11-02_host_memory_management.md#aclrtHostUnregister)接口。

本接口为封装接口，仅适用于C++程序，接口内部调用C接口[aclrtHostRegister](11-02_host_memory_management.md#aclrtHostRegister)或[aclrtHostRegisterV2](11-02_host_memory_management.md#aclrtHostRegisterV2)。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| ptr | 输入 | Host内存地址。<br>Host内存地址需4K页对齐。<br>当os内核版本为5.10或更低时，使用非锁页内存会导致异常，因此必须调用aclrtMallocHost接口来申请Host锁页内存。<br>当os内核版本为5.10以上时，支持使用非锁页的Host内存，因此既支持调用aclrtMallocHost接口申请Host锁页内存，也支持使用malloc接口申请Host非锁页内存。 |
| size | 输入 | 内存大小，单位Byte。 |
| type | 输入 | 内存注册类型。类型定义请参见[aclrtHostRegisterType](25-02_Enumerations.md#aclrtHostRegisterType)。 |
| devPtr | 输出 | Host内存映射成的Device可访问的内存地址。<br>该地址仅支持在Device上访问，例如作为核函数的参数，供Device的AI Core访问。若涉及Host侧的内存处理，需使用原始Host内存地址。 |
| flag | 输入 | 内存注册类型。<br>取值为如下宏，支持配置单个宏，也支持配置多个宏位或（例如ACL_HOST_REG_MAPPED \| ACL_HOST_REG_PINNED）。<br><br>  - ACL_HOST_REG_MAPPED：将Host内存映射注册为Device可访问的内存地址，再配合调用[aclrtHostGetDevicePointer](11-02_host_memory_management.md#aclrtHostGetDevicePointer)接口获取映射后的Device内存地址。<br>  - ACL_HOST_REG_IOMEMORY：将Host上第三方PCIe设备的IO space(寄存器、缓存)映射注册为Device可访问，包括读写。<br>  - ACL_HOST_REG_READONLY：Host内存映射注册为Device只读。预留选项，当前不支持。<br>  - ACL_HOST_REG_PINNED：将Host非锁页内存注册为锁页内存。Host非锁页内存可通过C/C++标准库函数（如malloc、calloc、new）或默认的mmap系统调用等方式申请。<br><br><br>宏定义如下：<br>#define ACL_HOST_REG_MAPPED 0x2UL<br>#define ACL_HOST_REG_IOMEMORY 0x4UL<br>#define ACL_HOST_REG_READONLY 0x8UL<br>#define ACL_HOST_REG_PINNED 0X10000000UL |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtHostGetDevicePointer"></a>

## aclrtHostGetDevicePointer

```cpp
template <typename T>
aclError aclrtHostGetDevicePointer(T *pHost, T **pDevice, uint32_t flag)
```

### 产品支持情况

<!-- npu="950" id169 -->
- Ascend 950PR：支持
- Ascend 950DT：不支持
<!-- end id169 -->
<!-- npu="A3" id170 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id170 -->
<!-- npu="910b" id171 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id171 -->
<!-- npu="310b" id172 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id172 -->
<!-- npu="310p" id173 -->
- Atlas 推理系列产品：不支持
<!-- end id173 -->
<!-- npu="910" id174 -->
- Atlas 训练系列产品：不支持
<!-- end id174 -->
<!-- npu="IPV350" id175 -->
- IPV350：不支持
<!-- end id175 -->
<!-- @ref: runtime/res/docs/zh/api_ref/26_cpp_extension_APIs_res.md#id12 -->

### 功能说明

获取由[aclrtHostRegister](#aclrtHostRegister)接口注册映射的Device内存地址。

本接口为封装接口，仅适用于C++程序，接口内部调用C接口[aclrtHostGetDevicePointer](11-02_host_memory_management.md#aclrtHostGetDevicePointer)。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| pHost | 输入 | 通过[aclrtHostRegister](#aclrtHostRegister)接口注册映射的Host内存地址。 |
| pDevice | 输出 | Host内存映射成的Device内存地址。 |
| flag | 输入 | 预留参数，当前固定配置为0。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtHostUnregister"></a>

## aclrtHostUnregister

```cpp
template <typename T>
aclError aclrtHostUnregister(T *ptr)
```

### 产品支持情况

<!-- npu="950" id848 -->
- Ascend 950PR：支持
- Ascend 950DT：不支持
<!-- end id848 -->
<!-- npu="A3" id849 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id849 -->
<!-- npu="910b" id850 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id850 -->
<!-- npu="310b" id851 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id851 -->
<!-- npu="310p" id852 -->
- Atlas 推理系列产品：不支持
<!-- end id852 -->
<!-- npu="910" id853 -->
- Atlas 训练系列产品：支持
<!-- end id853 -->
<!-- npu="IPV350" id854 -->
- IPV350：不支持
<!-- end id854 -->
<!-- @ref: runtime/res/docs/zh/api_ref/26_cpp_extension_APIs_res.md#id13 -->

### 功能说明

取消注册Host内存。

本接口与[aclrtHostRegister](#aclrtHostRegister)接口成对使用。

本接口为封装接口，仅适用于C++程序，接口内部调用C接口[aclrtHostUnregister](11-02_host_memory_management.md#aclrtHostUnregister)。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| ptr | 输入 | Host侧内存地址。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtMemAllocManaged"></a>

## aclrtMemAllocManaged

```cpp
template <typename T>
aclError aclrtMemAllocManaged(T **devPtr, size_t size, uint32_t flags = ACL_RT_MEM_ATTACH_GLOBAL)
```

### 产品支持情况

<!-- npu="950" id3417 -->
- Ascend 950PR/Ascend 950DT：不支持
<!-- end id3417 -->
<!-- npu="A3" id3418 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：不支持
<!-- end id3418 -->
<!-- npu="910b" id3419 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id3419 -->
<!-- npu="310b" id3420 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id3420 -->
<!-- npu="310p" id3421 -->
- Atlas 推理系列产品：不支持
<!-- end id3421 -->
<!-- npu="910" id3422 -->
- Atlas 训练系列产品：不支持
<!-- end id3422 -->
<!-- npu="IPV350" id3423 -->
- IPV350：不支持
<!-- end id3423 -->
<!-- @ref: runtime/res/docs/zh/api_ref/26_cpp_extension_APIs_res.md#id14 -->

### 功能说明

申请统一虚拟内存（Unified Virtual Memory, UVM），通过\*ptr返回已申请内存的指针，且申请的内存大小会根据用户指定的size向上按2M对齐。使用本接口申请的内存，若需释放内存，需调用[aclrtFree](11-01_device_memory_malloc_and_free.md#aclrtFree)接口。

本接口为封装接口，仅适用于C++程序，接口内部调用C接口[aclrtMemAllocManaged](11-05_unified_addressing.md#aclrtMemAllocManaged)。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| ptr | 输出 | “已分配内存的指针”的指针，由于Host和Device虚拟地址统一编址，该参数不区分申请位置。 |
| size | 输入 | 内存大小，单位Byte。<br>size不能为0，单个应用进程最大可申请3T UVM类型的虚拟内存。 |
| flag | 输入 | 内存标识。<br>当前flag仅支持设置为ACL_RT_MEM_ATTACH_GLOBAL，所对应数值为1。设置为ACL_RT_MEM_ATTACH_GLOBAL后，通过本接口申请的内存在Device和Host侧都可以被访问。<br>宏定义如下：<br>#define ACL_RT_MEM_ATTACH_GLOBAL (0x01U) |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

约束与C接口[aclrtMemAllocManaged](11-05_unified_addressing.md#aclrtMemAllocManaged)接口保持一致。

<br>
<br>
<br>

<a id="aclrtMemManagedPrefetchAsync"></a>

## aclrtMemManagedPrefetchAsync

```cpp
template <typename T>
aclError aclrtMemManagedPrefetchAsync(const T *ptr, size_t size, aclrtMemManagedLocation location, uint32_t flags, aclrtStream stream)
```

### 产品支持情况

<!-- npu="950" id2472 -->
- Ascend 950PR/Ascend 950DT：不支持
<!-- end id2472 -->
<!-- npu="A3" id2473 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：不支持
<!-- end id2473 -->
<!-- npu="910b" id2474 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2474 -->
<!-- npu="310b" id2475 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id2475 -->
<!-- npu="310p" id2476 -->
- Atlas 推理系列产品：不支持
<!-- end id2476 -->
<!-- npu="910" id2477 -->
- Atlas 训练系列产品：不支持
<!-- end id2477 -->
<!-- npu="IPV350" id2478 -->
- IPV350：不支持
<!-- end id2478 -->
<!-- @ref: runtime/res/docs/zh/api_ref/26_cpp_extension_APIs_res.md#id15 -->

### 功能说明

实现统一虚拟内存（Unified Virtual Memory, UVM）的预取。

本接口操作的内存必须是通过[aclrtMemAllocManaged](#aclrtMemAllocManaged)接口分配的。本接口是异步接口，调用接口成功仅表示任务下发成功，不表示任务执行成功，调用本接口后，需调用同步等待接口（例如，[aclrtSynchronizeStream](06_stream_management.md#aclrtSynchronizeStream)）确保内存预取的任务已执行完成。

本接口为封装接口，仅适用于C++程序，接口内部调用C接口[aclrtMemManagedPrefetchAsync](11-05_unified_addressing.md#aclrtMemManagedPrefetchAsync)。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| ptr | 输入 | 待预取的内存地址，地址范围必须在UVM内存范围之内，即[0x90000000000ULL, 0x90000000000ULL+3T)。 |
| size | 输入 | 待预取的内存长度，单位Byte，要求2MB对齐。取值范围为(0, 3T]。 |
| location | 输入 | 物理内存的位置信息，location参数包含id和type两个成员。类型定义请参见[aclrtMemManagedLocation](25-04_Structs.md#aclrtMemManagedLocation)。 |
| flags | 输入 | 预留参数。当前固定配置为0。 |
| stream | 输入 | 指定执行内存预取任务的stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtMemManagedPrefetchBatchAsync"></a>

## aclrtMemManagedPrefetchBatchAsync

```cpp
template <typename T>
aclError aclrtMemManagedPrefetchBatchAsync(const T **ptrs, size_t *sizes, size_t count, aclrtMemManagedLocation prefetchLoc, uint64_t flags, aclrtStream stream)

template <typename T>
aclError aclrtMemManagedPrefetchBatchAsync(const T **ptrs, size_t *sizes, size_t count, aclrtMemManagedLocation *prefetchLocs, size_t *prefetchLocIdxs, size_t numPrefetchLocs, uint64_t flags, aclrtStream stream)
```

### 产品支持情况

<!-- npu="950" id3298 -->
- Ascend 950PR/Ascend 950DT：不支持
<!-- end id3298 -->
<!-- npu="A3" id3299 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：不支持
<!-- end id3299 -->
<!-- npu="910b" id3300 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id3300 -->
<!-- npu="310b" id3301 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id3301 -->
<!-- npu="310p" id3302 -->
- Atlas 推理系列产品：不支持
<!-- end id3302 -->
<!-- npu="910" id3303 -->
- Atlas 训练系列产品：不支持
<!-- end id3303 -->
<!-- npu="IPV350" id3304 -->
- IPV350：不支持
<!-- end id3304 -->
<!-- @ref: runtime/res/docs/zh/api_ref/26_cpp_extension_APIs_res.md#id16 -->

### 功能说明

实现统一虚拟内存（Unified Virtual Memory, UVM）的批量预取。

本接口操作的内存必须是通过[aclrtMemAllocManaged](#aclrtMemAllocManaged)接口分配的。本接口是异步接口，调用接口成功仅表示任务下发成功，不表示任务执行成功，调用本接口后，需调用同步等待接口（例如，[aclrtSynchronizeStream](06_stream_management.md#aclrtSynchronizeStream)）确保内存预取的任务已执行完成。

本接口为封装接口，仅适用于C++程序，接口内部调用C接口[aclrtMemManagedPrefetchBatchAsync](11-05_unified_addressing.md#aclrtMemManagedPrefetchBatchAsync)。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| ptrs | 输入 | 待预取的内存地址数组，每个地址的范围都必须在UVM内存范围之内，即[0x90000000000ULL, 0x90000000000ULL+3T)。 |
| sizes | 输入 | 内存预取长度数组，用于存放每一段要预取的UVM内存长度，单位Byte。每段长度都要求2MB对齐，取值范围为(0, 3T]。 |
| count | 输入 | ptrs和sizes数组的长度。 |
| prefetchLoc | 输入 | 物理内存的位置信息，每个位置信息都包含id和type两个成员。针对所有待预取的内存，使用同一个物理内存的位置信息<br>类型定义请参见[aclrtMemManagedLocation](25-04_Structs.md#aclrtMemManagedLocation)。 |
| prefetchLocs | 输入 | 物理内存的位置信息数组，每个位置信息都包含id和type两个成员。针对每一段待预取的内存，使用相应的物理内存的位置信息<br>类型定义请参见[aclrtMemManagedLocation](25-04_Structs.md#aclrtMemManagedLocation)。 |
| prefetchLocIdxs | 输入 | 物理内存预取信息索引数组，用于指定prefetchLocs数组中的每个物理地址适用的预取范围。对于prefetchLocs[k]指定的物理地址，将预取ptrs数组中从第prefetchLocIdxs[k]个下标到第prefetchLocIdxs[k+1] – 1个下标指向元素的UVM内存地址，同时对于prefetchLocs[numPrefetchLocs -1]指定的物理地址，将预取ptrs数组中从第prefetchLocIdxs[numPrefetchLocs -1]个下标到第count - 1个下标指向元素的UVM内存地址。 |
| numPrefetchLocs | 输入 | prefetchLocs和prefetchLocIdxs数组的长度。 |
| flags | 输入 | 预留参数。当前固定配置为0。 |
| stream | 输入 | 指定执行内存预取任务的stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

约束与C接口[aclrtMemManagedPrefetchBatchAsync](11-05_unified_addressing.md#aclrtMemManagedPrefetchBatchAsync)接口保持一致。

<br>
<br>
<br>

<a id="aclrtMalloc"></a>

## aclrtMalloc

```cpp
template <typename T>
aclError aclrtMalloc(T **devPtr, size_t size, aclrtMallocConfig *cfg = nullptr)

template <typename T>
aclError aclrtMalloc(T **devPtr, size_t size, aclrtMemMallocPolicy policy, aclrtMallocConfig *cfg = nullptr)
```

### 产品支持情况

<!-- npu="950" id1828 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1828 -->
<!-- npu="A3" id1829 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1829 -->
<!-- npu="910b" id1830 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1830 -->
<!-- npu="310b" id1831 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1831 -->
<!-- npu="310p" id1832 -->
- Atlas 推理系列产品：支持
<!-- end id1832 -->
<!-- npu="910" id1833 -->
- Atlas 训练系列产品：支持
<!-- end id1833 -->
<!-- npu="IPV350" id1834 -->
- IPV350：支持
<!-- end id1834 -->
<!-- @ref: runtime/res/docs/zh/api_ref/26_cpp_extension_APIs_res.md#id17 -->

### 功能说明

在Device上分配size大小的线性内存，并通过\*devPtr返回已分配内存的指针，且内存首地址64字节对齐。

使用本接口申请的内存，需要通过[aclrtFree](11-01_device_memory_malloc_and_free.md#aclrtFree)接口或[aclrtFreeWithDevSync](11-01_device_memory_malloc_and_free.md#aclrtFreeWithDevSync)接口释放内存。

本接口为封装接口，仅适用于C++程序，接口内部调用C接口[aclrtMallocWithCfg](11-01_device_memory_malloc_and_free.md#aclrtMallocWithCfg)。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| devPtr | 输出 | “Device上已分配内存的指针”的指针。 |
| size | 输入 | 申请内存的大小，单位Byte。<br>size不能为0。 |
| policy | 输入 | 内存分配规则。类型定义请参见[aclrtMemMallocPolicy](25-02_Enumerations.md#aclrtMemMallocPolicy)。<br>若配置的内存分配规则超出[aclrtMemMallocPolicy](25-02_Enumerations.md#aclrtMemMallocPolicy)取值范围，size≥2M时，按大页申请内存，否则按普通页申请内存。 |
| cfg | 输入 | 内存配置信息。类型定义请参见[aclrtMallocConfig](25-04_Structs.md#aclrtMallocConfig)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtMallocHost"></a>

## aclrtMallocHost

```cpp
template <typename T>
aclError aclrtMallocHost(T **hostPtr, size_t size, aclrtMallocConfig *cfg = nullptr)
```

### 产品支持情况

<!-- npu="950" id2521 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2521 -->
<!-- npu="A3" id2522 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2522 -->
<!-- npu="910b" id2523 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2523 -->
<!-- npu="310b" id2524 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2524 -->
<!-- npu="310p" id2525 -->
- Atlas 推理系列产品：支持
<!-- end id2525 -->
<!-- npu="910" id2526 -->
- Atlas 训练系列产品：支持
<!-- end id2526 -->
<!-- npu="IPV350" id2527 -->
- IPV350：不支持
<!-- end id2527 -->
<!-- @ref: runtime/res/docs/zh/api_ref/26_cpp_extension_APIs_res.md#id18 -->

### 功能说明

申请Host内存（该内存是锁页内存），由系统保证内存首地址64字节对齐。

通过本接口申请的内存，需要通过[aclrtFreeHost](11-02_host_memory_management.md#aclrtFreeHost)接口或[aclrtFreeHostWithDevSync](11-02_host_memory_management.md#aclrtFreeHostWithDevSync)接口释放内存。

本接口为封装接口，仅适用于C++程序，接口内部调用C接口[aclrtMallocHostWithCfg](11-02_host_memory_management.md#aclrtMallocHostWithCfg)。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| devPtr | 输出 | “Device上已分配内存的指针”的指针。 |
| size | 输入 | 申请内存的大小，单位Byte。<br>size不能为0。 |
| policy | 输入 | 内存分配规则。类型定义请参见[aclrtMemMallocPolicy](25-02_Enumerations.md#aclrtMemMallocPolicy)。<br>若配置的内存分配规则超出[aclrtMemMallocPolicy](25-02_Enumerations.md#aclrtMemMallocPolicy)取值范围，size≥2M时，按大页申请内存，否则按普通页申请内存。 |
| cfg | 输入 | 内存配置信息。类型定义请参见[aclrtMallocConfig](25-04_Structs.md#aclrtMallocConfig)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtMemcpy"></a>

## aclrtMemcpy

```cpp
template <typename T, typename U>
aclError aclrtMemcpy(T *dst, size_t destMax, const U *src, size_t count, aclrtMemcpyKind kind)
```

### 产品支持情况

<!-- npu="950" id1632 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1632 -->
<!-- npu="A3" id1633 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1633 -->
<!-- npu="910b" id1634 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1634 -->
<!-- npu="310b" id1635 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1635 -->
<!-- npu="310p" id1636 -->
- Atlas 推理系列产品：支持
<!-- end id1636 -->
<!-- npu="910" id1637 -->
- Atlas 训练系列产品：支持
<!-- end id1637 -->
<!-- npu="IPV350" id1638 -->
- IPV350：支持
<!-- end id1638 -->
<!-- @ref: runtime/res/docs/zh/api_ref/26_cpp_extension_APIs_res.md#id19 -->

### 功能说明

实现内存复制。

本接口为封装接口，仅适用于C++程序，接口内部调用C接口[aclrtMemcpy](11-03_memory_copy_and_set.md#aclrtMemcpy)。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| dst | 输入 | 目的内存地址指针。 |
| destMax | 输入 | 目的内存地址的最大内存长度，单位Byte。 |
| src | 输入 | 源内存地址指针。 |
| count | 输入 | 内存复制的长度，单位Byte。 |
| kind | 输入 | 内存复制的类型，预留参数，配置枚举值中的值无效，系统内部会根据源内存地址指针、目的内存地址指针判断是否可以将源地址的数据复制到目的地址，如果不可以，则系统会返回报错。<br>类型定义请参见[aclrtMemcpyKind](25-02_Enumerations.md#aclrtMemcpyKind)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

约束与C接口[aclrtMemcpy](11-03_memory_copy_and_set.md#aclrtMemcpy)保持一致

<br>
<br>
<br>

<a id="aclrtMemcpyAsync"></a>

## aclrtMemcpyAsync

```cpp
template <typename T, typename U>
aclError aclrtMemcpyAsync(T *dst, size_t destMax, const U *src, size_t count, aclrtMemcpyKind kind, aclrtStream stream)
```

### 产品支持情况

<!-- npu="950" id3221 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id3221 -->
<!-- npu="A3" id3222 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id3222 -->
<!-- npu="910b" id3223 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id3223 -->
<!-- npu="310b" id3224 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id3224 -->
<!-- npu="310p" id3225 -->
- Atlas 推理系列产品：支持
<!-- end id3225 -->
<!-- npu="910" id3226 -->
- Atlas 训练系列产品：支持
<!-- end id3226 -->
<!-- npu="IPV350" id3227 -->
- IPV350：不支持
<!-- end id3227 -->
<!-- @ref: runtime/res/docs/zh/api_ref/26_cpp_extension_APIs_res.md#id20 -->

### 功能说明

实现内存复制。

本接口中的Host内存支持锁页内存（例如通过aclrtMallocHost接口申请的内存）、非锁页内存（通过malloc接口申请的内存）。当Host内存是锁页内存时，本接口是异步接口，调用接口成功仅表示任务下发成功，不表示任务执行成功，调用本接口后，需调用同步等待接口（例如，[aclrtSynchronizeStream](06_stream_management.md#aclrtSynchronizeStream)）确保内存复制的任务已执行完成；当Host内存是非锁页内存时，本接口在内存复制任务完成后才返回。

本接口为封装接口，仅适用于C++程序，接口内部调用C接口[aclrtMemcpyAsync](11-03_memory_copy_and_set.md#aclrtMemcpyAsync)。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| dst | 输入 | 目的内存地址指针。 |
| destMax | 输入 | 目的内存地址的最大内存长度，单位Byte。 |
| src | 输入 | 源内存地址指针。 |
| count | 输入 | 内存复制的长度，单位Byte。 |
| kind | 输入 | 内存复制的类型。类型定义请参见[aclrtMemcpyKind](25-02_Enumerations.md#aclrtMemcpyKind)。 |
| stream | 输入 | 指定执行内存复制任务的Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

约束与C接口[aclrtMemcpyAsync](11-03_memory_copy_and_set.md#aclrtMemcpyAsync)保持一致。

<br>
<br>
<br>

<a id="aclrtMemcpy2d"></a>

## aclrtMemcpy2d

```cpp
template <typename T, typename U>
aclError aclrtMemcpy2d(T *dst, size_t dpitch, const U *src, size_t spitch, size_t width, size_t height, aclrtMemcpyKind kind)
```

### 产品支持情况

<!-- npu="950" id2353 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2353 -->
<!-- npu="A3" id2354 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2354 -->
<!-- npu="910b" id2355 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2355 -->
<!-- npu="310b" id2356 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2356 -->
<!-- npu="310p" id2357 -->
- Atlas 推理系列产品：支持
<!-- end id2357 -->
<!-- npu="910" id2358 -->
- Atlas 训练系列产品：支持
<!-- end id2358 -->
<!-- npu="IPV350" id2359 -->
- IPV350：不支持
<!-- end id2359 -->
<!-- @ref: runtime/res/docs/zh/api_ref/26_cpp_extension_APIs_res.md#id21 -->

### 功能说明

实现同步内存复制，主要用于矩阵数据的复制。

本接口为封装接口，仅适用于C++程序，接口内部调用C接口[aclrtMemcpy2d](11-03_memory_copy_and_set.md#aclrtMemcpy2d)。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| dst | 输入 | 目的内存地址指针。 |
| dpitch | 输入 | 目的内存中相邻两列向量的地址距离。 |
| src | 输入 | 源内存地址指针。 |
| spitch | 输入 | 源内存中相邻两列向量的地址距离。 |
| width | 输入 | 待复制的数据宽度。 |
| height | 输入 | 待复制的数据高度。 |
| kind | 输入 | 内存复制的类型。类型定义请参见[aclrtMemcpyKind](25-02_Enumerations.md#aclrtMemcpyKind)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

约束与C接口[aclrtMemcpy2d](11-03_memory_copy_and_set.md#aclrtMemcpy2d)保持一致。

<br>
<br>
<br>

<a id="aclrtMemcpy2dAsync"></a>

## aclrtMemcpy2dAsync

```cpp
template <typename T, typename U>
aclError aclrtMemcpy2dAsync(T *dst, size_t dpitch, const U *src, size_t spitch, size_t width, size_t height, aclrtMemcpyKind kind, aclrtStream stream)
```

### 产品支持情况

<!-- npu="950" id2717 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2717 -->
<!-- npu="A3" id2718 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2718 -->
<!-- npu="910b" id2719 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2719 -->
<!-- npu="310b" id2720 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2720 -->
<!-- npu="310p" id2721 -->
- Atlas 推理系列产品：支持
<!-- end id2721 -->
<!-- npu="910" id2722 -->
- Atlas 训练系列产品：支持
<!-- end id2722 -->
<!-- npu="IPV350" id2723 -->
- IPV350：不支持
<!-- end id2723 -->
<!-- @ref: runtime/res/docs/zh/api_ref/26_cpp_extension_APIs_res.md#id22 -->

### 功能说明

实现异步内存复制，主要用于矩阵数据的复制。异步接口。

本接口中的Host内存支持锁页内存（例如通过aclrtMallocHost接口申请的内存）、非锁页内存（通过malloc接口申请的内存）。当Host内存是非锁页内存时，本接口在内存复制任务完成后才返回；当Host内存是锁页内存时，本接口是异步接口，调用接口成功仅表示任务下发成功，不表示任务执行成功，调用本接口后，需调用同步等待接口（例如，[aclrtSynchronizeStream](06_stream_management.md#aclrtSynchronizeStream)）确保内存复制的任务已执行完成。

本接口为封装接口，仅适用于C++程序，接口内部调用C接口[aclrtMemcpy2dAsync](11-03_memory_copy_and_set.md#aclrtMemcpy2dAsync)。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| dst | 输入 | 目的内存地址指针。 |
| dpitch | 输入 | 目的内存中相邻两列向量的地址距离。 |
| src | 输入 | 源内存地址指针。 |
| spitch | 输入 | 源内存中相邻两列向量的地址距离。 |
| width | 输入 | 待复制的数据宽度。<br>width最大设置为5000000，且必须小于或等于dpitch和spitch。 |
| height | 输入 | 待复制的数据高度。<br>height最大设置为5*1024*1024=5242880，否则接口返回失败。 |
| kind | 输入 | 内存复制的类型。类型定义请参见[aclrtMemcpyKind](25-02_Enumerations.md#aclrtMemcpyKind)。 |
| stream | 输入 | 指定执行内存复制任务的Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

约束与C接口[aclrtMemcpy2dAsync](11-03_memory_copy_and_set.md#aclrtMemcpy2dAsync)保持一致。

<br>
<br>
<br>

<a id="aclrtGetSymbolAddress"></a>

## aclrtGetSymbolAddress

```cpp
template <typename T>
aclError aclrtGetSymbolAddress(const T &symbol, void **devPtr)
```

### 产品支持情况

<!-- npu="950" id1317 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1317 -->
<!-- npu="A3" id1318 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1318 -->
<!-- npu="910b" id1319 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1319 -->
<!-- npu="310b" id1320 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id1320 -->
<!-- npu="310p" id1321 -->
- Atlas 推理系列产品：支持
<!-- end id1321 -->
<!-- npu="910" id1322 -->
- Atlas 训练系列产品：不支持
<!-- end id1322 -->
<!-- npu="IPV350" id1323 -->
- IPV350：不支持
<!-- end id1323 -->
<!-- @ref: runtime/res/docs/zh/api_ref/26_cpp_extension_APIs_res.md#id23 -->

### 功能说明

获取Device变量的地址。

本接口为封装接口，仅适用于C++程序，接口内部调用C接口[aclrtGetSymbolAddress](11-11_device_variable_memory_operation.md#aclrtGetSymbolAddress)。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| symbol | 输入 | Device变量名。此处传入`__gm__`声明的变量名。 |
| devPtr | 输出 | Device变量的内存地址指针。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

- 本接口仅适用于 C++ 程序。
- 本接口仅适用于Ascend C语言开发自定义算子并基于毕昇编译器进行Host和Device代码混合编译的场景。
- Device变量地址仅在当前Device有效，切换Device后需重新获取地址。
- 仅支持AI Core算子中的Device变量，具体约束如下：
    - 支持在main函数所在文件中定义的Device变量（如 `__gm__ float convWeights`）。
    - 支持通过extern关键字跨文件引用Device变量。例如，在文件A中定义`__gm__ float convWeights`，文件B中可通过`extern __gm__ float convWeights`声明并引用该变量。需要满足编译要求：使用毕昇编译器的-dc模式，将多个源文件编译为单个算子二进制文件。
    - 支持基础数据类型、函数指针、结构体及数组，不支持class类型。注意：函数指针只支持指向纯Scalar的函数，不能有效区分Cube和Vector的函数逻辑。

<br>
<br>
<br>

<a id="aclrtGetSymbolSize"></a>

## aclrtGetSymbolSize

```cpp
template <typename T>
aclError aclrtGetSymbolSize(const T &symbol, size_t *size)
```

### 产品支持情况

<!-- npu="950" id2325 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2325 -->
<!-- npu="A3" id2326 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2326 -->
<!-- npu="910b" id2327 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2327 -->
<!-- npu="310b" id2328 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id2328 -->
<!-- npu="310p" id2329 -->
- Atlas 推理系列产品：支持
<!-- end id2329 -->
<!-- npu="910" id2330 -->
- Atlas 训练系列产品：不支持
<!-- end id2330 -->
<!-- npu="IPV350" id2331 -->
- IPV350：不支持
<!-- end id2331 -->
<!-- @ref: runtime/res/docs/zh/api_ref/26_cpp_extension_APIs_res.md#id24 -->

### 功能说明

获取Device变量占用的内存大小。

本接口为封装接口，仅适用于C++程序，接口内部调用C接口[aclrtGetSymbolSize](11-11_device_variable_memory_operation.md#aclrtGetSymbolSize)。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| symbol | 输入 | Device变量名。此处传入`__gm__`声明的变量名。 |
| size | 输出 | Device变量的大小，单位Byte。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

同[aclrtGetSymbolAddress](#aclrtGetSymbolAddress)接口约束说明。

<br>
<br>
<br>

<a id="aclrtMemcpyFromSymbol"></a>

## aclrtMemcpyFromSymbol

```cpp
template <typename T>
aclError aclrtMemcpyFromSymbol(void *dst, size_t dstMax, const T &symbol, size_t count,
                               size_t offset, aclrtMemcpyKind kind)
```

### 产品支持情况

<!-- npu="950" id1912 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1912 -->
<!-- npu="A3" id1913 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1913 -->
<!-- npu="910b" id1914 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1914 -->
<!-- npu="310b" id1915 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id1915 -->
<!-- npu="310p" id1916 -->
- Atlas 推理系列产品：支持
<!-- end id1916 -->
<!-- npu="910" id1917 -->
- Atlas 训练系列产品：不支持
<!-- end id1917 -->
<!-- npu="IPV350" id1918 -->
- IPV350：不支持
<!-- end id1918 -->
<!-- @ref: runtime/res/docs/zh/api_ref/26_cpp_extension_APIs_res.md#id25 -->

### 功能说明

实现Device变量的数据到Host的同步内存复制。用于读取Device变量的数据。

本接口为封装接口，仅适用于C++程序，接口内部调用C接口[aclrtMemcpyFromSymbol](11-11_device_variable_memory_operation.md#aclrtMemcpyFromSymbol)。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| dst | 输入 | 目的内存地址指针。 |
| dstMax | 输入 | 目标内存最大长度，单位Byte。需满足 dstMax ≥ count。 |
| symbol | 输入 | Device变量名。此处传入`__gm__`声明的变量名。 |
| count | 输入 | 内存复制的长度，单位Byte。需满足 offset + count ≤ Device变量大小，Device变量大小可通过 [aclrtGetSymbolSize](#aclrtGetSymbolSize)接口查询获取。 |
| offset | 输入 | Device变量地址偏移，单位Byte。需满足 offset + count ≤ Device变量大小，Device变量大小可通过 [aclrtGetSymbolSize](#aclrtGetSymbolSize)接口查询获取。 |
| kind | 输入 | 拷贝类型，类型定义请参见[aclrtMemcpyKind](25-02_Enumerations.md#aclrtMemcpyKind)。本接口仅支持ACL_MEMCPY_DEVICE_TO_HOST和ACL_MEMCPY_DEFAULT。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

同[aclrtGetSymbolAddress](#aclrtGetSymbolAddress)接口约束说明。

<br>
<br>
<br>

<a id="aclrtMemcpyFromSymbolAsync"></a>

## aclrtMemcpyFromSymbolAsync

```cpp
template <typename T>
aclError aclrtMemcpyFromSymbolAsync(void *dst, size_t dstMax, const T &symbol, size_t count,
                                    size_t offset, aclrtMemcpyKind kind, aclrtStream stream)
```

### 产品支持情况

<!-- npu="950" id2738 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2738 -->
<!-- npu="A3" id2739 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2739 -->
<!-- npu="910b" id2740 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2740 -->
<!-- npu="310b" id2741 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id2741 -->
<!-- npu="310p" id2742 -->
- Atlas 推理系列产品：支持
<!-- end id2742 -->
<!-- npu="910" id2743 -->
- Atlas 训练系列产品：不支持
<!-- end id2743 -->
<!-- npu="IPV350" id2744 -->
- IPV350：不支持
<!-- end id2744 -->
<!-- @ref: runtime/res/docs/zh/api_ref/26_cpp_extension_APIs_res.md#id26 -->

### 功能说明

实现Device变量的数据到Host的异步内存复制。用于读取Device变量的数据。

本接口中的Host内存支持锁页内存（例如通过aclrtMallocHost接口申请的内存）、非锁页内存（通过malloc接口申请的内存）。当Host内存是锁页内存时，本接口是异步接口，调用接口成功仅表示任务下发成功，不表示任务执行成功，调用本接口后，需调用同步等待接口（例如，[aclrtSynchronizeStream](06_stream_management.md#aclrtSynchronizeStream)）确保内存复制的任务已执行完成；当Host内存是非锁页内存时，本接口在内存复制任务完成后才返回。

本接口为封装接口，仅适用于C++程序，接口内部调用C接口[aclrtMemcpyFromSymbolAsync](11-11_device_variable_memory_operation.md#aclrtMemcpyFromSymbolAsync)。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| dst | 输入 | 目的内存地址指针。 |
| dstMax | 输入 | 目标内存最大长度，单位Byte。需满足 dstMax ≥ count。 |
| symbol | 输入 | Device变量名。此处传入`__gm__`声明的变量名。 |
| count | 输入 | 内存复制的长度，单位Byte。需满足 offset + count ≤ Device变量大小，Device变量大小可通过 [aclrtGetSymbolSize](#aclrtGetSymbolSize)接口查询获取。 |
| offset | 输入 | Device变量地址偏移，单位Byte。需满足 offset + count ≤ Device变量大小，Device变量大小可通过 [aclrtGetSymbolSize](#aclrtGetSymbolSize)接口查询获取。 |
| kind | 输入 | 拷贝类型，类型定义请参见[aclrtMemcpyKind](25-02_Enumerations.md#aclrtMemcpyKind)。本接口仅支持ACL_MEMCPY_DEVICE_TO_HOST和ACL_MEMCPY_DEFAULT。 |
| stream | 输入 | 指定执行内存复制任务的Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

- 同[aclrtGetSymbolAddress](#aclrtGetSymbolAddress)接口约束说明。
- 本接口为异步接口，调用后需同步等待拷贝完成。

<br>
<br>
<br>

<a id="aclrtMemcpyToSymbol"></a>

## aclrtMemcpyToSymbol

```cpp
template <typename T>
aclError aclrtMemcpyToSymbol(const T &symbol, const void *src, size_t count, size_t offset, aclrtMemcpyKind kind)
```

### 产品支持情况

<!-- npu="950" id3291 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id3291 -->
<!-- npu="A3" id3292 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id3292 -->
<!-- npu="910b" id3293 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id3293 -->
<!-- npu="310b" id3294 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id3294 -->
<!-- npu="310p" id3295 -->
- Atlas 推理系列产品：支持
<!-- end id3295 -->
<!-- npu="910" id3296 -->
- Atlas 训练系列产品：不支持
<!-- end id3296 -->
<!-- npu="IPV350" id3297 -->
- IPV350：不支持
<!-- end id3297 -->
<!-- @ref: runtime/res/docs/zh/api_ref/26_cpp_extension_APIs_res.md#id27 -->

### 功能说明

实现Host数据到Device变量的同步内存复制。用于向Device变量写入数据。

本接口为封装接口，仅适用于C++程序，接口内部调用C接口[aclrtMemcpyToSymbol](11-11_device_variable_memory_operation.md#aclrtMemcpyToSymbol)。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| symbol | 输入 | Device变量名。此处传入`__gm__`声明的变量名。 |
| src | 输入 | 源内存地址指针。 |
| count | 输入 | 内存复制的长度，单位Byte。需满足 offset + count ≤ Device变量大小，Device变量大小可通过 [aclrtGetSymbolSize](#aclrtGetSymbolSize)接口查询获取。 |
| offset | 输入 | Device变量地址偏移，单位Byte。需满足 offset + count ≤ Device变量大小，Device变量大小可通过 [aclrtGetSymbolSize](#aclrtGetSymbolSize)接口查询获取。 |
| kind | 输入 | 拷贝类型，类型定义请参见[aclrtMemcpyKind](25-02_Enumerations.md#aclrtMemcpyKind)。本接口仅支持ACL_MEMCPY_HOST_TO_DEVICE和ACL_MEMCPY_DEFAULT。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

同[aclrtGetSymbolAddress](#aclrtGetSymbolAddress)接口约束说明。

<br>
<br>
<br>

<a id="aclrtMemcpyToSymbolAsync"></a>

## aclrtMemcpyToSymbolAsync

```cpp
template <typename T>
aclError aclrtMemcpyToSymbolAsync(const T &symbol, const void *src, size_t count, size_t offset,
                                  aclrtMemcpyKind kind, aclrtStream stream)
```

### 产品支持情况

<!-- npu="950" id3466 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id3466 -->
<!-- npu="A3" id3467 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id3467 -->
<!-- npu="910b" id3468 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id3468 -->
<!-- npu="310b" id3469 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id3469 -->
<!-- npu="310p" id3470 -->
- Atlas 推理系列产品：支持
<!-- end id3470 -->
<!-- npu="910" id3471 -->
- Atlas 训练系列产品：不支持
<!-- end id3471 -->
<!-- npu="IPV350" id3472 -->
- IPV350：不支持
<!-- end id3472 -->
<!-- @ref: runtime/res/docs/zh/api_ref/26_cpp_extension_APIs_res.md#id28 -->

### 功能说明

实现Host数据到Device变量的异步内存复制。用于向Device变量写入数据。

本接口中的Host内存支持锁页内存（例如通过aclrtMallocHost接口申请的内存）、非锁页内存（通过malloc接口申请的内存）。当Host内存是锁页内存时，本接口是异步接口，调用接口成功仅表示任务下发成功，不表示任务执行成功，调用本接口后，需调用同步等待接口（例如，[aclrtSynchronizeStream](06_stream_management.md#aclrtSynchronizeStream)）确保内存复制的任务已执行完成；当Host内存是非锁页内存时，本接口在内存复制任务完成后才返回。

本接口为封装接口，仅适用于C++程序，接口内部调用C接口[aclrtMemcpyToSymbolAsync](11-11_device_variable_memory_operation.md#aclrtMemcpyToSymbolAsync)。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| symbol | 输入 | Device变量名。此处传入`__gm__`声明的变量名。 |
| src | 输入 | 源内存地址指针。 |
| count | 输入 | 内存复制的长度，单位Byte。需满足 offset + count ≤ Device变量大小，Device变量大小可通过 [aclrtGetSymbolSize](#aclrtGetSymbolSize)接口查询获取。 |
| offset | 输入 | Device变量地址偏移，单位Byte。需满足 offset + count ≤ Device变量大小，Device变量大小可通过 [aclrtGetSymbolSize](#aclrtGetSymbolSize)接口查询获取。 |
| kind | 输入 | 拷贝类型，类型定义请参见[aclrtMemcpyKind](25-02_Enumerations.md#aclrtMemcpyKind)。本接口仅支持ACL_MEMCPY_HOST_TO_DEVICE和ACL_MEMCPY_DEFAULT。 |
| stream | 输入 | 指定执行内存复制任务的Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

- 同[aclrtGetSymbolAddress](#aclrtGetSymbolAddress)接口约束说明。
- 本接口为异步接口，调用后需同步等待拷贝完成。

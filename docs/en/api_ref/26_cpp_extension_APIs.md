# 26. C++ Extension APIs

<!-- md-trans-meta sourceCommit=213bb540e7cb7a1b1c68c574dc99ea56a3468970 translatedAt=2026-11-06T11:41:39.905Z pushedAt=2026-11-09T11:13:20.114Z nl=2 -->

This chapter describes C++ extension APIs, including APIs for function overloading and template encapsulation, which simplify API calls in C++ scenarios and provide type-safe memory operations.

- [`aclError aclrtSynchronizeDevice(int32_t timeout)`](#aclrtSynchronizeDevice): Device synchronization. This is a simplified API.
- [`aclError aclrtSynchronizeStream(aclrtStream stream, int32_t timeout)`](#aclrtSynchronizeStream): Stream synchronization. This is a simplified API.
- [`aclError aclrtSynchronizeEvent(aclrtEvent event, int32_t timeout)`](#aclrtSynchronizeEvent): Event synchronization. This is a simplified API.
- [`aclError aclrtStreamWaitEvent(aclrtStream stream, aclrtEvent event, int32_t timeout)`](#aclrtStreamWaitEvent): Stream waits for an event. This is a simplified API.
- [`aclError aclrtCreateStream(aclrtStream *stream, uint32_t priority, uint32_t flag)`](#aclrtCreateStream): Creates a stream. This is a simplified API.
- [`aclError aclrtSetOpExecuteTimeOut(uint64_t timeout, uint64_t *actualTimeout)`](#aclrtSetOpExecuteTimeOut): Sets the operator execution timeout. This is a simplified API.
- [`aclError aclrtCreateEvent(aclrtEvent *event, uint32_t flag)`](#aclrtCreateEvent): Creates an event. This is a simplified API.
- [`template <typename T> aclError aclrtMalloc(T **devPtr, size_t size, aclrtMallocConfig *cfg = nullptr)`](#aclrtMalloc): Type-safe device memory allocation.
- [`template <typename T> aclError aclrtMallocHost(T **hostPtr, size_t size, aclrtMallocConfig *cfg = nullptr)`](#aclrtMallocHost): Type-safe host memory allocation.
- [`template <typename T, typename U> aclError aclrtMemcpy(T *dst, size_t destMax, const U *src, size_t count, aclrtMemcpyKind kind)`](#aclrtMemcpy): Type-safe memory copy.
- [`template <typename T, typename U> aclError aclrtMemcpyAsync(T *dst, size_t destMax, const U *src, size_t count, aclrtMemcpyKind kind, aclrtStream stream)`](#aclrtMemcpyAsync): Asynchronous memory copy.
- [`template <typename T, typename U> aclError aclrtMemcpy2d(T *dst, size_t dpitch, const U *src, size_t spitch, size_t width, size_t height, aclrtMemcpyKind kind)`](#aclrtMemcpy2d): 2D memory copy.
- [`template <typename T, typename U> aclError aclrtMemcpy2dAsync(T *dst, size_t dpitch, const U *src, size_t spitch, size_t width, size_t height, aclrtMemcpyKind kind, aclrtStream stream)`](#aclrtMemcpy2dAsync): Asynchronous 2D memory copy.
- [`template <typename T, typename U> aclError aclrtMemcpyBatch(...)`](#aclrtMemcpyBatch): Batch memory copy.
- [`template <typename T, typename U> aclError aclrtMemcpyBatchAsync(...)`](#aclrtMemcpyBatchAsync): Asynchronous batch memory copy.
- [`template <typename T> aclError aclrtPointerGetAttributes(const T *ptr, aclrtPtrAttributes *attributes)`](#aclrtPointerGetAttributes): Type-safe pointer attribute query.
- [`template <typename T> aclError aclrtHostRegister(...)`](#aclrtHostRegister): Type-safe host memory registration.
- [`template <typename T> aclError aclrtHostGetDevicePointer(T *pHost, T **pDevice, uint32_t flag)`](#aclrtHostGetDevicePointer): Host memory to device pointer mapping.
- [`template <typename T> aclError aclrtHostUnregister(T *ptr)`](#aclrtHostUnregister): Type-safe host memory unregistration.
- [`template <typename T> aclError aclrtMemAllocManaged(T **devPtr, size_t size, uint32_t flags = ACL_RT_MEM_ATTACH_GLOBAL)`](#aclrtMemAllocManaged): Type-safe unified memory allocation.
- [`template <typename T> aclError aclrtMemManagedPrefetchAsync(const T *ptr, size_t size, aclrtMemManagedLocation location, uint32_t flags, aclrtStream stream)`](#aclrtMemManagedPrefetchAsync): Prefetches unified memory.
- [`template <typename T> aclError aclrtMemManagedPrefetchBatchAsync(...)`](#aclrtMemManagedPrefetchBatchAsync): Prefetches unified memory in batches.
- [`template <typename T> aclError aclrtGetSymbolAddress(...)`](#aclrtGetSymbolAddress): Obtains the address of a device variable.
- [`template <typename T> aclError aclrtGetSymbolSize(...)`](#aclrtGetSymbolSize): Obtains the memory size occupied by a device variable.
- [`template <typename T> aclError aclrtMemcpyFromSymbol(...)`](#aclrtMemcpyFromSymbol): Performs synchronous memory copy from a device variable to the host.
- [`template <typename T> aclError aclrtMemcpyFromSymbolAsync(...)`](#aclrtMemcpyFromSymbolAsync): Performs asynchronous memory copy from a device variable to the host.
- [`template <typename T> aclError aclrtMemcpyToSymbol(...)`](#aclrtMemcpyToSymbol): Performs synchronous memory copy from the host to a device variable.
- [`template <typename T> aclError aclrtMemcpyToSymbolAsync(...)`](#aclrtMemcpyToSymbolAsync): Performs asynchronous memory copy from the host to a device variable.

---

<br>
<br>
<br>

<a class="method_anchor" id="aclrtSynchronizeDevice"></a>

## aclrtSynchronizeDevice

```cpp
aclError aclrtSynchronizeDevice(int32_t timeout)
```

### Applicable Products

<!-- npu="950" id1205 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1205 -->
<!-- npu="A3" id1206 -->
- Atlas A3 products: Supported
<!-- end id1206 -->
<!-- npu="910b" id1207 -->
- Atlas A2 products: Supported
<!-- end id1207 -->
<!-- npu="310b" id1208 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1208 -->
<!-- npu="310p" id1209 -->
- Atlas inference products: Supported
<!-- end id1209 -->
<!-- npu="910" id1210 -->
- Atlas training products: Supported
<!-- end id1210 -->
<!-- @ref: runtime/res/docs/zh/api_ref/26_cpp_extension_APIs_res.md#id1 -->

### Description

Blocks the current thread until the device corresponding to the context bound to the current thread completes computation.

This API is an encapsulated API applicable only to C++ programs. Inside the API, the C API [aclrtSynchronizeDeviceWithTimeout](04_device_management.md#aclrtSynchronizeDeviceWithTimeout) is called.

### Parameters

| Parameter | Input/Output | Description |
| --- | --- | --- |
| timeout | Input | Timeout of the API.<br>Value description:<br>  - `-1`: Permanent wait.<br>  - > 0: A specific timeout, in milliseconds. |

### Return Values

`0`: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtSynchronizeStream"></a>

## aclrtSynchronizeStream

```cpp
aclError aclrtSynchronizeStream(aclrtStream stream, int32_t timeout)
```

### Applicable Products

<!-- npu="950" id2220 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2220 -->
<!-- npu="A3" id2221 -->
- Atlas A3 products: Supported
<!-- end id2221 -->
<!-- npu="910b" id2222 -->
- Atlas A2 products: Supported
<!-- end id2222 -->
<!-- npu="310b" id2223 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2223 -->
<!-- npu="310p" id2224 -->
- Atlas inference products: Supported
<!-- end id2224 -->
<!-- npu="910" id2225 -->
- Atlas training products: Supported
<!-- end id2225 -->
<!-- @ref: runtime/res/docs/zh/api_ref/26_cpp_extension_APIs_res.md#id2 -->

### Description

Blocks the current thread on the host until all tasks in the specified stream are complete. This API also allows you to set a timeout so that it can exit on its own when the application becomes abnormal.

This API is an encapsulated API applicable only to C++ programs. Inside the API, the C API [aclrtSynchronizeStreamWithTimeout](06_stream_management.md#aclrtSynchronizeStreamWithTimeout) is called.

### Parameters

| Parameter | Input/Output | Description |
| --- | --- | --- |
| stream | Input | Stream for which all tasks need to be completed. See [aclrtStream](25-05_Typedefs.md#aclrtStream) for the type definition. |
| timeout | Input | Timeout of the API.<br>Value description:<br>  - `-1`: Permanent wait.<br>  - > 0: A specific timeout, in milliseconds. |

### Return Values

`0`: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtSynchronizeEvent"></a>

## aclrtSynchronizeEvent

```cpp
aclError aclrtSynchronizeEvent(aclrtEvent event, int32_t timeout)
```

### Applicable Products

<!-- npu="950" id3424 -->
- Ascend 950PR&950DT products: Supported
<!-- end id3424 -->
<!-- npu="A3" id3425 -->
- Atlas A3 products: Supported
<!-- end id3425 -->
<!-- npu="910b" id3426 -->
- Atlas A2 products: Supported
<!-- end id3426 -->
<!-- npu="310b" id3427 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id3427 -->
<!-- npu="310p" id3428 -->
- Atlas inference products: Supported
<!-- end id3428 -->
<!-- npu="910" id3429 -->
- Atlas training products: Supported
<!-- end id3429 -->
<!-- @ref: runtime/res/docs/zh/api_ref/26_cpp_extension_APIs_res.md#id3 -->

### Description

Blocks the current thread until all tasks captured by the event are complete. This API also allows you to wait permanently or configure a specific timeout. If a specific timeout is configured, the application can exit on its own based on the configured timeout when an exception occurs.

This API is an encapsulated API applicable only to C++ programs. Inside the API, the C API [aclrtSynchronizeEventWithTimeout](07_event_management.md#aclrtSynchronizeEventWithTimeout) is called.

### Parameters

| Parameter | Input/Output | Description |
| --- | --- | --- |
| event | Input | Event to wait for. See [aclrtEvent](25-05_Typedefs.md#aclrtEvent) for the type definition. |
| timeout | Input | Timeout of the API.<br>Value description:<br>  - `-1`: Permanent wait.<br>  - > 0: A specific timeout, in milliseconds. |

### Return Values

`0`: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<!-- @ref: runtime/res/docs/zh/api_ref/26_cpp_extension_APIs_res.md#id29 -->

<br>
<br>
<br>

<a class="method_anchor" id="aclrtStreamWaitEvent"></a>

## aclrtStreamWaitEvent

```cpp
aclError aclrtStreamWaitEvent(aclrtStream stream, aclrtEvent event, int32_t timeout)
```

### Applicable Products

<!-- npu="950" id680 -->
- Ascend 950PR&950DT products: Supported
<!-- end id680 -->
<!-- npu="A3" id681 -->
- Atlas A3 products: Supported
<!-- end id681 -->
<!-- npu="910b" id682 -->
- Atlas A2 products: Supported
<!-- end id682 -->
<!-- npu="310b" id683 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id683 -->
<!-- npu="310p" id684 -->
- Atlas inference products: Supported
<!-- end id684 -->
<!-- npu="910" id685 -->
- Atlas training products: Supported
<!-- end id685 -->
<!-- @ref: runtime/res/docs/zh/api_ref/26_cpp_extension_APIs_res.md#id4 -->

### Description

Blocks the execution of the specified stream until the specified event is complete. This is an asynchronous API.

This API is an encapsulated API applicable only to C++ programs. Inside the API, the C API [aclrtStreamWaitEventWithTimeout](07_event_management.md#aclrtStreamWaitEventWithTimeout) is called.

### Parameters

| Parameter | Input/Output | Description |
| --- | --- | --- |
| stream | Input | Specified stream. See [aclrtStream](25-05_Typedefs.md#aclrtStream) for the type definition.<br>In a multi-stream synchronous wait scenario, for example, when Stream2 waits for Stream1, set this parameter to Stream2. |
| event | Input | Event to wait for. See [aclrtEvent](25-05_Typedefs.md#aclrtEvent) for the type definition. |
| timeout | Input | Timeout period.<br>Value description:<br>  - `0`: No timeout.<br>  - > 0: A specific timeout, in milliseconds. |

### Return Values

`0`: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtCreateStream"></a>

## aclrtCreateStream

```cpp
aclError aclrtCreateStream(aclrtStream *stream, uint32_t priority, uint32_t flag)
```

### Applicable Products

<!-- npu="950" id624 -->
- Ascend 950PR&950DT products: Supported
<!-- end id624 -->
<!-- npu="A3" id625 -->
- Atlas A3 products: Supported
<!-- end id625 -->
<!-- npu="910b" id626 -->
- Atlas A2 products: Supported
<!-- end id626 -->
<!-- npu="310b" id627 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id627 -->
<!-- npu="310p" id628 -->
- Atlas inference products: Supported
<!-- end id628 -->
<!-- npu="910" id629 -->
- Atlas training products: Supported
<!-- end id629 -->
<!-- @ref: runtime/res/docs/zh/api_ref/26_cpp_extension_APIs_res.md#id5 -->

### Description

Creates a stream in the current process or thread.

This API is an encapsulated API applicable only to C++ programs. Inside the API, the C API [aclrtCreateStreamWithConfig](06_stream_management.md#aclrtCreateStreamWithConfig) is called.

### Parameters

| Parameter | Input/Output | Description |
| --- | --- | --- |
| stream | Output | Pointer to the stream. See [aclrtStream](25-05_Typedefs.md#aclrtStream) for the type definition. |
| priority | Input | Priority.<br>The value range is [0, 7], supporting up to 8 priorities in total. A smaller number indicates a higher priority, where 0 is the highest and 7 is the lowest. If the configured priority exceeds the value range, it is corrected to the nearest boundary value. |
| flag | Input | Flag of the stream pointer.<br>For the `flag` value description, see the "flag value description" in the C API [aclrtCreateStreamWithConfig](06_stream_management.md#aclrtCreateStreamWithConfig). |

### Return Values

`0`: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtSetOpExecuteTimeOut"></a>

## aclrtSetOpExecuteTimeOut

```cpp
aclError aclrtSetOpExecuteTimeOut(uint64_t timeout, uint64_t *actualTimeout)
```

### Applicable Products

<!-- npu="950" id2318 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2318 -->
<!-- npu="A3" id2319 -->
- Atlas A3 products: Supported
<!-- end id2319 -->
<!-- npu="910b" id2320 -->
- Atlas A2 products: Supported
<!-- end id2320 -->
<!-- npu="310b" id2321 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2321 -->
<!-- npu="310p" id2322 -->
- Atlas inference products: Supported
<!-- end id2322 -->
<!-- npu="910" id2323 -->
- Atlas training products: Supported
<!-- end id2323 -->
<!-- @ref: runtime/res/docs/zh/api_ref/26_cpp_extension_APIs_res.md#id6 -->

### Description

Sets the timeout for operator execution, in microseconds. If a timeout is specified when the operator is delivered, that timeout takes priority over the timeout set by this API.

This API is an encapsulated API applicable only to C++ programs. Inside the API, the C API [aclrtSetOpExecuteTimeOutV2](12_execution_control.md#aclrtSetOpExecuteTimeOutV2) is called.

### Parameters

| Parameter | Input/Output | Description |
| --- | --- | --- |
| timeout | Input | Sets the timeout, in microseconds.<br>Setting this parameter to `0` indicates the maximum timeout. |
| actualTimeout | Output | Returns the timeout that actually takes effect, in microseconds. |

### Return Values

`0`: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

Same as the constraints of the C API [aclrtSetOpExecuteTimeOutV2](12_execution_control.md#aclrtSetOpExecuteTimeOutV2).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtCreateEvent"></a>

## aclrtCreateEvent

```cpp
aclError aclrtCreateEvent(aclrtEvent *event, uint32_t flag)
```

### Applicable Products

<!-- npu="950" id1506 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1506 -->
<!-- npu="A3" id1507 -->
- Atlas A3 products: Supported
<!-- end id1507 -->
<!-- npu="910b" id1508 -->
- Atlas A2 products: Supported
<!-- end id1508 -->
<!-- npu="310b" id1509 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1509 -->
<!-- npu="310p" id1510 -->
- Atlas inference products: Supported
<!-- end id1510 -->
<!-- npu="910" id1511 -->
- Atlas training products: Supported
<!-- end id1511 -->
<!-- @ref: runtime/res/docs/zh/api_ref/26_cpp_extension_APIs_res.md#id7 -->

### Description

Creates an event with flags. Events with different flags serve different purposes. You can specify multiple flags when creating an event (by performing a bitwise OR operation) to enable the corresponding functions simultaneously. When creating an event, event resources are not limited by hardware.

This API is an encapsulated API applicable only to C++ programs. Inside the API, the C API [aclrtCreateEventExWithFlag](07_event_management.md#aclrtCreateEventExWithFlag) is called.

### Parameters

| Parameter | Input/Output | Description |
| --- | --- | --- |
| event | Output | Event pointer. See [aclrtEvent](25-05_Typedefs.md#aclrtEvent) for the type definition. |
| flag | Input | Flag of the event pointer.<br>`flag` is a bitmap. You can set `flag` to a single macro or perform an OR operation on multiple macros.<br>Currently, `flag` can be set to the following macros:<br>  - `ACL_EVENT_TIME_LINE`: This bit indicates that the created event needs to record timestamp information. Note: Using the timestamp function affects the performance of event-related APIs.<br>  - `ACL_EVENT_SYNC`: This bit indicates that the created event supports synchronization across multiple streams.<br>  - `ACL_EVENT_CAPTURE_STREAM_PROGRESS`: This bit indicates that the created event is used to track the task execution progress of a stream.<br>  - `ACL_EVENT_IPC`: This bit indicates that the created event is used for inter-process communication. For details, see [aclrtIpcGetEventHandle](07_event_management.md#aclrtIpcGetEventHandle). Note: On Ascend 950DT products, this flag is not supported for creating an event. This flag cannot be ORed with other flags. An event created with this flag cannot be used in the following APIs or scenarios: [aclrtResetEvent](07_event_management.md#aclrtResetEvent), [aclrtQueryEvent](07_event_management.md#aclrtQueryEvent), [aclrtQueryEventWaitStatus](07_event_management.md#aclrtQueryEventWaitStatus), [aclrtEventElapsedTime](07_event_management.md#aclrtEventElapsedTime), [aclrtEventGetTimestamp](07_event_management.md#aclrtEventGetTimestamp), [aclrtGetEventId](07_event_management.md#aclrtGetEventId), and model capture scenarios (see the description in [aclmdlRICaptureBegin](15_model_running_instance_management.md#aclmdlRICaptureBegin)). Otherwise, an error is returned.<br><br><br>The macros are defined as follows:<br>#define ACL_EVENT_TIME_LINE 0x00000008U<br>#define ACL_EVENT_SYNC 0x00000001U<br>#define ACL_EVENT_CAPTURE_STREAM_PROGRESS 0x00000002U<br>#define ACL_EVENT_IPC 0x00000040U |

### Return Values

`0`: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

Same as the constraints of the C API [aclrtCreateEventExWithFlag](07_event_management.md#aclrtCreateEventExWithFlag).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtMemcpyBatch"></a>

## aclrtMemcpyBatch

```cpp
template <typename T, typename U>
aclError aclrtMemcpyBatch(T **dsts, size_t *destMaxs, U **srcs, size_t *sizes, size_t numBatches, aclrtMemcpyBatchAttr attr)

template <typename T, typename U>
aclError aclrtMemcpyBatch(T **dsts, size_t *destMaxs, U **srcs, size_t *sizes, size_t numBatches, aclrtMemcpyBatchAttr *attrs, size_t *attrsIndexes, size_t numAttrs)
```

### Applicable Products

<!-- npu="950" id204 -->
- Ascend 950PR&950DT products: Supported
<!-- end id204 -->
<!-- npu="A3" id205 -->
- Atlas A3 products: Supported
<!-- end id205 -->
<!-- npu="910b" id206 -->
- Atlas A2 products: Supported
<!-- end id206 -->
<!-- npu="310b" id207 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id207 -->
<!-- npu="310p" id208 -->
- Atlas inference products: Not supported
<!-- end id208 -->
<!-- npu="910" id209 -->
- Atlas training products: Not supported
<!-- end id209 -->
<!-- @ref: runtime/res/docs/zh/api_ref/26_cpp_extension_APIs_res.md#id8 -->

### Description

Performs batch memory copy.

The host memory in this API supports page-locked memory (for example, memory allocated through the aclrtMallocHost API) and non-page-locked memory (memory allocated through the malloc API).

This API is an encapsulated API applicable only to C++ programs. Inside the API, the C API [aclrtMemcpyBatchV2](11-03_memory_copy_and_set.md#aclrtMemcpyBatchV2) is called.

### Parameters

| Parameter | Input/Output | Description |
| --- | --- | --- |
| dsts | Input | Destination memory address array. |
| destMaxs | Input | Memory copy maximum length array, used to store the maximum length of each memory segment to be copied, in bytes. |
| srcs | Input | Source memory address array. |
| sizes | Input | Memory copy length array, used to store the size of each memory segment to be copied, in bytes. |
| numBatches | Input | Length of the dsts, srcs, and sizes arrays. |
| attr | Input | Memory copy attribute. The same memory copy attribute is used for all memory.<br>See [aclrtMemcpyBatchAttr](25-04_Structs.md#aclrtMemcpyBatchAttr) for the type definition. |
| attrs | Input | Memory copy attribute array. The corresponding memory copy attribute is used for each memory segment.<br>See [aclrtMemcpyBatchAttr](25-04_Structs.md#aclrtMemcpyBatchAttr) for the type definition. |
| attrsIndexes | Input | Memory copy attribute index array, used to specify the copy range to which each entry in the attrs array applies. The attribute specified in attrs[k] applies to copy operations from attrsIndexes[k] to attrsIndexes[k+1] - 1, and attrs[numAttrs-1] applies to copy operations from attrsIndexes[numAttrs-1] to numBatches - 1. |
| numAttrs | Input | Length of the attrs and attrsIndexes arrays. |

### Return Values

`0`: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

Same as the constraints of the C API [aclrtMemcpyBatchV2](11-03_memory_copy_and_set.md#aclrtMemcpyBatchV2).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtMemcpyBatchAsync"></a>

## aclrtMemcpyBatchAsync

```cpp
template <typename T, typename U>
aclError aclrtMemcpyBatchAsync(T **dsts, size_t *destMaxs, U **srcs, size_t *sizes, size_t numBatches, aclrtMemcpyBatchAttr attr, aclrtStream stream)

template <typename T, typename U>
aclError aclrtMemcpyBatchAsync(T **dsts, size_t *destMaxs, U **srcs, size_t *sizes, size_t numBatches, aclrtMemcpyBatchAttr *attrs, size_t *attrsIndexes, size_t numAttrs, aclrtStream stream)
```

### Applicable Products

<!-- npu="950" id1156 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1156 -->
<!-- npu="A3" id1157 -->
- Atlas A3 products: Supported
<!-- end id1157 -->
<!-- npu="910b" id1158 -->
- Atlas A2 products: Supported
<!-- end id1158 -->
<!-- npu="310b" id1159 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id1159 -->
<!-- npu="310p" id1160 -->
- Atlas inference products: Not supported
<!-- end id1160 -->
<!-- npu="910" id1161 -->
- Atlas training products: Not supported
<!-- end id1161 -->
<!-- @ref: runtime/res/docs/zh/api_ref/26_cpp_extension_APIs_res.md#id9 -->

### Description

Performs batch memory copy.

The host memory in this API supports page-locked memory (for example, memory allocated through the aclrtMallocHost API) and non-page-locked memory (memory allocated through the malloc API). When the host memory is non-page-locked memory, this API returns only after the memory copy task is complete. When the host memory is page-locked memory, this API is an asynchronous API. A successful call only indicates that the task has been delivered, not that the task has been executed. After calling this API, call a synchronous wait API (for example, [aclrtSynchronizeStream](06_stream_management.md#aclrtSynchronizeStream)) to ensure that the memory copy task has been completed.

This API is an encapsulated API applicable only to C++ programs. Inside the API, the C API [aclrtMemcpyBatchAsyncV2](11-03_memory_copy_and_set.md#aclrtMemcpyBatchAsyncV2) is called.

### Parameters

| Parameter | Input/Output | Description |
| --- | --- | --- |
| dsts | Input | Destination memory address array. |
| destMaxs | Input | Memory copy maximum length array, used to store the maximum length of each memory segment to be copied, in bytes. |
| srcs | Input | Source memory address array. |
| sizes | Input | Memory copy length array, used to store the size of each memory segment to be copied, in bytes. |
| numBatches | Input | Length of the dsts, srcs, and sizes arrays. |
| attr | Input | Memory copy attribute. The same memory copy attribute is used for all memory.<br>See [aclrtMemcpyBatchAttr](25-04_Structs.md#aclrtMemcpyBatchAttr) for the type definition. |
| attrs | Input | Memory copy attribute array. The corresponding memory copy attribute is used for each memory segment.<br>See [aclrtMemcpyBatchAttr](25-04_Structs.md#aclrtMemcpyBatchAttr) for the type definition. |
| attrsIndexes | Input | Memory copy attribute index array, used to specify the copy range to which each entry in the attrs array applies. The attribute specified in attrs[k] applies to copy operations from attrsIndexes[k] to attrsIndexes[k+1] - 1, and attrs[numAttrs-1] applies to copy operations from attrsIndexes[numAttrs-1] to numBatches - 1. |
| numAttrs | Input | Length of the attrs and attrsIndexes arrays. |
| stream | Input | Stream on which the memory copy task is executed. See [aclrtStream](25-05_Typedefs.md#aclrtStream) for the type definition. |

### Return Values

`0`: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

Same as the constraints of the C API [aclrtMemcpyBatchAsyncV2](11-03_memory_copy_and_set.md#aclrtMemcpyBatchAsyncV2).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtPointerGetAttributes"></a>

## aclrtPointerGetAttributes

```cpp
template <typename T>
aclError aclrtPointerGetAttributes(const T *ptr, aclrtPtrAttributes *attributes)
```

### Applicable Products

<!-- npu="950" id2941 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2941 -->
<!-- npu="A3" id2942 -->
- Atlas A3 products: Supported
<!-- end id2942 -->
<!-- npu="910b" id2943 -->
- Atlas A2 products: Supported
<!-- end id2943 -->
<!-- npu="310b" id2944 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2944 -->
<!-- npu="310p" id2945 -->
- Atlas inference products: Supported
<!-- end id2945 -->
<!-- npu="910" id2946 -->
- Atlas training products: Supported
<!-- end id2946 -->
<!-- @ref: runtime/res/docs/zh/api_ref/26_cpp_extension_APIs_res.md#id10 -->

### Description

Obtains memory attribute information, including whether the memory resides on the host or device, the page table size, and other details.

This API is an encapsulated API applicable only to C++ programs. Inside the API, the C API [aclrtPointerGetAttributes](11-05_unified_addressing.md#aclrtPointerGetAttributes) is called.

### Parameters

| Parameter | Input/Output | Description |
| --- | --- | --- |
| ptr | Input | Memory address.<br>Do not pass a device address mapped through the aclrtHostRegister API or a device address obtained through the aclrtHostGetDevicePointer API; otherwise, undefined behavior occurs. |
| attributes | Output | Memory attribute information. See [aclrtPtrAttributes](25-04_Structs.md#aclrtPtrAttributes) for the type definition. |

### Return Values

`0`: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtHostRegister"></a>

## aclrtHostRegister

```cpp
template <typename T>
aclError aclrtHostRegister(T *ptr, uint64_t size, aclrtHostRegisterType type, T **devPtr)

template <typename T>
aclError aclrtHostRegister(T *ptr, uint64_t size, uint32_t flag)
```

### Applicable Products

<!-- npu="950" id708 -->
- Ascend 950PR&950DT products: Supported
<!-- end id708 -->
<!-- npu="A3" id709 -->
- Atlas A3 products: Supported
<!-- end id709 -->
<!-- npu="910b" id710 -->
- Atlas A2 products: Supported
<!-- end id710 -->
<!-- npu="310b" id711 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id711 -->
<!-- npu="310p" id712 -->
- Atlas inference products: Not supported
<!-- end id712 -->
<!-- npu="910" id713 -->
- Atlas training products: Not supported
<!-- end id713 -->
<!-- @ref: runtime/res/docs/zh/api_ref/26_cpp_extension_APIs_res.md#id11 -->

### Description

Registers a host memory address. To unregister, call the [aclrtHostUnregister](11-02_host_memory_management.md#aclrtHostUnregister) API.

This API is an encapsulated API applicable only to C++ programs. Inside the API, it calls the C API [aclrtHostRegister](#aclrtHostRegister) or [aclrtHostRegisterV2](11-02_host_memory_management.md#aclrtHostRegisterV2).

### Parameters

| Parameter | Input/Output | Description |
| --- | --- | --- |
| ptr | Input | Host memory address.<br>You can directly pass a host memory address allocated through the aclrtMallocHost or aclrtMallocHostWithCfg API, or pass the address after offsetting it. However, the offset address must meet the 4 KB page alignment requirement.<br>When the OS kernel version is 5.10 or earlier, using non-page-locked memory causes exceptions. Therefore, you must call the aclrtMallocHost or aclrtMallocHostWithCfg API to allocate host page-locked memory.<br>When the OS kernel version is later than 5.10, non-page-locked host memory is supported. Therefore, you can either call the aclrtMallocHost or aclrtMallocHostWithCfg API to allocate host page-locked memory, or use the malloc API to allocate host non-page-locked memory. Host memory allocated through the malloc API does not need to meet the 4 KB page alignment requirement. |
| size | Input | Memory size, in bytes. |
| type | Input | Memory registration type. See [aclrtHostRegisterType](25-02_Enumerations.md#aclrtHostRegisterType) for the type definition. |
| devPtr | Output | Device-accessible memory address to which the host memory is mapped.<br>This address can be accessed only on the device, for example, as a kernel function parameter for the AI Core on the device to access. For memory processing on the host side, use the original host memory address. |
| flag | Input | Memory registration type.<br>The value is one of the following macros. You can configure a single macro or a bitwise OR of multiple macros (for example, ACL_HOST_REG_MAPPED \| ACL_HOST_REG_PINNED).<br><br>  - ACL_HOST_REG_MAPPED: Registers the host memory mapping as a memory address accessible by the device, and then calls the [aclrtHostGetDevicePointer](11-02_host_memory_management.md#aclrtHostGetDevicePointer) API to obtain the mapped device memory address.<br>  - ACL_HOST_REG_IOMEMORY: Registers the I/O space (registers and cache) mapping of a third-party PCIe device on the host as accessible by the device, including read and write. Page-locked memory is not supported when this macro is used, so this macro cannot be combined with ACL_HOST_REG_PINNED.<br>  - ACL_HOST_REG_READONLY: Registers the host memory mapping as read-only for the device.<br>  - ACL_HOST_REG_PINNED: Registers the host page-unlocked memory as page-locked memory. Host page-unlocked memory can be requested through C/C++ standard library functions (such as malloc, calloc, and new) or the default mmap system call. This macro applies only to host page-unlocked memory; if host page-locked memory is passed, the API returns an error.<br><br><br>The macro definitions are as follows:<br>#define ACL_HOST_REG_MAPPED 0x2UL<br>#define ACL_HOST_REG_IOMEMORY 0x4UL<br>#define ACL_HOST_REG_READONLY 0x8UL<br>#define ACL_HOST_REG_PINNED 0X10000000UL |

### Return Values

`0`: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtHostGetDevicePointer"></a>

## aclrtHostGetDevicePointer

```cpp
template <typename T>
aclError aclrtHostGetDevicePointer(T *pHost, T **pDevice, uint32_t flag)
```

### Applicable Products

<!-- npu="950" id169 -->
- Ascend 950PR&950DT products: Supported
<!-- end id169 -->
<!-- npu="A3" id170 -->
- Atlas A3 products: Supported
<!-- end id170 -->
<!-- npu="910b" id171 -->
- Atlas A2 products: Supported
<!-- end id171 -->
<!-- npu="310b" id172 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id172 -->
<!-- npu="310p" id173 -->
- Atlas inference products: Not supported
<!-- end id173 -->
<!-- npu="910" id174 -->
- Atlas training products: Not supported
<!-- end id174 -->
<!-- @ref: runtime/res/docs/zh/api_ref/26_cpp_extension_APIs_res.md#id12 -->

### Description

Obtains the device memory address mapped by the [aclrtHostRegister](#aclrtHostRegister) API.

This API is an encapsulated API applicable only to C++ programs. Inside the API, the C API [aclrtHostGetDevicePointer](11-02_host_memory_management.md#aclrtHostGetDevicePointer) is called.

### Parameters

| Parameter | Input/Output | Description |
| --- | --- | --- |
| pHost | Input | Host memory address mapped by the [aclrtHostRegister](#aclrtHostRegister) API. |
| pDevice | Output | Device memory address to which the host memory is mapped. |
| flag | Input | Reserved parameter. Currently fixed to `0`. |

### Return Values

`0`: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtHostUnregister"></a>

## aclrtHostUnregister

```cpp
template <typename T>
aclError aclrtHostUnregister(T *ptr)
```

### Applicable Products

<!-- npu="950" id848 -->
- Ascend 950PR&950DT products: Supported
<!-- end id848 -->
<!-- npu="A3" id849 -->
- Atlas A3 products: Supported
<!-- end id849 -->
<!-- npu="910b" id850 -->
- Atlas A2 products: Supported
<!-- end id850 -->
<!-- npu="310b" id851 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id851 -->
<!-- npu="310p" id852 -->
- Atlas inference products: Not supported
<!-- end id852 -->
<!-- npu="910" id853 -->
- Atlas training products: Not supported
<!-- end id853 -->
<!-- @ref: runtime/res/docs/zh/api_ref/26_cpp_extension_APIs_res.md#id13 -->

### Description

Unregisters the host memory.

This API is used in pairs with the [aclrtHostRegister](#aclrtHostRegister) API.

This API is an encapsulated API applicable only to C++ programs. Inside the API, it calls the C API [aclrtHostUnregister](11-02_host_memory_management.md#aclrtHostUnregister).

### Parameters

| Parameter | Input/Output | Description |
| --- | --- | --- |
| ptr | Input | Host-side memory address. |

### Return Values

`0`: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtMemAllocManaged"></a>

## aclrtMemAllocManaged

```cpp
template <typename T>
aclError aclrtMemAllocManaged(T **devPtr, size_t size, uint32_t flags = ACL_RT_MEM_ATTACH_GLOBAL)
```

### Applicable Products

<!-- npu="950" id3417 -->
- Ascend 950PR&950DT products: Not supported
<!-- end id3417 -->
<!-- npu="A3" id3418 -->
- Atlas A3 products: Not supported
<!-- end id3418 -->
<!-- npu="910b" id3419 -->
- Atlas A2 products: Supported
<!-- end id3419 -->
<!-- npu="310b" id3420 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id3420 -->
<!-- npu="310p" id3421 -->
- Atlas inference products: Not supported
<!-- end id3421 -->
<!-- npu="910" id3422 -->
- Atlas training products: Not supported
<!-- end id3422 -->
<!-- @ref: runtime/res/docs/zh/api_ref/26_cpp_extension_APIs_res.md#id14 -->

### Description

Allocates Unified Virtual Memory (UVM) and returns the pointer to the allocated memory through \*ptr. The allocated memory size is aligned upward to 2 MB based on the size you specify. To release the memory allocated by this API, call [aclrtFree](11-01_device_memory_malloc_and_free.md#aclrtFree).

This API is an encapsulated API applicable only to C++ programs. Inside the API, the C API [aclrtMemAllocManaged](11-05_unified_addressing.md#aclrtMemAllocManaged) is called.

### Parameters

| Parameter | Input/Output | Description |
| --- | --- | --- |
| devPtr | Output | Pointer to the pointer to the allocated memory. Because host and device virtual addresses are unified, this parameter does not distinguish the allocation location. |
| size | Input | Memory size, in bytes.<br>`size` cannot be `0`. A single application process can allocate up to 3 TB of UVM virtual memory. |
| flag | Input | Memory flag.<br>Currently, `flag` supports only `ACL_RT_MEM_ATTACH_GLOBAL`, whose value is `1`. When `ACL_RT_MEM_ATTACH_GLOBAL` is set, the memory allocated by this API can be accessed on both the device and host sides.<br>The macro is defined as follows:<br>#define ACL_RT_MEM_ATTACH_GLOBAL (0x01U) |

### Return Values

`0`: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

Same as the constraints of the C API [aclrtMemAllocManaged](11-05_unified_addressing.md#aclrtMemAllocManaged).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtMemManagedPrefetchAsync"></a>

## aclrtMemManagedPrefetchAsync

```cpp
template <typename T>
aclError aclrtMemManagedPrefetchAsync(const T *ptr, size_t size, aclrtMemManagedLocation location, uint32_t flags, aclrtStream stream)
```

### Applicable Products

<!-- npu="950" id2472 -->
- Ascend 950PR&950DT products: Not supported
<!-- end id2472 -->
<!-- npu="A3" id2473 -->
- Atlas A3 products: Not supported
<!-- end id2473 -->
<!-- npu="910b" id2474 -->
- Atlas A2 products: Supported
<!-- end id2474 -->
<!-- npu="310b" id2475 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id2475 -->
<!-- npu="310p" id2476 -->
- Atlas inference products: Not supported
<!-- end id2476 -->
<!-- npu="910" id2477 -->
- Atlas training products: Not supported
<!-- end id2477 -->
<!-- @ref: runtime/res/docs/zh/api_ref/26_cpp_extension_APIs_res.md#id15 -->

### Description

Performs prefetching for UVM.

The memory operated by this API must be allocated through the [aclrtMemAllocManaged](#aclrtMemAllocManaged) API. This API is asynchronous. A successful call only indicates that the task has been delivered, not that the task has been executed. After calling this API, call a synchronous wait API (for example, [aclrtSynchronizeStream](06_stream_management.md#aclrtSynchronizeStream)) to ensure that the memory prefetch task has been executed.

This API is an encapsulated API applicable only to C++ programs. Inside the API, it calls the C API [aclrtMemManagedPrefetchAsync](11-05_unified_addressing.md#aclrtMemManagedPrefetchAsync).

### Parameters

| Parameter | Input/Output | Description |
| --- | --- | --- |
| ptr | Input | Memory address to be prefetched. The address range must be within the UVM memory range, that is, [0x90000000000ULL, 0x90000000000ULL+3TB). |
| size | Input | Length of the memory to be prefetched, in bytes. It must be 2 MB aligned. The value range is (0, 3TB]. |
| location | Input | Location information of the physical memory. The location parameter contains two members: id and type. See [aclrtMemManagedLocation](25-04_Structs.md#aclrtMemManagedLocation) for the type definition. |
| flags | Input | Reserved parameter. Currently fixed to `0`. |
| stream | Input | Stream on which the memory prefetch task is executed. See [aclrtStream](25-05_Typedefs.md#aclrtStream) for the type definition. |

### Return Values

`0`: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtMemManagedPrefetchBatchAsync"></a>

## aclrtMemManagedPrefetchBatchAsync

```cpp
template <typename T>
aclError aclrtMemManagedPrefetchBatchAsync(const T **ptrs, size_t *sizes, size_t count, aclrtMemManagedLocation prefetchLoc, uint64_t flags, aclrtStream stream)

template <typename T>
aclError aclrtMemManagedPrefetchBatchAsync(const T **ptrs, size_t *sizes, size_t count, aclrtMemManagedLocation *prefetchLocs, size_t *prefetchLocIdxs, size_t numPrefetchLocs, uint64_t flags, aclrtStream stream)
```

### Applicable Products

<!-- npu="950" id3298 -->
- Ascend 950PR&950DT products: Not supported
<!-- end id3298 -->
<!-- npu="A3" id3299 -->
- Atlas A3 products: Not supported
<!-- end id3299 -->
<!-- npu="910b" id3300 -->
- Atlas A2 products: Supported
<!-- end id3300 -->
<!-- npu="310b" id3301 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id3301 -->
<!-- npu="310p" id3302 -->
- Atlas inference products: Not supported
<!-- end id3302 -->
<!-- npu="910" id3303 -->
- Atlas training products: Not supported
<!-- end id3303 -->
<!-- @ref: runtime/res/docs/zh/api_ref/26_cpp_extension_APIs_res.md#id16 -->

### Description

Performs batch prefetch of UVM.

The memory operated by this API must be allocated through the [aclrtMemAllocManaged](#aclrtMemAllocManaged) API. This API is asynchronous. A successful call only indicates that the task has been delivered, not that the task has been executed. After calling this API, call a synchronous wait API (for example, [aclrtSynchronizeStream](06_stream_management.md#aclrtSynchronizeStream)) to ensure that the memory prefetch task has been executed.

This API is an encapsulated API applicable only to C++ programs. Inside the API, the C API [aclrtMemManagedPrefetchBatchAsync](11-05_unified_addressing.md#aclrtMemManagedPrefetchBatchAsync) is called.

### Parameters

| Parameter | Input/Output | Description |
| --- | --- | --- |
| ptrs | Input | Memory address array to be prefetched. The range of each address must be within the UVM memory range, that is, [0x90000000000ULL, 0x90000000000ULL+3TB). |
| sizes | Input | Memory prefetch length array, used to store the length of each UVM memory segment to be prefetched, in bytes. Each segment length must be 2 MB aligned, with a value range of (0, 3TB]. |
| count | Input | Length of the ptrs and sizes arrays. |
| prefetchLoc | Input | Physical memory location information. Each location contains two members: id and type. The same physical memory location information is used for all memory to be prefetched.<br>See [aclrtMemManagedLocation](25-04_Structs.md#aclrtMemManagedLocation) for the type definition. |
| prefetchLocs | Input | Physical memory location information array. Each location contains two members: id and type. The corresponding physical memory location information is used for each memory segment to be prefetched.<br>See [aclrtMemManagedLocation](25-04_Structs.md#aclrtMemManagedLocation) for the type definition. |
| prefetchLocIdxs | Input | Physical memory prefetch information index array, used to specify the prefetch range applicable to each physical address in the prefetchLocs array. For the physical address specified by prefetchLocs[k], the UVM memory addresses of the elements from index prefetchLocIdxs[k] to index prefetchLocIdxs[k+1] – 1 in the ptrs array are prefetched. For the physical address specified by prefetchLocs[numPrefetchLocs -1], the UVM memory addresses of the elements from index prefetchLocIdxs[numPrefetchLocs -1] to index count - 1 in the ptrs array are prefetched. |
| numPrefetchLocs | Input | Length of the prefetchLocs and prefetchLocIdxs arrays. |
| flags | Input | Reserved parameter. Currently fixed to 0. |
| stream | Input | Stream on which the memory prefetch task is executed. See [aclrtStream](25-05_Typedefs.md#aclrtStream) for the type definition. |

### Return Values

`0`: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

Same as the constraints of the C API [aclrtMemManagedPrefetchBatchAsync](11-05_unified_addressing.md#aclrtMemManagedPrefetchBatchAsync).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtMalloc"></a>

## aclrtMalloc

```cpp
template <typename T>
aclError aclrtMalloc(T **devPtr, size_t size, aclrtMallocConfig *cfg = nullptr)

template <typename T>
aclError aclrtMalloc(T **devPtr, size_t size, aclrtMemMallocPolicy policy, aclrtMallocConfig *cfg = nullptr)
```

### Applicable Products

<!-- npu="950" id1828 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1828 -->
<!-- npu="A3" id1829 -->
- Atlas A3 products: Supported
<!-- end id1829 -->
<!-- npu="910b" id1830 -->
- Atlas A2 products: Supported
<!-- end id1830 -->
<!-- npu="310b" id1831 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1831 -->
<!-- npu="310p" id1832 -->
- Atlas inference products: Supported
<!-- end id1832 -->
<!-- npu="910" id1833 -->
- Atlas training products: Supported
<!-- end id1833 -->
<!-- @ref: runtime/res/docs/zh/api_ref/26_cpp_extension_APIs_res.md#id17 -->

### Description

Allocates linear memory of the specified size on the device and returns the pointer to the allocated memory through \*devPtr. The start address of the memory is 64-byte aligned.

Memory allocated by this API must be released using the [aclrtFree](11-01_device_memory_malloc_and_free.md#aclrtFree) API or the [aclrtFreeWithDevSync](11-01_device_memory_malloc_and_free.md#aclrtFreeWithDevSync) API.

This API is an encapsulated API applicable only to C++ programs. Inside the API, the C API [aclrtMallocWithCfg](11-01_device_memory_malloc_and_free.md#aclrtMallocWithCfg) is called.

### Parameters

| Parameter | Input/Output | Description |
| --- | --- | --- |
| devPtr | Output | Pointer to the pointer to the allocated memory on the device. |
| size | Input | Size of the memory to allocate, in bytes.<br>`size` cannot be `0`. |
| policy | Input | Memory allocation policy. See [aclrtMemMallocPolicy](25-02_Enumerations.md#aclrtMemMallocPolicy) for the type definition.<br>If the configured memory allocation policy exceeds the value range of [aclrtMemMallocPolicy](25-02_Enumerations.md#aclrtMemMallocPolicy), memory is allocated as large pages when size ≥ 2 MB; otherwise, memory is allocated as normal pages. |
| cfg | Input | Memory configuration information. See [aclrtMallocConfig](25-04_Structs.md#aclrtMallocConfig) for the type definition. |

### Return Values

`0`: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtMallocHost"></a>

## aclrtMallocHost

```cpp
template <typename T>
aclError aclrtMallocHost(T **hostPtr, size_t size, aclrtMallocConfig *cfg = nullptr)
```

### Applicable Products

<!-- npu="950" id2521 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2521 -->
<!-- npu="A3" id2522 -->
- Atlas A3 products: Supported
<!-- end id2522 -->
<!-- npu="910b" id2523 -->
- Atlas A2 products: Supported
<!-- end id2523 -->
<!-- npu="310b" id2524 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2524 -->
<!-- npu="310p" id2525 -->
- Atlas inference products: Supported
<!-- end id2525 -->
<!-- npu="910" id2526 -->
- Atlas training products: Supported
<!-- end id2526 -->
<!-- @ref: runtime/res/docs/zh/api_ref/26_cpp_extension_APIs_res.md#id18 -->

### Description

Allocates host memory (page-locked memory). The system ensures that the start address of the memory is 64-byte aligned.

Memory allocated through this API must be released through the [aclrtFreeHost](11-02_host_memory_management.md#aclrtFreeHost) API or the [aclrtFreeHostWithDevSync](11-02_host_memory_management.md#aclrtFreeHostWithDevSync) API.

This API is an encapsulated API applicable only to C++ programs. Inside the API, the C API [aclrtMallocHostWithCfg](11-02_host_memory_management.md#aclrtMallocHostWithCfg) is called.

### Parameters

| Parameter | Input/Output | Description |
| --- | --- | --- |
| hostPtr | Output | Pointer to the pointer of the allocated memory. |
| size | Input | Size of the memory to allocate, in bytes.<br>`size` cannot be `0`. |
| cfg | Input | Memory configuration information. See [aclrtMallocConfig](25-04_Structs.md#aclrtMallocConfig) for the type definition. |

### Return Values

`0`: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtMemcpy"></a>

## aclrtMemcpy

```cpp
template <typename T, typename U>
aclError aclrtMemcpy(T *dst, size_t destMax, const U *src, size_t count, aclrtMemcpyKind kind)
```

### Applicable Products

<!-- npu="950" id1632 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1632 -->
<!-- npu="A3" id1633 -->
- Atlas A3 products: Supported
<!-- end id1633 -->
<!-- npu="910b" id1634 -->
- Atlas A2 products: Supported
<!-- end id1634 -->
<!-- npu="310b" id1635 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1635 -->
<!-- npu="310p" id1636 -->
- Atlas inference products: Supported
<!-- end id1636 -->
<!-- npu="910" id1637 -->
- Atlas training products: Supported
<!-- end id1637 -->
<!-- @ref: runtime/res/docs/zh/api_ref/26_cpp_extension_APIs_res.md#id19 -->

### Description

Performs memory copy.

This API is an encapsulated API applicable only to C++ programs. Inside the API, the C API [aclrtMemcpy](11-03_memory_copy_and_set.md#aclrtMemcpy) is called.

### Parameters

| Parameter | Input/Output | Description |
| --- | --- | --- |
| dst | Input | Destination memory address pointer. |
| destMax | Input | Maximum memory length of the destination memory address, in bytes. |
| src | Input | Source memory address pointer. |
| count | Input | Length of the memory copy, in bytes. |
| kind | Input | Type of the memory copy. This is a reserved parameter. Configuring a value from the enumeration is invalid. The system determines, based on the source memory address pointer and the destination memory address pointer, whether data at the source address can be copied to the destination address. If not, the system returns an error.<br>See [aclrtMemcpyKind](25-02_Enumerations.md#aclrtMemcpyKind) for the type definition. |

### Return Values

`0`: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

Same as the constraints of the C API [aclrtMemcpy](11-03_memory_copy_and_set.md#aclrtMemcpy).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtMemcpyAsync"></a>

## aclrtMemcpyAsync

```cpp
template <typename T, typename U>
aclError aclrtMemcpyAsync(T *dst, size_t destMax, const U *src, size_t count, aclrtMemcpyKind kind, aclrtStream stream)
```

### Applicable Products

<!-- npu="950" id3221 -->
- Ascend 950PR&950DT products: Supported
<!-- end id3221 -->
<!-- npu="A3" id3222 -->
- Atlas A3 products: Supported
<!-- end id3222 -->
<!-- npu="910b" id3223 -->
- Atlas A2 products: Supported
<!-- end id3223 -->
<!-- npu="310b" id3224 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id3224 -->
<!-- npu="310p" id3225 -->
- Atlas inference products: Supported
<!-- end id3225 -->
<!-- npu="910" id3226 -->
- Atlas training products: Supported
<!-- end id3226 -->
<!-- @ref: runtime/res/docs/zh/api_ref/26_cpp_extension_APIs_res.md#id20 -->

### Description

Performs memory copy.

The host memory in this API supports page-locked memory (for example, memory allocated through the aclrtMallocHost API) and non-page-locked memory (memory allocated through the malloc API). When the host memory is page-locked memory, this API is an asynchronous API. A successful call only indicates that the task has been delivered, not that the task has been executed. After calling this API, call a synchronous wait API (for example, [aclrtSynchronizeStream](06_stream_management.md#aclrtSynchronizeStream)) to ensure that the memory copy task has been executed. When the host memory is non-page-locked memory, this API returns only after the memory copy task is complete.

This API is an encapsulated API applicable only to C++ programs. Inside the API, it calls the C API [aclrtMemcpyAsync](11-03_memory_copy_and_set.md#aclrtMemcpyAsync).

### Parameters

| Parameter | Input/Output | Description |
| --- | --- | --- |
| dst | Input | Destination memory address pointer. |
| destMax | Input | Maximum memory length of the destination memory address, in bytes. |
| src | Input | Source memory address pointer. |
| count | Input | Length of the memory copy, in bytes. |
| kind | Input | Type of the memory copy. See [aclrtMemcpyKind](25-02_Enumerations.md#aclrtMemcpyKind) for the type definition. |
| stream | Input | Stream on which the memory copy task is executed. See [aclrtStream](25-05_Typedefs.md#aclrtStream) for the type definition. |

### Return Values

`0`: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

Same as the constraints of the C API [aclrtMemcpyAsync](11-03_memory_copy_and_set.md#aclrtMemcpyAsync).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtMemcpy2d"></a>

## aclrtMemcpy2d

```cpp
template <typename T, typename U>
aclError aclrtMemcpy2d(T *dst, size_t dpitch, const U *src, size_t spitch, size_t width, size_t height, aclrtMemcpyKind kind)
```

### Applicable Products

<!-- npu="950" id2353 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2353 -->
<!-- npu="A3" id2354 -->
- Atlas A3 products: Supported
<!-- end id2354 -->
<!-- npu="910b" id2355 -->
- Atlas A2 products: Supported
<!-- end id2355 -->
<!-- npu="310b" id2356 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2356 -->
<!-- npu="310p" id2357 -->
- Atlas inference products: Supported
<!-- end id2357 -->
<!-- npu="910" id2358 -->
- Atlas training products: Supported
<!-- end id2358 -->
<!-- @ref: runtime/res/docs/zh/api_ref/26_cpp_extension_APIs_res.md#id21 -->

### Description

Performs synchronous memory copy, mainly for copying matrix data.

This API is an encapsulated API applicable only to C++ programs. Inside the API, it calls the C API [aclrtMemcpy2d](11-03_memory_copy_and_set.md#aclrtMemcpy2d).

### Parameters

| Parameter | Input/Output | Description |
| --- | --- | --- |
| dst | Input | Destination memory address pointer. |
| dpitch | Input | Address distance between two adjacent column vectors in the destination memory. |
| src | Input | Source memory address pointer. |
| spitch | Input | Address distance between two adjacent column vectors in the source memory. |
| width | Input | Width of the data to be copied. |
| height | Input | Height of the data to be copied. |
| kind | Input | Memory copy type. See [aclrtMemcpyKind](25-02_Enumerations.md#aclrtMemcpyKind) for the type definition. |

### Return Values

`0`: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

Same as the constraints of the C API [aclrtMemcpy2d](11-03_memory_copy_and_set.md#aclrtMemcpy2d).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtMemcpy2dAsync"></a>

## aclrtMemcpy2dAsync

```cpp
template <typename T, typename U>
aclError aclrtMemcpy2dAsync(T *dst, size_t dpitch, const U *src, size_t spitch, size_t width, size_t height, aclrtMemcpyKind kind, aclrtStream stream)
```

### Applicable Products

<!-- npu="950" id2717 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2717 -->
<!-- npu="A3" id2718 -->
- Atlas A3 products: Supported
<!-- end id2718 -->
<!-- npu="910b" id2719 -->
- Atlas A2 products: Supported
<!-- end id2719 -->
<!-- npu="310b" id2720 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2720 -->
<!-- npu="310p" id2721 -->
- Atlas inference products: Supported
<!-- end id2721 -->
<!-- npu="910" id2722 -->
- Atlas training products: Supported
<!-- end id2722 -->
<!-- @ref: runtime/res/docs/zh/api_ref/26_cpp_extension_APIs_res.md#id22 -->

### Description

Performs asynchronous memory copy, mainly for copying matrix data. This is an asynchronous API.

The host memory in this API supports page-locked memory (for example, memory allocated through the aclrtMallocHost API) and non-page-locked memory (memory allocated through the malloc API). When the host memory is non-page-locked memory, this API returns only after the memory copy task is complete. When the host memory is page-locked memory, this API is an asynchronous API. A successful call only indicates that the task has been delivered, not that the task has been executed. After calling this API, call a synchronous wait API (for example, [aclrtSynchronizeStream](06_stream_management.md#aclrtSynchronizeStream)) to ensure that the memory copy task has been executed.

This API is an encapsulated API applicable only to C++ programs. Inside the API, the C API [aclrtMemcpy2dAsync](11-03_memory_copy_and_set.md#aclrtMemcpy2dAsync) is called.

### Parameters

| Parameter | Input/Output | Description |
| --- | --- | --- |
| dst | Input | Destination memory address pointer. |
| dpitch | Input | Address distance between two adjacent column vectors in the destination memory. |
| src | Input | Source memory address pointer. |
| spitch | Input | Address distance between two adjacent column vectors in the source memory. |
| width | Input | Width of the data to be copied.<br>The maximum value of width is 5000000, and it must be less than or equal to dpitch and spitch. |
| height | Input | Height of the data to be copied.<br>The maximum value of height is 5 × 1024 × 1024 = 5242880. Otherwise, the API returns a failure value. |
| kind | Input | Type of memory copy. See [aclrtMemcpyKind](25-02_Enumerations.md#aclrtMemcpyKind) for the type definition. |
| stream | Input | Stream on which the memory copy task is executed. See [aclrtStream](25-05_Typedefs.md#aclrtStream) for the type definition. |

### Return Values

`0`: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

Same as the constraints of the C API [aclrtMemcpy2dAsync](11-03_memory_copy_and_set.md#aclrtMemcpy2dAsync).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtGetSymbolAddress"></a>

## aclrtGetSymbolAddress

```cpp
template <typename T>
aclError aclrtGetSymbolAddress(const T &symbol, void **devPtr)
```

### Applicable Products

<!-- npu="950" id1317 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1317 -->
<!-- npu="A3" id1318 -->
- Atlas A3 products: Supported
<!-- end id1318 -->
<!-- npu="910b" id1319 -->
- Atlas A2 products: Supported
<!-- end id1319 -->
<!-- npu="310b" id1320 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id1320 -->
<!-- npu="310p" id1321 -->
- Atlas inference products: Supported
<!-- end id1321 -->
<!-- npu="910" id1322 -->
- Atlas training products: Not supported
<!-- end id1322 -->
<!-- @ref: runtime/res/docs/zh/api_ref/26_cpp_extension_APIs_res.md#id23 -->

### Description

Obtains the address of a device variable.

This API is an encapsulated API applicable only to C++ programs. Inside the API, the C API [aclrtGetSymbolAddress](11-11_device_variable_memory_operation.md#aclrtGetSymbolAddress) is called.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| symbol | Input | Device variable name. Pass the variable name declared with `__gm__` here. |
| devPtr | Output | Memory address pointer of the device variable. |

### Return Values

`0`: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

- This API is applicable only to C++ programs.
- This API applies only to the scenario where you develop custom operators in Ascend C and use the Bisheng compiler for mixed host and device code compilation.
- The device variable address is valid only on the current device. After switching the device, you must re-obtain the address.
- Only device variables in AI Core operators are supported, with the following constraints:
    - Device variables defined in the file where the main function resides are supported (for example, `__gm__ float convWeights`).
    - Cross-file references to device variables through the `extern` keyword are supported. For example, if `__gm__ float convWeights` is defined in file A, it can be declared and referenced in file B through `extern __gm__ float convWeights`. The compilation requirement must be satisfied: use the -dc mode of the Bisheng compiler to compile multiple source files into a single operator binary file.
    - Basic data types, function pointers, structures, and arrays are supported. The class type is not supported. Note that function pointers support only functions pointing to pure Scalar, and cannot effectively distinguish between Cube and Vector function logic.

<br>
<br>
<br>

<a class="method_anchor" id="aclrtGetSymbolSize"></a>

## aclrtGetSymbolSize

```cpp
template <typename T>
aclError aclrtGetSymbolSize(const T &symbol, size_t *size)
```

### Applicable Products

<!-- npu="950" id2325 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2325 -->
<!-- npu="A3" id2326 -->
- Atlas A3 products: Supported
<!-- end id2326 -->
<!-- npu="910b" id2327 -->
- Atlas A2 products: Supported
<!-- end id2327 -->
<!-- npu="310b" id2328 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id2328 -->
<!-- npu="310p" id2329 -->
- Atlas inference products: Supported
<!-- end id2329 -->
<!-- npu="910" id2330 -->
- Atlas training products: Not supported
<!-- end id2330 -->
<!-- @ref: runtime/res/docs/zh/api_ref/26_cpp_extension_APIs_res.md#id24 -->

### Description

Obtains the memory size occupied by a device variable.

This API is an encapsulated API applicable only to C++ programs. Inside the API, the C API [aclrtGetSymbolSize](11-11_device_variable_memory_operation.md#aclrtGetSymbolSize) is called.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| symbol | Input | Device variable name. Pass the variable name declared with `__gm__`. |
| size | Output | Size of the device variable, in bytes. |

### Return Values

`0`: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

Same as the constraints of the [aclrtGetSymbolAddress](#aclrtGetSymbolAddress) API.

<br>
<br>
<br>

<a class="method_anchor" id="aclrtMemcpyFromSymbol"></a>

## aclrtMemcpyFromSymbol

```cpp
template <typename T>
aclError aclrtMemcpyFromSymbol(void *dst, size_t dstMax, const T &symbol, size_t count,
                               size_t offset, aclrtMemcpyKind kind)
```

### Applicable Products

<!-- npu="950" id1912 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1912 -->
<!-- npu="A3" id1913 -->
- Atlas A3 products: Supported
<!-- end id1913 -->
<!-- npu="910b" id1914 -->
- Atlas A2 products: Supported
<!-- end id1914 -->
<!-- npu="310b" id1915 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id1915 -->
<!-- npu="310p" id1916 -->
- Atlas inference products: Supported
<!-- end id1916 -->
<!-- npu="910" id1917 -->
- Atlas training products: Not supported
<!-- end id1917 -->
<!-- @ref: runtime/res/docs/zh/api_ref/26_cpp_extension_APIs_res.md#id25 -->

### Description

Performs synchronous memory copy from a device variable to the host. It is used to read the data of a device variable.

This API is an encapsulated API applicable only to C++ programs. Inside the API, the C API [aclrtMemcpyFromSymbol](11-11_device_variable_memory_operation.md#aclrtMemcpyFromSymbol) is called.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| dst | Input | Destination memory address pointer. |
| dstMax | Input | Maximum length of the destination memory, in bytes. The condition dstMax ≥ Count must be satisfied. |
| symbol | Input | Device variable name. Pass the variable name declared with `__gm__` here. |
| count | Input | Length of the memory copy, in bytes. The condition Offset + Count ≤ Device variable size must be satisfied. The device variable size can be obtained via the [aclrtGetSymbolSize](#aclrtGetSymbolSize) API. |
| offset | Input | Device variable address offset, in bytes. The condition Offset + Count ≤ Device variable size must be satisfied. The device variable size can be obtained via the [aclrtGetSymbolSize](#aclrtGetSymbolSize) API. |
| kind | Input | Copy type. See [aclrtMemcpyKind](25-02_Enumerations.md#aclrtMemcpyKind) for the type definition. This API supports only `ACL_MEMCPY_DEVICE_TO_HOST` and `ACL_MEMCPY_DEFAULT`. |

### Return Values

`0`: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

Same as the constraints of the [aclrtGetSymbolAddress](#aclrtGetSymbolAddress) API.

<br>
<br>
<br>

<a class="method_anchor" id="aclrtMemcpyFromSymbolAsync"></a>

## aclrtMemcpyFromSymbolAsync

```cpp
template <typename T>
aclError aclrtMemcpyFromSymbolAsync(void *dst, size_t dstMax, const T &symbol, size_t count,
                                    size_t offset, aclrtMemcpyKind kind, aclrtStream stream)
```

### Applicable Products

<!-- npu="950" id2738 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2738 -->
<!-- npu="A3" id2739 -->
- Atlas A3 products: Supported
<!-- end id2739 -->
<!-- npu="910b" id2740 -->
- Atlas A2 products: Supported
<!-- end id2740 -->
<!-- npu="310b" id2741 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id2741 -->
<!-- npu="310p" id2742 -->
- Atlas inference products: Supported
<!-- end id2742 -->
<!-- npu="910" id2743 -->
- Atlas training products: Not supported
<!-- end id2743 -->
<!-- @ref: runtime/res/docs/zh/api_ref/26_cpp_extension_APIs_res.md#id26 -->

### Description

Performs asynchronous memory copy of device variable data to the host. It is used to read the data of a device variable.

The host memory in this API supports page-locked memory (for example, memory allocated through the aclrtMallocHost API) and non-page-locked memory (memory allocated through the malloc API). When the host memory is page-locked memory, this API is an asynchronous API. A successful call only indicates that the task has been delivered, not that the task has been executed. After calling this API, call a synchronous wait API (for example, [aclrtSynchronizeStream](06_stream_management.md#aclrtSynchronizeStream)) to ensure that the memory copy task has been completed. When the host memory is page-locked memory, this API is an asynchronous API. When the host memory is non-page-locked memory, this API returns only after the memory copy task is complete.

This API is an encapsulated API applicable only to C++ programs. Inside the API, the C API [aclrtMemcpyFromSymbolAsync](11-11_device_variable_memory_operation.md#aclrtMemcpyFromSymbolAsync) is called.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| dst | Input | Destination memory address pointer. |
| dstMax | Input | Maximum length of the destination memory, in bytes. The condition dstMax ≥ Count must be satisfied. |
| symbol | Input | Device variable name. Pass the variable name declared with `__gm__` here. |
| count | Input | Length of the memory copy, in bytes. The condition Offset + Count ≤ Device variable size must be satisfied. The device variable size can be obtained via the [aclrtGetSymbolSize](#aclrtGetSymbolSize) API. |
| offset | Input | Address offset of the device variable, in bytes. The condition Offset + Count ≤ Device variable size must be satisfied. The device variable size can be obtained via the [aclrtGetSymbolSize](#aclrtGetSymbolSize) API. |
| kind | Input | Copy type. See [aclrtMemcpyKind](25-02_Enumerations.md#aclrtMemcpyKind) for the type definition. This API supports only `ACL_MEMCPY_DEVICE_TO_HOST` and `ACL_MEMCPY_DEFAULT`. |
| stream | Input | Stream on which the memory copy task is executed. See [aclrtStream](25-05_Typedefs.md#aclrtStream) for the type definition. |

### Return Values

`0`: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

- Same as the constraints of the [aclrtGetSymbolAddress](#aclrtGetSymbolAddress) API.
- This API is asynchronous. After calling it, you need to synchronously wait for the copy to complete.

<br>
<br>
<br>

<a class="method_anchor" id="aclrtMemcpyToSymbol"></a>

## aclrtMemcpyToSymbol

```cpp
template <typename T>
aclError aclrtMemcpyToSymbol(const T &symbol, const void *src, size_t count, size_t offset, aclrtMemcpyKind kind)
```

### Applicable Products

<!-- npu="950" id3291 -->
- Ascend 950PR&950DT products: Supported
<!-- end id3291 -->
<!-- npu="A3" id3292 -->
- Atlas A3 products: Supported
<!-- end id3292 -->
<!-- npu="910b" id3293 -->
- Atlas A2 products: Supported
<!-- end id3293 -->
<!-- npu="310b" id3294 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id3294 -->
<!-- npu="310p" id3295 -->
- Atlas inference products: Supported
<!-- end id3295 -->
<!-- npu="910" id3296 -->
- Atlas training products: Not supported
<!-- end id3296 -->
<!-- @ref: runtime/res/docs/zh/api_ref/26_cpp_extension_APIs_res.md#id27 -->

### Description

Performs synchronous memory copy from host data to a device variable. It is used to write data to a device variable.

This API is an encapsulated API applicable only to C++ programs. Inside the API, the C API [aclrtMemcpyToSymbol](11-11_device_variable_memory_operation.md#aclrtMemcpyToSymbol) is called.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| symbol | Input | Device variable name. Pass the variable name declared with `__gm__` here. |
| src | Input | Source memory address pointer. |
| count | Input | Length of the memory copy, in bytes. The condition Offset + Count ≤ Device variable size must be satisfied. The device variable size can be obtained via the [aclrtGetSymbolSize](#aclrtGetSymbolSize) API. |
| offset | Input | Device variable address offset, in bytes. The condition Offset + Count ≤ Device variable size must be satisfied. The device variable size can be obtained via the [aclrtGetSymbolSize](#aclrtGetSymbolSize) API. |
| kind | Input | Copy type. See [aclrtMemcpyKind](25-02_Enumerations.md#aclrtMemcpyKind) for the type definition. This API supports only `ACL_MEMCPY_HOST_TO_DEVICE` and `ACL_MEMCPY_DEFAULT`. |

### Return Values

`0`: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

Same as the constraints of the [aclrtGetSymbolAddress](#aclrtGetSymbolAddress) API.

<br>
<br>
<br>

<a class="method_anchor" id="aclrtMemcpyToSymbolAsync"></a>

## aclrtMemcpyToSymbolAsync

```cpp
template <typename T>
aclError aclrtMemcpyToSymbolAsync(const T &symbol, const void *src, size_t count, size_t offset,
                                  aclrtMemcpyKind kind, aclrtStream stream)
```

### Applicable Products

<!-- npu="950" id3466 -->
- Ascend 950PR&950DT products: Supported
<!-- end id3466 -->
<!-- npu="A3" id3467 -->
- Atlas A3 products: Supported
<!-- end id3467 -->
<!-- npu="910b" id3468 -->
- Atlas A2 products: Supported
<!-- end id3468 -->
<!-- npu="310b" id3469 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id3469 -->
<!-- npu="310p" id3470 -->
- Atlas inference products: Supported
<!-- end id3470 -->
<!-- npu="910" id3471 -->
- Atlas training products: Not supported
<!-- end id3471 -->
<!-- @ref: runtime/res/docs/zh/api_ref/26_cpp_extension_APIs_res.md#id28 -->

### Description

Performs asynchronous memory copy from host data to a device variable. It is used to write data to a device variable.

The host memory in this API supports page-locked memory (for example, memory allocated through the aclrtMallocHost API) and non-page-locked memory (memory allocated through the malloc API). When the host memory is page-locked memory, this API is an asynchronous API. A successful call only indicates that the task has been delivered, not that the task has been executed. After calling this API, call a synchronous wait API (for example, [aclrtSynchronizeStream](06_stream_management.md#aclrtSynchronizeStream)) to ensure that the memory copy task has been executed. When the host memory is page-locked memory, this API is an asynchronous API. When the host memory is non-page-locked memory, this API returns only after the memory copy task is complete.

This API is an encapsulated API applicable only to C++ programs. Inside the API, it calls the C API [aclrtMemcpyToSymbolAsync](11-11_device_variable_memory_operation.md#aclrtMemcpyToSymbolAsync).

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| symbol | Input | Device variable name. Pass the variable name declared with `__gm__` here. |
| src | Input | Source memory address pointer. |
| count | Input | Length of the memory copy, in bytes. The condition Offset + Count ≤ Device variable size must be satisfied. The device variable size can be obtained via the [aclrtGetSymbolSize](#aclrtGetSymbolSize) API. |
| offset | Input | Device variable address offset, in bytes. The condition Offset + Count ≤ Device variable size must be satisfied. The device variable size can be obtained via the [aclrtGetSymbolSize](#aclrtGetSymbolSize) API. |
| kind | Input | Copy type. See [aclrtMemcpyKind](25-02_Enumerations.md#aclrtMemcpyKind) for the type definition. This API supports only `ACL_MEMCPY_HOST_TO_DEVICE` and `ACL_MEMCPY_DEFAULT`. |
| stream | Input | Stream on which the memory copy task is executed. See [aclrtStream](25-05_Typedefs.md#aclrtStream) for the type definition. |

### Return Values

`0`: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

- Same as the constraints of the [aclrtGetSymbolAddress](#aclrtGetSymbolAddress) API.
- This API is asynchronous. After calling it, you must synchronously wait for the copy to complete.

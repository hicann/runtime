# 11-08 Custom Memory Allocator

<!-- md-trans-meta sourceCommit=31ae292a88c1a38674abaa350b60eba724bab178 translatedAt=2026-10-23T11:30:42.066Z pushedAt=2026-10-26T08:58:43.549Z -->

This topic describes the custom Allocator APIs, which are used to register, query, and unregister user-defined memory allocators.

- [`aclError aclrtAllocatorRegister(aclrtStream stream, aclrtAllocatorDesc allocatorDesc)`](#aclrtAllocatorRegister): Registers the Allocator provided by the user and the callback functions corresponding to the Allocator, so that the user-provided Allocator can be used subsequently.
- [`aclError aclrtAllocatorGetByStream(aclrtStream stream, aclrtAllocatorDesc *allocatorDesc, aclrtAllocator *allocator, aclrtAllocatorAllocFunc *allocFunc, aclrtAllocatorFreeFunc *freeFunc, aclrtAllocatorAllocAdviseFunc *allocAdviseFunc, aclrtAllocatorGetAddrFromBlockFunc *getAddrFromBlockFunc)`](#aclrtAllocatorGetByStream): Queries the Allocator information registered by the user based on the stream.
- [`aclError aclrtAllocatorUnregister(aclrtStream stream)`](#aclrtAllocatorUnregister): Unregisters the Allocator provided by the user and the callback functions corresponding to the Allocator before the user destroys the Allocator.

<a class="method_anchor" id="aclrtAllocatorRegister"></a>

## aclrtAllocatorRegister

```c
aclError aclrtAllocatorRegister(aclrtStream stream, aclrtAllocatorDesc allocatorDesc)
```

### Applicable Products

<!-- npu="950" id2297 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2297 -->
<!-- npu="A3" id2298 -->
- Atlas A3 products: Supported
<!-- end id2298 -->
<!-- npu="910b" id2299 -->
- Atlas A2 products: Supported
<!-- end id2299 -->
<!-- npu="310b" id2300 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id2300 -->
<!-- npu="310p" id2301 -->
- Atlas inference products: Supported
<!-- end id2301 -->
<!-- npu="910" id2302 -->
- Atlas training products: Supported
<!-- end id2302 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-08_custom_memory_allocator_res.md#id1 -->

### Description

Registers the Allocator provided by the user and the callback functions corresponding to the Allocator, so that the user-provided Allocator can be used subsequently.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| stream | Input | Stream to which the Allocator is to be registered. For details about the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream).<br>The value of the stream parameter cannot be **NULL**; otherwise, an error is returned. |
| allocatorDesc | Input | Pointer to the Allocator descriptor. For details about the type definition, see [aclrtAllocatorDesc](25-03_Operation_APIs.md#aclrtAllocatorDesc). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

- This API can be used only in single-operator model execution and dynamic shape model inference scenarios.

    In the single-operator model scenario, call this API before the operator execution API (for example, **aclopExecuteV2**).

    In the dynamic shape model inference scenario, this API must be used together with the **aclmdlExecuteAsync** API, and it must be called before the **aclmdlExecuteAsync** API.

- Before calling this API, call [aclrtAllocatorCreateDesc](25-03_Operation_APIs.md#aclrtAllocatorCreateDesc) to create the Allocator descriptor, and then call [aclrtAllocatorSetObjToDesc](25-03_Operation_APIs.md#aclrtAllocatorSetObjToDesc), [aclrtAllocatorSetAllocFuncToDesc](25-03_Operation_APIs.md#aclrtAllocatorSetAllocFuncToDesc), [aclrtAllocatorSetGetAddrFromBlockFuncToDesc](25-03_Operation_APIs.md#aclrtAllocatorSetGetAddrFromBlockFuncToDesc), and [aclrtAllocatorSetFreeFuncToDesc](25-03_Operation_APIs.md#aclrtAllocatorSetFreeFuncToDesc) to set the Allocator object and callback functions. After the Allocator descriptor is no longer needed, call [aclrtAllocatorDestroyDesc](25-03_Operation_APIs.md#aclrtAllocatorDestroyDesc) to destroy the Allocator descriptor.
- For the same stream, if this API is called multiple times, the last registration takes effect.
- For different streams, if the same Allocator is used, multiple streams cannot execute concurrently. Before executing the next stream, stream synchronization must be performed on the previous stream.
- Before releasing the memory in the Allocator to the operating system, call [aclrtSynchronizeStream](06_stream_management.md#aclrtSynchronizeStream) to perform stream synchronization to ensure that the tasks in the stream have completed.

<br>
<br>
<br>

<a class="method_anchor" id="aclrtAllocatorGetByStream"></a>

## aclrtAllocatorGetByStream

```c
aclError aclrtAllocatorGetByStream(aclrtStream stream, aclrtAllocatorDesc *allocatorDesc, aclrtAllocator *allocator, aclrtAllocatorAllocFunc *allocFunc, aclrtAllocatorFreeFunc *freeFunc, aclrtAllocatorAllocAdviseFunc *allocAdviseFunc, aclrtAllocatorGetAddrFromBlockFunc *getAddrFromBlockFunc)
```

### Applicable Products

<!-- npu="950" id372 -->
- Ascend 950PR&950DT products: Supported
<!-- end id372 -->
<!-- npu="A3" id373 -->
- Atlas A3 products: Supported
<!-- end id373 -->
<!-- npu="910b" id374 -->
- Atlas A2 products: Supported
<!-- end id374 -->
<!-- npu="310b" id375 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id375 -->
<!-- npu="310p" id376 -->
- Atlas inference products: Supported
<!-- end id376 -->
<!-- npu="910" id377 -->
- Atlas training products: Supported
<!-- end id377 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-08_custom_memory_allocator_res.md#id2 -->

### Description

Queries the Allocator information registered by the user based on the stream.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| stream | Input | Stream to be queried. For details about the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream). |
| allocatorDesc | Output | Allocator descriptor pointer. For details about the type definition, see [aclrtAllocatorDesc](25-03_Operation_APIs.md#aclrtAllocatorDesc). |
| allocator | Output | Pointer to the Allocator object provided by the user. For details about the type definition, see [aclrtAllocator](25-05_Typedefs.md#aclrtAllocator). |
| allocFunc | Output | Callback function for applying for a memory block.<br>The callback function is defined as follows:<br>typedef void *(*aclrtAllocatorAllocFunc)([aclrtAllocator](25-05_Typedefs.md#aclrtAllocator) allocator, size_t size); |
| freeFunc | Output | Callback function for releasing a memory block.<br>The callback function is defined as follows:<br>typedef void (*aclrtAllocatorFreeFunc)([aclrtAllocator](25-05_Typedefs.md#aclrtAllocator) allocator, [aclrtAllocatorBlock](25-05_Typedefs.md#aclrtAllocatorBlock) block); |
| allocAdviseFunc | Output | Callback function for applying for a memory block based on the recommended address.<br>The callback function is defined as follows:<br>typedef void *(*aclrtAllocatorAllocAdviseFunc)([aclrtAllocator](25-05_Typedefs.md#aclrtAllocator) allocator, size_t size, [aclrtAllocatorAddr](25-05_Typedefs.md#aclrtAllocatorAddr) addr); |
| getAddrFromBlockFunc | Output | Callback function for obtaining the device memory address from the obtained block.<br>The callback function is defined as follows:<br>typedef void *(*aclrtAllocatorGetAddrFromBlockFunc)([aclrtAllocatorBlock](25-05_Typedefs.md#aclrtAllocatorBlock) block); |

### Return Value

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtAllocatorUnregister"></a>

## aclrtAllocatorUnregister

```c
aclError aclrtAllocatorUnregister(aclrtStream stream)
```

### Applicable Products

<!-- npu="950" id3186 -->
- Ascend 950PR&950DT products: Supported
<!-- end id3186 -->
<!-- npu="A3" id3187 -->
- Atlas A3 products: Supported
<!-- end id3187 -->
<!-- npu="910b" id3188 -->
- Atlas A2 products: Supported
<!-- end id3188 -->
<!-- npu="310b" id3189 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id3189 -->
<!-- npu="310p" id3190 -->
- Atlas inference products: Supported
<!-- end id3190 -->
<!-- npu="910" id3191 -->
- Atlas training products: Supported
<!-- end id3191 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-08_custom_memory_allocator_res.md#id3 -->

### Description

Unregisters the Allocator provided by the user and the callback functions corresponding to the Allocator before the user destroys the Allocator.

If the stream to be unregistered does not exist, or if this API is called multiple times to unregister, this API performs no operation internally and returns success.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| stream | Input | Stream corresponding to the Allocator. For details about the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

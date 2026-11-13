# 11-01 Device Memory Allocation and Release

<!-- md-trans-meta sourceCommit=be113e8125a2a8c7ff54fc96bb9a5e053217e879 translatedAt=2026-11-06T11:19:19.773Z pushedAt=2026-11-09T08:26:10.938Z nl=2 -->

This chapter describes the APIs for allocating and releasing device memory.

- [`aclError aclrtMalloc(void **devPtr, size_t size, aclrtMemMallocPolicy policy)`](#aclrtMalloc): Allocates linear memory of size on the device, returns the pointer to the allocated memory through \*devPtr, and the start address of the memory is 64-byte aligned.
- [`aclError aclrtMallocAlign32(void **devPtr, size_t size, aclrtMemMallocPolicy policy)`](#aclrtMallocAlign32): Allocates linear memory of size on the device, and returns the pointer to the allocated memory through \*devPtr.
- [`aclError aclrtMallocCached(void **devPtr, size_t size, aclrtMemMallocPolicy policy)`](#aclrtMallocCached): Allocates linear memory of size on the device, and returns the pointer to the allocated memory through \*devPtr. The memory allocated by this API supports cache in all scenarios.
- [`aclError aclrtMemFlush(void *devPtr, size_t size)`](#aclrtMemFlush): Flushes the data in the cache to the DDR, and invalidates the content in the cache.
- [`aclError aclrtMemInvalidate(void *devPtr, size_t size)`](#aclrtMemInvalidate): Invalidates the data in the cache.
- [`aclError aclrtMallocWithCfg(void **devPtr, size_t size, aclrtMemMallocPolicy policy, aclrtMallocConfig *cfg)`](#aclrtMallocWithCfg): Allocates linear memory of size on the device, returns the pointer to the allocated memory through \*devPtr, and the start address of the memory is 64-byte aligned.
- [`aclError aclrtMallocForTaskScheduler(void **devPtr, size_t size, aclrtMemMallocPolicy policy, aclrtMallocConfig *cfg)`](#aclrtMallocForTaskScheduler): Allocates memory that can be used by the task scheduler on the AI processor.
- [`aclError aclrtFree(void *devPtr)`](#aclrtFree): Frees the memory on the device.
- [`aclError aclrtFreeWithDevSync(void *devPtr)`](#aclrtFreeWithDevSync): Frees memory on the device.
- [`aclError aclrtGetMemInfo(aclrtMemAttr attr, size_t *free, size_t *total)`](#aclrtGetMemInfo): Obtains the free size and total size of available memory on the device based on the specified attributes, excluding the system reserved memory size.
- [`aclError aclrtGetMemUsageInfo(int32_t deviceId, aclrtMemUsageInfo *memUsageInfo, size_t inputNum, size_t *outputNum)`](#aclrtGetMemUsageInfo): Queries the memory usage information of components, including the component name, current memory size, and peak memory size.
- [`aclError aclrtCheckMemType(void** addrList, uint32_t size, uint32_t memType, uint32_t *checkResult, uint32_t reserve)`](#aclrtCheckMemType): Checks the device memory type.

<a class="method_anchor" id="aclrtMalloc"></a>

## aclrtMalloc

```c
aclError aclrtMalloc(void **devPtr, size_t size, aclrtMemMallocPolicy policy)
```

### Applicable Products

<!-- npu="950" id729 -->
- Ascend 950PR&950DT products: Supported
<!-- end id729 -->
<!-- npu="A3" id730 -->
- Atlas A3 products: Supported
<!-- end id730 -->
<!-- npu="910b" id731 -->
- Atlas A2 products: Supported
<!-- end id731 -->
<!-- npu="310b" id732 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id732 -->
<!-- npu="310p" id733 -->
- Atlas inference products: Supported
<!-- end id733 -->
<!-- npu="910" id734 -->
- Atlas training products: Supported
<!-- end id734 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-01_device_memory_malloc_and_free_res.md#id1 -->

### Description

Allocates linear memory of the specified size on the device, and returns the pointer to the allocated memory through \*devPtr. The start address of the memory is 64-byte aligned. Memory allocated by this API must be freed by the [aclrtFree](#aclrtFree) API or the [aclrtFreeWithDevSync](#aclrtFreeWithDevSync) API.

<!-- npu="950,A3,910b,910,310p,310b" id1 -->
The memory allocated by this API is byte-aligned. The alignment rules vary by product model:
<!-- end id1 -->

<!-- npu="950" id2 -->
- For Ascend 950PR&950DT products, the memory allocated by this API is byte-aligned, and the requested size is rounded up to a multiple of 32 bytes.
<!-- end id2 -->
<!-- npu="A3,910b,910,310p,310b" id3 -->
- For the following product models, the memory allocated by this API is byte-aligned, and the requested size is rounded up to a multiple of 32 bytes and then increased by 32 bytes. However, for large-page memory with a memory allocation granularity of 1 GB, to save large-page memory, this API only rounds up the requested size to a multiple of 32 bytes without adding 32 bytes.
    <!-- npu="A3" id4 -->
    - Atlas A3 products
    <!-- end id4 -->
    <!-- npu="910b" id5 -->
    - Atlas A2 products
    <!-- end id5 -->
    <!-- npu="310b" id6 -->
    - Atlas 200I/500 A2 inference products
    <!-- end id6 -->
    <!-- npu="310p" id7 -->
    - Atlas inference products
    <!-- end id7 -->
    <!-- npu="910" id8 -->
    - Atlas training products
    <!-- end id8 -->
<!-- end id3 -->

<!-- @ref: runtime/res/docs/zh/api_ref/11-01_device_memory_malloc_and_free_res.md#id11 -->

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| devPtr | Output | Pointer to the pointer of the allocated memory on the device. |
| size | Input | Size of the memory to be allocated, in bytes.<br>The value of size cannot be 0. |
| policy | Input | Memory allocation policy. For the type definition, see [aclrtMemMallocPolicy](25-02_Enumerations.md#aclrtMemMallocPolicy).<br>If the configured memory allocation policy exceeds the value range of [aclrtMemMallocPolicy](25-02_Enumerations.md#aclrtMemMallocPolicy), memory is allocated by large pages when size ≥ 2 MB; otherwise, memory is allocated by normal pages. |

### Return Values

Returns 0 on success and other values on failure. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

<!-- @ref: runtime/res/docs/zh/api_ref/11-01_device_memory_malloc_and_free_res.md#id14 -->
- The memory allocated by this API is not initialized. It is recommended that you call the [aclrtMemset](11-03_memory_copy_and_set.md#aclrtMemset) API to initialize the memory before using it, so as to clear the random data in the memory.
- This API does not perform implicit device synchronization or stream synchronization internally. It returns the result immediately whether the memory allocation succeeds or fails.
- For policy, only a single enum member can be configured. Configuring multiple enum members with bitwise OR is not supported.

- For the ACL\_MEM\_MALLOC\_HUGE\_FIRST\_P2P and ACL\_MEM\_MALLOC\_HUGE\_ONLY\_P2P memory allocation rules, use the aclrtMallocWithCfg API. Otherwise, performance issues may occur or memory may fail to be allocated.
- Frequently calling aclrtMalloc to allocate memory and [aclrtFree](#aclrtFree) to free memory degrades performance. Pre-allocate or re-manage memory in advance to avoid frequent memory allocation and release.
- If you need to allocate a large block of memory and divide and manage it by yourself, each memory segment must meet the following requirements, where len indicates the size of a memory segment and ALIGN\_UP\[len,k\] indicates alignment upwards to k bytes: \(\(len-1\)/k+1\)\*k:
    <!-- npu="950,A3,910b,910,310p,310b" id12 -->
    - The memory size alignment rule varies by product model:
        <!-- npu="950" id13 -->
        - For Ascend 950PR&950DT products, the memory size is aligned upwards to a multiple of 32 (m=ALIGN\_UP\[len,32\] bytes).
        <!-- end id13 -->
        <!-- npu="A3,910b,910,310p,310b" id14 -->
        - For the following product models, the memory size is aligned upwards to a multiple of 32 plus 32 bytes (m=ALIGN\_UP\[len,32\]+32 bytes).

            <!-- npu="A3" id15 -->
            Atlas A3 products
            <!-- end id15 -->

            <!-- npu="910b" id16 -->
            Atlas A2 products
            <!-- end id16 -->

            <!-- npu="310b" id17 -->
            Atlas 200I/500 A2 inference products
            <!-- end id17 -->

            <!-- npu="310p" id18 -->
            Atlas inference products
            <!-- end id18 -->

            <!-- npu="910" id19 -->
            Atlas training products
            <!-- end id19 -->
        <!-- end id14 -->
    <!-- end id12 -->

    <!-- @ref: runtime/res/docs/en/api_ref/11-01_device_memory_malloc_and_free_res.md#id13 -->
    - The start address of the memory must be 64-byte aligned (ALIGN\_UP\[m,64\]).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtMallocAlign32"></a>

## aclrtMallocAlign32

```c
aclError aclrtMallocAlign32(void **devPtr, size_t size, aclrtMemMallocPolicy policy)
```

### Applicable Products

<!-- npu="950" id1786 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1786 -->
<!-- npu="A3" id1787 -->
- Atlas A3 products: Supported
<!-- end id1787 -->
<!-- npu="910b" id1788 -->
- Atlas A2 products: Supported
<!-- end id1788 -->
<!-- npu="310b" id1789 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1789 -->
<!-- npu="310p" id1790 -->
- Atlas inference products: Supported
<!-- end id1790 -->
<!-- npu="910" id1791 -->
- Atlas training products: Supported
<!-- end id1791 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-01_device_memory_malloc_and_free_res.md#id2 -->

### Description

Allocates linear memory of the specified size on the device and returns the pointer to the allocated memory through \*devPtr. The memory allocated by this API is byte-aligned, and the requested size is rounded up to a multiple of 32 bytes. The memory allocated by this API must be freed by calling [aclrtFree](#aclrtFree) or [aclrtFreeWithDevSync](#aclrtFreeWithDevSync).

<!-- npu="950" id21 -->
For Ascend 950PR&950DT products, this API is functionally equivalent to aclrtMalloc.
<!-- end id21 -->

<!-- npu="A3,910b,910,310p,310b" id22 -->
For the following product models, compared with aclrtMalloc, this API only rounds up the requested size to a multiple of 32 bytes and does not add an extra 32 bytes.

<!-- npu="A3" id23 -->
- Atlas A3 products
<!-- end id23 -->
<!-- npu="910b" id24 -->
- Atlas A2 products
<!-- end id24 -->
<!-- npu="310b" id25 -->
- Atlas 200I/500 A2 inference products
<!-- end id25 -->
<!-- npu="310p" id26 -->
- Atlas inference products
<!-- end id26 -->
<!-- npu="910" id27 -->
- Atlas training products
<!-- end id27 -->
<!-- end id22 -->

<!-- @ref: runtime/res/docs/zh/api_ref/11-01_device_memory_malloc_and_free_res.md#id12 -->

### Parameters

| Parameter Name | Input/Output | Description |
| --- | :---: | --- |
| devPtr | Output | Pointer to the pointer to the allocated memory on the device. |
| size | Input | Size of the memory to be allocated, in bytes.<br>The value of size cannot be 0. |
| policy | Input | Memory allocation policy. For the type definition, see [aclrtMemMallocPolicy](25-02_Enumerations.md#aclrtMemMallocPolicy).<br>If the configured memory allocation policy exceeds the value range of [aclrtMemMallocPolicy](25-02_Enumerations.md#aclrtMemMallocPolicy), memory is allocated by large pages when size ≥ 2 MB; otherwise, memory is allocated by normal pages. |

### Return Values

Returns 0 on success and other values on failure. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

<!-- @ref: runtime/res/docs/zh/api_ref/11-01_device_memory_malloc_and_free_res.md#id20 -->
- The memory allocated by this API is not initialized.
- This API does not perform implicit device synchronization or stream synchronization internally. The result is returned immediately whether the memory allocation succeeds or fails.
- The policy parameter supports configuring only a single enum member, and does not support configuring multiple enum members with a bitwise OR operation.

- For the ACL_MEM_MALLOC_HUGE_FIRST_P2P and ACL_MEM_MALLOC_HUGE_ONLY_P2P memory allocation rules, it is recommended to use the aclrtMallocWithCfg API. Otherwise, performance issues may occur or memory may fail to be allocated.
- Frequently calling the aclrtMallocAlign32 API to allocate memory and the [aclrtFree](11-01_device_memory_malloc_and_free.md#aclrtFree) API to free memory degrades performance. It is recommended that users pre-allocate memory or perform secondary management in advance to avoid frequent memory allocation and release.
- If users use this API to allocate a large block of memory and then divide and manage the memory themselves, each memory segment must satisfy the following requirements, where len indicates the size of a memory segment and ALIGN\_UP\[len,k\] indicates upward alignment to k bytes: \(\(len-1\)/k+1\)\*k:
    <!-- npu="950,A3,910b,910,310p,310b" id30 -->
    - The memory size alignment rule varies by product model:
        <!-- npu="950" id31 -->
        - For Ascend 950PR&950DT products, the memory size is aligned upward to a multiple of 32 (m=ALIGN\_UP\[len,32\] bytes).
        <!-- end id31 -->
        <!-- npu="A3,910b,910,310p,310b" id32 -->
        - For the following product models, the memory size is aligned upward to a multiple of 32 plus 32 bytes (m=ALIGN\_UP\[len,32\]+32 bytes).

            <!-- npu="A3" id34 -->
            Atlas A3 products
            <!-- end id34 -->

            <!-- npu="910b" id35 -->
            Atlas A2 products
            <!-- end id35 -->

            <!-- npu="310b" id36 -->
            Atlas 200I/500 A2 inference products
            <!-- end id36 -->

            <!-- npu="310p" id37 -->
            Atlas inference products
            <!-- end id37 -->

            <!-- npu="910" id38 -->
            Atlas training products
            <!-- end id38 -->
        <!-- end id32 -->
    <!-- end id30 -->

    <!-- @ref: runtime/res/docs/en/api_ref/11-01_device_memory_malloc_and_free_res.md#id15 -->
    - The start address of the memory must meet the 64-byte alignment requirement (ALIGN\_UP\[m,64\]).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtMallocCached"></a>

## aclrtMallocCached

```c
aclError aclrtMallocCached(void **devPtr, size_t size, aclrtMemMallocPolicy policy)
```

### Applicable Products

<!-- npu="950" id316 -->
- Ascend 950PR&950DT products: Supported
<!-- end id316 -->
<!-- npu="A3" id317 -->
- Atlas A3 products: Supported
<!-- end id317 -->
<!-- npu="910b" id318 -->
- Atlas A2 products: Supported
<!-- end id318 -->
<!-- npu="310b" id319 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id319 -->
<!-- npu="310p" id320 -->
- Atlas inference products: Supported
<!-- end id320 -->
<!-- npu="910" id321 -->
- Atlas training products: Supported
<!-- end id321 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-01_device_memory_malloc_and_free_res.md#id3 -->

### Description

Allocates linear memory of the specified size on the device and returns the pointer to the allocated memory through \*devPtr. The memory allocated by this API supports cache in all scenarios.

The memory allocated by aclrtMallocCached is equivalent to that allocated by [aclrtMalloc](#aclrtMalloc). Both support cache, and the user does not need to handle cache coherence between the CPU and the NPU.

### Parameters

| Parameter Name | Input/Output | Description |
| --- | :---: | --- |
| devPtr | Output | Pointer to the pointer to the allocated memory on the device. |
| size | Input | Size of the memory to be allocated, in bytes.<br>The value of size cannot be 0. |
| policy | Input | Memory allocation rule. For the type definition, see [aclrtMemMallocPolicy](25-02_Enumerations.md#aclrtMemMallocPolicy).<br>If the configured memory allocation rule is outside the value range of [aclrtMemMallocPolicy](25-02_Enumerations.md#aclrtMemMallocPolicy), memory is allocated by large pages when size ≥ 2 MB; otherwise, memory is allocated by normal pages. |

### Return Values

Returns 0 on success and other values on failure. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

For policy, only a single enum member can be configured, and configuring multiple enum members with bitwise OR is not supported. Only the following enum members are supported: ACL\_MEM\_MALLOC\_HUGE\_FIRST, ACL\_MEM\_MALLOC\_HUGE\_ONLY, ACL\_MEM\_MALLOC\_NORMAL\_ONLY, ACL\_MEM\_MALLOC\_HUGE1G\_ONLY.

<br>
<br>
<br>

<a class="method_anchor" id="aclrtMemFlush"></a>

## aclrtMemFlush

```c
aclError aclrtMemFlush(void *devPtr, size_t size)
```

### Applicable Products

<!-- npu="950" id2094 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2094 -->
<!-- npu="A3" id2095 -->
- Atlas A3 products: Supported
<!-- end id2095 -->
<!-- npu="910b" id2096 -->
- Atlas A2 products: Supported
<!-- end id2096 -->
<!-- npu="310b" id2097 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2097 -->
<!-- npu="310p" id2098 -->
- Atlas inference products: Supported
<!-- end id2098 -->
<!-- npu="910" id2099 -->
- Atlas training products: Supported
<!-- end id2099 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-01_device_memory_malloc_and_free_res.md#id16 -->

### Description

Flushes data in the cache to DDR and invalidates the cache content.

In this version, users do not need to handle cache coherence between the CPU and NPU, and do not need to call this API.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| devPtr | Input | Start address pointer of the DDR memory to be flushed. |
| size | Input | Size of the DDR memory to be flushed, in bytes.<br>The value of size cannot be 0. |

### Return Values

Returns 0 on success and other values on failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtMemInvalidate"></a>

## aclrtMemInvalidate

```c
aclError aclrtMemInvalidate(void *devPtr, size_t size)
```

### Applicable Products

<!-- npu="950" id2031 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2031 -->
<!-- npu="A3" id2032 -->
- Atlas A3 products: Supported
<!-- end id2032 -->
<!-- npu="910b" id2033 -->
- Atlas A2 products: Supported
<!-- end id2033 -->
<!-- npu="310b" id2034 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2034 -->
<!-- npu="310p" id2035 -->
- Atlas inference products: Supported
<!-- end id2035 -->
<!-- npu="910" id2036 -->
- Atlas training products: Supported
<!-- end id2036 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-01_device_memory_malloc_and_free_res.md#id17 -->

### Description

Invalidates the data in the cache.

In this version, users do not need to handle cache coherence between the CPU and NPU, and therefore do not need to call this API.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| devPtr | Input | Start address pointer of the DDR memory whose cached data needs to be invalidated. |
| size | Input | Size of the DDR memory, in bytes.<br>size cannot be 0. |

### Return Values

0 is returned on success, and other values are returned on failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtMallocWithCfg"></a>

## aclrtMallocWithCfg

```c
aclError aclrtMallocWithCfg(void **devPtr, size_t size, aclrtMemMallocPolicy policy, aclrtMallocConfig *cfg)
```

### Applicable Products

<!-- npu="950" id589 -->
- Ascend 950PR&950DT products: Supported
<!-- end id589 -->
<!-- npu="A3" id590 -->
- Atlas A3 products: Supported
<!-- end id590 -->
<!-- npu="910b" id591 -->
- Atlas A2 products: Supported
<!-- end id591 -->
<!-- npu="310b" id592 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id592 -->
<!-- npu="310p" id593 -->
- Atlas inference products: Supported
<!-- end id593 -->
<!-- npu="910" id594 -->
- Atlas training products: Supported
<!-- end id594 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-01_device_memory_malloc_and_free_res.md#id4 -->

### Description

Allocates linear memory of the specified size on the device, returns the pointer to the allocated memory through \*devPtr, and aligns the start address of the memory to 64 bytes.

Compared with the aclrtMalloc API, this API also allows you to specify memory-related configuration information when allocating memory.

The memory allocated by this API must be freed by calling the [aclrtFree](#aclrtFree) API or the [aclrtFreeWithDevSync](#aclrtFreeWithDevSync) API.

### Parameters

| Parameter Name | Input/Output | Description |
| --- | :---: | --- |
| devPtr | Output | Pointer to the pointer of the allocated memory on the device. |
| size | Input | Size of the memory to be allocated, in bytes.<br>The size cannot be 0. |
| policy | Input | Memory allocation policy. For the type definition, see [aclrtMemMallocPolicy](25-02_Enumerations.md#aclrtMemMallocPolicy).<br>If the configured memory allocation policy exceeds the value range of [aclrtMemMallocPolicy](25-02_Enumerations.md#aclrtMemMallocPolicy), memory is allocated by large pages when size ≥ 2 MB; otherwise, memory is allocated by normal pages. |
| cfg | Input | Memory configuration information. For the type definition, see [aclrtMallocConfig](25-04_Structs.md#aclrtMallocConfig).<br>If no configuration is specified, NULL can be passed here. |

### Return Values

Returns 0 on success and other values on failure. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints
<!-- @ref: runtime/res/docs/zh/api_ref/11-01_device_memory_malloc_and_free_res.md#id19 -->

The policy parameter supports configuring a single enum member or multiple enum members combined with the bitwise OR operation. When the bitwise OR operation is used, the enum members in the following three groups can be combined, for example, ACL\_MEM\_TYPE\_HIGH\_BAND\_WIDTH | ACL\_MEM\_ACCESS\_USER\_SPACE\_READONLY | ACL\_MEM\_MALLOC\_HUGE\_FIRST:

- Used to distinguish high and low bandwidth: ACL\_MEM\_TYPE\_LOW\_BAND\_WIDTH, ACL\_MEM\_TYPE\_HIGH\_BAND\_WIDTH
- Used to control the allocated memory to be read-only in user mode: ACL\_MEM\_ACCESS\_USER\_SPACE\_READONLY
- Other basic memory allocation rules: for example, ACL\_MEM\_MALLOC\_HUGE\_FIRST, ACL\_MEM\_MALLOC\_HUGE\_ONLY, ACL\_MEM\_MALLOC\_NORMAL\_ONLY, and so on

<br>
<br>
<br>

<a class="method_anchor" id="aclrtMallocForTaskScheduler"></a>

## aclrtMallocForTaskScheduler

```c
aclError aclrtMallocForTaskScheduler(void **devPtr, size_t size, aclrtMemMallocPolicy policy, aclrtMallocConfig *cfg)
```

### Applicable Products

<!-- npu="950" id2381 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2381 -->
<!-- npu="A3" id2382 -->
- Atlas A3 products: Supported
<!-- end id2382 -->
<!-- npu="910b" id2383 -->
- Atlas A2 products: Supported
<!-- end id2383 -->
<!-- npu="310b" id2384 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2384 -->
<!-- npu="310p" id2385 -->
- Atlas inference products: Supported
<!-- end id2385 -->
<!-- npu="910" id2386 -->
- Atlas training products: Supported
<!-- end id2386 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-01_device_memory_malloc_and_free_res.md#id5 -->

### Description

Allocates memory that can be used by the Task Scheduler on the AI Processor.

In graph mode, some operators require this type of memory.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| devPtr | Output | Pointer to the pointer of the allocated memory on the device. |
| size | Input | Size of the memory to be allocated, in bytes.<br>The value of size cannot be 0. |
| policy | Input | Memory allocation policy. For the type definition, see [aclrtMemMallocPolicy](25-02_Enumerations.md#aclrtMemMallocPolicy).<br>If the configured memory allocation policy exceeds the value range of [aclrtMemMallocPolicy](25-02_Enumerations.md#aclrtMemMallocPolicy), memory is allocated by large pages when size ≥ 2 MB; otherwise, memory is allocated by normal pages. |
| cfg | Input | Memory configuration information. For the type definition, see [aclrtMallocConfig](25-04_Structs.md#aclrtMallocConfig).<br>If no configuration is specified, NULL can be passed here. |

### Return Values

Returns 0 on success and other values on failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtFree"></a>

## aclrtFree

```c
aclError aclrtFree(void *devPtr)
```

### Applicable Products

<!-- npu="950" id323 -->
- Ascend 950PR&950DT products: Supported
<!-- end id323 -->
<!-- npu="A3" id324 -->
- Atlas A3 products: Supported
<!-- end id324 -->
<!-- npu="910b" id325 -->
- Atlas A2 products: Supported
<!-- end id325 -->
<!-- npu="310b" id326 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id326 -->
<!-- npu="310p" id327 -->
- Atlas inference products: Supported
<!-- end id327 -->
<!-- npu="910" id328 -->
- Atlas training products: Supported
<!-- end id328 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-01_device_memory_malloc_and_free_res.md#id6 -->

### Description

Frees memory on the device.

This API immediately frees the passed-in memory. It does not perform implicit device synchronization or stream synchronization internally, nor does it wait for tasks that are using the memory to complete. The user must ensure that the memory pointer is no longer accessed after this API is called.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| `devPtr` | Input | Pointer to the memory to be freed.<br>If `devPtr` is a null pointer, this API returns an error. |

### Return Values

Returns 0 on success and other values on failure. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

The [aclrtFree](#aclrtFree) API can only free the device memory allocated by Runtime APIs such as [aclrtMalloc](#aclrtMalloc) and [aclrtMallocAlign32](#aclrtMallocAlign32).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtFreeWithDevSync"></a>

## aclrtFreeWithDevSync

```c
aclError aclrtFreeWithDevSync(void *devPtr)
```

### Applicable Products

<!-- npu="950" id1100 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1100 -->
<!-- npu="A3" id1101 -->
- Atlas A3 products: Supported
<!-- end id1101 -->
<!-- npu="910b" id1102 -->
- Atlas A2 products: Supported
<!-- end id1102 -->
<!-- npu="310b" id1103 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1103 -->
<!-- npu="310p" id1104 -->
- Atlas inference products: Supported
<!-- end id1104 -->
<!-- npu="910" id1105 -->
- Atlas training products: Supported
<!-- end id1105 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-01_device_memory_malloc_and_free_res.md#id7 -->

### Description

Frees memory on the device.

This API performs implicit device synchronization internally and waits for the tasks that use the memory to complete.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| devPtr | Input | Pointer to the memory to be freed.<br>If `devPtr` is a null pointer, this API returns an error. |

### Return Values

Returns 0 on success and other values on failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtGetMemInfo"></a>

## aclrtGetMemInfo

```c
aclError aclrtGetMemInfo(aclrtMemAttr attr, size_t *free, size_t *total)
```

### Applicable Products

<!-- npu="950" id463 -->
- Ascend 950PR&950DT products: Supported
<!-- end id463 -->
<!-- npu="A3" id464 -->
- Atlas A3 products: Supported
<!-- end id464 -->
<!-- npu="910b" id465 -->
- Atlas A2 products: Supported
<!-- end id465 -->
<!-- npu="310b" id466 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id466 -->
<!-- npu="310p" id467 -->
- Atlas inference products: Supported
<!-- end id467 -->
<!-- npu="910" id468 -->
- Atlas training products: Supported
<!-- end id468 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-01_device_memory_malloc_and_free_res.md#id8 -->

### Description

Obtains the free size and total size of available memory on the device based on the specified attributes, excluding the system-reserved memory size.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| attr | Input | Attribute value of the memory to be queried. For the type definition, see [aclrtMemAttr](25-02_Enumerations.md#aclrtMemAttr). |
| free | Output | Pointer to the free memory size of the corresponding attribute, in bytes. |
| total | Output | Pointer to the total memory size of the corresponding attribute, in bytes. |

### Return Values

Returns 0 on success and other values on failure. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

- Before calling this API, you must specify the device used for computation (for example, call the aclrtSetDevice API to specify the device used for computation). Therefore, the device ID is not reflected in this API.
- Select the appropriate memory attributes based on the actual hardware support. Otherwise, both the free size and total size obtained through this API will be 0. If the hardware does not support HBM memory, when querying HBM memory information, the API automatically converts the query to DDR memory information. For example, when querying ACL\_HBM\_MEM, the API actually queries ACL\_DDR\_MEM.

<br>
<br>
<br>

<a class="method_anchor" id="aclrtGetMemUsageInfo"></a>

## aclrtGetMemUsageInfo

```c
aclError aclrtGetMemUsageInfo(int32_t deviceId, aclrtMemUsageInfo *memUsageInfo, size_t inputNum, size_t *outputNum)
```

### Applicable Products

<!-- npu="950" id85 -->
- Ascend 950PR&950DT products: Not supported
<!-- end id85 -->
<!-- npu="A3" id86 -->
- Atlas A3 products: Supported
<!-- end id86 -->
<!-- npu="910b" id87 -->
- Atlas A2 products: Supported
<!-- end id87 -->
<!-- npu="310b" id88 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id88 -->
<!-- npu="310p" id89 -->
- Atlas inference products: Supported
<!-- end id89 -->
<!-- npu="910" id90 -->
- Atlas training products: Supported
<!-- end id90 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-01_device_memory_malloc_and_free_res.md#id9 -->

### Description

Queries the memory usage information of a component, including the component name, current memory size, and peak memory size.

### Parameters

| Parameter Name | Input/Output | Description |
| --- | :---: | --- |
| deviceId | Input | Device ID.<br>After the user calls [aclrtGetDeviceCount](04_device_management.md#aclrtGetDeviceCount) to obtain the number of available devices, the value range of this device ID is [0, (number of available devices - 1)]. |
| memUsageInfo | Input & Output | Array of memory usage information. For the type definition, see [aclrtMemUsageInfo](25-04_Structs.md#aclrtMemUsageInfo).<br>When this parameter is used as an input, the user passes a pointer to the aclrtMemUsageInfo structure, and its memory size must be sufficient to store the memory usage information of inputNum components.<br>When this parameter is used as an output, information such as the component name, current memory size, and peak memory size can be obtained. The elements in the memUsageInfo array are sorted in descending order by current memory usage. |
| inputNum | Input | Specifies the number of components to be queried.<br>If the actual number of components is less than inputNum, the query is performed based on the actual number of components. |
| outputNum | Output | Actual number of components queried. |

### Return Values

Returns 0 on success and other values on failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtCheckMemType"></a>

## aclrtCheckMemType

```c
aclError aclrtCheckMemType(void** addrList, uint32_t size, uint32_t memType, uint32_t *checkResult, uint32_t reserve)
```

### Applicable Products

<!-- npu="950" id2668 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2668 -->
<!-- npu="A3" id2669 -->
- Atlas A3 products: Supported
<!-- end id2669 -->
<!-- npu="910b" id2670 -->
- Atlas A2 products: Supported
<!-- end id2670 -->
<!-- npu="310b" id2671 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2671 -->
<!-- npu="310p" id2672 -->
- Atlas inference products: Supported
<!-- end id2672 -->
<!-- npu="910" id2673 -->
- Atlas training products: Supported
<!-- end id2673 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-01_device_memory_malloc_and_free_res.md#id10 -->

### Description

Checks the device memory type.

<!-- npu="950" id39 -->
In Ascend 950PR&950DT products, there is no longer a separate DVPP device memory type (ACL\_RT\_MEM\_TYPE\_DVPP); instead, it is processed as normal device memory.
<!-- end id39 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-01_device_memory_malloc_and_free_res.md#id18 -->

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| addrList | Input | Array of device memory addresses. |
| size | Input | Size of the addrList array. |
| memType | Input | Device memory type. If the addrList array contains memory addresses of multiple different types, memType must be configured as the bitwise OR of the multiple memory types, for example: ACL_RT_MEM_TYPE_DEV \| ACL_RT_MEM_TYPE_DVPP <br><br>The following macros are currently supported:<br>  - ACL_RT_MEM_TYPE_DEV: indicates device memory allocated by calling APIs such as [aclrtMalloc](11-01_device_memory_malloc_and_free.md#aclrtMalloc) and [aclrtMallocWithCfg](11-01_device_memory_malloc_and_free.md#aclrtMallocWithCfg).<br>  - ACL_RT_MEM_TYPE_DVPP: indicates device memory dedicated to DVPP, which can be allocated by calling the relevant memory allocation APIs (for example, hi_mpi_dvpp_malloc). In Ascend 950PR&950DT products, there is no longer a separate DVPP device memory type; it is treated as ordinary device memory.<br>  - ACL_RT_MEM_TYPE_RSVD: indicates virtual memory reserved by calling the [aclrtReserveMemAddress](11-04_virtual_memory_management.md#aclrtReserveMemAddress) API.<br><br><br>The macro definitions are as follows:<br>#define ACL_RT_MEM_TYPE_DEV  (0X2U)<br>#define ACL_RT_MEM_TYPE_DVPP  (0X8U)<br>#define ACL_RT_MEM_TYPE_RSVD  (0X10U) |
| checkResult | Output | Checks whether the memory address types in the addrList array match memType. 1 indicates a match, and 0 indicates a mismatch. |
| reserve | Input | Reserved parameter, which is fixed to 0. |

### Return Values

Returns 0 on success and other values on failure. For details, see [aclError](25-01_aclError.md#aclError).

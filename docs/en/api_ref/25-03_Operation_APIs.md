# Operation APIs

<!-- md-trans-meta sourceCommit=2f8767a8ea410c0e1fd4474732451a0c69efd6b1 translatedAt=2026-10-26T12:59:28.918Z pushedAt=2026-10-29T06:18:37.736Z -->

This topic provides the APIs for operating data types, including **create**, **set**, **get**, and **destroy**.

<br>

- [aclDataBuffer](#aclDataBuffer)
    - [aclCreateDataBuffer](#aclCreateDataBuffer)
    - [aclDestroyDataBuffer](#aclDestroyDataBuffer)
    - [aclGetDataBufferAddr](#aclGetDataBufferAddr)
    - [aclGetDataBufferSize (Deprecated)](#aclGetDataBufferSize)
    - [aclGetDataBufferSizeV2](#aclGetDataBufferSizeV2)
    - [aclUpdateDataBuffer](#aclUpdateDataBuffer)
- [aclprofConfig](#aclprofConfig)
    - [aclprofCreateConfig](#aclprofCreateConfig)
    - [aclprofDestroyConfig](#aclprofDestroyConfig)
- [aclprofStepInfo](#aclprofStepInfo)
    - [aclprofCreateStepInfo](#aclprofCreateStepInfo)
    - [aclprofDestroyStepInfo](#aclprofDestroyStepInfo)
- [aclprofSubscribeConfig](#aclprofSubscribeConfig)
    - [aclprofCreateSubscribeConfig](#aclprofCreateSubscribeConfig)
    - [aclprofDestroySubscribeConfig](#aclprofDestroySubscribeConfig)
- [aclrtAllocatorDesc](#aclrtAllocatorDesc)
    - [aclrtAllocatorCreateDesc](#aclrtAllocatorCreateDesc)
    - [aclrtAllocatorDestroyDesc](#aclrtAllocatorDestroyDesc)
    - [aclrtAllocatorSetObjToDesc](#aclrtAllocatorSetObjToDesc)
    - [aclrtAllocatorSetAllocFuncToDesc](#aclrtAllocatorSetAllocFuncToDesc)
    - [aclrtAllocatorSetAllocAdviseFuncToDesc](#aclrtAllocatorSetAllocAdviseFuncToDesc)
    - [aclrtAllocatorSetFreeFuncToDesc](#aclrtAllocatorSetFreeFuncToDesc)
    - [aclrtAllocatorSetGetAddrFromBlockFuncToDesc](#aclrtAllocatorSetGetAddrFromBlockFuncToDesc)
- [aclrtStreamConfigHandle](#aclrtStreamConfigHandle)
    - [aclrtCreateStreamConfigHandle](#aclrtCreateStreamConfigHandle)
    - [aclrtDestroyStreamConfigHandle](#aclrtDestroyStreamConfigHandle)
- [acltdtDataItem](#acltdtDataItem)
    - [acltdtCreateDataItem](#acltdtCreateDataItem)
    - [acltdtDestroyDataItem](#acltdtDestroyDataItem)
    - [acltdtGetTensorTypeFromItem](#acltdtGetTensorTypeFromItem)
    - [acltdtGetDataTypeFromItem](#acltdtGetDataTypeFromItem)
    - [acltdtGetDataAddrFromItem](#acltdtGetDataAddrFromItem)
    - [acltdtGetDataSizeFromItem](#acltdtGetDataSizeFromItem)
    - [acltdtGetDimNumFromItem](#acltdtGetDimNumFromItem)
    - [acltdtGetDimsFromItem](#acltdtGetDimsFromItem)
- [acltdtDataset](#acltdtDataset)
    - [acltdtCreateDataset](#acltdtCreateDataset)
    - [acltdtDestroyDataset](#acltdtDestroyDataset)
    - [acltdtGetDataItem](#acltdtGetDataItem)
    - [acltdtAddDataItem](#acltdtAddDataItem)
    - [acltdtGetDatasetSize](#acltdtGetDatasetSize)
    - [acltdtGetDatasetName](#acltdtGetDatasetName)
- [acltdtQueueAttr](#acltdtQueueAttr)
    - [acltdtCreateQueueAttr](#acltdtCreateQueueAttr)
    - [acltdtDestroyQueueAttr](#acltdtDestroyQueueAttr)
    - [acltdtSetQueueAttr](#acltdtSetQueueAttr)
    - [acltdtGetQueueAttr](#acltdtGetQueueAttr)
- [acltdtQueueRoute](#acltdtQueueRoute)
    - [acltdtCreateQueueRoute](#acltdtCreateQueueRoute)
    - [acltdtDestroyQueueRoute](#acltdtDestroyQueueRoute)
    - [acltdtGetQueueRouteParam](#acltdtGetQueueRouteParam)
- [acltdtQueueRouteList](#acltdtQueueRouteList)
    - [acltdtCreateQueueRouteList](#acltdtCreateQueueRouteList)
    - [acltdtDestroyQueueRouteList](#acltdtDestroyQueueRouteList)
    - [acltdtAddQueueRoute](#acltdtAddQueueRoute)
    - [acltdtGetQueueRoute](#acltdtGetQueueRoute)
    - [acltdtGetQueueRouteNum](#acltdtGetQueueRouteNum)
- [acltdtQueueRouteQueryInfo](#acltdtQueueRouteQueryInfo)
    - [acltdtCreateQueueRouteQueryInfo](#acltdtCreateQueueRouteQueryInfo)
    - [acltdtDestroyQueueRouteQueryInfo](#acltdtDestroyQueueRouteQueryInfo)
    - [acltdtSetQueueRouteQueryInfo](#acltdtSetQueueRouteQueryInfo)

<br>

<a class="method_anchor" id="aclDataBuffer"></a>

## aclDataBuffer

- **[aclCreateDataBuffer](#aclCreateDataBuffer)**

- **[aclDestroyDataBuffer](#aclDestroyDataBuffer)**

- **[aclGetDataBufferAddr](#aclGetDataBufferAddr)**

- **[aclGetDataBufferSize (Deprecated)](#aclGetDataBufferSize)**

- **[aclGetDataBufferSizeV2](#aclGetDataBufferSizeV2)**

- **[aclUpdateDataBuffer](#aclUpdateDataBuffer)**

<br>

<a class="method_anchor" id="aclCreateDataBuffer"></a>

## aclCreateDataBuffer

```c
aclDataBuffer *aclCreateDataBuffer(void *data, size_t size)
```

### Applicable Products

<!-- npu="950" id3459 -->
- Ascend 950PR&950DT products: Supported
<!-- end id3459 -->
<!-- npu="A3" id3460 -->
- Atlas A3 products: Supported
<!-- end id3460 -->
<!-- npu="910b" id3461 -->
- Atlas A2 products: Supported
<!-- end id3461 -->
<!-- npu="310b" id3462 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id3462 -->
<!-- npu="310p" id3463 -->
- Atlas inference products: Supported
<!-- end id3463 -->
<!-- npu="910" id3464 -->
- Atlas training products: Supported
<!-- end id3464 -->
<!-- @ref: runtime/res/docs/zh/api_ref/25-03_Operation_APIs_res.md#id1 -->

### Description

Creates data of the **aclDataBuffer** type, which is used to describe memory information such as the memory address and size.

To destroy data of the **aclDataBuffer** type, use [aclDestroyDataBuffer](#aclDestroyDataBuffer).

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| data | Input | Pointer to the memory address where the data is stored. The **data** parameter supports passing **nullptr**, which indicates creation of an empty data type. In this case, the **size** parameter must be set to **0**.<br>This memory must be managed by the user. Call [aclrtMalloc](11-01_device_memory_malloc_and_free.md#aclrtMalloc)/[aclrtFree](11-01_device_memory_malloc_and_free.md#aclrtFree) to request/free memory, or call [aclrtMallocHost](11-02_host_memory_management.md#aclrtMallocHost)/[aclrtFreeHost](11-02_host_memory_management.md#aclrtFreeHost) to request/free memory. |
| size | Input | Memory size, in bytes.<br>If the user needs to use an empty tensor, the minimum memory size is 1 byte when the memory is requested, to ensure normal subsequent service operation. |

### Return Values

Returns a pointer of the data of the **aclDataBuffer** type.

<br>

<a class="method_anchor" id="aclDestroyDataBuffer"></a>

## aclDestroyDataBuffer

```c
aclError aclDestroyDataBuffer(const aclDataBuffer *dataBuffer)
```

### Applicable Products

<!-- npu="950" id2003 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2003 -->
<!-- npu="A3" id2004 -->
- Atlas A3 products: Supported
<!-- end id2004 -->
<!-- npu="910b" id2005 -->
- Atlas A2 products: Supported
<!-- end id2005 -->
<!-- npu="310b" id2006 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2006 -->
<!-- npu="310p" id2007 -->
- Atlas inference products: Supported
<!-- end id2007 -->
<!-- npu="910" id2008 -->
- Atlas training products: Supported
<!-- end id2008 -->
<!-- @ref: runtime/res/docs/zh/api_ref/25-03_Operation_APIs_res.md#id2 -->

### Description

Destroys the data of the **aclDataBuffer** type created via the [aclCreateDataBuffer](#aclCreateDataBuffer) API.

Only the data of the **aclDataBuffer** type is destroyed here. The memory of **data** passed in when the [aclCreateDataBuffer](#aclCreateDataBuffer) API is called to create the data of the **aclDataBuffer** type must be freed by the user.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| dataBuffer | Input | Pointer of the data of the **aclDataBuffer** type to be destroyed. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>

<a class="method_anchor" id="aclGetDataBufferAddr"></a>

## aclGetDataBufferAddr

```c
void *aclGetDataBufferAddr(const aclDataBuffer *dataBuffer)
```

### Applicable Products

<!-- npu="950" id3319 -->
- Ascend 950PR&950DT products: Supported
<!-- end id3319 -->
<!-- npu="A3" id3320 -->
- Atlas A3 products: Supported
<!-- end id3320 -->
<!-- npu="910b" id3321 -->
- Atlas A2 products: Supported
<!-- end id3321 -->
<!-- npu="310b" id3322 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id3322 -->
<!-- npu="310p" id3323 -->
- Atlas inference products: Supported
<!-- end id3323 -->
<!-- npu="910" id3324 -->
- Atlas training products: Supported
<!-- end id3324 -->
<!-- @ref: runtime/res/docs/zh/api_ref/25-03_Operation_APIs_res.md#id3 -->

### Description

Obtains the memory address of the data of the **aclDataBuffer** type.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| dataBuffer | Input | Pointer of the data of the **aclDataBuffer** type.<br>Call [aclCreateDataBuffer](#aclCreateDataBuffer) in advance to create data of the **aclDataBuffer** type. |

### Return Values

Returns the memory address of the data of the **aclDataBuffer** type.

<br>

<a class="method_anchor" id="aclGetDataBufferSize"></a>

## aclGetDataBufferSize (Deprecated)

```c
uint32_t aclGetDataBufferSize(const aclDataBuffer *dataBuffer)
```

**Caution: This API will be deprecated in later versions. Use [aclGetDataBufferSizeV2](#aclGetDataBufferSizeV2) instead.**

### Applicable Products

<!-- npu="950" id3158 -->
- Ascend 950PR&950DT products: Supported
<!-- end id3158 -->
<!-- npu="A3" id3159 -->
- Atlas A3 products: Supported
<!-- end id3159 -->
<!-- npu="910b" id3160 -->
- Atlas A2 products: Supported
<!-- end id3160 -->
<!-- npu="310b" id3161 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id3161 -->
<!-- npu="310p" id3162 -->
- Atlas inference products: Supported
<!-- end id3162 -->
<!-- npu="910" id3163 -->
- Atlas training products: Supported
<!-- end id3163 -->
<!-- @ref: runtime/res/docs/zh/api_ref/25-03_Operation_APIs_res.md#id4 -->

### Description

Obtains the memory size of the data of the **aclDataBuffer** type, in bytes.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| dataBuffer | Input | Pointer of the data of the **aclDataBuffer** type.<br>Call [aclCreateDataBuffer](#aclCreateDataBuffer) in advance to create data of the **aclDataBuffer** type. |

### Return Values

Returns the memory size of the data of the **aclDataBuffer** type.

<br>

<a class="method_anchor" id="aclGetDataBufferSizeV2"></a>

## aclGetDataBufferSizeV2

```c
size_t aclGetDataBufferSizeV2(const aclDataBuffer *dataBuffer)
```

### Applicable Products

<!-- npu="950" id1597 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1597 -->
<!-- npu="A3" id1598 -->
- Atlas A3 products: Supported
<!-- end id1598 -->
<!-- npu="910b" id1599 -->
- Atlas A2 products: Supported
<!-- end id1599 -->
<!-- npu="310b" id1600 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1600 -->
<!-- npu="310p" id1601 -->
- Atlas inference products: Supported
<!-- end id1601 -->
<!-- npu="910" id1602 -->
- Atlas training products: Supported
<!-- end id1602 -->
<!-- @ref: runtime/res/docs/zh/api_ref/25-03_Operation_APIs_res.md#id5 -->

### Description

Obtains the memory size of the data of the **aclDataBuffer** type, in bytes.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| dataBuffer | Input | Pointer of the data of the **aclDataBuffer** type.<br>Call [aclCreateDataBuffer](#aclCreateDataBuffer) in advance to create data of the **aclDataBuffer** type. |

### Return Values

Returns the memory size of the data of the **aclDataBuffer** type.

<br>

<a class="method_anchor" id="aclUpdateDataBuffer"></a>

## aclUpdateDataBuffer

```c
aclError aclUpdateDataBuffer(aclDataBuffer *dataBuffer, void *data, size_t size)
```

### Applicable Products

<!-- npu="950" id2535 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2535 -->
<!-- npu="A3" id2536 -->
- Atlas A3 products: Supported
<!-- end id2536 -->
<!-- npu="910b" id2537 -->
- Atlas A2 products: Supported
<!-- end id2537 -->
<!-- npu="310b" id2538 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2538 -->
<!-- npu="310p" id2539 -->
- Atlas inference products: Supported
<!-- end id2539 -->
<!-- npu="910" id2540 -->
- Atlas training products: Supported
<!-- end id2540 -->
<!-- @ref: runtime/res/docs/zh/api_ref/25-03_Operation_APIs_res.md#id6 -->

### Description

Updates the memory and size of the data of the **aclDataBuffer** type.

After **aclDataBuffer** is updated, if the memory that previously stored data in **aclDataBuffer** is no longer used, it must be released in a timely manner; otherwise, a memory leak may occur.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| dataBuffer | Input | Pointer of the data of the **aclDataBuffer** type.<br>Call [aclCreateDataBuffer](#aclCreateDataBuffer) in advance to create data of the **aclDataBuffer** type.<br>This memory must be managed by the user. Call [aclrtMalloc](11-01_device_memory_malloc_and_free.md#aclrtMalloc) / [aclrtFree](11-01_device_memory_malloc_and_free.md#aclrtFree) to request/free memory, or call [aclrtMallocHost](11-02_host_memory_management.md#aclrtMallocHost) / [aclrtFreeHost](11-02_host_memory_management.md#aclrtFreeHost) to request/free memory. |
| data | Input | Pointer to the memory address where the data is stored. |
| size | Input | Memory size, in bytes.<br>If an empty tensor is required, the minimum memory size to request is 1 byte to ensure subsequent services run properly. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>

<a class="method_anchor" id="aclprofConfig"></a>

## aclprofConfig

- **[aclprofCreateConfig](#aclprofCreateConfig)**

- **[aclprofDestroyConfig](#aclprofDestroyConfig)**

<br>

<a class="method_anchor" id="aclprofCreateConfig"></a>

## aclprofCreateConfig

```c
aclprofConfig *aclprofCreateConfig(uint32_t *deviceIdList, uint32_t deviceNums, aclprofAicoreMetrics aicoreMetrics, const aclprofAicoreEvents *aicoreEvents, uint64_t dataTypeConfig)
```

### Applicable Products

<!-- npu="950" id2724 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2724 -->
<!-- npu="A3" id2725 -->
- Atlas A3 products: Supported
<!-- end id2725 -->
<!-- npu="910b" id2726 -->
- Atlas A2 products: Supported
<!-- end id2726 -->
<!-- npu="310b" id2727 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2727 -->
<!-- npu="310p" id2728 -->
- Atlas inference products: Supported
<!-- end id2728 -->
<!-- npu="910" id2729 -->
- Atlas training products: Supported
<!-- end id2729 -->
<!-- @ref: runtime/res/docs/zh/api_ref/25-03_Operation_APIs_res.md#id44 -->

### Description

Creates data of the **aclprofConfig** type, which indicates creation of profiling configuration data.

Data of the **aclprofConfig** type can be created once and used in multiple places. The user must ensure data consistency and accuracy.

To destroy data of the **aclprofConfig** type, use [aclprofDestroyConfig](#aclprofDestroyConfig).

### Constraints

- Use the **aclprofDestroyConfig** API to destroy data of the **aclprofConfig** type. If not destroyed, memory will not be released.

- This API is paired with [aclprofDestroyConfig](#aclprofDestroyConfig). Call **aclprofCreateConfig** first and then **aclprofDestroyConfig**.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| deviceIdList | Input | Device ID list. It must be set based on the device IDs in the actual environment.|
| deviceNums | Input | Number of devices. The user must ensure that the number of devices in **deviceIdList** is consistent with the value of the **deviceNums** parameter; otherwise, subsequent service exceptions may occur. |
| aicoreMetrics | Input | AI Core performance metric collection item. For details, see [aclprofAicoreMetrics](25-02_Enumerations.md#aclprofAicoreMetrics). |
| aicoreEvents | Input | AI Core events, which is set to **NULL** currently. |
| dataTypeConfig | Input | Data type configuration. The user selects multiple macros for logical OR (for example, **ACL_PROF_ACL_API \| ACL_PROF_AICORE_METRICS**) as the value of the **dataTypeConfig** parameter. Each macro indicates a type of performance data. The details are as follows:<br><br>  - **ACL_PROF_ACL_API**: collects API performance data, including synchronous and asynchronous memory copy latency between the host and device and between devices.<br>  - **ACL_PROF_TASK_TIME**: collects operator dispatch latency, operator execution latency data, and basic operator information data, providing more comprehensive performance analysis data.<br>  - **ACL_PROF_TASK_TIME_L0**: collects operator dispatch latency and operator execution latency data. Compared with **ACL_PROF_TASK_TIME** and **ACL_PROF_TASK_TIME_L2**, since basic operator information data is not collected, the performance overhead during collection is smaller, allowing more accurate statistics of the related latency data.<br>  - **ACL_PROF_TASK_TIME_L2**: collects operator dispatch latency, operator execution latency data, and basic operator information data (including **attr**), providing more comprehensive performance analysis data.<br>  - **ACL_PROF_GE_API_L0**: collects latency data of the main stages of dynamic shape operator scheduling on the host, allowing more accurate statistics of the related latency data.<br>  - **ACL_PROF_GE_API_L1**: collects finer-grained latency data of dynamic shape operator scheduling on the host, providing more comprehensive performance analysis data.<br>  - **ACL_PROF_OP_ATTR**: controls collection of operator attribute information. Currently only aclnn operators are supported.<br>  - **ACL_PROF_AICORE_METRICS**: collects AI Core performance metric data. This macro must be included in the logical OR; otherwise, the performance metric collection item configured in the **aicoreMetrics** input parameter is invalid.<br>  - **ACL_PROF_TASK_MEMORY**: controls the switch for collecting memory usage of CANN operators, used to optimize memory usage. In the single-operator scenario, operator memory size and lifecycle information are collected by GE component dimension and operator dimension (in the single-operator API execution mode, GE component memory is not collected). In the static graph and static subgraph scenarios, operator memory size and lifecycle information are collected by operator dimension during the operator compilation phase.<br>  - **ACL_PROF_AICPU**: collects AI CPU task start and end data.<br>  - **ACL_PROF_L2CACHE**: collects L2 Cache data and TLB page table cache hit rates.<br>  - **ACL_PROF_HCCL_TRACE**: controls the switch for communication data collection.<br>  - **ACL_PROF_MSPROFTX**: obtains performance data output by users and upper-layer framework programs. Within the collection process (between the **aclprofStart** and **aclprofStop** APIs), the msproftx extension API or the mstx API can be called to enable recording of the time span of specific events during application execution, write the data to a performance data file, and then use the msprof tool to parse the file and export the performance analysis data for display.<br>  - **ACL_PROF_TRAINING_TRACE**: controls the switch for iteration trace data collection. When the **ACL_PROF_TASK_TIME** switch is enabled, the tool enables this switch by default.<br>  - **ACL_PROF_RUNTIME_API**: controls the switch for runtime API performance data collection.<br>  - **ACL_PROF_API_STATS**: controls the statistics switch for acl APIs. After this switch is enabled, profiling enables the online analysis mode to collect statistics on acl API performance data. In this mode, other switches are invalid.<br/>  - **ACL_PROF_AICORE_SHAPE**: controls the switch for collecting shape data of CANN-layer operators. **ACL_PROF_TASK_TIME_L0** must be configured. |

<!-- @ref: runtime/res/docs/zh/api_ref/25-03_Operation_APIs_res.md#id51 -->

### Return Values

- Returns a pointer of the data of the **aclprofConfig** type, which indicates success.
- Returns **nullptr**, which indicates failure.

<br>

<a class="method_anchor" id="aclprofDestroyConfig"></a>

## aclprofDestroyConfig

```c
aclError aclprofDestroyConfig(const aclprofConfig *profilerConfig)
```

### Applicable Products

<!-- npu="950" id211 -->
- Ascend 950PR&950DT products: Supported
<!-- end id211 -->
<!-- npu="A3" id212 -->
- Atlas A3 products: Supported
<!-- end id212 -->
<!-- npu="910b" id213 -->
- Atlas A2 products: Supported
<!-- end id213 -->
<!-- npu="310b" id214 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id214 -->
<!-- npu="310p" id215 -->
- Atlas inference products: Supported
<!-- end id215 -->
<!-- npu="910" id216 -->
- Atlas training products: Supported
<!-- end id216 -->
<!-- @ref: runtime/res/docs/zh/api_ref/25-03_Operation_APIs_res.md#id45 -->
### Description

Destroys data of the **aclprofConfig** type created via the [aclprofCreateConfig](#aclprofCreateConfig) API.

### Constraints

- This API is used in pairing with the [aclprofCreateConfig](#aclprofCreateConfig) API. Call **aclprofCreateConfig** first, and then call **aclprofDestroyConfig**.
- Repeatedly calling **aclprofDestroyConfig** on the same **aclprofConfig** pointer may cause repeated memory release errors.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| profilerConfig | Input | Pointer of the data of the **aclprofConfig** type to be destroyed. For details about the type definition, see [aclprofConfig](#aclprofConfig). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>

<a class="method_anchor" id="aclprofStepInfo"></a>

## aclprofStepInfo

- **[aclprofCreateStepInfo](#aclprofCreateStepInfo)**

- **[aclprofDestroyStepInfo](#aclprofDestroyStepInfo)**

<br>

<a class="method_anchor" id="aclprofCreateStepInfo"></a>

## aclprofCreateStepInfo

```c
aclprofStepInfo* aclprofCreateStepInfo()
```

### Applicable Products

<!-- npu="950" id1863 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1863 -->
<!-- npu="A3" id1864 -->
- Atlas A3 products: Supported
<!-- end id1864 -->
<!-- npu="910b" id1865 -->
- Atlas A2 products: Supported
<!-- end id1865 -->
<!-- npu="310b" id1866 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1866 -->
<!-- npu="310p" id1867 -->
- Atlas inference products: Supported
<!-- end id1867 -->
<!-- npu="910" id1868 -->
- Atlas training products: Supported
<!-- end id1868 -->
<!-- @ref: runtime/res/docs/zh/api_ref/25-03_Operation_APIs_res.md#id46 -->

### Description

Creates an **aclprofStepInfo** object to describe iteration information.

### Constraints

- Use **aclprofDestroyStepInfo** to destroy data of the **aclprofStepInfo** type. If not destroyed, it may cause memory not released.
- This API is used in pairing with [aclprofDestroyStepInfo](#aclprofDestroyStepInfo). Call **aclprofCreateStepInfo** first, and then call **aclprofDestroyStepInfo**.

### Return Value

- Returns a pointer of the data of the **aclprofStepInfo** type, indicating success.
- Returns **nullptr**, indicating failure.

> **Note:**
> The same **aclprofStepInfo** object and the same **tag** can be set only once; otherwise, profiling parsing will fail.

<br>

<a class="method_anchor" id="aclprofDestroyStepInfo"></a>

## aclprofDestroyStepInfo

```c
void aclprofDestroyStepInfo(aclprofStepInfo* stepinfo)
```

### Applicable Products

<!-- npu="950" id351 -->
- Ascend 950PR&950DT products: Supported
<!-- end id351 -->
<!-- npu="A3" id352 -->
- Atlas A3 products: Supported
<!-- end id352 -->
<!-- npu="910b" id353 -->
- Atlas A2 products: Supported
<!-- end id353 -->
<!-- npu="310b" id354 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id354 -->
<!-- npu="310p" id355 -->
- Atlas inference products: Supported
<!-- end id355 -->
<!-- npu="910" id356 -->
- Atlas training products: Supported
<!-- end id356 -->
<!-- @ref: runtime/res/docs/zh/api_ref/25-03_Operation_APIs_res.md#id47 -->

### Description

Destroys data of the **aclprofStepInfo** type created via the [aclprofCreateStepInfo](#aclprofCreateStepInfo) API.

### Constraints

- This API is paired with [aclprofCreateStepInfo](#aclprofCreateStepInfo). Call **aclprofCreateStepInfo** first, and then call **aclprofDestroyStepInfo**.
- Repeatedly calling **aclprofDestroyStepInfo** on the same **aclprofStepInfo** data may cause repeated memory release errors.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| stepinfo | Input | Iteration information. Call [aclprofCreateStepInfo](#aclprofCreateStepInfo) in advance to create data of the [aclprofStepInfo](#aclprofStepInfo) type. |

<br>

<a class="method_anchor" id="aclprofSubscribeConfig"></a>

## aclprofSubscribeConfig

- **[aclprofCreateSubscribeConfig](#aclprofCreateSubscribeConfig)**

- **[aclprofDestroySubscribeConfig](#aclprofDestroySubscribeConfig)**

<br>

<a class="method_anchor" id="aclprofCreateSubscribeConfig"></a>

## aclprofCreateSubscribeConfig

```c
aclprofSubscribeConfig *aclprofCreateSubscribeConfig(int8_t timeInfoSwitch, aclprofAicoreMetrics aicoreMetrics, void *fd)
```

### Applicable Products

<!-- npu="950" id43 -->
- Ascend 950PR&950DT products: Supported
<!-- end id43 -->
<!-- npu="A3" id44 -->
- Atlas A3 products: Supported
<!-- end id44 -->
<!-- npu="910b" id45 -->
- Atlas A2 products: Supported
<!-- end id45 -->
<!-- npu="310b" id46 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id46 -->
<!-- npu="310p" id47 -->
- Atlas inference products: Supported
<!-- end id47 -->
<!-- npu="910" id48 -->
- Atlas training products: Supported
<!-- end id48 -->
<!-- @ref: runtime/res/docs/zh/api_ref/25-03_Operation_APIs_res.md#id48 -->
### Description

Creates data of the **aclprofSubscribeConfig** type, which indicates creation of subscription configuration information.

To destroy data of the **aclprofSubscribeConfig** type, use [aclprofDestroySubscribeConfig](#aclprofDestroySubscribeConfig).

### Constraints

- Use the **aclprofDestroySubscribeConfig** API to destroy data of the **aclprofSubscribeConfig** type. If not destroyed, memory will not be released.

- This API is used in pairing with [aclprofDestroySubscribeConfig](#aclprofDestroySubscribeConfig). Call **aclprofCreateSubscribeConfig** first, and then call **aclprofDestroySubscribeConfig**.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| timeInfoSwitch | Input | Whether to collect the performance data of operators in the network model. The value options are as follows:<br><br>  - **1**: collect<br>  - **0**: not collect<br><br>For details about the type definition, see [aclprofSubscribeConfig](#aclprofSubscribeConfig) and [aclprofAicoreMetrics](25-02_Enumerations.md#aclprofAicoreMetrics). |
| aicoreMetrics | Input | AI Core performance metric collection item.<br>  Description: The subscription API currently provides only operator latency statistics and does not support the **AicoreMetrics** collection feature.<br>For values, see [aclprofAicoreMetrics](25-02_Enumerations.md#aclprofAicoreMetrics). |
| fd | Input | Write pointer of the pipe created by the user.<br>After the user calls the **aclprofModelUnSubscribe** API, the system closes the write pointer of the pipe for this model after data transmission ends. |

### Return Values

- Returns a pointer of the data of the **aclprofSubscribeConfig** type, which indicates success.
- Returns **nullptr**, which indicates failure.

<br>

<a class="method_anchor" id="aclprofDestroySubscribeConfig"></a>

## aclprofDestroySubscribeConfig

```c
aclError aclprofDestroySubscribeConfig(const aclprofSubscribeConfig *profSubscribeConfig)
```

### Applicable Products

<!-- npu="950" id1744 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1744 -->
<!-- npu="A3" id1745 -->
- Atlas A3 products: Supported
<!-- end id1745 -->
<!-- npu="910b" id1746 -->
- Atlas A2 products: Supported
<!-- end id1746 -->
<!-- npu="310b" id1747 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1747 -->
<!-- npu="310p" id1748 -->
- Atlas inference products: Supported
<!-- end id1748 -->
<!-- npu="910" id1749 -->
- Atlas training products: Supported
<!-- end id1749 -->
<!-- @ref: runtime/res/docs/zh/api_ref/25-03_Operation_APIs_res.md#id49 -->

### Description

Destroys data of the **aclprofSubscribeConfig** type created via the [aclprofCreateSubscribeConfig](#aclprofCreateSubscribeConfig) API.

### Constraints

- This API is used in pair with [aclprofCreateSubscribeConfig](#aclprofCreateSubscribeConfig). Call **aclprofCreateSubscribeConfig** first, and then call **aclprofDestroySubscribeConfig**.
- Repeatedly calling **aclprofDestroySubscribeConfig** on the same **aclprofSubscribeConfig** pointer may cause repeated memory release errors.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| profSubscribeConfig | Input | Pointer of the data of the **aclprofSubscribeConfig** type to be destroyed. For details about the type definition, see [aclprofSubscribeConfig](#aclprofSubscribeConfig). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>

<a class="method_anchor" id="aclrtAllocatorDesc"></a>

## aclrtAllocatorDesc

- **[aclrtAllocatorCreateDesc](#aclrtAllocatorCreateDesc)**

- **[aclrtAllocatorDestroyDesc](#aclrtAllocatorDestroyDesc)**

- **[aclrtAllocatorSetObjToDesc](#aclrtAllocatorSetObjToDesc)**

- **[aclrtAllocatorSetAllocFuncToDesc](#aclrtAllocatorSetAllocFuncToDesc)**

- **[aclrtAllocatorSetAllocAdviseFuncToDesc](#aclrtAllocatorSetAllocAdviseFuncToDesc)**

- **[aclrtAllocatorSetFreeFuncToDesc](#aclrtAllocatorSetFreeFuncToDesc)**

- **[aclrtAllocatorSetGetAddrFromBlockFuncToDesc](#aclrtAllocatorSetGetAddrFromBlockFuncToDesc)**

<br>

<a class="method_anchor" id="aclrtAllocatorCreateDesc"></a>

## aclrtAllocatorCreateDesc

```c
aclrtAllocatorDesc aclrtAllocatorCreateDesc()
```

### Applicable Products

<!-- npu="950" id1534 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1534 -->
<!-- npu="A3" id1535 -->
- Atlas A3 products: Supported
<!-- end id1535 -->
<!-- npu="910b" id1536 -->
- Atlas A2 products: Supported
<!-- end id1536 -->
<!-- npu="310b" id1537 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1537 -->
<!-- npu="310p" id1538 -->
- Atlas inference products: Supported
<!-- end id1538 -->
<!-- npu="910" id1539 -->
- Atlas training products: Supported
<!-- end id1539 -->
<!-- @ref: runtime/res/docs/zh/api_ref/25-03_Operation_APIs_res.md#id7 -->

### Description

Creates data of the **aclrtAllocatorDesc** type, which indicates the Allocator description information and is mainly used to register callback functions.

### Return Values

- Returns data of the **aclrtAllocatorDesc** type, which indicates success.
- Returns **NULL**, which indicates failure.

<br>

<a class="method_anchor" id="aclrtAllocatorDestroyDesc"></a>

## aclrtAllocatorDestroyDesc

```c
aclError aclrtAllocatorDestroyDesc(aclrtAllocatorDesc allocatorDesc)
```

### Applicable Products

<!-- npu="950" id1163 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1163 -->
<!-- npu="A3" id1164 -->
- Atlas A3 products: Supported
<!-- end id1164 -->
<!-- npu="910b" id1165 -->
- Atlas A2 products: Supported
<!-- end id1165 -->
<!-- npu="310b" id1166 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1166 -->
<!-- npu="310p" id1167 -->
- Atlas inference products: Supported
<!-- end id1167 -->
<!-- npu="910" id1168 -->
- Atlas training products: Supported
<!-- end id1168 -->
<!-- @ref: runtime/res/docs/zh/api_ref/25-03_Operation_APIs_res.md#id8 -->

### Description

Destroys data of the **aclrtAllocatorDesc** type created via the **aclrtAllocatorCreateDesc** API.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| allocatorDesc | Input | Data of the **aclrtAllocatorDesc** type to be destroyed. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>

<a class="method_anchor" id="aclrtAllocatorSetObjToDesc"></a>

## aclrtAllocatorSetObjToDesc

```c
aclError aclrtAllocatorSetObjToDesc(aclrtAllocatorDesc allocatorDesc,  aclrtAllocator allocator)
```

### Applicable Products

<!-- npu="950" id3193 -->
- Ascend 950PR&950DT products: Supported
<!-- end id3193 -->
<!-- npu="A3" id3194 -->
- Atlas A3 products: Supported
<!-- end id3194 -->
<!-- npu="910b" id3195 -->
- Atlas A2 products: Supported
<!-- end id3195 -->
<!-- npu="310b" id3196 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id3196 -->
<!-- npu="310p" id3197 -->
- Atlas inference products: Supported
<!-- end id3197 -->
<!-- npu="910" id3198 -->
- Atlas training products: Supported
<!-- end id3198 -->
<!-- @ref: runtime/res/docs/zh/api_ref/25-03_Operation_APIs_res.md#id9 -->

### Description

Sets the Allocator object in the Allocator description information when a user-provided Allocator is used.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| allocatorDesc | Input | Pointer to the Allocator descriptor.<br>Call [aclrtAllocatorCreateDesc](#aclrtAllocatorCreateDesc) in advance to configure the Allocator description information.<br>For details about the value, see [aclrtAllocatorDesc](#aclrtAllocatorDesc). |
| allocator | Input | Pointer to the Allocator object provided by the user. For details about the type definition, see [aclrtAllocator](25-05_Typedefs.md#aclrtAllocator). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails.

<br>

<a class="method_anchor" id="aclrtAllocatorSetAllocFuncToDesc"></a>

## aclrtAllocatorSetAllocFuncToDesc

```c
aclError aclrtAllocatorSetAllocFuncToDesc(aclrtAllocatorDesc allocatorDesc, aclrtAllocatorAllocFunc func)
```

### Applicable Products

<!-- npu="950" id2430 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2430 -->
<!-- npu="A3" id2431 -->
- Atlas A3 products: Supported
<!-- end id2431 -->
<!-- npu="910b" id2432 -->
- Atlas A2 products: Supported
<!-- end id2432 -->
<!-- npu="310b" id2433 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2433 -->
<!-- npu="310p" id2434 -->
- Atlas inference products: Supported
<!-- end id2434 -->
<!-- npu="910" id2435 -->
- Atlas training products: Supported
<!-- end id2435 -->
<!-- @ref: runtime/res/docs/zh/api_ref/25-03_Operation_APIs_res.md#id10 -->

### Description

Sets the callback function for "requesting a memory block" in the scenario where a user-provided Allocator is used.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| allocatorDesc | Input | Pointer to the Allocator descriptor.<br>Call [aclrtAllocatorCreateDesc](#aclrtAllocatorCreateDesc) in advance to configure the Allocator description information.<br>For details about the value, see [aclrtAllocatorDesc](#aclrtAllocatorDesc). |
| func | Input | Callback function for requesting a memory block.<br>The callback function is defined as follows:<br>typedef void *(*aclrtAllocatorAllocFunc)([aclrtAllocator](25-05_Typedefs.md#aclrtAllocator) allocator, size_t size); |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>

<a class="method_anchor" id="aclrtAllocatorSetAllocAdviseFuncToDesc"></a>

## aclrtAllocatorSetAllocAdviseFuncToDesc

```c
aclError aclrtAllocatorSetAllocAdviseFuncToDesc(aclrtAllocatorDesc allocatorDesc, aclrtAllocatorAllocAdviseFunc func)
```

### Applicable Products

<!-- npu="950" id2682 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2682 -->
<!-- npu="A3" id2683 -->
- Atlas A3 products: Supported
<!-- end id2683 -->
<!-- npu="910b" id2684 -->
- Atlas A2 products: Supported
<!-- end id2684 -->
<!-- npu="310b" id2685 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2685 -->
<!-- npu="310p" id2686 -->
- Atlas inference products: Supported
<!-- end id2686 -->
<!-- npu="910" id2687 -->
- Atlas training products: Supported
<!-- end id2687 -->
<!-- @ref: runtime/res/docs/zh/api_ref/25-03_Operation_APIs_res.md#id11 -->

### Description

Sets the callback function for "requesting a memory block based on the recommended address" in the scenario where a user-provided Allocator is used, which is generally used for memory reuse scenarios.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| allocatorDesc | Input | Pointer to the Allocator descriptor.<br>Call [aclrtAllocatorCreateDesc](#aclrtAllocatorCreateDesc) in advance to configure the Allocator description information.<br>For details about the value, see [aclrtAllocatorDesc](#aclrtAllocatorDesc). |
| func | Input | Callback function for requesting a memory block based on the recommended address.<br>The callback function is defined as follows:<br>typedef void *(*aclrtAllocatorAllocAdviseFunc)([aclrtAllocator](25-05_Typedefs.md#aclrtAllocator) allocator, size_t size, [aclrtAllocatorAddr](25-05_Typedefs.md#aclrtAllocatorAddr) addr); |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>

<a class="method_anchor" id="aclrtAllocatorSetFreeFuncToDesc"></a>

## aclrtAllocatorSetFreeFuncToDesc

```c
aclError aclrtAllocatorSetFreeFuncToDesc(aclrtAllocatorDesc allocatorDesc, aclrtAllocatorFreeFunc func)
```

### Applicable Products

<!-- npu="950" id1751 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1751 -->
<!-- npu="A3" id1752 -->
- Atlas A3 products: Supported
<!-- end id1752 -->
<!-- npu="910b" id1753 -->
- Atlas A2 products: Supported
<!-- end id1753 -->
<!-- npu="310b" id1754 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1754 -->
<!-- npu="310p" id1755 -->
- Atlas inference products: Supported
<!-- end id1755 -->
<!-- npu="910" id1756 -->
- Atlas training products: Supported
<!-- end id1756 -->
<!-- @ref: runtime/res/docs/zh/api_ref/25-03_Operation_APIs_res.md#id12 -->

### Description

Sets the callback function for "releasing a memory block" in the scenario where a user-provided Allocator is used.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| allocatorDesc | Input | Pointer to the Allocator descriptor.<br>Call [aclrtAllocatorCreateDesc](#aclrtAllocatorCreateDesc) in advance to configure the Allocator description information.<br>For details about the value, see [aclrtAllocatorDesc](#aclrtAllocatorDesc). |
| func | Input | Callback function for releasing a memory block.<br>The callback function is defined as follows:<br>typedef void (*aclrtAllocatorFreeFunc)([aclrtAllocator](25-05_Typedefs.md#aclrtAllocator) allocator, [aclrtAllocatorBlock](25-05_Typedefs.md#aclrtAllocatorBlock) block); |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>

<a class="method_anchor" id="aclrtAllocatorSetGetAddrFromBlockFuncToDesc"></a>

## aclrtAllocatorSetGetAddrFromBlockFuncToDesc

```c
aclError aclrtAllocatorSetGetAddrFromBlockFuncToDesc(aclrtAllocatorDesc allocatorDesc, aclrtAllocatorGetAddrFromBlockFunc func)
```

### Applicable Products

<!-- npu="950" id1450 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1450 -->
<!-- npu="A3" id1451 -->
- Atlas A3 products: Supported
<!-- end id1451 -->
<!-- npu="910b" id1452 -->
- Atlas A2 products: Supported
<!-- end id1452 -->
<!-- npu="310b" id1453 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1453 -->
<!-- npu="310p" id1454 -->
- Atlas inference products: Supported
<!-- end id1454 -->
<!-- npu="910" id1455 -->
- Atlas training products: Supported
<!-- end id1455 -->
<!-- @ref: runtime/res/docs/zh/api_ref/25-03_Operation_APIs_res.md#id50 -->

### Description

Sets the callback function for "obtaining the device memory address from the requested block" in the scenario where a user-provided allocator is used.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| allocatorDesc | Input | Pointer to the Allocator descriptor.<br>Call [aclrtAllocatorCreateDesc](#aclrtAllocatorCreateDesc) in advance to configure the Allocator description information.<br>For details about the value, see [aclrtAllocatorDesc](#aclrtAllocatorDesc). |
| func | Input | Callback function for obtaining the device memory address from the obtained block.<br>The callback function is defined as follows:<br>typedef void *(*aclrtAllocatorGetAddrFromBlockFunc)([aclrtAllocatorBlock](25-05_Typedefs.md#aclrtAllocatorBlock) block); |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>

<a class="method_anchor" id="aclrtStreamConfigHandle"></a>

## aclrtStreamConfigHandle

- **[aclrtCreateStreamConfigHandle](#aclrtCreateStreamConfigHandle)**

- **[aclrtDestroyStreamConfigHandle](#aclrtDestroyStreamConfigHandle)**

<br>

<a class="method_anchor" id="aclrtCreateStreamConfigHandle"></a>

## aclrtCreateStreamConfigHandle

```c
aclrtStreamConfigHandle *aclrtCreateStreamConfigHandle(void)
```

### Applicable Products

<!-- npu="950" id2374 -->
- Ascend 950PR&950DT products: Not supported
<!-- end id2374 -->
<!-- npu="A3" id2375 -->
- Atlas A3 products: Not supported
<!-- end id2375 -->
<!-- npu="910b" id2376 -->
- Atlas A2 products: Not supported
<!-- end id2376 -->
<!-- npu="310b" id2377 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id2377 -->
<!-- npu="310p" id2378 -->
- Atlas inference products: Not supported
<!-- end id2378 -->
<!-- npu="910" id2379 -->
- Atlas training products: Not supported
<!-- end id2379 -->
<!-- @ref: runtime/res/docs/zh/api_ref/25-03_Operation_APIs_res.md#id13 -->

### Description

Creates data of the **aclrtStreamConfigHandle** type, which indicates a configuration object of a stream.

To destroy data of the **aclrtStreamConfigHandle** type, use [aclrtDestroyStreamConfigHandle](#aclrtDestroyStreamConfigHandle).

### Parameters

None

### Return Values

- Returns a pointer of the data of the **aclrtStreamConfigHandle** type, which indicates success.
- Returns **NULL**, which indicates failure.

<br>

<a class="method_anchor" id="aclrtDestroyStreamConfigHandle"></a>

## aclrtDestroyStreamConfigHandle

```c
aclError aclrtDestroyStreamConfigHandle(aclrtStreamConfigHandle *handle)
```

### Applicable Products

<!-- npu="950" id1471 -->
- Ascend 950PR&950DT products: Not supported
<!-- end id1471 -->
<!-- npu="A3" id1472 -->
- Atlas A3 products: Not supported
<!-- end id1472 -->
<!-- npu="910b" id1473 -->
- Atlas A2 products: Not supported
<!-- end id1473 -->
<!-- npu="310b" id1474 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id1474 -->
<!-- npu="310p" id1475 -->
- Atlas inference products: Not supported
<!-- end id1475 -->
<!-- npu="910" id1476 -->
- Atlas training products: Not supported
<!-- end id1476 -->
<!-- @ref: runtime/res/docs/zh/api_ref/25-03_Operation_APIs_res.md#id14 -->

### Description

Destroys data of the **aclrtStreamConfigHandle** type created via the [aclrtCreateStreamConfigHandle](#aclrtCreateStreamConfigHandle) API.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| handle | Input | Pointer of data of the **aclrtStreamConfigHandle** type to be destroyed. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>

<a class="method_anchor" id="acltdtDataItem"></a>

## acltdtDataItem

- **[acltdtCreateDataItem](#acltdtCreateDataItem)**

- **[acltdtDestroyDataItem](#acltdtDestroyDataItem)**

- **[acltdtGetTensorTypeFromItem](#acltdtGetTensorTypeFromItem)**

- **[acltdtGetDataTypeFromItem](#acltdtGetDataTypeFromItem)**

- **[acltdtGetDataAddrFromItem](#acltdtGetDataAddrFromItem)**

- **[acltdtGetDataSizeFromItem](#acltdtGetDataSizeFromItem)**

- **[acltdtGetDimNumFromItem](#acltdtGetDimNumFromItem)**

- **[acltdtGetDimsFromItem](#acltdtGetDimsFromItem)**

<br>

<a class="method_anchor" id="acltdtCreateDataItem"></a>

## acltdtCreateDataItem

```c
acltdtDataItem *acltdtCreateDataItem(acltdtTensorType tdtType,
const int64_t *dims,
size_t dimNum,
aclDataType dataType,
void *data,
size_t size)
```

### Applicable Products

<!-- npu="950" id1604 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1604 -->
<!-- npu="A3" id1605 -->
- Atlas A3 products: Supported
<!-- end id1605 -->
<!-- npu="910b" id1606 -->
- Atlas A2 products: Supported
<!-- end id1606 -->
<!-- npu="310b" id1607 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id1607 -->
<!-- npu="310p" id1608 -->
- Atlas inference products: Not supported
<!-- end id1608 -->
<!-- npu="910" id1609 -->
- Atlas training products: Supported
<!-- end id1609 -->
<!-- @ref: runtime/res/docs/zh/api_ref/25-03_Operation_APIs_res.md#id15 -->

### Description

Creates data of the **acltdtDataItem** type, which indicates a tensor in a service scenario.

To destroy data of the **acltdtDataItem** type, use [acltdtDestroyDataItem](#acltdtDestroyDataItem).

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| tdtType | Input | Tensor type. For details about the type definition, see [acltdtTensorType](25-02_Enumerations.md#acltdtTensorType). |
| dims | Input | Shape of the tensor. |
| dimNum | Input | Number of dimensions in the shape of the tensor. |
| dataType | Input | Data type in the normal data. For details about the type definition, see [aclDataType](25-02_Enumerations.md#aclDataType). |
| data | Input | Data address pointer. |
| size | Input | Data length. |

### Return Values

- Returns a pointer of the data of **acltdtDataItem** type, which indicates success.
- Returns **nullptr**, which indicates failure.

<br>

<a class="method_anchor" id="acltdtDestroyDataItem"></a>

## acltdtDestroyDataItem

```c
aclError acltdtDestroyDataItem(acltdtDataItem *dataItem)
```

### Applicable Products

<!-- npu="950" id3011 -->
- Ascend 950PR&950DT products: Supported
<!-- end id3011 -->
<!-- npu="A3" id3012 -->
- Atlas A3 products: Supported
<!-- end id3012 -->
<!-- npu="910b" id3013 -->
- Atlas A2 products: Supported
<!-- end id3013 -->
<!-- npu="310b" id3014 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id3014 -->
<!-- npu="310p" id3015 -->
- Atlas inference products: Not supported
<!-- end id3015 -->
<!-- npu="910" id3016 -->
- Atlas training products: Supported
<!-- end id3016 -->
<!-- @ref: runtime/res/docs/zh/api_ref/25-03_Operation_APIs_res.md#id16 -->

### Description

Destroys data of the **acltdtDataItem** type created via the [acltdtCreateDataItem](#acltdtCreateDataItem) API.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| dataItem | Input | Pointer of the data of the **acltdtDataItem** type to be destroyed. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>

<a class="method_anchor" id="acltdtGetTensorTypeFromItem"></a>

## acltdtGetTensorTypeFromItem

```c
acltdtTensorType acltdtGetTensorTypeFromItem(const acltdtDataItem *dataItem)
```

### Applicable Products

<!-- npu="950" id3361 -->
- Ascend 950PR&950DT products: Supported
<!-- end id3361 -->
<!-- npu="A3" id3362 -->
- Atlas A3 products: Supported
<!-- end id3362 -->
<!-- npu="910b" id3363 -->
- Atlas A2 products: Supported
<!-- end id3363 -->
<!-- npu="310b" id3364 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id3364 -->
<!-- npu="310p" id3365 -->
- Atlas inference products: Not supported
<!-- end id3365 -->
<!-- npu="910" id3366 -->
- Atlas training products: Supported
<!-- end id3366 -->
<!-- @ref: runtime/res/docs/zh/api_ref/25-03_Operation_APIs_res.md#id17 -->

### Description

Checks whether the data in the data description is normal data, end data, or abnormal data after receiving the **dataItem** data.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| dataItem | Input | Pointer of the data of the **acltdtDataItem** type.<br>Call [acltdtCreateDataItem](#acltdtCreateDataItem) in advance to create data of the **acltdtDataItem** type. |

### Return Values

For details, see [acltdtTensorType](25-02_Enumerations.md#acltdtTensorType).

<br>

<a class="method_anchor" id="acltdtGetDataTypeFromItem"></a>

## acltdtGetDataTypeFromItem

```c
aclDataType acltdtGetDataTypeFromItem(const acltdtDataItem *dataItem)
```

### Applicable Products

<!-- npu="950" id2857 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2857 -->
<!-- npu="A3" id2858 -->
- Atlas A3 products: Supported
<!-- end id2858 -->
<!-- npu="910b" id2859 -->
- Atlas A2 products: Supported
<!-- end id2859 -->
<!-- npu="310b" id2860 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id2860 -->
<!-- npu="310p" id2861 -->
- Atlas inference products: Not supported
<!-- end id2861 -->
<!-- npu="910" id2862 -->
- Atlas training products: Supported
<!-- end id2862 -->
<!-- @ref: runtime/res/docs/zh/api_ref/25-03_Operation_APIs_res.md#id18 -->

### Description

Obtains the data type of normal data.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| dataItem | Input | Pointer of the data of the **acltdtDataItem** type.<br>Call [acltdtCreateDataItem](#acltdtCreateDataItem) in advance to create data of the **acltdtDataItem** type. |

### Return Values

Returns the obtained data type. For details about the type definition, see [aclDataType](25-02_Enumerations.md#aclDataType).

<br>

<a class="method_anchor" id="acltdtGetDataAddrFromItem"></a>

## acltdtGetDataAddrFromItem

```c
void *acltdtGetDataAddrFromItem(const acltdtDataItem *dataItem)
```

### Applicable Products

<!-- npu="950" id526 -->
- Ascend 950PR&950DT products: Supported
<!-- end id526 -->
<!-- npu="A3" id527 -->
- Atlas A3 products: Supported
<!-- end id527 -->
<!-- npu="910b" id528 -->
- Atlas A2 products: Supported
<!-- end id528 -->
<!-- npu="310b" id529 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id529 -->
<!-- npu="310p" id530 -->
- Atlas inference products: Not supported
<!-- end id530 -->
<!-- npu="910" id531 -->
- Atlas training products: Supported
<!-- end id531 -->
<!-- @ref: runtime/res/docs/zh/api_ref/25-03_Operation_APIs_res.md#id19 -->

### Description

Obtains the data address of the normal data.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| dataItem | Input | Pointer of the data of the **acltdtDataItem** type.<br>Call [acltdtCreateDataItem](#acltdtCreateDataItem) in advance to create data of the **acltdtDataItem** type. |

### Return Values

Returns the data address of the normal data.

<br>

<a class="method_anchor" id="acltdtGetDataSizeFromItem"></a>

## acltdtGetDataSizeFromItem

```c
size_t acltdtGetDataSizeFromItem(const acltdtDataItem *dataItem)
```

### Applicable Products

<!-- npu="950" id1457 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1457 -->
<!-- npu="A3" id1458 -->
- Atlas A3 products: Supported
<!-- end id1458 -->
<!-- npu="910b" id1459 -->
- Atlas A2 products: Supported
<!-- end id1459 -->
<!-- npu="310b" id1460 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id1460 -->
<!-- npu="310p" id1461 -->
- Atlas inference products: Not supported
<!-- end id1461 -->
<!-- npu="910" id1462 -->
- Atlas training products: Supported
<!-- end id1462 -->
<!-- @ref: runtime/res/docs/zh/api_ref/25-03_Operation_APIs_res.md#id20 -->

### Description

Obtains the data length of normal data.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| dataItem | Input | Pointer of the data of the  **acltdtDataItem** type.<br>Call [acltdtCreateDataItem](#acltdtCreateDataItem) in advance to create data of the  **acltdtDataItem** type. |

### Return Values

Returns the obtained data length.

<br>

<a class="method_anchor" id="acltdtGetDimNumFromItem"></a>

## acltdtGetDimNumFromItem

```c
size_t acltdtGetDimNumFromItem(const acltdtDataItem *dataItem)
```

### Applicable Products

<!-- npu="950" id2416 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2416 -->
<!-- npu="A3" id2417 -->
- Atlas A3 products: Supported
<!-- end id2417 -->
<!-- npu="910b" id2418 -->
- Atlas A2 products: Supported
<!-- end id2418 -->
<!-- npu="310b" id2419 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id2419 -->
<!-- npu="310p" id2420 -->
- Atlas inference products: Not supported
<!-- end id2420 -->
<!-- npu="910" id2421 -->
- Atlas training products: Supported
<!-- end id2421 -->
<!-- @ref: runtime/res/docs/zh/api_ref/25-03_Operation_APIs_res.md#id21 -->

### Description

Obtains the number of dimensions in the data shape of normal tensor data.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| dataItem | Input | Pointer of the data of the **acltdtDataItem** type.<br>Call [acltdtCreateDataItem](#acltdtCreateDataItem) in advance to create data of the **acltdtDataItem** type. |

### Return Values

Returns the number of dimensions obtained.

<br>

<a class="method_anchor" id="acltdtGetDimsFromItem"></a>

## acltdtGetDimsFromItem

```c
aclError acltdtGetDimsFromItem(const acltdtDataItem *dataItem, int64_t *dims, size_t dimNum)
```

### Applicable Products

<!-- npu="950" id365 -->
- Ascend 950PR&950DT products: Supported
<!-- end id365 -->
<!-- npu="A3" id366 -->
- Atlas A3 products: Supported
<!-- end id366 -->
<!-- npu="910b" id367 -->
- Atlas A2 products: Supported
<!-- end id367 -->
<!-- npu="310b" id368 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id368 -->
<!-- npu="310p" id369 -->
- Atlas inference products: Not supported
<!-- end id369 -->
<!-- npu="910" id370 -->
- Atlas training products: Supported
<!-- end id370 -->
<!-- @ref: runtime/res/docs/zh/api_ref/25-03_Operation_APIs_res.md#id22 -->

### Description

Obtains the data shape of normal tensor data.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| dataItem | Input | Pointer of the data of the **acltdtDataItem** type.<br>Call [acltdtCreateDataItem](#acltdtCreateDataItem) in advance to create data of the **acltdtDataItem** type. |
| dims | Input/Output | Dimension information array. |
| dimNum | Input | Number of dimensions. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>

<a class="method_anchor" id="acltdtDataset"></a>

## acltdtDataset

- **[acltdtCreateDataset](#acltdtCreateDataset)**

- **[acltdtDestroyDataset](#acltdtDestroyDataset)**

- **[acltdtGetDataItem](#acltdtGetDataItem)**

- **[acltdtAddDataItem](#acltdtAddDataItem)**

- **[acltdtGetDatasetSize](#acltdtGetDatasetSize)**

- **[acltdtGetDatasetName](#acltdtGetDatasetName)**

<br>

<a class="method_anchor" id="acltdtCreateDataset"></a>

## acltdtCreateDataset

```c
acltdtDataset *acltdtCreateDataset()
```

### Applicable Products

<!-- npu="950" id743 -->
- Ascend 950PR&950DT products: Supported
<!-- end id743 -->
<!-- npu="A3" id744 -->
- Atlas A3 products: Supported
<!-- end id744 -->
<!-- npu="910b" id745 -->
- Atlas A2 products: Supported
<!-- end id745 -->
<!-- npu="310b" id746 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id746 -->
<!-- npu="310p" id747 -->
- Atlas inference products: Not supported
<!-- end id747 -->
<!-- npu="910" id748 -->
- Atlas training products: Supported
<!-- end id748 -->
<!-- @ref: runtime/res/docs/zh/api_ref/25-03_Operation_APIs_res.md#id23 -->

### Description

Creates data of the **acltdtDataset** type, which is equivalent to a **Vector<tensor\>**.

To destroy data of the **acltdtDataset** type, use [acltdtDestroyDataset](#acltdtDestroyDataset).

### Parameters

None

### Return Values

- Returns a pointer of the data of the **acltdtDataset** type, which indicates success.
- Returns **nullptr**, which indicates failure.

<br>

<a class="method_anchor" id="acltdtDestroyDataset"></a>

## acltdtDestroyDataset

```c
aclError acltdtDestroyDataset(acltdtDataset *dataset)
```

### Applicable Products

<!-- npu="950" id3277 -->
- Ascend 950PR&950DT products: Supported
<!-- end id3277 -->
<!-- npu="A3" id3278 -->
- Atlas A3 products: Supported
<!-- end id3278 -->
<!-- npu="910b" id3279 -->
- Atlas A2 products: Supported
<!-- end id3279 -->
<!-- npu="310b" id3280 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id3280 -->
<!-- npu="310p" id3281 -->
- Atlas inference products: Not supported
<!-- end id3281 -->
<!-- npu="910" id3282 -->
- Atlas training products: Supported
<!-- end id3282 -->
<!-- @ref: runtime/res/docs/zh/api_ref/25-03_Operation_APIs_res.md#id24 -->

### Description

Destroys data of the **acltdtDataset** type created via the [acltdtCreateDataset](#acltdtCreateDataset) API.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| dataset | Input | Pointer of the data of the **acltdtDataset** type to be destroyed. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>

<a class="method_anchor" id="acltdtGetDataItem"></a>

## acltdtGetDataItem

```c
acltdtDataItem *acltdtGetDataItem(const acltdtDataset *dataset, size_t index)
```

### Applicable Products

<!-- npu="950" id834 -->
- Ascend 950PR&950DT products: Supported
<!-- end id834 -->
<!-- npu="A3" id835 -->
- Atlas A3 products: Supported
<!-- end id835 -->
<!-- npu="910b" id836 -->
- Atlas A2 products: Supported
<!-- end id836 -->
<!-- npu="310b" id837 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id837 -->
<!-- npu="310p" id838 -->
- Atlas inference products: Not supported
<!-- end id838 -->
<!-- npu="910" id839 -->
- Atlas training products: Supported
<!-- end id839 -->
<!-- @ref: runtime/res/docs/zh/api_ref/25-03_Operation_APIs_res.md#id25 -->

### Description

Obtains the n-th **acltdtDataItem** in **acltdtDataset**.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| dataset | Input | Pointer of the data of the **acltdtDataset** type.<br>Call [acltdtCreateDataset](#acltdtCreateDataset) in advance to create data of the **acltdtDataset** type, and then call [acltdtAddDataItem](#acltdtAddDataItem) to add an **acltdtDataItem**. |
| index | Input | Index of the **acltdtDataItem** to be obtained. |

### Return Values

- Returns the address of the **acltdtDataItem** if the operation is successful.
- Returns an empty address if the operation fails.

<br>

<a class="method_anchor" id="acltdtAddDataItem"></a>

## acltdtAddDataItem

```c
aclError acltdtAddDataItem(acltdtDataset *dataset, acltdtDataItem *dataItem)
```

### Applicable Products

<!-- npu="950" id806 -->
- Ascend 950PR&950DT products: Supported
<!-- end id806 -->
<!-- npu="A3" id807 -->
- Atlas A3 products: Supported
<!-- end id807 -->
<!-- npu="910b" id808 -->
- Atlas A2 products: Supported
<!-- end id808 -->
<!-- npu="310b" id809 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id809 -->
<!-- npu="310p" id810 -->
- Atlas inference products: Not supported
<!-- end id810 -->
<!-- npu="910" id811 -->
- Atlas training products: Supported
<!-- end id811 -->
<!-- @ref: runtime/res/docs/zh/api_ref/25-03_Operation_APIs_res.md#id26 -->

### Description

Adds an **acltdtDataItem** to **acltdtDataset**.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| dataset | Input | Pointer to the **acltdtDataset** address to which the **acltdtDataItem** is to be added.<br>Call [acltdtCreateDataset](#acltdtCreateDataset) in advance to create data of the **acltdtDataset** type. |
| dataItem | Input | Pointer to the **acltdtDataItem** address to be added.<br>Call [acltdtCreateDataItem](#acltdtCreateDataItem) in advance to create data of the **acltdtDataItem** type. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>

<a class="method_anchor" id="acltdtGetDatasetSize"></a>

## acltdtGetDatasetSize

```c
size_t acltdtGetDatasetSize(const acltdtDataset *dataset)
```

### Applicable Products

<!-- npu="950" id1443 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1443 -->
<!-- npu="A3" id1444 -->
- Atlas A3 products: Supported
<!-- end id1444 -->
<!-- npu="910b" id1445 -->
- Atlas A2 products: Supported
<!-- end id1445 -->
<!-- npu="310b" id1446 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id1446 -->
<!-- npu="310p" id1447 -->
- Atlas inference products: Not supported
<!-- end id1447 -->
<!-- npu="910" id1448 -->
- Atlas training products: Supported
<!-- end id1448 -->
<!-- @ref: runtime/res/docs/zh/api_ref/25-03_Operation_APIs_res.md#id27 -->

### Description

Obtains the number of **acltdtDataItem** objects in **acltdtDataset**.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| dataset | Input | Pointer of the data of the **acltdtDataset** type.<br>Call [acltdtCreateDataset](#acltdtCreateDataset) in advance to create data of the **acltdtDataset** type. |

### Return Values

Returns the number of **acltdtDataItem** objects.

<br>

<a class="method_anchor" id="acltdtGetDatasetName"></a>

## acltdtGetDatasetName

```c
const char *acltdtGetDatasetName(const acltdtDataset *dataset)
```

### Applicable Products

<!-- npu="950" id3438 -->
- Ascend 950PR&950DT products: Supported
<!-- end id3438 -->
<!-- npu="A3" id3439 -->
- Atlas A3 products: Supported
<!-- end id3439 -->
<!-- npu="910b" id3440 -->
- Atlas A2 products: Supported
<!-- end id3440 -->
<!-- npu="310b" id3441 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id3441 -->
<!-- npu="310p" id3442 -->
- Atlas inference products: Not supported
<!-- end id3442 -->
<!-- npu="910" id3443 -->
- Atlas training products: Supported
<!-- end id3443 -->
<!-- @ref: runtime/res/docs/zh/api_ref/25-03_Operation_APIs_res.md#id28 -->

### Description

Obtains the descriptor that identifies an **acltdtDataset** (equivalent to a **Vector<tensor\>**).

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| dataset | Input | Pointer of the data of the **acltdtDataset** type.<br>Call [acltdtCreateDataset](#acltdtCreateDataset) in advance to create data of the **acltdtDataset** type. |

### Return Values

Returns the pointer to the descriptor that identifies an **acltdtDataset** (equivalent to a **Vector<tensor\>**).

<br>

<a class="method_anchor" id="acltdtQueueAttr"></a>

## acltdtQueueAttr

- **[acltdtCreateQueueAttr](#acltdtCreateQueueAttr)**

- **[acltdtDestroyQueueAttr](#acltdtDestroyQueueAttr)**

- **[acltdtSetQueueAttr](#acltdtSetQueueAttr)**

- **[acltdtGetQueueAttr](#acltdtGetQueueAttr)**

<br>

<a class="method_anchor" id="acltdtCreateQueueAttr"></a>

## acltdtCreateQueueAttr

```c
acltdtQueueAttr *acltdtCreateQueueAttr()
```

### Applicable Products

<!-- npu="950" id2885 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2885 -->
<!-- npu="A3" id2886 -->
- Atlas A3 products: Supported
<!-- end id2886 -->
<!-- npu="910b" id2887 -->
- Atlas A2 products: Supported
<!-- end id2887 -->
<!-- npu="310b" id2888 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2888 -->
<!-- npu="310p" id2889 -->
- Atlas inference products: Supported
<!-- end id2889 -->
<!-- npu="910" id2890 -->
- Atlas training products: Supported
<!-- end id2890 -->
<!-- @ref: runtime/res/docs/zh/api_ref/25-03_Operation_APIs_res.md#id29 -->

### Description

Creates data of the **acltdtQueueAttr** type, which indicates queue attribute configuration information.

### Parameters

None

### Return Values

- Returns a pointer of the data of the **acltdtQueueAttr** type, indicating success.
- Returns **nullptr**, indicating failure.

<br>

<a class="method_anchor" id="acltdtDestroyQueueAttr"></a>

## acltdtDestroyQueueAttr

```c
aclError acltdtDestroyQueueAttr(const acltdtQueueAttr *attr)
```

### Applicable Products

<!-- npu="950" id876 -->
- Ascend 950PR&950DT products: Supported
<!-- end id876 -->
<!-- npu="A3" id877 -->
- Atlas A3 products: Supported
<!-- end id877 -->
<!-- npu="910b" id878 -->
- Atlas A2 products: Supported
<!-- end id878 -->
<!-- npu="310b" id879 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id879 -->
<!-- npu="310p" id880 -->
- Atlas inference products: Supported
<!-- end id880 -->
<!-- npu="910" id881 -->
- Atlas training products: Supported
<!-- end id881 -->
<!-- @ref: runtime/res/docs/zh/api_ref/25-03_Operation_APIs_res.md#id30 -->

### Description

Destroys data of the **acltdtQueueAttr** type created via the **acltdtCreateQueueAttr** API.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| attr | Input | Pointer of the data of the **acltdtQueueAttr** type to be destroyed. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>

<a class="method_anchor" id="acltdtSetQueueAttr"></a>

## acltdtSetQueueAttr

```c
aclError acltdtSetQueueAttr(acltdtQueueAttr *attr, acltdtQueueAttrType type, size_t len, const void *param)
```

### Applicable Products

<!-- npu="950" id1324 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1324 -->
<!-- npu="A3" id1325 -->
- Atlas A3 products: Supported
<!-- end id1325 -->
<!-- npu="910b" id1326 -->
- Atlas A2 products: Supported
<!-- end id1326 -->
<!-- npu="310b" id1327 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1327 -->
<!-- npu="310p" id1328 -->
- Atlas inference products: Supported
<!-- end id1328 -->
<!-- npu="910" id1329 -->
- Atlas training products: Supported
<!-- end id1329 -->
<!-- @ref: runtime/res/docs/zh/api_ref/25-03_Operation_APIs_res.md#id31 -->

### Description

Sets the queue attribute.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| attr | Input&Output | Pointer to the queue attribute configuration information.<br>Call [acltdtCreateQueueAttr](#acltdtCreateQueueAttr) in advance to create data of the **acltdtQueueAttr** type. |
| type | Input | Attribute type. For details about the type definition, see [acltdtQueueAttrType](25-02_Enumerations.md#acltdtQueueAttrType). |
| len | Input | Number of bytes of the attribute value.<br><br>  - When the enumeration name of the **type** value ends with **_UINT64**, set this parameter to **8**.<br>  - When the enumeration name of the **type** value ends with **_UINT32**, set this parameter to **4**.<br>  - When the enumeration name of the **type** value ends with **_PTR**, set this parameter to **4** if the operating system is 32-bit, or to **8** if the operating system is 64-bit. |
| param | Input | Pointer to the attribute value. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>

<a class="method_anchor" id="acltdtGetQueueAttr"></a>

## acltdtGetQueueAttr

```c
aclError acltdtGetQueueAttr(const acltdtQueueAttr *attr, acltdtQueueAttrType type, size_t len, size_t *paramRetSize, void *param)
```

### Applicable Products

<!-- npu="950" id1842 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1842 -->
<!-- npu="A3" id1843 -->
- Atlas A3 products: Supported
<!-- end id1843 -->
<!-- npu="910b" id1844 -->
- Atlas A2 products: Supported
<!-- end id1844 -->
<!-- npu="310b" id1845 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1845 -->
<!-- npu="310p" id1846 -->
- Atlas inference products: Supported
<!-- end id1846 -->
<!-- npu="910" id1847 -->
- Atlas training products: Supported
<!-- end id1847 -->
<!-- @ref: runtime/res/docs/zh/api_ref/25-03_Operation_APIs_res.md#id32 -->

### Description

Obtains the queue attribute value.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| attr | Input | Pointer to the queue attribute configuration information.<br>Call [acltdtCreateQueueAttr](#acltdtCreateQueueAttr) in advance to create data of the **acltdtQueueAttr** type. |
| type | Input | Attribute type. For details about the type definition, see [acltdtQueueAttrType](25-02_Enumerations.md#acltdtQueueAttrType). |
| len | Input | Number of bytes of the attribute value.<br><br>  - When the enumeration name of the **type** value ends with **_UINT64**, set this parameter to **8**.<br>  - When the enumeration name of the **type** value ends with **_UINT32**, set this parameter to **4**.<br>  - When the enumeration name of the **type** value ends with **_PTR**, set this parameter to **4** if the operating system is 32-bit, or to **8** if the operating system is 64-bit. |
| paramRetSize | Output | Pointer to the number of bytes of the attribute value actually returned. |
| param | Output | Pointer to the attribute value. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>

<a class="method_anchor" id="acltdtQueueRoute"></a>

## acltdtQueueRoute

- **[acltdtCreateQueueRoute](#acltdtCreateQueueRoute)**

- **[acltdtDestroyQueueRoute](#acltdtDestroyQueueRoute)**

- **[acltdtGetQueueRouteParam](#acltdtGetQueueRouteParam)**

<br>

<a class="method_anchor" id="acltdtCreateQueueRoute"></a>

## acltdtCreateQueueRoute

```c
acltdtQueueRoute* acltdtCreateQueueRoute(uint32_t srcId, uint32_t dstId)
```

### Applicable Products

<!-- npu="950" id1415 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1415 -->
<!-- npu="A3" id1416 -->
- Atlas A3 products: Supported
<!-- end id1416 -->
<!-- npu="910b" id1417 -->
- Atlas A2 products: Supported
<!-- end id1417 -->
<!-- npu="310b" id1418 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1418 -->
<!-- npu="310p" id1419 -->
- Atlas inference products: Supported
<!-- end id1419 -->
<!-- npu="910" id1420 -->
- Atlas training products: Supported
<!-- end id1420 -->
<!-- @ref: runtime/res/docs/zh/api_ref/25-03_Operation_APIs_res.md#id33 -->

### Description

Creates data of the **acltdtQueueRoute** type, indicating the creation of a queue route configuration.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| srcId | Input | Source queue ID. |
| dstId | Input | Destination queue ID. |

### Return Values

- Returns a pointer of the data of the **acltdtQueueRoute** type, indicating success.
- Returns **nullptr**, indicating failure.

<br>

<a class="method_anchor" id="acltdtDestroyQueueRoute"></a>

## acltdtDestroyQueueRoute

```c
aclError acltdtDestroyQueueRoute(const acltdtQueueRoute *route)
```

### Applicable Products

<!-- npu="950" id1800 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1800 -->
<!-- npu="A3" id1801 -->
- Atlas A3 products: Supported
<!-- end id1801 -->
<!-- npu="910b" id1802 -->
- Atlas A2 products: Supported
<!-- end id1802 -->
<!-- npu="310b" id1803 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1803 -->
<!-- npu="310p" id1804 -->
- Atlas inference products: Supported
<!-- end id1804 -->
<!-- npu="910" id1805 -->
- Atlas training products: Supported
<!-- end id1805 -->
<!-- @ref: runtime/res/docs/zh/api_ref/25-03_Operation_APIs_res.md#id34 -->

### Description

Destroys data of the **acltdtQueueRoute** type created by the [acltdtCreateQueueRoute](#acltdtCreateQueueRoute) API.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| route | Input | Pointer of the data of the **acltdtQueueRoute** type to be destroyed. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>

<a class="method_anchor" id="acltdtGetQueueRouteParam"></a>

## acltdtGetQueueRouteParam

```c
aclError acltdtGetQueueRouteParam(const acltdtQueueRoute *route, acltdtQueueRouteParamType type, size_t len, size_t *paramRetSize, void *param)
```

### Applicable Products

<!-- npu="950" id1821 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1821 -->
<!-- npu="A3" id1822 -->
- Atlas A3 products: Supported
<!-- end id1822 -->
<!-- npu="910b" id1823 -->
- Atlas A2 products: Supported
<!-- end id1823 -->
<!-- npu="310b" id1824 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1824 -->
<!-- npu="310p" id1825 -->
- Atlas inference products: Supported
<!-- end id1825 -->
<!-- npu="910" id1826 -->
- Atlas training products: Supported
<!-- end id1826 -->
<!-- @ref: runtime/res/docs/zh/api_ref/25-03_Operation_APIs_res.md#id35 -->

### Description

Obtains information about the queue route configuration, such as the source queue ID and destination queue ID.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| route | Input | Pointer to the queue route configuration information.<br>Call [acltdtCreateQueueRoute](#acltdtCreateQueueRoute) in advance to create data of the **acltdtQueueRoute** type. |
| type | Input | Route parameter type. For details about the type definition, see [acltdtQueueRouteParamType](25-02_Enumerations.md#acltdtQueueRouteParamType). |
| len | Input | Number of bytes of the parameter value.<br>If the enumeration name of the **type** value ends with **_UINT32** or **_INT32**, this is fixed to **4**. |
| paramRetSize | Output | Pointer to the number of bytes of the parameter value actually returned. |
| param | Output | Pointer to the parameter value. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>

<a class="method_anchor" id="acltdtQueueRouteList"></a>

## acltdtQueueRouteList

- **[acltdtCreateQueueRouteList](#acltdtCreateQueueRouteList)**

- **[acltdtDestroyQueueRouteList](#acltdtDestroyQueueRouteList)**

- **[acltdtAddQueueRoute](#acltdtAddQueueRoute)**

- **[acltdtGetQueueRoute](#acltdtGetQueueRoute)**

- **[acltdtGetQueueRouteNum](#acltdtGetQueueRouteNum)**

<br>

<a class="method_anchor" id="acltdtCreateQueueRouteList"></a>

## acltdtCreateQueueRouteList

```c
acltdtQueueRouteList* acltdtCreateQueueRouteList()
```

### Applicable Products

<!-- npu="950" id92 -->
- Ascend 950PR&950DT products: Supported
<!-- end id92 -->
<!-- npu="A3" id93 -->
- Atlas A3 products: Supported
<!-- end id93 -->
<!-- npu="910b" id94 -->
- Atlas A2 products: Supported
<!-- end id94 -->
<!-- npu="310b" id95 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id95 -->
<!-- npu="310p" id96 -->
- Atlas inference products: Supported
<!-- end id96 -->
<!-- npu="910" id97 -->
- Atlas training products: Supported
<!-- end id97 -->
<!-- @ref: runtime/res/docs/zh/api_ref/25-03_Operation_APIs_res.md#id36 -->

### Description

Creates data of the **acltdtQueueRouteList** type, which indicates an array of queue route configurations.

### Parameters

None

### Return Values

- Returns a pointer of the data of the **acltdtQueueRouteList** type, which indicates success.
- Returns **nullptr**, which indicates failure.

<br>

<a class="method_anchor" id="acltdtDestroyQueueRouteList"></a>

## acltdtDestroyQueueRouteList

```c
aclError acltdtDestroyQueueRouteList(const acltdtQueueRouteList *routeList)
```

### Applicable Products

<!-- npu="950" id799 -->
- Ascend 950PR&950DT products: Supported
<!-- end id799 -->
<!-- npu="A3" id800 -->
- Atlas A3 products: Supported
<!-- end id800 -->
<!-- npu="910b" id801 -->
- Atlas A2 products: Supported
<!-- end id801 -->
<!-- npu="310b" id802 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id802 -->
<!-- npu="310p" id803 -->
- Atlas inference products: Supported
<!-- end id803 -->
<!-- npu="910" id804 -->
- Atlas training products: Supported
<!-- end id804 -->
<!-- @ref: runtime/res/docs/zh/api_ref/25-03_Operation_APIs_res.md#id37 -->

### Description

Destroys data of the **acltdtQueueRouteList** type created via the [acltdtCreateQueueRouteList](#acltdtCreateQueueRouteList) API.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| routeList | Input | Pointer of the data of the **acltdtQueueRouteList** type to be destroyed. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>

<a class="method_anchor" id="acltdtAddQueueRoute"></a>

## acltdtAddQueueRoute

```c
aclError acltdtAddQueueRoute(acltdtQueueRouteList *routeList, const acltdtQueueRoute *route)
```

### Applicable Products

<!-- npu="950" id1114 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1114 -->
<!-- npu="A3" id1115 -->
- Atlas A3 products: Supported
<!-- end id1115 -->
<!-- npu="910b" id1116 -->
- Atlas A2 products: Supported
<!-- end id1116 -->
<!-- npu="310b" id1117 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1117 -->
<!-- npu="310p" id1118 -->
- Atlas inference products: Supported
<!-- end id1118 -->
<!-- npu="910" id1119 -->
- Atlas training products: Supported
<!-- end id1119 -->
<!-- @ref: runtime/res/docs/zh/api_ref/25-03_Operation_APIs_res.md#id38 -->

### Description

Adds queue route configuration information to the queue route configuration array.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| routeList | Input&Output | Queue route configuration array.<br>Call [acltdtCreateQueueRouteList](#acltdtCreateQueueRouteList) in advance to create data of the **acltdtQueueRouteList** type. |
| route | Input | Pointer to the queue route configuration information.<br>Call [acltdtCreateQueueRoute](#acltdtCreateQueueRoute) in advance to create data of the **acltdtQueueRoute** type. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>

<a class="method_anchor" id="acltdtGetQueueRoute"></a>

## acltdtGetQueueRoute

```c
aclError acltdtGetQueueRoute(const acltdtQueueRouteList *routeList, size_t index, acltdtQueueRoute *route)
```

### Applicable Products

<!-- npu="950" id470 -->
- Ascend 950PR&950DT products: Supported
<!-- end id470 -->
<!-- npu="A3" id471 -->
- Atlas A3 products: Supported
<!-- end id471 -->
<!-- npu="910b" id472 -->
- Atlas A2 products: Supported
<!-- end id472 -->
<!-- npu="310b" id473 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id473 -->
<!-- npu="310p" id474 -->
- Atlas inference products: Supported
<!-- end id474 -->
<!-- npu="910" id475 -->
- Atlas training products: Supported
<!-- end id475 -->
<!-- @ref: runtime/res/docs/zh/api_ref/25-03_Operation_APIs_res.md#id39 -->

### Description

Obtains the specified queue route configuration information from the queue route configuration array.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| routeList | Input | Queue route configuration array.<br>Call [acltdtCreateQueueRouteList](#acltdtCreateQueueRouteList) in advance to create data of the **acltdtQueueRouteList** type. |
| index | Input | Index of the queue route configuration information to obtain. The index number starts from 0. |
| route | Input&Output | Pointer to the queue route configuration information. For details about the type definition, see [acltdtQueueRoute](#acltdtQueueRoute). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>

<a class="method_anchor" id="acltdtGetQueueRouteNum"></a>

## acltdtGetQueueRouteNum

```c
size_t acltdtGetQueueRouteNum(const acltdtQueueRouteList *routeList)
```

### Applicable Products

<!-- npu="950" id2542 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2542 -->
<!-- npu="A3" id2543 -->
- Atlas A3 products: Supported
<!-- end id2543 -->
<!-- npu="910b" id2544 -->
- Atlas A2 products: Supported
<!-- end id2544 -->
<!-- npu="310b" id2545 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2545 -->
<!-- npu="310p" id2546 -->
- Atlas inference products: Supported
<!-- end id2546 -->
<!-- npu="910" id2547 -->
- Atlas training products: Supported
<!-- end id2547 -->
<!-- @ref: runtime/res/docs/zh/api_ref/25-03_Operation_APIs_res.md#id40 -->

### Description

Obtains the number of routes from the queue route configuration array.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| routeList | Input | Queue route configuration array.<br>Call [acltdtCreateQueueRouteList](#acltdtCreateQueueRouteList) in advance to create data of the **acltdtQueueRouteList** type. |

### Return Values

Returns the number of routes.

<br>

<a class="method_anchor" id="acltdtQueueRouteQueryInfo"></a>

## acltdtQueueRouteQueryInfo

- **[acltdtCreateQueueRouteQueryInfo](#acltdtCreateQueueRouteQueryInfo)**

- **[acltdtDestroyQueueRouteQueryInfo](#acltdtDestroyQueueRouteQueryInfo)**

- **[acltdtSetQueueRouteQueryInfo](#acltdtSetQueueRouteQueryInfo)**

<br>

<a class="method_anchor" id="acltdtCreateQueueRouteQueryInfo"></a>

## acltdtCreateQueueRouteQueryInfo

```c
acltdtQueueRouteQueryInfo* acltdtCreateQueueRouteQueryInfo()
```

### Applicable Products

<!-- npu="950" id2584 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2584 -->
<!-- npu="A3" id2585 -->
- Atlas A3 products: Supported
<!-- end id2585 -->
<!-- npu="910b" id2586 -->
- Atlas A2 products: Supported
<!-- end id2586 -->
<!-- npu="310b" id2587 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2587 -->
<!-- npu="310p" id2588 -->
- Atlas inference products: Supported
<!-- end id2588 -->
<!-- npu="910" id2589 -->
- Atlas training products: Supported
<!-- end id2589 -->
<!-- @ref: runtime/res/docs/zh/api_ref/25-03_Operation_APIs_res.md#id41 -->

### Description

Creates data of the **acltdtQueueRouteQueryInfo** type, which indicates the query condition for the queue route relationship.

### Parameters

None

### Return Values

- Returns a pointer of the data of the **acltdtQueueRouteQueryInfo** type, which indicates success.
- Returns **nullptr**, which indicates failure.

<br>

<a class="method_anchor" id="acltdtDestroyQueueRouteQueryInfo"></a>

## acltdtDestroyQueueRouteQueryInfo

```c
aclError acltdtDestroyQueueRouteQueryInfo(const acltdtQueueRouteQueryInfo *info)
```

### Applicable Products

<!-- npu="950" id3200 -->
- Ascend 950PR&950DT products: Supported
<!-- end id3200 -->
<!-- npu="A3" id3201 -->
- Atlas A3 products: Supported
<!-- end id3201 -->
<!-- npu="910b" id3202 -->
- Atlas A2 products: Supported
<!-- end id3202 -->
<!-- npu="310b" id3203 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id3203 -->
<!-- npu="310p" id3204 -->
- Atlas inference products: Supported
<!-- end id3204 -->
<!-- npu="910" id3205 -->
- Atlas training products: Supported
<!-- end id3205 -->
<!-- @ref: runtime/res/docs/zh/api_ref/25-03_Operation_APIs_res.md#id42 -->

### Description

Destroys data of the **acltdtQueueRouteQueryInfo** type created via the [acltdtCreateQueueRouteQueryInfo](#acltdtCreateQueueRouteQueryInfo) API.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| info | Input | Pointer of the data of the **acltdtQueueRouteQueryInfo** type to be destroyed. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>

<a class="method_anchor" id="acltdtSetQueueRouteQueryInfo"></a>

## acltdtSetQueueRouteQueryInfo

```c
aclError acltdtSetQueueRouteQueryInfo(acltdtQueueRouteQueryInfo *param, acltdtQueueRouteQueryInfoParamType type, size_t len, const void *value)
```

### Applicable Products

<!-- npu="950" id1387 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1387 -->
<!-- npu="A3" id1388 -->
- Atlas A3 products: Supported
<!-- end id1388 -->
<!-- npu="910b" id1389 -->
- Atlas A2 products: Supported
<!-- end id1389 -->
<!-- npu="310b" id1390 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1390 -->
<!-- npu="310p" id1391 -->
- Atlas inference products: Supported
<!-- end id1391 -->
<!-- npu="910" id1392 -->
- Atlas training products: Supported
<!-- end id1392 -->
<!-- @ref: runtime/res/docs/zh/api_ref/25-03_Operation_APIs_res.md#id43 -->

### Description

Sets the route relationship query condition.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| param | Input&Output | Pointer to the queue route relationship query condition.<br>Call [acltdtCreateQueueRouteQueryInfo](#acltdtCreateQueueRouteQueryInfo) in advance to create data of the **acltdtQueueRouteQueryInfo** type. |
| type | Input | Parameter type. For details about the type definition, see [acltdtQueueRouteQueryInfoParamType](25-02_Enumerations.md#acltdtQueueRouteQueryInfoParamType). |
| len | Input | Number of bytes of the parameter value.<br><br>  - When the enumeration name of the **type** value ends with **_UINT64**, set this parameter to **8**.<br>  - When the enumeration name of the **type** value ends with **_UINT32**, set this parameter to **4**.<br>  - When the enumeration name of the **type** value ends with **_PTR**, set this parameter to **4** if the operating system is 32-bit, or to **8** if the operating system is 64-bit. |
| value | Input | Pointer to the parameter value. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

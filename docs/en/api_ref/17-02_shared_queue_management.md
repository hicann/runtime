# 17-02 Shared Queue Management

<!-- md-trans-meta sourceCommit=31ae292a88c1a38674abaa350b60eba724bab178 translatedAt=2026-10-26T13:23:27.013Z pushedAt=2026-10-28T08:26:21.951Z -->

This topic describes the shared queue management APIs, which are used for queue creation, destruction, enqueueing, dequeueing, and route management.

- [`aclError acltdtCreateQueue(const acltdtQueueAttr *attr, uint32_t *qid)`](#acltdtCreateQueue): Creates a queue.
- [`aclError acltdtDestroyQueue(uint32_t qid)`](#acltdtDestroyQueue): Destroys the queue created by the **acltdtCreateQueue** API.
- [`aclError acltdtEnqueueData(uint32_t qid, const void *data, size_t dataSize, const void *userData, size_t userDataSize, int32_t timeout, uint32_t rsv)`](#acltdtEnqueueData): Adds data to a queue.
- [`aclError acltdtDequeueData(uint32_t qid, void *data, size_t dataSize, size_t *retDataSize, void *userData, size_t userDataSize, int32_t timeout)`](#acltdtDequeueData): Obtains data from a queue.
- [`aclError acltdtEnqueue(uint32_t qid, acltdtBuf buf, int32_t timeout)`](#acltdtEnqueue): Adds data to a queue. The memory for storing the data must be requested by calling the [acltdtAllocBuf](17-03_shared_buffer_management.md#acltdtAllocBuf) API.
- [`aclError acltdtDequeue(uint32_t qid, acltdtBuf *buf, int32_t timeout)`](#acltdtDequeue): Obtains data from a queue.
- [`aclError acltdtBindQueueRoutes(acltdtQueueRouteList *qRouteList)`](#acltdtBindQueueRoutes): Binds the data forwarding routing relationship between queues when an application distributes data from one source to multiple destinations.
- [`aclError acltdtUnbindQueueRoutes(acltdtQueueRouteList *qRouteList)`](#acltdtUnbindQueueRoutes): Unbinds the data queue routing relationship.
- [`aclError acltdtQueryQueueRoutes(const acltdtQueueRouteQueryInfo *queryInfo, acltdtQueueRouteList *qRouteList)`](#acltdtQueryQueueRoutes): Queries the data queue routing relationship based on specified conditions.
- [`aclError acltdtGrantQueue(uint32_t qid, int32_t pid, uint32_t permission, int32_t timeout)`](#acltdtGrantQueue): Grants queue-related permissions to other processes, such as the enqueue (adding data to the queue) permission and the dequeue (obtaining data from the queue) permission, when inter-process queue information sharing is required.
- [`aclError acltdtAttachQueue(uint32_t qid, int32_t timeout, uint32_t *permission)`](#acltdtAttachQueue): Confirms that the current process has the corresponding permissions on the queue in the authorized process when inter-process queue information sharing is required.

<a class="method_anchor" id="acltdtCreateQueue"></a>

## acltdtCreateQueue

```c
aclError acltdtCreateQueue(const acltdtQueueAttr *attr, uint32_t *qid)
```

### Applicable Products

<!-- npu="950" id2815 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2815 -->
<!-- npu="A3" id2816 -->
- Atlas A3 products: Supported
<!-- end id2816 -->
<!-- npu="910b" id2817 -->
- Atlas A2 products: Supported
<!-- end id2817 -->
<!-- npu="310b" id2818 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2818 -->
<!-- npu="310p" id2819 -->
- Atlas inference products: Supported
<!-- end id2819 -->
<!-- npu="910" id2820 -->
- Atlas training products: Supported
<!-- end id2820 -->
<!-- @ref: runtime/res/docs/zh/api_ref/17-02_shared_queue_management_res.md#id1 -->

### Description

Creates a queue.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| attr | Input | Pointer to the queue attribute configuration information. For details about the type definition, see [acltdtQueueAttr](25-03_Operation_APIs.md#acltdtQueueAttr).<br>Call [acltdtCreateQueueAttr](25-03_Operation_APIs.md#acltdtCreateQueueAttr) in advance to create data of the **acltdtQueueAttr** type, and then call [acltdtSetQueueAttr](25-03_Operation_APIs.md#acltdtSetQueueAttr) to set the queue attribute (for example, the queue name).<br>If this parameter is **nullptr**, the default queue attribute values are used, that is, the queue name is automatically assigned by the system and the queue depth defaults to 8. |
| qid | Output | Pointer to the queue ID. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="acltdtDestroyQueue"></a>

## acltdtDestroyQueue

```c
aclError acltdtDestroyQueue(uint32_t qid)
```

### Applicable Products

<!-- npu="950" id3249 -->
- Ascend 950PR&950DT products: Supported
<!-- end id3249 -->
<!-- npu="A3" id3250 -->
- Atlas A3 products: Supported
<!-- end id3250 -->
<!-- npu="910b" id3251 -->
- Atlas A2 products: Supported
<!-- end id3251 -->
<!-- npu="310b" id3252 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id3252 -->
<!-- npu="310p" id3253 -->
- Atlas inference products: Supported
<!-- end id3253 -->
<!-- npu="910" id3254 -->
- Atlas training products: Supported
<!-- end id3254 -->
<!-- @ref: runtime/res/docs/zh/api_ref/17-02_shared_queue_management_res.md#id2 -->

### Description

Destroys the queue created by the **acltdtCreateQueue** API.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| **qid** | Input | Queue to be destroyed. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="acltdtEnqueueData"></a>

## acltdtEnqueueData

```c
aclError acltdtEnqueueData(uint32_t qid, const void *data, size_t dataSize, const void *userData, size_t userDataSize, int32_t timeout, uint32_t rsv)
```

### Applicable Products

<!-- npu="950" id3151 -->
- Ascend 950PR&950DT products: Supported
<!-- end id3151 -->
<!-- npu="A3" id3152 -->
- Atlas A3 products: Supported
<!-- end id3152 -->
<!-- npu="910b" id3153 -->
- Atlas A2 products: Supported
<!-- end id3153 -->
<!-- npu="310b" id3154 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id3154 -->
<!-- npu="310p" id3155 -->
- Atlas inference products: Supported
<!-- end id3155 -->
<!-- npu="910" id3156 -->
- Atlas training products: Supported
<!-- end id3156 -->
<!-- @ref: runtime/res/docs/zh/api_ref/17-02_shared_queue_management_res.md#id3 -->

### Description

Add data to a queue.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| qid | Input | Queue to which data is to be added.<br>The queue must be created in advance by calling [acltdtCreateQueue](#acltdtCreateQueue). |
| data | Input | Memory data pointer, supporting memory on the host side or the device side. |
| dataSize | Input | Memory data size, in bytes. |
| userData | Input | User-defined data pointer.<br>If there is no user-defined data, pass **nullptr**. |
| userDataSize | Input | User-defined data size (<= 96 bytes).<br>If there is no user-defined data, pass **0**. |
| timeout | Input | Wait timeout. When the queue is full, if data is added to the queue, the system internally determines how to handle this scenario based on the set wait timeout.<br>The value options are as follows:<br>  - **-1**: blocking mode, that is, waiting until the data is successfully added to the queue.<br>  - **0**: non-blocking mode (supported only in the device scenario; invalid in the host scenario). When the queue is full, the queue-full error is returned, and the user sets the retry interval.<br>  - **>0**: specific timeout, in milliseconds. When the queue is full, an error is returned after the wait reaches the timeout. The timeout is affected by the operating system and generally deviates within one time slice of the operating system. For example, if one time slice of the operating system is 4 ms and the user sets the timeout to 1 ms, the actual timeout ranges from 1 ms to 5 ms. Under high CPU load, the timeout may still fluctuate. |
| rsv | Input | Reserved parameter, not supported yet. Currently it can be set to **0**. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="acltdtDequeueData"></a>

## acltdtDequeueData

```c
aclError acltdtDequeueData(uint32_t qid, void *data, size_t dataSize, size_t *retDataSize, void *userData, size_t userDataSize, int32_t timeout)
```

### Applicable Products

<!-- npu="950" id2710 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2710 -->
<!-- npu="A3" id2711 -->
- Atlas A3 products: Supported
<!-- end id2711 -->
<!-- npu="910b" id2712 -->
- Atlas A2 products: Supported
<!-- end id2712 -->
<!-- npu="310b" id2713 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2713 -->
<!-- npu="310p" id2714 -->
- Atlas inference products: Supported
<!-- end id2714 -->
<!-- npu="910" id2715 -->
- Atlas training products: Supported
<!-- end id2715 -->
<!-- @ref: runtime/res/docs/zh/api_ref/17-02_shared_queue_management_res.md#id4 -->

### Description

Obtains data from a queue.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| qid | Input | Queue from which data is to be obtained.<br>The queue must be created in advance by calling [acltdtCreateQueue](#acltdtCreateQueue). |
| data | Input&Output | Memory data pointer.<br>It supports memory on the host side or the device side. |
| dataSize | Input | Memory data size, in bytes. |
| retDataSize | Output | Actual data size, in bytes. |
| userData | Input&Output | User-defined data pointer.<br>If the user does not customize data, pass **nullptr**. |
| userDataSize | Input | User-defined data size (<= 96 bytes).<br>If the user does not customize data, pass **0**. |
| timeout | Input | Wait timeout. When the queue is empty, if data is obtained from the queue, the system internally determines how to handle this scenario based on the set wait timeout.<br>The parameter value range is as follows:<br>  - **-1**: blocking mode, that is, wait until the queue has data and then return.<br>  - **0**: non-blocking mode (supported only in the device scenario; invalid in the host scenario). When the queue is empty, the queue-empty error is returned directly, and the user sets the retry interval accordingly.<br>  - **>0**: specific timeout, in milliseconds. When the queue is empty, an error is returned after the timeout is reached. The timeout is affected by the operating system, and the deviation is generally within one time slice of the operating system. For example, if one time slice of the operating system is 4 ms and the user sets the timeout to 1 ms, the actual timeout ranges from 1 ms to 5 ms. Under high CPU load, the timeout may still fluctuate. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="acltdtEnqueue"></a>

## acltdtEnqueue

```c
aclError acltdtEnqueue(uint32_t qid, acltdtBuf buf, int32_t timeout)
```

### Applicable Products

<!-- npu="950" id2864 -->
- Ascend 950PR&950DT products: Not supported
<!-- end id2864 -->
<!-- npu="A3" id2865 -->
- Atlas A3 products: Not supported
<!-- end id2865 -->
<!-- npu="910b" id2866 -->
- Atlas A2 products: Not supported
<!-- end id2866 -->
<!-- npu="310b" id2867 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id2867 -->
<!-- npu="310p" id2868 -->
- Atlas inference products: Not supported
<!-- end id2868 -->
<!-- npu="910" id2869 -->
- Atlas training products: Not supported
<!-- end id2869 -->
<!-- @ref: runtime/res/docs/zh/api_ref/17-02_shared_queue_management_res.md#id5 -->

### Description

Adds data to a queue. The memory that stores the data must be requested by calling [acltdtAllocBuf](17-03_shared_buffer_management.md#acltdtAllocBuf).

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| qid | Input | Queue to which data is added.<br>The queue must be created in advance by calling [acltdtCreateQueue](#acltdtCreateQueue). |
| buf | Input | Shared buffer pointer. For details about the type definition, see [acltdtBuf](25-05_Typedefs.md#acltdtBuf).<br>This memory must be requested in advance by calling [acltdtAllocBuf](17-03_shared_buffer_management.md#acltdtAllocBuf). |
| timeout | Input | Wait timeout. When the queue is full, if data is added to the queue, the system internally determines how to handle this scenario based on the set wait timeout.<br>The value range of this parameter is as follows:<br>  - **-1**: blocking mode, that is, wait until the data is successfully added to the queue.<br>  - **0**: non-blocking mode. When the queue is full, the queue-full error is returned directly. In this case, the user sets the retry interval accordingly.<br>  - **>0**: specific timeout, in milliseconds. When the queue is full, an error is returned after the wait reaches the timeout. The timeout is affected by the operating system and generally deviates within one time slice of the operating system. For example, if one time slice of the operating system is 4 ms and the user sets the timeout to 1 ms, the actual timeout ranges from 1 ms to 5 ms. Under high CPU load, the timeout may still fluctuate. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="acltdtDequeue"></a>

## acltdtDequeue

```c
aclError acltdtDequeue(uint32_t qid, acltdtBuf *buf, int32_t timeout)
```

### Applicable Products

<!-- npu="950" id932 -->
- Ascend 950PR&950DT products: Not supported
<!-- end id932 -->
<!-- npu="A3" id933 -->
- Atlas A3 products: Not supported
<!-- end id933 -->
<!-- npu="910b" id934 -->
- Atlas A2 products: Not supported
<!-- end id934 -->
<!-- npu="310b" id935 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id935 -->
<!-- npu="310p" id936 -->
- Atlas inference products: Not supported
<!-- end id936 -->
<!-- npu="910" id937 -->
- Atlas training products: Not supported
<!-- end id937 -->
<!-- @ref: runtime/res/docs/zh/api_ref/17-02_shared_queue_management_res.md#id6 -->

### Description

Obtains data from a queue.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| qid | Input | Queue from which data is to be obtained.<br>The queue must be created in advance by calling [acltdtCreateQueue](#acltdtCreateQueue). |
| buf | Output | Shared buffer pointer. For details about the type definition, see [acltdtBuf](25-05_Typedefs.md#acltdtBuf). |
| timeout | Input | Wait timeout. When the queue is empty, if data is obtained from the queue, the system internally determines how to handle this scenario based on the set wait timeout.<br>The value range of this parameter is as follows:<br>  - **-1**: blocking mode, that is, wait until the queue has data and then return.<br>  - **0**: non-blocking mode. When the queue is empty, the queue-empty error is returned directly. In this case, the user sets the retry interval accordingly.<br>  - **>0**: specific timeout, in milliseconds. When the queue is empty, wait until the timeout expires and then return an error. The timeout is affected by the operating system and generally deviates within one time slice of the operating system. For example, if one time slice of the operating system is 4 ms and the user sets the timeout to 1 ms, the actual timeout ranges from 1 ms to 5 ms. Under high CPU load, the timeout may still fluctuate. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="acltdtBindQueueRoutes"></a>

## acltdtBindQueueRoutes

```c
aclError acltdtBindQueueRoutes(acltdtQueueRouteList *qRouteList)
```

### Applicable Products

<!-- npu="950" id2801 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2801 -->
<!-- npu="A3" id2802 -->
- Atlas A3 products: Supported
<!-- end id2802 -->
<!-- npu="910b" id2803 -->
- Atlas A2 products: Supported
<!-- end id2803 -->
<!-- npu="310b" id2804 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2804 -->
<!-- npu="310p" id2805 -->
- Atlas inference products: Supported
<!-- end id2805 -->
<!-- npu="910" id2806 -->
- Atlas training products: Supported
<!-- end id2806 -->
<!-- @ref: runtime/res/docs/zh/api_ref/17-02_shared_queue_management_res.md#id7 -->

### Description

Binds the data forwarding routing relationship between queues when an application distributes data from one source to multiple destinations.

As shown in the following figure, two routing relationships can be established (Q1-\>Q2 and Q1-\>Q3). During one-to-many data distribution, the shared buffer data passed is lock-free, and consumers cannot perform in-place operations on the data. As shown in the following figure, a modification to the shared data by consumer 1 causes the data accessed by consumer 2 to change.

![](figures/data_producers_and_data_consumers.png)

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| qRouteList | Input/Output | Pointer to the routing relationship array. After the API call completes, the route binding result is returned. For details about the type definition, see [acltdtQueueRouteList](25-03_Operation_APIs.md#acltdtQueueRouteList).<br>Call [acltdtCreateQueueRouteList](25-03_Operation_APIs.md#acltdtCreateQueueRouteList) in advance to create data of the **acltdtQueueRouteList** type, and then call [acltdtAddQueueRoute](25-03_Operation_APIs.md#acltdtAddQueueRoute) to add routing relationships. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

This API returns success only when all queue relationships are bound successfully and the route status is normal. If any binding fails, this API returns failure. If you need to know which specific routing relationship failed to bind, you can first call [acltdtGetQueueRoute](25-03_Operation_APIs.md#acltdtGetQueueRoute) to obtain each routing relationship from the routing relationship array, and then call [acltdtGetQueueRouteParam](25-03_Operation_APIs.md#acltdtGetQueueRouteParam) to query the binding relationship status.

### Constraints

- The system internally checks whether the added queue routing relationships form a loop, and loops are not allowed.
- Concurrent calls from multiple threads are not supported.

<br>
<br>
<br>

<a class="method_anchor" id="acltdtUnbindQueueRoutes"></a>

## acltdtUnbindQueueRoutes

```c
aclError acltdtUnbindQueueRoutes(acltdtQueueRouteList *qRouteList)
```

### Applicable Products

<!-- npu="950" id1436 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1436 -->
<!-- npu="A3" id1437 -->
- Atlas A3 products: Supported
<!-- end id1437 -->
<!-- npu="910b" id1438 -->
- Atlas A2 products: Supported
<!-- end id1438 -->
<!-- npu="310b" id1439 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1439 -->
<!-- npu="310p" id1440 -->
- Atlas inference products: Supported
<!-- end id1440 -->
<!-- npu="910" id1441 -->
- Atlas training products: Supported
<!-- end id1441 -->
<!-- @ref: runtime/res/docs/zh/api_ref/17-02_shared_queue_management_res.md#id8 -->

### Description

Unbinds the routing relationship of the data queue.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| qRouteList | Input/Output | Pointer to the routing relationship array. After the API call completes, the route unbinding result is returned. For details about the type definition, see [acltdtQueueRouteList](25-03_Operation_APIs.md#acltdtQueueRouteList).<br>You can first obtain the routing relationship array through [acltdtQueryQueueRoutes](#acltdtQueryQueueRoutes). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

This API returns success only when all queue relationships are unbound successfully. If any unbinding fails, this API returns failure. If you need to know which specific routing relationship failed to unbind, you can first call [acltdtGetQueueRoute](25-03_Operation_APIs.md#acltdtGetQueueRoute) to obtain each routing relationship from the routing relationship array, and then call [acltdtGetQueueRouteParam](25-03_Operation_APIs.md#acltdtGetQueueRouteParam) to query the binding relationship status.

<br>
<br>
<br>

<a class="method_anchor" id="acltdtQueryQueueRoutes"></a>

## acltdtQueryQueueRoutes

```c
aclError acltdtQueryQueueRoutes(const acltdtQueueRouteQueryInfo *queryInfo, acltdtQueueRouteList *qRouteList)
```

### Applicable Products

<!-- npu="950" id3025 -->
- Ascend 950PR&950DT products: Supported
<!-- end id3025 -->
<!-- npu="A3" id3026 -->
- Atlas A3 products: Supported
<!-- end id3026 -->
<!-- npu="910b" id3027 -->
- Atlas A2 products: Supported
<!-- end id3027 -->
<!-- npu="310b" id3028 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id3028 -->
<!-- npu="310p" id3029 -->
- Atlas inference products: Supported
<!-- end id3029 -->
<!-- npu="910" id3030 -->
- Atlas training products: Supported
<!-- end id3030 -->
<!-- @ref: runtime/res/docs/zh/api_ref/17-02_shared_queue_management_res.md#id9 -->

### Description

Queries the data queue routing relationship based on specified conditions.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| queryInfo | Input | Pointer to the query condition. For details about the type definition, see [acltdtQueueRouteQueryInfo](25-03_Operation_APIs.md#acltdtQueueRouteQueryInfo).<br>First call [acltdtCreateQueueRouteQueryInfo](25-03_Operation_APIs.md#acltdtCreateQueueRouteQueryInfo) to create data of the **acltdtQueueRouteQueryInfo** type. |
| qRouteList | Input&Output | Pointer to the routing relationship array. For details about the type definition, see [acltdtQueueRouteList](25-03_Operation_APIs.md#acltdtQueueRouteList).<br>First call [acltdtCreateQueueRouteList](25-03_Operation_APIs.md#acltdtCreateQueueRouteList) to create data of the **acltdtQueueRouteList** type. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="acltdtGrantQueue"></a>

## acltdtGrantQueue

```c
aclError acltdtGrantQueue(uint32_t qid, int32_t pid, uint32_t permission, int32_t timeout)
```

### Applicable Products

<!-- npu="950" id183 -->
- Ascend 950PR&950DT products: Not supported
<!-- end id183 -->
<!-- npu="A3" id184 -->
- Atlas A3 products: Not supported
<!-- end id184 -->
<!-- npu="910b" id185 -->
- Atlas A2 products: Not supported
<!-- end id185 -->
<!-- npu="310b" id186 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id186 -->
<!-- npu="310p" id187 -->
- Atlas inference products: Not supported
<!-- end id187 -->
<!-- npu="910" id188 -->
- Atlas training products: Not supported
<!-- end id188 -->
<!-- @ref: runtime/res/docs/zh/api_ref/17-02_shared_queue_management_res.md#id10 -->

### Description

Grants queue-related permissions to other processes, such as the enqueue (adding data to the queue) permission and the dequeue (obtaining data from the queue) permission, when inter-process queue information sharing is required.

When queue-related information is transferred between processes, security is ensured by the user.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| qid | Input | Queue ID. |
| pid | Input | ID of the process to be granted permissions. |
| permission | Input | Permission flag (queue producer/consumer).<br>The user selects multiple macros from the following and performs a logical OR on them (for example, **ACL_TDT_QUEUE_PERMISSION_DEQUEUE \| ACL_TDT_QUEUE_PERMISSION_ENQUEUE**) as the value of the **permission** parameter. Each macro represents a specific permission, as described below:<br>  - **ACL_TDT_QUEUE_PERMISSION_MANAGE**: queue management permission.<br>  - **ACL_TDT_QUEUE_PERMISSION_DEQUEUE**: dequeue permission.<br>  - **ACL_TDT_QUEUE_PERMISSION_ENQUEUE**: enqueue permission. |
| timeout | Input | Wait timeout. The value range is as follows:<br>  - **-1**: blocking mode, that is, wait until the data is successfully added to the queue.<br>  - **0**: non-blocking mode, that is, return immediately.<br>  - **>0**: specific timeout, in milliseconds. An error is returned after the timeout is reached. The timeout is affected by the operating system and generally deviates within one time slice of the operating system. For example, if one time slice of the operating system is 4 ms and the user sets the timeout to 1 ms, the actual timeout ranges from 1 ms to 5 ms. Under high CPU load, the timeout may still fluctuate. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="acltdtAttachQueue"></a>

## acltdtAttachQueue

```c
aclError acltdtAttachQueue(uint32_t qid, int32_t timeout, uint32_t *permission)
```

### Applicable Products

<!-- npu="950" id3445 -->
- Ascend 950PR&950DT products: Not supported
<!-- end id3445 -->
<!-- npu="A3" id3446 -->
- Atlas A3 products: Not supported
<!-- end id3446 -->
<!-- npu="910b" id3447 -->
- Atlas A2 products: Not supported
<!-- end id3447 -->
<!-- npu="310b" id3448 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id3448 -->
<!-- npu="310p" id3449 -->
- Atlas inference products: Not supported
<!-- end id3449 -->
<!-- npu="910" id3450 -->
- Atlas training products: Not supported
<!-- end id3450 -->
<!-- @ref: runtime/res/docs/zh/api_ref/17-02_shared_queue_management_res.md#id11 -->

### Description

Confirms that the current process has the corresponding permissions on the queue in the authorized process when inter-process queue information sharing is required.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| qid | Input | Queue ID. |
| timeout | Input | Wait timeout. The value range is as follows:<br>  - **-1**: blocking mode, that is, wait until the data is successfully added to the queue.<br>  - **0**: non-blocking mode, that is, return immediately.<br>  - **>0**: specific timeout, in milliseconds. An error is returned after the timeout is reached. The timeout is affected by the operating system and generally deviates within one time slice of the operating system. For example, if one time slice of the operating system is 4 ms and the user sets the timeout to 1 ms, the actual timeout ranges from 1 ms to 5 ms. Under high CPU load, the timeout may still fluctuate. |
| permission | Output | Permission flag.<br><br>  - Determine whether the management permission is granted based on the last bit of the output parameter value. **0** means no, and **1** means yes.<br>  - Determine whether the permission to obtain data from the queue is granted based on the second-to-last bit of the output parameter value. **0** means no, and **1** means yes.<br>  - Determine whether the permission to add data to the queue is granted based on the third-to-last bit of the output parameter value. **0** means no, and **1** means yes. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).
